Return-Path: <netdev+bounces-31529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE878E916
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269AD280D07
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE1847A;
	Thu, 31 Aug 2023 09:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4CA210A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:10:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC7CE6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693473006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BzTE6iveZZSL/qke02UmOFuqyQVPsM06jev1BURIww=;
	b=QeNGPpyFsHIKg3QJ0u486E/J3Dng6bMNtZkXLVM2j/ZZvcZN8yc4J3xMWKF/1x4ET2GkS9
	IlKVCO6nnMVpt4Bd1k3+fGVIlEWdeDPCK/lR4owydCa9n/LhJ2oj7BZhxVh1U4YmnOIQJF
	HRWMzn9UeglQ7uBr9sDuS06etfZB1Ts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-t4oByPbYOoOpIbH8O_RMxg-1; Thu, 31 Aug 2023 05:10:04 -0400
X-MC-Unique: t4oByPbYOoOpIbH8O_RMxg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401d62c2de7so1787505e9.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693473003; x=1694077803;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BzTE6iveZZSL/qke02UmOFuqyQVPsM06jev1BURIww=;
        b=RpUOPUS93JedrhGV/4DIw05byycxNG/A7qzIkylGB0fOH2MgdqfRx8nq3pvbkI5qT/
         Sdur7nqIghSGl7oEwnvTcQhF+h4t2ECCD+RCqJE9ynTKu1NQk/e2ef4c4FFVX8SmuS+M
         aGrAGNh2FJ+i19VwXxs9FY7EvDk2tg2tGEQ5iDeERzUFa1j5P/tOzeaf2t54uyVHNhtS
         f+0c6Kbf63fuz1X9GmYM1kMXAXIaYMjWC3IXlOOJPlIxuB+xhLOU6FwFSIxWpD09QuEL
         kaYkCoIBGBPHk8HDQj5rJo2wB4YKUfUS1sxRMpvuiQz6vLqWwSI9UON092lvaL7Mz9K9
         HCUg==
X-Gm-Message-State: AOJu0YykSy5dn2v/f/Q+9TxJMUAfj3fihkcjiYbrvN25gDteFE3z3Umv
	/HeyOL4xTYJY36oQ5JbEsh1i42S0a4NkCz3ZPkP7m92EFfWCumLSgoxEr7GmUA1M1LXcOxtTzAs
	aDNdj2nZ5uM5R9ljF
X-Received: by 2002:a05:600c:1c05:b0:401:c07f:72bd with SMTP id j5-20020a05600c1c0500b00401c07f72bdmr3721348wms.4.1693473003535;
        Thu, 31 Aug 2023 02:10:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBvYLYX1TbgI+F5VAn3QQ+wii4EVihSIxsp63bCsCHtELfSbFvjM4cLcRtcp/CrbrhiMgGcQ==
X-Received: by 2002:a05:600c:1c05:b0:401:c07f:72bd with SMTP id j5-20020a05600c1c0500b00401c07f72bdmr3721323wms.4.1693473003192;
        Thu, 31 Aug 2023 02:10:03 -0700 (PDT)
Received: from gerbillo.redhat.com (host-87-20-178-126.retail.telecomitalia.it. [87.20.178.126])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b003fe1c332810sm4527349wme.33.2023.08.31.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:10:02 -0700 (PDT)
Message-ID: <6b4733f4a5bedd465b7ee5ea435dcdaf12a61321.camel@redhat.com>
Subject: Re: [PATCH 1/4] net: dsa: Extend the dsa_switch structure to hold
 info about HSR ports
From: Paolo Abeni <pabeni@redhat.com>
To: Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com, Eric Dumazet
	 <edumazet@google.com>, davem@davemloft.net, Woojung Huh
	 <woojung.huh@microchip.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Jakub Kicinski
	 <kuba@kernel.org>, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 31 Aug 2023 11:10:00 +0200
In-Reply-To: <20230829121132.414335-2-lukma@denx.de>
References: <20230829121132.414335-1-lukma@denx.de>
	 <20230829121132.414335-2-lukma@denx.de>
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

On Tue, 2023-08-29 at 14:11 +0200, Lukasz Majewski wrote:
> Information about HSR aware ports in a DSA switch can be helpful when
> one needs tags to be adjusted before the HSR frame is sent.
>=20
> For example - with ksz9477 switch - the TAG needs to be adjusted to have
> both HSR ports marked in tag to allow execution of HW based frame
> duplication.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  include/net/dsa.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index d309ee7ed04b..15274afc42bb 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -470,6 +470,9 @@ struct dsa_switch {
>  	/* Number of switch port queues */
>  	unsigned int		num_tx_queues;
> =20
> +	/* Bitmask indicating ports supporting HSR */
> +	u16                     hsr_ports;
> +
>  	/* Drivers that benefit from having an ID associated with each
>  	 * offloaded LAG should set this to the maximum number of
>  	 * supported IDs. DSA will then maintain a mapping of _at

Out of sheer ignorance, I think this new field does not belong to
dsa_switch, at least not in this form. AFAICS there is no current hard
limitation on the number of ports a DSA switch can handle at the API
level, and this will introduce an hard one.

I think you are better off keeping this field in the KSZ-specific
struct. If you really want to keep it here you should remove the above
limitation somehow (possibly a query op to check if a given port is HSR
aware???)

In any case this series looks like net-next material, does not apply
correctly to net-next and net-next is currently closed. You can share a
new version as RFC or wait for net-next to re-open in ~2w.

Cheers,

Paolo


