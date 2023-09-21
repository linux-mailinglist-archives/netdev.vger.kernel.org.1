Return-Path: <netdev+bounces-35503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A87A9BBC
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AD31C2144D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0E94A52B;
	Thu, 21 Sep 2023 17:51:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2F4A528
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:51:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E042E7E7D0
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695318645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7gLU3+rfv3HHSp+DEvudAw0y1szA/aWbZkWDtyEikvk=;
	b=BmdLBp92AbesraJKxWOI5+H/820A4lB+1b1x8zs2XvUGvN0zea9QXWaWG6ymOhD4U5vcYs
	csmgy4I3oW4awRrFDu8NqlnDEIZt9gzIs7JCQoTpJI6qgqbQXxN8sMcxWijogbR2TiPfTo
	PPRADXtohV3MzQKIY/LUzxvobqH38Y4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-xLnmuW6LM86sIfYlLuN5cA-1; Thu, 21 Sep 2023 10:35:35 -0400
X-MC-Unique: xLnmuW6LM86sIfYlLuN5cA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2a7a6393ba6so2289011fa.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 07:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695306933; x=1695911733;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gLU3+rfv3HHSp+DEvudAw0y1szA/aWbZkWDtyEikvk=;
        b=DX/BVLG8nwNkhrdZaypp+92Z1t2swY4raZPzXw8Y04FEsCBnMARKjVgPfOW30S3YKt
         fNVXtyjvzTrUcMWfzzHMAzqNM6gzljUPNS4Af/QYfOoi4n7dn7WPuEXabft0CApGioCW
         8zPl5dngWFw5ChjOcTcBThHtPMOtkiEWJBGOJuZwgOMPsAXFOlJAojdM746sYnh9Ve6A
         uu3Q7uVMKwSriZi8X5pUyGNqtckpA7Md3c8C8rx7e/iEMJYzJLysigjbsBTePNbFEFau
         gnrBWgqLHcFXafAO5OpHrJ0/cdJf8PXBR7rmHOpFilaejrXDy8feUhss1PY3VJmBn8bG
         KHfg==
X-Gm-Message-State: AOJu0YyK3D7b2M5nRWTzmEG01IxsRhYGPDVgEVJlBsHc8GHPQW+1L5Gc
	BPu5Kd9PVWb9/TONRwwPXMLD4hRXEnfCPyYy3PyK8AU1BMNGkov7fgtgbuE/0YSM3196U9d25vc
	dwYO2z722wIG0MjP/
X-Received: by 2002:a2e:a60a:0:b0:2bf:eafb:3442 with SMTP id v10-20020a2ea60a000000b002bfeafb3442mr4138864ljp.3.1695306933641;
        Thu, 21 Sep 2023 07:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuAp7m0hjif9+lpPxXN9OH1XssIg13XiXVjnldMBJ6IlMoqth3cyfJJFOhFSvkHo1V5fnjJQ==
X-Received: by 2002:a2e:a60a:0:b0:2bf:eafb:3442 with SMTP id v10-20020a2ea60a000000b002bfeafb3442mr4138856ljp.3.1695306933291;
        Thu, 21 Sep 2023 07:35:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906474800b0099297c99314sm1126843ejs.113.2023.09.21.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:35:32 -0700 (PDT)
Message-ID: <a15822902e9e751b982a07621d180e3fa00353d4.camel@redhat.com>
Subject: Re:  [GIT PULL] Networking for 6.6-rc3
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 21 Sep 2023 16:35:31 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Linus,

I noticed after sending the PR that since this morning I have email
delivery problems with lore: "Recipient server unavailable or busy."=20

That is likely something in between my corporate server and lore, as
messages form other sources are reaching there.

I'm wondering is if my PR reached somehow your inbox and/or if I have
to re-send it.

Thanks!

Paolo


