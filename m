Return-Path: <netdev+bounces-17587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C6D7521DD
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAE21C21396
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CDF9F7;
	Thu, 13 Jul 2023 12:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBBF9E3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:50:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE53326AC
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689252553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEH+MIbrb/f0v8KKIqNFOQt9+3/4sgWJ0QURBPgwaPk=;
	b=OTHE4v/ARkxBH1wm75oJ9spachPpZ+XGK8hgkRs6Qf4Qtn1UVJ9f6il4/Szjc5z8iE9at8
	MPpI9rE1k6qEht0M5DTcGEYgWHP3gVhkA/iX0aJin2zdJNL5mQ9Q/NVLhYg8BUNB5GiolI
	w7/NiMn5Uw4KBoN4AlXbPlOxcMB/pvg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-0b650qBMOr-iFiC2FmGXZA-1; Thu, 13 Jul 2023 08:49:11 -0400
X-MC-Unique: 0b650qBMOr-iFiC2FmGXZA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403a1b0e259so1721881cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252551; x=1691844551;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEH+MIbrb/f0v8KKIqNFOQt9+3/4sgWJ0QURBPgwaPk=;
        b=Rl8VFoXSMLRp83IALor6BKUznRWL3AHiWOoz2kj6Nlcn++R2CnZr3EVMBBR8nBUdrp
         sm3O+445lIZzOuA3yLjKOoQEkzrZ4PdmzA0fHUWpAvAQHijP9aMzIvSQYGevZnF9OlJZ
         8dTsBafYwfirRoEIBuYIXt/GGypxF4A3G+gI9EqTNwAOyV5P4LRdTt7VyEt5F04KhBq6
         aF3oNhYY4vSp6CEO6Odm1qoGXcZe1fVnaA4MWVEcJXZryNljtuVWHxK0o4U84IFK/997
         jTssuQIbx7FjTXaY5HCjhdvAEfRtZBjBbmU76i43fIoHgktgAedNfPuqbRKEuwdveZpn
         z1fA==
X-Gm-Message-State: ABy/qLYu1qZRsAzzelZrvQW2EekMduy7Q/pHKzPotVoyt3jfPV4OFtpX
	FIEJnO6jEhmwGCUv2KG76ggriTdckkJZoOM7Rppr8nHXVSpgUU03HK8qvfB0XLVQ7w3wmNITOZd
	u6qWEJEAhl5j1Zm044P80DIBv
X-Received: by 2002:a05:622a:19a9:b0:400:990c:8f7c with SMTP id u41-20020a05622a19a900b00400990c8f7cmr1485987qtc.0.1689252551280;
        Thu, 13 Jul 2023 05:49:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGACOfct0D1KMNQ/eKeMW3LT+7MZHHtob9ZvnwA3uh1XUKTFGMvfSrzPZ5DZu8VUZgso2Jcmg==
X-Received: by 2002:a05:622a:19a9:b0:400:990c:8f7c with SMTP id u41-20020a05622a19a900b00400990c8f7cmr1485971qtc.0.1689252551002;
        Thu, 13 Jul 2023 05:49:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id cr16-20020a05622a429000b003f9bccc3182sm3050553qtb.32.2023.07.13.05.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 05:49:10 -0700 (PDT)
Message-ID: <520aeaeae454ed7e044e147be4b4edd9495d480b.camel@redhat.com>
Subject: Re: [PATCH net-next v3] net: txgbe: change LAN reset mode
From: Paolo Abeni <pabeni@redhat.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
Date: Thu, 13 Jul 2023 14:49:08 +0200
In-Reply-To: <20230711062623.3058-1-jiawenwu@trustnetic.com>
References: <20230711062623.3058-1-jiawenwu@trustnetic.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Tue, 2023-07-11 at 14:26 +0800, Jiawen Wu wrote:
> The old way to do LAN reset is sending reset command to firmware. Once
> firmware performs reset, it reconfigures what it needs.
>=20
> In the new firmware versions, veto bit is introduced for NCSI/LLDP to
> block PHY domain in LAN reset. At this point, writing register of LAN
> reset directly makes the same effect as the old way. And it does not
> reset MNG domain, so that veto bit does not change.
>=20
> And this change is compatible with old firmware versions, since veto
> bit was never used.

As the current commit message wording still raises questions, could you
please explicitly the level of compatibility of both the old and new
firmware pre/after this change?

And please drop the fixes tag, thanks!

Paolo



