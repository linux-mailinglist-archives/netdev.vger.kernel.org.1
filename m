Return-Path: <netdev+bounces-209323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF49B0F0B3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8E01C8582F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D77E289364;
	Wed, 23 Jul 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="qfN29ILP"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985D230268;
	Wed, 23 Jul 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268602; cv=none; b=J+tuo8EXEzP7zlgn05QnD5KafSlRdhEAaov9muHmnN6pmvbt/xjyoNeQo7B2dW5MrU/GCtk1/WxmZGHRA5jsY3dJedxFS+6Rbs/v8quNFT4eG1voUNliAsssIvMCZ6WIW3R6Ae/xoh7Qb3eIkjt5bUJcE0NP15EPwV4mhdCjkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268602; c=relaxed/simple;
	bh=QPxiXguHsz3/IgGxbGoTb29vEn8S9ZjWyH1BjKYamuY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=c80nitdT1D4YovG30LQsM42D2nTzVO/gGpgNfc2WiEt5AZwBZ/yOsiBKpp19kl4HiZ3UP89h9UIhiEGiueHluvmbpZZGgYn3lGQSosOyHeWQRp9VLzwa3n5RQcn4pGWNfuyxSxDl9YzhW/MZWERAEbG151Qq3qfrklK7CR0EMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=qfN29ILP; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tpUwu4il1VAiTMh13wOHJHOYU4uf2KEQd4xPzFOpTMk=; b=qfN29ILP5BDZQoV1YozWjQ2m92
	ZlM0uuWGKU/sFaEY7+M0Upxd9Io6/DdLXOh/yhGIu9gvfBKELJgamULl8hSnqVSmdzk/JAf/uvW/S
	kNsNOGwEbXYVdPHnKPXTLdyV2pDeMCFM+TOyt7qVKzVxtqxJZhPI3HyEooSuPSHHzqpw0mNIeLRbj
	v0BRvORh1FxxPy1BmtUMToWTOFdCzsKIC3IcP7OCAYk9i6X/gVKFXglJZ4o16Lfz6pWuNHw8UFq6I
	hRcivPL1CmMq7s4QIfwY7v9Q/wPYRAs77MOqmTo79Yi2ezt/4Z9QvxQV1pjeYU5eEEr3JoxzRMJqA
	wt34HXPA==;
Received: from [122.175.9.182] (port=24906 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1ueXFg-00000006TmQ-1gKW;
	Wed, 23 Jul 2025 07:03:12 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 231911782036;
	Wed, 23 Jul 2025 16:33:03 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id F36BA17823D4;
	Wed, 23 Jul 2025 16:33:02 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kVxGdNqyNizW; Wed, 23 Jul 2025 16:33:02 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 948C61782036;
	Wed, 23 Jul 2025 16:33:02 +0530 (IST)
Date: Wed, 23 Jul 2025 16:33:02 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	horms <horms@kernel.org>, s-anna <s-anna@ti.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1390395318.23287.1753268582122.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250722184749.0c04d669@kernel.org>
References: <20250722132700.2655208-1-parvathi@couthit.com> <20250722132700.2655208-3-parvathi@couthit.com> <20250722184749.0c04d669@kernel.org>
Subject: Re: [PATCH net-next v11 2/5] net: ti: prueth: Adds ICSSM Ethernet
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds ICSSM Ethernet driver
Thread-Index: CS6Pxk1Q6vpt0yapW6BMmVo7ZPHfVw==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On Tue, 22 Jul 2025 18:55:02 +0530 Parvathi Pudi wrote:
>> +	for_each_child_of_node(eth_ports_node, eth_node) {
>> +		u32 reg;
>> +
>> +		if (strcmp(eth_node->name, "ethernet-port"))
>> +			continue;
>> +		ret = of_property_read_u32(eth_node, "reg", &reg);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%pOF error reading port_id %d\n",
>> +				eth_node, ret);
>> +			return ret;
> 
> missing put for eth_node
> 

Yes, We will address this and post the next version shortly.


Thanks and Regards,
Parvathi.

