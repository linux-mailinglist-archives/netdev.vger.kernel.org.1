Return-Path: <netdev+bounces-184137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457AAA936F7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8249A7A4579
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0D253B6E;
	Fri, 18 Apr 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="GXiJnl4D"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE41A3168;
	Fri, 18 Apr 2025 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979015; cv=none; b=VWZEvhnhyHXRC/mOojW2AQSrK1l0x78/ZnKPq3MIlpkgI/sm4K+j/Vq49Wyj3cI5g0IfVBqfMM52fPXf+WHyBOOnXTvk1UYfgbZ8uiKjM02aB7yVAZq17ENcz1sqg8O13y+h9jOMVaSzk5Z79jHakK0d8vwOWaloVNmezwrC+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979015; c=relaxed/simple;
	bh=/athQpagqGCJQydUSSRxJ6e7ydT+ucVxDrLxoePgYOU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LI/JDJTjhLJ2HiGL+bF+BJjP7+LA3LcAFk7+ChWSxVwbHCkD4bsUm/PcOsfP6z0sIS3MLvppNdn75tHQodkuQR9468xI3WQp3MOuOeZbfxIr3xdrBdnl+UxONRaHG0SOKYFSyXOOvIa+TKD4B8eUsiCMOqX2lDB4HiPA8UTO8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=GXiJnl4D; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6N8phbfSv9V0CpUrr5t8I9tEoX+mLXZakuN/NJixNGw=; b=GXiJnl4D0z2eqznZsfm7Xsd/EU
	+02d/HwTSj/ip/0N44Tlz/UButm0fDm0wXLu8eyDeqwAf1K9/zuJq0k4EHF80fFU0jneSL5mBTegg
	cwbJigiNr9UvZppwKOTVhBwUFrtU2w1FYv7GFOUqplxcRCfPPLF6CoYDXOLEPKzNihvIUqWFspG7O
	LA6Lo9TzzE72MtTcTcGQNoxM/euZGRqdWBEmbFU4d1hvSpqgZHSQXakzC7z0DfaozCtDfOMuBy3gq
	eD2OUT6VqCv8Pyzxd6x+AMYolVobsOt8JdAsbQjLHsUdaZ0aaDktQP5H8B836UAZBIiznPze/pKSr
	LyGftaZA==;
Received: from [122.175.9.182] (port=16515 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u5kkY-000000004ak-3tGs;
	Fri, 18 Apr 2025 17:53:19 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 60FFA17823F4;
	Fri, 18 Apr 2025 17:53:09 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 3B2471783F61;
	Fri, 18 Apr 2025 17:53:09 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UmjO3TSNTQeh; Fri, 18 Apr 2025 17:53:09 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id E4DC917823F4;
	Fri, 18 Apr 2025 17:53:08 +0530 (IST)
Date: Fri, 18 Apr 2025 17:53:08 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: horms <horms@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, nm <nm@ti.com>, 
	ssantosh <ssantosh@kernel.org>, tony <tony@atomide.com>, 
	richardcochran <richardcochran@gmail.com>, 
	glaroque <glaroque@baylibre.com>, schnelle <schnelle@linux.ibm.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	rdunlap <rdunlap@infradead.org>, diogo ivo <diogo.ivo@siemens.com>, 
	basharath <basharath@couthit.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi <m-malladi@ti.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	afd <afd@ti.com>, s-anna <s-anna@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <440344110.1093115.1744978988608.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250416091632.GM395307@horms.kernel.org>
References: <20250414113458.1913823-1-parvathi@couthit.com> <20250414113458.1913823-3-parvathi@couthit.com> <20250416091632.GM395307@horms.kernel.org>
Subject: Re: [PATCH net-next v5 02/11] net: ti: prueth: Adds ICSSM Ethernet
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds ICSSM Ethernet driver
Thread-Index: S0aUb2vCfdcMlVbjfjteCA2lYt5ujg==
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

> On Mon, Apr 14, 2025 at 05:04:49PM +0530, Parvathi Pudi wrote:
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> Updates Kernel configuration to enable PRUETH driver and its dependencies
>> along with makefile changes to add the new PRUETH driver.
>> 
>> Changes includes init and deinit of ICSSM PRU Ethernet driver including
>> net dev registration and firmware loading for DUAL-MAC mode running on
>> PRU-ICSS2 instance.
>> 
>> Changes also includes link handling, PRU booting, default firmware loading
>> and PRU stopping using existing remoteproc driver APIs.
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> 
> ...
> 
>> +static int icssm_prueth_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *eth0_node = NULL, *eth1_node = NULL;
>> +	struct device_node *eth_node, *eth_ports_node;
>> +	enum pruss_pru_id pruss_id0, pruss_id1;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np;
>> +	struct prueth *prueth;
>> +	int i, ret;
>> +
>> +	np = dev->of_node;
>> +	if (!np)
>> +		return -ENODEV; /* we don't support non DT */
>> +
>> +	prueth = devm_kzalloc(dev, sizeof(*prueth), GFP_KERNEL);
>> +	if (!prueth)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, prueth);
>> +	prueth->dev = dev;
>> +	prueth->fw_data = device_get_match_data(dev);
>> +
>> +	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
>> +	if (!eth_ports_node)
>> +		return -ENOENT;
>> +
>> +	for_each_child_of_node(eth_ports_node, eth_node) {
>> +		u32 reg;
>> +
>> +		if (strcmp(eth_node->name, "ethernet-port"))
>> +			continue;
>> +		ret = of_property_read_u32(eth_node, "reg", &reg);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%pOF error reading port_id %d\n",
>> +				eth_node, ret);
>> +		}
>> +
>> +		of_node_get(eth_node);
> 
> Hi Roger, Parvathi, all,
> 
> I feel that I'm missing something obvious here.
> But I have some questions about the reference to eth_node
> taken on the line above.
> 
>> +
>> +		if (reg == 0) {
>> +			eth0_node = eth_node;
> 
> If, while iterating through the for loop above, we reach this point more
> than once, then will the reference to the previously node assigned to
> eth0_node be leaked?
> 

We will modify the condition as below to avoid leaks
if ((reg == 0) && (eth0_node == NULL))

>> +			if (!of_device_is_available(eth0_node)) {
>> +				of_node_put(eth0_node);
>> +				eth0_node = NULL;
>> +			}
>> +		} else if (reg == 1) {
>> +			eth1_node = eth_node;
> 
> Likewise here for eth1_node.
> 

We will modify this also as below
if ((reg == 1) && (eth1_node == NULL))

>> +			if (!of_device_is_available(eth1_node)) {
>> +				of_node_put(eth1_node);
>> +				eth1_node = NULL;
>> +			}
>> +		} else {
>> +			dev_err(dev, "port reg should be 0 or 1\n");
> 
> And, perhaps more to the point, is the reference to eth_node leaked if
> we reach this line?
> 

We will check and add of_node_put(eth_node) at the end of the for loop.

>> +		}
>> +	}
>> +
>> +	of_node_put(eth_ports_node);
>> +
>> +	/* At least one node must be present and available else we fail */
>> +	if (!eth0_node && !eth1_node) {
>> +		dev_err(dev, "neither port0 nor port1 node available\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (eth0_node == eth1_node) {
> 
> Given the if / else if condition in the for loop above,
> I'm not sure this can ever occur.
> 

We will remove this.


Thanks and Regards,
Parvathi.

