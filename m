Return-Path: <netdev+bounces-224799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F899B8A9FB
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB397B62EC
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEBB241665;
	Fri, 19 Sep 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="aQYQLuf7"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8831E888;
	Fri, 19 Sep 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300305; cv=none; b=l7rYDmJspzv/IbD7VwZBScZAtGSyHdAzuUg5yzRpg2XoEEU/p6vCedJ2HuXGMkx0eaTMlqMQgmdYgupSsspWaRdDNSvr6wulO3jLK22Z0WVwoGv2aD++DB2pZwRlu6tg9SW2+wSEbzVRmdFJOsvEGhrqsxYfN3LN7+wFmEPb60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300305; c=relaxed/simple;
	bh=etX8Wl/6aaYgLhuUC5ko9MRsMCqNmTd+JPqfBb6bgzM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ck5EU8dqsM0Ad0/AI2na/iYUvca4RNVbwhOrzBrzWt/laRexxtfgy1NTfBzifoBNH9ADCMDbUVcSUink90lIpFNb0LldZmkUOn7QuBIpMQIKUzWOyXTXBoVNOe6mBAedQzlSADWm4KOJNlF9jOaXWMBI/2qM2w4H1e2U/0wfb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=aQYQLuf7; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XAO+gGxG2+bfA9bUn9PeQDcZUygV2d3WgfnEJdr8asM=; b=aQYQLuf7FC+Ugjcq+akkLzHEWb
	gnCyLMuj5kMO+VYRn2E7hKCgSKhx6G4GTh7ksinzmqPQz5Lc1wDLWEjV99GORtkou8RJkpVYKpzMY
	IpkZz9/h7x1hLwsg9iXTR53mkmQtRV4wDiknBzNb6Di/ydOK8PJ6LHdeDQIPSnxq5ujlwipeq2t1f
	Ux0ycNvS+gm8k6mhwnY2NsmNB8v3P/7nyU513H1pxcvdK9kvLpR2EGPj9Igaq4E+Gso87jRA2VIRn
	IHuOewkTswSi1O+bF+gaOQGnH3hmzUAQ/IR5IVtYv9ExiH/3ons+XzBy3wFdRaUHayqDaQTKVrTPe
	0UPmESXA==;
Received: from [122.175.9.182] (port=43780 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uzdwg-00000008iZx-3eQP;
	Fri, 19 Sep 2025 12:26:50 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id D708317821F2;
	Fri, 19 Sep 2025 21:56:45 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id B46BF1783FBE;
	Fri, 19 Sep 2025 21:56:45 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gwyFsi76Mi5L; Fri, 19 Sep 2025 21:56:45 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 81BB117821F2;
	Fri, 19 Sep 2025 21:56:45 +0530 (IST)
Date: Fri, 19 Sep 2025 21:56:45 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: rogerq <rogerq@ti.com>, danishanwar <danishanwar@ti.com>, 
	parvathi <parvathi@couthit.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, basharath <basharath@couthit.com>, 
	afd <afd@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Message-ID: <1112336225.391532.1758299205136.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250919070456.197f3930@kernel.org>
References: <aMvVagz8aBRxMvFn@stanley.mountain> <20250919070456.197f3930@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssm-prueth: unwind cleanly in
 probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC139 (Mac)/8.8.15_GA_3968)
Thread-Topic: icssm-prueth: unwind cleanly in probe()
Thread-Index: Ig+wyV11vbQ6KkdDAz/IymgNZCtcYw==
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

> On Thu, 18 Sep 2025 12:48:26 +0300 Dan Carpenter wrote:
>> This error handling triggers a Smatch warning:
>> 
>>     drivers/net/ethernet/ti/icssm/icssm_prueth.c:1574 icssm_prueth_probe()
>>     warn: 'prueth->pru1' is an error pointer or valid
>> 
>> The warning is harmless because the pru_rproc_put() function has an
>> IS_ERR_OR_NULL() check built in.  However, there is a small bug if
>> syscon_regmap_lookup_by_phandle() fails.  In that case we should call
>> of_node_put() on eth0_node and eth1_node.
>> 
>> It's a little bit easier to re-write this code to only free things which
>> we know have been allocated successfully.
> 
> icssm maintainers - please review

Yes you are correct. This got missed somehow sorry about that.

Now the error return is gracefully exiting by freeing the resources.

Reviewed-by: Parvathi Pudi <parvathi@couthit.com>


Thanks and Regards,
Parvathi.

