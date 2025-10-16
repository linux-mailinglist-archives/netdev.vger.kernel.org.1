Return-Path: <netdev+bounces-230045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6E1BE3323
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB18C1A6240F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF831B800;
	Thu, 16 Oct 2025 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="CxFPCAnE"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C63161B9;
	Thu, 16 Oct 2025 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615734; cv=none; b=k4YA9tsRZCe47ZALce6Louu/VZHdoW2eIPtHK1MKYGfE1LHZXD4ZdSPRcz1jhbYt5a7Qt7d9OETx0CMrcI3+JUIpCxoxYzEfBRcb0DCaP89BfOLAcU8kunT9C4g7wXEZ+6bff8lwRcG1Kduz/ewXDi6CtYLTX886Dc5GiS8yKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615734; c=relaxed/simple;
	bh=xTGD7ktb+E68vu2taqUt2m9ubpD6pFOo3Uxps+bU6ME=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oPQDJ6DZvjCYWOeX7YFnCxYUjiQARkDTxCPVmDetQBBW249ce6xndzbzfi2EDa3BqjF2ofXLTfLwfu9bZ0qI/emuVCCBBZhbFjGbkTZHqVKZ8IcfrZLEnQW46tgzfAXZWTDeT5Npfs8Gqk0vQB1x9mZQNN8pCTtIhtQovc1SxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=CxFPCAnE; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JdJWyTw5grIca2C49Gc8SShAY81xl1ZxjBDpB/TgceY=; b=CxFPCAnEfus2DAQGC/F0bO5d4C
	kLTklHkcWcVnvjybleV9p64RbrYZdQFzdDopV8SWnlFMURdQ+kLJVkG3CCo88/fmPtKYEJCRetPP2
	x3D291Gwuuy+wO6MzV/rFM8lrn+cR8xXn+rWp5dy9ib7ltgJFjD9ojLF3xGnA0H5Vnd2xx9NgfAzN
	1CRiAstPPcaL5okfp9H4Zc1Gm+LmQx/a0frpnREyqRJ+sdIKSJZfTuUFYze9n8lGWCf23frw1SAEX
	9HLigBvQkTAhbvLbYJtz9Hkn09mLzS6sYr+oQNAq/9zualqofN/BAq3JyLtqIMr5qfQtr0PI/0HGd
	6h1M1VXQ==;
Received: from [122.175.9.182] (port=2029 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v9MZu-000000079dC-1oBn;
	Thu, 16 Oct 2025 07:55:30 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id C240E1783FF9;
	Thu, 16 Oct 2025 17:25:26 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id B466E1783FF4;
	Thu, 16 Oct 2025 17:25:26 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uJODz3yCZt52; Thu, 16 Oct 2025 17:25:26 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 8BA601781E1F;
	Thu, 16 Oct 2025 17:25:26 +0530 (IST)
Date: Thu, 16 Oct 2025 17:25:26 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: parvathi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	afd <afd@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <179725937.1046.1760615726437.JavaMail.zimbra@couthit.local>
In-Reply-To: <ce87a72f-09b3-4615-aab9-2be8648300f8@lunn.ch>
References: <20251014124018.1596900-1-parvathi@couthit.com> <20251014124018.1596900-3-parvathi@couthit.com> <ce87a72f-09b3-4615-aab9-2be8648300f8@lunn.ch>
Subject: Re: [PATCH net-next v3 2/3] net: ti: icssm-prueth: Adds switchdev
 support for icssm_prueth driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: icssm-prueth: Adds switchdev support for icssm_prueth driver
Thread-Index: wPaVLJ+dDJYcM1dgRjkmeX50UJ4mnA==
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

>> +static struct prueth_fw_offsets fw_offsets_v2_1;
>> +
>> +static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
>> +{
>> +	/* Set VLAN/Multicast filter control and table offsets */
>> +	if (PRUETH_IS_EMAC(prueth)) {
>> +		prueth->fw_offsets->mc_ctrl_byte  =
>> +			ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET;
>> +		prueth->fw_offsets->mc_filter_mask =
>> +			ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET;
>> +		prueth->fw_offsets->mc_filter_tbl =
>> +			ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;
> 
> I know for some of these SoCs, there can be multiple instances of the
> hardware blocks. It looks like that will go wrong here, because there
> is only one fw_offsets_v2_1 ?
> 
> Humm, actually, if this are constant, why have fw_offsets_v2_1? Just
> use ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET directly?
> 

Sure we will evaluate this and address in the next version.

>> +static void icssm_emac_mc_filter_ctrl(struct prueth_emac *emac, bool enable)
>> +{
>> +	struct prueth *prueth = emac->prueth;
>> +	void __iomem *mc_filter_ctrl;
>> +	void __iomem *ram;
>> +	u32 mc_ctrl_byte;
>> +	u32 reg;
>> +
>> +	ram = prueth->mem[emac->dram].va;
>> +	mc_ctrl_byte = prueth->fw_offsets->mc_ctrl_byte;
>> +	mc_filter_ctrl = ram + mc_ctrl_byte;
> 
> mc_filter_ctrl = ram + ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET; ???
> 

Sure we will evaluate this and address in the next version.

>> +static void icssm_prueth_sw_fdb_work(struct work_struct *work)
>> +{
>> +	struct icssm_prueth_sw_fdb_work *fdb_work =
>> +		container_of(work, struct icssm_prueth_sw_fdb_work, work);
>> +	struct prueth_emac *emac = fdb_work->emac;
>> +
>> +	rtnl_lock();
>> +
>> +	/* Interface is not up */
>> +	if (!emac->prueth->fdb_tbl) {
>> +		rtnl_unlock();
>> +		goto free;
>> +	}
> 
> I would probably put the rtnl_unlock() after free: label.
> 

We will address this in the next version.

Thanks and Regards,
Parvathi.

