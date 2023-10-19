Return-Path: <netdev+bounces-42552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2057CF522
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFAC1C209AF
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8F182C1;
	Thu, 19 Oct 2023 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvpnKZBx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76617985
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:25:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7421911F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697711114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XntUvuhro1ALXornIv7c5rBfNf1FPsxFvHaqSzLuXQ=;
	b=QvpnKZBxhWLN1d1vVPB6MP7Ge2UF4dTSx1u1F7RofHfq1JmDa9MTpnnxhxIwlgkBD8ZqJr
	0mu64sPqPrPIeEbvmLkqrMMh1YoREuwyOBhUTJisJAl9Ho6exO10R/fcpE06UBNya/GpER
	3KhNSiPGIoVBRVEpW4/FvyHmAmwmERs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-wl_l-4zqNHOQutBABy5opw-1; Thu, 19 Oct 2023 06:25:03 -0400
X-MC-Unique: wl_l-4zqNHOQutBABy5opw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53eaedf5711so704824a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711102; x=1698315902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XntUvuhro1ALXornIv7c5rBfNf1FPsxFvHaqSzLuXQ=;
        b=YPyWllPO6wxwMDvCOzo1mGlijE3KtjEwCaNn6T4gIBeKF8ZHgy5PyGnFuns7+QpboX
         Q9pS6ca49I2kgIYfMPwb5qVbCHQ4Y8TyEmYXcgofOv7o8EG8xmVCvI3kbvh/rr+/sHaT
         4TPnwF3SJIWDsXmq05OUigbQb9GU4Ekicvkzp7beL/SE2WWrWg7Re9pnVSws6pj419Rd
         iSjcKaMbhlNrrLnFh97VuRDSjxVoasWkM8i2gEKdv0AUhOhhMC8rD0yvfM/7fkRnjsla
         Kyb6SqWMUm3AVEETlfzfeN3nT0URAcdsIIoHVep2l8YI2lx31/xyM25IPuPHT8ctImyU
         9RvA==
X-Gm-Message-State: AOJu0YyyfuoCk9LfEk+9u5zscEdcHKdg/1eChcD/eLXCoxGbX6p84moR
	UhGstpmxFQZpnQ6PdDnGXKZpROhekbA4oF99LR/DNhbqHsjwOuhxTPK1DBKofAeP/o5fiS1vyZh
	Kg+X48B2MPXeT0UqT
X-Received: by 2002:a50:c359:0:b0:53f:1aff:4dc2 with SMTP id q25-20020a50c359000000b0053f1aff4dc2mr1251332edb.4.1697711102122;
        Thu, 19 Oct 2023 03:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF/kxTzU+9JHxinXDTjDZm13nI6jLL/SOYN5tFsvK+CZA1Q2UYBbHY6ENsgHZX0due/fqSyA==
X-Received: by 2002:a50:c359:0:b0:53f:1aff:4dc2 with SMTP id q25-20020a50c359000000b0053f1aff4dc2mr1251321edb.4.1697711101772;
        Thu, 19 Oct 2023 03:25:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id s10-20020a508dca000000b005340d9d042bsm4109287edh.40.2023.10.19.03.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:25:01 -0700 (PDT)
Message-ID: <84fbe8a5d47c81142c5eb07b77288711970051e1.camel@redhat.com>
Subject: Re: [PATCH net 1/1] net: stmmac: update MAC capabilities when tx
 queues are updated
From: Paolo Abeni <pabeni@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Gan, Yi Fang"
	 <yi.fang.gan@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>,  netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Michael
 Sit Wei Hong <michael.wei.hong.sit@intel.com>, Looi Hong Aun
 <hong.aun.looi@intel.com>, Voon Weifeng <weifeng.voon@intel.com>, Song
 Yoong Siang <yoong.siang.song@intel.com>
Date: Thu, 19 Oct 2023 12:24:59 +0200
In-Reply-To: <ZS+IUo5q/AnYm1Gb@shell.armlinux.org.uk>
References: <20231018023137.652132-1-yi.fang.gan@intel.com>
	 <ZS+IUo5q/AnYm1Gb@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-18 at 08:25 +0100, Russell King (Oracle) wrote:
> On Wed, Oct 18, 2023 at 10:31:36AM +0800, Gan, Yi Fang wrote:
> > From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> >=20
> > Upon boot up, the driver will configure the MAC capabilities based on
> > the maximum number of tx and rx queues. When the user changes the
> > tx queues to single queue, the MAC should be capable of supporting Half
> > Duplex, but the driver does not update the MAC capabilities when it is
> > configured so.
> >=20
> > Using the stmmac_reinit_queues() to check the number of tx queues
> > and set the MAC capabilities accordingly.
>=20
> There is other setup elsewhere in the driver that fiddles with this in
> stmmac_phy_setup(). Maybe provide a helper function so that this
> decision making can be made in one function called from both these
> locations, so if the decision making for HD support changes, only one
> place needs changing?

Indeed that looks both straight-forward and more robust.

@Gan, Yi Fang: please send a v2 introducing and using such helper,
thanks!

Paolo


