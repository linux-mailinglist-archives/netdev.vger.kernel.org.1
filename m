Return-Path: <netdev+bounces-35534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696337A9C83
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291FD2833FC
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B104C86D;
	Thu, 21 Sep 2023 18:11:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD8941E4F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:11:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0849D466
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695318969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJuzqw6y7Ip39zFY8UF3H/ph0aENOEUx7vxRau7h7Js=;
	b=dhCJbHTZOe2fkQ+81EEmeOr794mj5DVYMH6yecZcn/pSi6fGXgGKf4Lnb/edO8ojR4g8kP
	Nd2zoPStGn76cGKInqAkUt+5do349oBi2KKS08xhmGYMNAZs0iVwxN+pY9qcfYrgZoQkC/
	zxm1xmhEzkjvaTJgQusKqZRCbL3NPmk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-ohIdwED6Mt2FDOppFjX6Cw-1; Thu, 21 Sep 2023 10:40:48 -0400
X-MC-Unique: ohIdwED6Mt2FDOppFjX6Cw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51e3bb0aeedso183951a12.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 07:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695307247; x=1695912047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJuzqw6y7Ip39zFY8UF3H/ph0aENOEUx7vxRau7h7Js=;
        b=DQzYIz0tUhUZqlF2H6doVKoBariKam2udkCEd1U4lcsUwm19lguhMPrpvDK5VV0x5y
         qhqqJkFaPoDta4bnqtUN/IKN5tMtSEV3j6sBZEBNPsEgwn82qgxbazgoImExO+vaYiqg
         oV7WPQHI/ZMfQ+TBfdDu3ZCmI6Xa7U2e4HjnzU/ymJmsM53gmcnknkyqmRIGtQhxhKy6
         aCN1GYBAAvuw8McMVm10P5CyQ7mZf4RrE1WBVs8yh8GBR922ooJ+Z/bdFXtbUSUPIyHq
         TosX/nk5UHYCGwpAhCuydqhY7zA3VQML9cdyflnUGuEodTA+9aBUAc9qcqCWLePSmZbg
         zS1Q==
X-Gm-Message-State: AOJu0YwAlh4/NKF8+JdYYLzYAnY64MbosfRJSE9BSGTNPHFRcrYBDn3b
	Zy63NFxGhfEAfX/xL4o71PbKuV1yQwtzbDlHsL9vVu8own55SiSKIwEd8FaP/NgAUd2s8c63Koc
	T1mNqkcVWwh6046bG
X-Received: by 2002:a17:906:d3:b0:99c:5711:3187 with SMTP id 19-20020a17090600d300b0099c57113187mr4432974eji.6.1695307247362;
        Thu, 21 Sep 2023 07:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUXkWRy8pyVz5Er6anCQu7FYs2J46jfxMTML3x7ct4qBYd5KH3WxyrVl/hSXMaku8sKa2ejQ==
X-Received: by 2002:a17:906:d3:b0:99c:5711:3187 with SMTP id 19-20020a17090600d300b0099c57113187mr4432954eji.6.1695307247050;
        Thu, 21 Sep 2023 07:40:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1163364ejb.85.2023.09.21.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:40:46 -0700 (PDT)
Message-ID: <5615a39b3402e7499fd531c928845e102fba6f1c.camel@redhat.com>
Subject: Re: [net-next PATCH] net: sfp: add quirk for Fiberstone
 GPON-ONU-34-20BI
From: Paolo Abeni <pabeni@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Christian Marangi
	 <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 21 Sep 2023 16:40:45 +0200
In-Reply-To: <ZQmkv9o329m98CUG@shell.armlinux.org.uk>
References: <20230919124720.8210-1-ansuelsmth@gmail.com>
	 <ZQmkv9o329m98CUG@shell.armlinux.org.uk>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russel,

On Tue, 2023-09-19 at 14:40 +0100, Russell King (Oracle) wrote:
> On Tue, Sep 19, 2023 at 02:47:20PM +0200, Christian Marangi wrote:
> > Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
> > NRZ in their EEPROM.
> >=20
> > The module also require the ignore tx fault fixup similar to Huawei MA5=
671A
> > as it gets disabled on error messages with serial redirection enabled.
>=20
> I'll send you shortly a different approach for the "ignore tx fault"
> thing that I'd like you to test please.

Said patch is not blocking this one, am I correct?

Thanks,

Paolo


