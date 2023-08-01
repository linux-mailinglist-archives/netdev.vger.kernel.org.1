Return-Path: <netdev+bounces-23091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBAA76AB15
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E5C2812D0
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF71ED36;
	Tue,  1 Aug 2023 08:31:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E051F93C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:31:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4049E0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690878658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74HFyZzMGrXl6va4edyK81bToNdro7Q8TPNruTSzGeA=;
	b=Qzvo5z6ZpJzpLPIJjzzpNj87Uf1dU71i9K/tKYf6cp9WQoYRjH+2Tsmv6KUvaobNVWP7sK
	MVCF5Kt1/QPZAEou8P9aXl9z18IX2IrGyHuocxHmTQfIX2e4841fM27Fyq1JWlMDDJJ1qd
	rezZjNItSDyOUAbe6rL1w8fDGrKUDOs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-7xkwK8mCPBay3l41ayORhw-1; Tue, 01 Aug 2023 04:30:56 -0400
X-MC-Unique: 7xkwK8mCPBay3l41ayORhw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63cc3a44aedso14724176d6.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 01:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690878656; x=1691483456;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74HFyZzMGrXl6va4edyK81bToNdro7Q8TPNruTSzGeA=;
        b=UlNNFVkaWdr1la2zdV7a1Zd374vIHOLgIfd4wkLN1R1woKCszTagwq4m8JoBI9SKFW
         fqda0Nd83tXuD5PzAQ8lfKGFZ0Sf5iIS+nKmfOukp31h9IyxKk880In0iScV2++dL19p
         pUOjrp25mzeuseeZheo29iYzfCNRRimzi9lLrf03YIE7g6xwOEVVa+kLJ71BvOEDLshp
         8sJfJrXHvYjeNSs0M9A+h1MyO27FWSHD93rj7wbujiT7wrQQUDBdv2XUh4+BEx/8Z4Jr
         Vzitb7iTPPDr8yYztwOJL3i7iOOBRmHI2MrfRyUkAjOH/KZs+9LfNJQqmEMV0RRwzBiQ
         bRsQ==
X-Gm-Message-State: ABy/qLaKqPhTuV9KhyA+hhXU2fUB3i645wEO9m8P7RzAY0VgRkWVAAZG
	dQM/K9teCr4YLXmV1btlIz4/4HEXk3Aiwd/+Rdt5yZpMjs6b4qQEdmW197OCYLSwLPbkEPw6ncg
	3jqNEyYHaODVd9ko+
X-Received: by 2002:a05:6214:b65:b0:636:dae2:dc4 with SMTP id ey5-20020a0562140b6500b00636dae20dc4mr12989936qvb.5.1690878656461;
        Tue, 01 Aug 2023 01:30:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHT3PxdTQNoH2RsucmSFn8YWer2+i7WFZ+JIJKrUcKl2dSkmWj4E0lvuRhAOsE7pYlzv3B+w==
X-Received: by 2002:a05:6214:b65:b0:636:dae2:dc4 with SMTP id ey5-20020a0562140b6500b00636dae20dc4mr12989920qvb.5.1690878656140;
        Tue, 01 Aug 2023 01:30:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id n2-20020a0ce542000000b0061b5dbf1994sm4372381qvm.146.2023.08.01.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:30:55 -0700 (PDT)
Message-ID: <cd2b2456b1853d71b1c84c152164732f3a39f4dc.camel@redhat.com>
Subject: Re: [PATCH v4] bnx2x: Fix error recovering in switch configuration
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com, 
	manishc@marvell.com, netdev@vger.kernel.org, skalluru@marvell.com, 
	drc@linux.vnet.ibm.com, abdhalee@in.ibm.com, simon.horman@corigine.com
Date: Tue, 01 Aug 2023 10:30:52 +0200
In-Reply-To: <20230731174716.0898ff62@kernel.org>
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
	 <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
	 <20230731174716.0898ff62@kernel.org>
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

On Mon, 2023-07-31 at 17:47 -0700, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 16:11:33 -0500 Thinh Tran wrote:
> > As the BCM57810 and other I/O adapters are connected
> > through a PCIe switch, the bnx2x driver causes unexpected
> > system hang/crash while handling PCIe switch errors, if
> > its error handler is called after other drivers' handlers.
> >=20
> > In this case, after numbers of bnx2x_tx_timout(), the
> > bnx2x_nic_unload() is  called, frees up resources and
> > calls bnx2x_napi_disable(). Then when EEH calls its
> > error handler, the bnx2x_io_error_detected() and
> > bnx2x_io_slot_reset() also calling bnx2x_napi_disable()
> > and freeing the resources.
> >=20
> >=20
> > Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
> > Reviewed-by: Manish Chopra <manishc@marvell.com>
> > Tested-by: Abdul Haleem <abdhalee@in.ibm.com>
> > Tested-by: David Christensen <drc@linux.vnet.ibm.com>
> >=20
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
>=20
> nit: no empty lines between tags
>=20
> There should be a "---" line between the tags and changelog.
>=20
> >   v4:
> >    - factoring common code into new function bnx2x_stop_nic()
> >      that disables and releases IRQs and NAPIs=20
> >   v3:
> >     - no changes, just repatched to the latest driver level
> >     - updated the reviewed-by Manish in October, 2022
> >=20
> >   v2:
> >    - Check the state of the NIC before calling disable nappi
> >      and freeing the IRQ
> >    - Prevent recurrence of TX timeout by turning off the carrier,
> >      calling netif_carrier_off() in bnx2x_tx_timeout()
> >    - Check and bail out early if fp->page_pool already freed
> >=20
> > ---
> >  drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  2 ++
>=20
> > @@ -3095,14 +3097,8 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unloa=
d_mode, bool keep_link)
> >  		if (!CHIP_IS_E1x(bp))
> >  			bnx2x_pf_disable(bp);
> > =20
> > -		/* Disable HW interrupts, NAPI */
> > -		bnx2x_netif_stop(bp, 1);
> > -		/* Delete all NAPI objects */
> > -		bnx2x_del_all_napi(bp);
> > -		if (CNIC_LOADED(bp))
> > -			bnx2x_del_all_napi_cnic(bp);
> > -		/* Release IRQs */
> > -		bnx2x_free_irq(bp);
>=20
> Could you split the change into two patches - one factoring out the
> code into bnx2x_stop_nic() and the other adding the nic_stopped
> variable? First one should be pure code refactoring with no functional
> changes. That'd make the reviewing process easier.
>=20
> > +		/* Disable HW interrupts, delete NAPIs, Release IRQs */
> > +		bnx2x_stop_nic(bp);
> > =20
> >  		/* Report UNLOAD_DONE to MCP */
> >  		bnx2x_send_unload_done(bp, false);
> > @@ -4987,6 +4983,12 @@ void bnx2x_tx_timeout(struct net_device *dev, un=
signed int txqueue)
> >  {
> >  	struct bnx2x *bp =3D netdev_priv(dev);
> > =20
> > +	/* Immediately indicate link as down */
> > +	bp->link_vars.link_up =3D 0;
> > +	bp->force_link_down =3D true;
> > +	netif_carrier_off(dev);
> > +	BNX2X_ERR("Indicating link is down due to Tx-timeout\n");
>=20
> Is this code move to make the shutdown more immediate?
> That could also be a separate patch.

Note that the original code run under the rtnl lock and this is not
lockless, it that safe?

Cheers,

Paolo


