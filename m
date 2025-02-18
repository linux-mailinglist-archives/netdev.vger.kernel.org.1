Return-Path: <netdev+bounces-167265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D2A3981B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1003B8817
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B81323496A;
	Tue, 18 Feb 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="skjPJG3q"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3919234962;
	Tue, 18 Feb 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872733; cv=none; b=m2fd6BC9rJ+E6msvBSKMaRj7xUEw5YxjBtPInqqV+NtcvwoVqzR3xFfBbSWUwdfSDZGrUPJnxUJbQOyFRtmBLHz1vtQLHbWr+iDijdeXOlyfhznHKq4g58INkZi92IrH6C0y+b9XEFDGvBAyk0wubsAfQRkzz9/jhJWKnTia3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872733; c=relaxed/simple;
	bh=/5c9NpxXM4pSZx9SBXZ0Bku0kkqiwO9j8xWtCl97MGc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Bzd0kut14udFZqTGmpRK4SvaFNo21JyV4QDjGADYyRKDSwo5YJXf9l9XZVTHOfJLM43je0143j93e7yyVlLBo3q6MViXCc5YdxP8t0tdtrKA0EIt0VIdlQr43YzmAfY/gOrauZQGk9cbtH6M73xC9q/zxEgSzW//1SprFaH7azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=skjPJG3q; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IplbbsjtQNJ9e6AF522ZXUvBfXM+LfwzW90At7QJSew=; b=skjPJG3qHyyrQxKdigVU5Yrf/3
	Yj1J/c5z6dFoGQWIMJTz4LBoTxUbW8gsCvnA4wrW7EZhOq66KKLmF+eUxYtNF0/HOxlgJn5x9roGh
	5TeDGN3kOkGFJ8y8IQFZR39DRkbtQeRdu7QKAw+YKlU0G+JbpWpKyzpA3xItlRY2rqL349W98C9Mg
	WegKmZcHRR3VkNP4DPHhdZzVHw02BBXWB0OuikiFV0Zr5Ibng073GjDtPHAVyf6sSNrSKfAylxAAK
	TcjfojLRd+Ix+3zdxJ1yc/08VFtBY1EGx3p9oIi+SrbylPcIA5adTn/LlD1AVu/CKdCaEhXgpXt7o
	p1+xvIRg==;
Received: from [122.175.9.182] (port=27501 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parvathi@couthit.com>)
	id 1tkKND-0007xL-1i;
	Tue, 18 Feb 2025 15:28:40 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id AEF9617821C8;
	Tue, 18 Feb 2025 15:28:29 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 85C9C17823D4;
	Tue, 18 Feb 2025 15:28:29 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SPe3V9-vo6EN; Tue, 18 Feb 2025 15:28:29 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 41B8D17821C8;
	Tue, 18 Feb 2025 15:28:29 +0530 (IST)
Date: Tue, 18 Feb 2025 15:28:29 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org, 
	richardcochran@gmail.com, basharath <basharath@couthit.com>, 
	schnelle@linux.ibm.com, diogo ivo <diogo.ivo@siemens.com>, 
	m-karicheri2@ti.com, horms@kernel.org, 
	jacob e keller <jacob.e.keller@intel.com>, m-malladi@ti.com, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, afd@ti.com, 
	s-anna@ti.com, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pratheesh <pratheesh@ti.com>, 
	Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth@ti.com, srk@ti.com, 
	rogerq@ti.com, krishna <krishna@couthit.com>, 
	pmohan <pmohan@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <1901840071.600762.1739872709135.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250214164422.1bb58a89@fedora.home>
References: <20250214054702.1073139-1-parvathi@couthit.com> <20250214073757.1076778-5-parvathi@couthit.com> <20250214164422.1bb58a89@fedora.home>
Subject: Re: [PATCH net-next v3 04/10] net: ti: prueth: Adds link detection,
 RX and TX support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds link detection, RX and TX support.
Thread-Index: ruvuX5QuiCck3qy25K/1ke8txq1XdQ==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Hi,

> On Fri, 14 Feb 2025 13:07:51 +0530
> parvathi <parvathi@couthit.com> wrote:
> 
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> Changes corresponding to link configuration such as speed and duplexity.
>> IRQ and handler initializations are performed for packet reception.Firmware
>> receives the packet from the wire and stores it into OCMC queue. Next, it
>> notifies the CPU via interrupt. Upon receiving the interrupt CPU will
>> service the IRQ and packet will be processed by pushing the newly allocated
>> SKB to upper layers.
>> 
>> When the user application want to transmit a packet, it will invoke
>> sys_send() which will inturn invoke the PRUETH driver, then it will write
>> the packet into OCMC queues. PRU firmware will pick up the packet and
>> transmit it on to the wire.
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> 
> 
>> +/* update phy/port status information for firmware */
>> +static void icssm_emac_update_phystatus(struct prueth_emac *emac)
>> +{
>> +	struct prueth *prueth = emac->prueth;
>> +	u32 phy_speed, port_status = 0;
>> +	enum prueth_mem region;
>> +	u32 delay;
>> +
>> +	region = emac->dram;
>> +	phy_speed = emac->speed;
>> +	icssm_prueth_write_reg(prueth, region, PHY_SPEED_OFFSET, phy_speed);
>> +
>> +	delay = TX_CLK_DELAY_100M;
>> +
>> +	delay = delay << PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_SHIFT;
>> +
>> +	if (emac->port_id) {
>> +		regmap_update_bits(prueth->mii_rt,
>> +				   PRUSS_MII_RT_TXCFG1,
>> +				   PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_MASK,
>> +				   delay);
>> +	} else {
>> +		regmap_update_bits(prueth->mii_rt,
>> +				   PRUSS_MII_RT_TXCFG0,
>> +				   PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_MASK,
>> +				   delay);
>> +	}
>> +
>> +	if (emac->link)
>> +		port_status |= PORT_LINK_MASK;
>> +
>> +	writeb(port_status, prueth->mem[region].va + PORT_STATUS_OFFSET);
>> +}
>> +
>>  /* called back by PHY layer if there is change in link state of hw port*/
>>  static void icssm_emac_adjust_link(struct net_device *ndev)
>>  {
>> @@ -369,6 +426,8 @@ static void icssm_emac_adjust_link(struct net_device *ndev)
>>  		emac->link = 0;
>>  	}
>>  
>> +	icssm_emac_update_phystatus(emac);
>> +
> 
> It looks to me like emac->link, emac->speed and emac->duplex are only
> used in icssm_emac_update_phystatus(). If you consider either passing
> these as parameters to the above function, or simply merge
> icssm_emac_update_phystatus() into your adjust_link callback, you can get
> rid of these 3 attributes entirely. It even looks like emac->duplex is
> simply unused.
> 

Sure, we will address this in the next version.

Thanks and Regards,
Parvathi.

