Return-Path: <netdev+bounces-166484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BFDA36222
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8433B31E3
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F272673AD;
	Fri, 14 Feb 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OK5miJOJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117E2673AE;
	Fri, 14 Feb 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547873; cv=none; b=j2yW+iEp9uvitk9+Rw6LQ+D/QHx6NdaeElYeGaJ59BK1xqTA+FW03fG6zaruhCBY1lWBxpE7ujlbqwN7QS9l0SgKViadar4/oJ5fXGeI2MyKGDu9Z2HBUGqw4Hbsi8Lb1mriYXV71q0pwR6tPUVt2qxbl/B2AEFQYWuuwUA/GNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547873; c=relaxed/simple;
	bh=zsRwvnv/M28J39lw+VCysnL1n0zTtcQPCFYKGLmz7pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3fcxeHRDb9ZXU7j8sXe/Kjte7pzUYN9Z3nqqUxkfuqc50VWRyFmw0VCjjprXFzzJLXVPFoW3bKshdwifgOchS/1Lix7g90QLDlZLUHoxZoaM1ClOjHypgPirREopUGXFA3SVzD2bUPqomV4oMgwkEzi2LxQAYWNi4i8RiUu478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OK5miJOJ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0B6E441CF;
	Fri, 14 Feb 2025 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739547868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+PKxLoAHL0OKiOb08grmk94WrSubefSKGNnWVGebmI=;
	b=OK5miJOJnRHgzhZeOv6bEJp90XE2/B044jLfMkhE/dkQX4ZWvP4dybs4/3gVcodXPthzp9
	19fHEEdO8FJynxySa03hMIZeWxpMfmWQQSV0W0ZhK6uvpGP+L8MSSnncfrhvGm7NbwSVEK
	dCm3JK9Vwht9KFnAZgp6OcLKk9yWNKE1j38rL2FibzKzcoO6wcegLzaxiyQSdkqHf3SPOX
	7xo/19sF1W2ODueTSqiWu1UFVg5KvYc1g01G+QViX8APL4+682KwCFhwTg23kJQ4+Ebbs/
	YpG3ZTP37vPoZlImaIvbeQyNu4UhDkBHCCIILZa+oQUfmx/vzzeJzSFoyk6FKw==
Date: Fri, 14 Feb 2025 16:44:22 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: parvathi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
 richardcochran@gmail.com, basharath@couthit.com, schnelle@linux.ibm.com,
 diogo.ivo@siemens.com, m-karicheri2@ti.com, horms@kernel.org,
 jacob.e.keller@intel.com, m-malladi@ti.com, javier.carrasco.cruz@gmail.com,
 afd@ti.com, s-anna@ti.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratheesh@ti.com, prajith@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v3 04/10] net: ti: prueth: Adds link detection,
 RX and TX support.
Message-ID: <20250214164422.1bb58a89@fedora.home>
In-Reply-To: <20250214073757.1076778-5-parvathi@couthit.com>
References: <20250214054702.1073139-1-parvathi@couthit.com>
	<20250214073757.1076778-5-parvathi@couthit.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfeejpdhrtghpthhtohepphgrrhhvrghthhhisegtohhuthhhihhtrdgtohhmpdhrtghpthhtohepuggrnhhishhhrghnfigrrhesthhirdgtohhmpdhrtghpthhtoheprhhoghgvrhhqsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehlu
 hhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Fri, 14 Feb 2025 13:07:51 +0530
parvathi <parvathi@couthit.com> wrote:

> From: Roger Quadros <rogerq@ti.com>
> 
> Changes corresponding to link configuration such as speed and duplexity.
> IRQ and handler initializations are performed for packet reception.Firmware
> receives the packet from the wire and stores it into OCMC queue. Next, it
> notifies the CPU via interrupt. Upon receiving the interrupt CPU will
> service the IRQ and packet will be processed by pushing the newly allocated
> SKB to upper layers.
> 
> When the user application want to transmit a packet, it will invoke
> sys_send() which will inturn invoke the PRUETH driver, then it will write
> the packet into OCMC queues. PRU firmware will pick up the packet and
> transmit it on to the wire.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>


> +/* update phy/port status information for firmware */
> +static void icssm_emac_update_phystatus(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	u32 phy_speed, port_status = 0;
> +	enum prueth_mem region;
> +	u32 delay;
> +
> +	region = emac->dram;
> +	phy_speed = emac->speed;
> +	icssm_prueth_write_reg(prueth, region, PHY_SPEED_OFFSET, phy_speed);
> +
> +	delay = TX_CLK_DELAY_100M;
> +
> +	delay = delay << PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_SHIFT;
> +
> +	if (emac->port_id) {
> +		regmap_update_bits(prueth->mii_rt,
> +				   PRUSS_MII_RT_TXCFG1,
> +				   PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_MASK,
> +				   delay);
> +	} else {
> +		regmap_update_bits(prueth->mii_rt,
> +				   PRUSS_MII_RT_TXCFG0,
> +				   PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_MASK,
> +				   delay);
> +	}
> +
> +	if (emac->link)
> +		port_status |= PORT_LINK_MASK;
> +
> +	writeb(port_status, prueth->mem[region].va + PORT_STATUS_OFFSET);
> +}
> +
>  /* called back by PHY layer if there is change in link state of hw port*/
>  static void icssm_emac_adjust_link(struct net_device *ndev)
>  {
> @@ -369,6 +426,8 @@ static void icssm_emac_adjust_link(struct net_device *ndev)
>  		emac->link = 0;
>  	}
>  
> +	icssm_emac_update_phystatus(emac);
> +

It looks to me like emac->link, emac->speed and emac->duplex are only
used in icssm_emac_update_phystatus(). If you consider either passing
these as parameters to the above function, or simply merge
icssm_emac_update_phystatus() into your adjust_link callback, you can get
rid of these 3 attributes entirely. It even looks like emac->duplex is
simply unused.

Thanks,

Maxime

