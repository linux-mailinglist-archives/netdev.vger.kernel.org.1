Return-Path: <netdev+bounces-90666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E6A8AF757
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 21:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050FD1C21EC6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946471411DE;
	Tue, 23 Apr 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E2LxU41e"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC013E418
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900588; cv=none; b=GaiMX6HrpzwQ1gbTn4K5wX56elP3sLf6RUhyJ+1Fs/Fk110f5c5MEwghy9KDYLzKj1V06jmAwfsLB7y0b4MXNy3YVsFr5APEQi1GrctkTffUegQ4186GuNyzXQ/sm6UCuzfY87Z2fTghetLaqOu1rLCiMDgI22nDrBR7fN/z1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900588; c=relaxed/simple;
	bh=odvs53J89vHkxamj8JtAAYYYthFoYRIwiYqr53H9o4A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j50WvlEDf4IpVhATxTuvbadf4vFGs6bzr6DrDdYzR1pB9RMF6c/bQ6UHhWVBOoQqBswxYgI1DGsdgrGLFcrGyTx/N5c+aEIQRJvFAJpd16P1qXJDT7OBpD+niowhNvmeFJF2TRQA6A7CMneeNewgl/zJXcRFvUemikD4ZTf3mAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E2LxU41e; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713900588; x=1745436588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=odvs53J89vHkxamj8JtAAYYYthFoYRIwiYqr53H9o4A=;
  b=E2LxU41e9LEkSExyipihkdz82ZdTaiTiORZ1ylEo0xDYDooGcla7JCAT
   rsH57LmTqyXDTPnn08Zav9otKIjaQ2x7KELoP16LDwD0AwLKBMmLDlODj
   PG+4V4qPdReEaFO1Ywjr8t0N0caJlbigaRzdzpMYR5dN1r2RXlQiUczmu
   Qn19K3QZho8ya27nu+L+NA/xXhcwAyHGAnBF/3ZjSARw/lKf0JuBHDNjw
   uVw2k2c+8CIEX6HWs78ekvUPFfuUY7iYmTzsMrcP0FJrgRSY1FKWkEl4m
   D3w+KkyeL7duEGspHvBCEP8/m9MM/0xO4ipAX1YI//YqMUihVIpOAFrJm
   A==;
X-CSE-ConnectionGUID: SD2mN5/IQM20Rk6USUIJug==
X-CSE-MsgGUID: gCTb8hoCSFCt/0pTMDJExA==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208";a="22340301"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 12:29:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 12:29:33 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 12:29:31 -0700
Date: Tue, 23 Apr 2024 19:29:30 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Bryan Whitehead <bryan.whitehead@microchip.com>,
	"Richard Cochran" <richardcochran@gmail.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next 4/4] net: sparx5: Correct spelling in comments
Message-ID: <20240423192930.okhvbvlao6ke3pkl@DEN-DL-M70577>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
 <20240419-lan743x-confirm-v1-4-2a087617a3e5@kernel.org>
 <20240420192424.42z2aztt73grdvsj@DEN-DL-M70577>
 <20240422105756.GC42092@kernel.org>
 <20240423112915.5cmqvmvwfwutahky@DEN-DL-M70577>
 <20240423135417.GT42092@kernel.org>
 <20240423161849.GW42092@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240423161849.GW42092@kernel.org>

> On Tue, Apr 23, 2024 at 02:54:17PM +0100, Simon Horman wrote:
> > On Tue, Apr 23, 2024 at 11:29:15AM +0000, Daniel Machon wrote:
> > > > > Hi Simon,
> > > > >
> > > > > > -/* Convert validation error code into tc extact error message */
> > > > > > +/* Convert validation error code into tc exact error message */
> > > > >
> > > > > This seems wrong. I bet it refers to the 'netlink_ext_ack' struct. So
> > > > > the fix should be 'extack' instead.
> > > > >
> > > > > >  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule)
> > > > > >  {
> > > > > >         switch (vrule->exterr) {
> > > > > > diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > > index 56874f2adbba..d6c3e90745a7 100644
> > > > > > --- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > > +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > > @@ -238,7 +238,7 @@ const struct vcap_set *vcap_keyfieldset(struct vcap_control *vctrl,
> > > > > >  /* Copy to host byte order */
> > > > > >  void vcap_netbytes_copy(u8 *dst, u8 *src, int count);
> > > > > >
> > > > > > -/* Convert validation error code into tc extact error message */
> > > > > > +/* Convert validation error code into tc exact error message */
> > > > >
> > > > > Same here.
> > > >
> > > > Thanks Daniel,
> > > >
> > > > Silly me. I'll drop these changes in v2.
> > >
> > > No reason to drop them just change it to 'extack' :-)
> >
> > Thanks, will do.
> 
> Sorry, I am somehow confused.
> 
> Do you mean like this?
> 
> /* Convert validation error code into extact error message */
> 
> Or just leave things unchanged?
> 
> /* Convert validation error code into tc extact error message */

Should be:

  /* Convert validation error code into tc extack error message */

So the misspelling was real, just the fix was extack and not exact.

/Daniel

