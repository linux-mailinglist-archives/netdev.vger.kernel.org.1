Return-Path: <netdev+bounces-237158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5FFC464C2
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E5E188A3A0
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF3830DD1A;
	Mon, 10 Nov 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="pDrF6cLe"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5E30CDA9;
	Mon, 10 Nov 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774301; cv=none; b=pxv820cjw4ekB8JOy5r8+LzKDxw47XGhfnp2hLEVM2rs79yZXYYdnNXixmhB0uvXSUPIF4ux6cqGhkfNW8xtO8KKFGAsVX4UHe8sjb7EWircslaen1T5UVWzFC2ukOkow39Px7a8/N/JF8iZoOexYFxvXtr6jaJKL+KCG5s6MWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774301; c=relaxed/simple;
	bh=JIkN7KUYhgUYZiUu3ulKF15ZBbT+S2SDBctf2gH/2V8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=p5FT5pmS0AXtErtzaS6ZpP0yd03EFLRoE95rw6VPivXDIrxoVRLsfs+nLc72wlxN2W48jwCAAftTV3UUXUJtQJHilKv29s4D9wvEwqkT/k+ykZ+sisuf9Bz8NKsgka3LhEK2XviYF/lya/dwneAxJ8PeDlvH3z47BTb73fMiL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=pDrF6cLe; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BXiqQF+gRk3kPg1EvMqNubQuZrzlTUWKCjIloAq55N0=; b=pDrF6cLeTCBmb+vrjvWrBZGzCh
	j2OEaki+U0AGtnO/6EIrPvOv8SB9P5T7XyS/0EIoX0iT2SKqdRzEl7ZipPJux3/lvqPy/Vc1W5Rnd
	3B6DfdopI6k66SIy1xe7ylFBDM/yaHXQSdHv6wtIhFKQnsV0S/okw4iaY+nzYbZs35eKIWk2iLQXB
	FIE2ziVItfHgns0cAzl8/oNB0RCNDxZQQ8uWOv4EdY6+jeNZJKWgTBYUaHOlEBmkVRB5ZGcN1ChqF
	jYWBs+YlQPkSG3UHN1IAte5J0RU6Le2S/3RLkQIYlmonmb18dv/9iVPTivG+uVEQkVzA2DSBxFhhH
	5DcWbWgg==;
Received: from [122.175.9.182] (port=59601 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vIQ7P-0000000Dy5b-3VRO;
	Mon, 10 Nov 2025 06:31:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id EB1751A45041;
	Mon, 10 Nov 2025 17:01:20 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZbCz9p0DjiJh; Mon, 10 Nov 2025 17:01:19 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 58D7B1A4505E;
	Mon, 10 Nov 2025 17:01:19 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id y5mx4F2JezO3; Mon, 10 Nov 2025 17:01:19 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 370341A45041;
	Mon, 10 Nov 2025 17:01:19 +0530 (IST)
Date: Mon, 10 Nov 2025 17:01:19 +0530 (IST)
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
Message-ID: <1945451921.12277.1762774279163.JavaMail.zimbra@couthit.local>
In-Reply-To: <1336430040.1005.1760615639799.JavaMail.zimbra@couthit.local>
References: <20251014124018.1596900-1-parvathi@couthit.com> <20251014124018.1596900-2-parvathi@couthit.com> <ff651c3d-108b-48f8-b69b-fb0b522edd4e@lunn.ch> <1336430040.1005.1760615639799.JavaMail.zimbra@couthit.local>
Subject: Re: [PATCH net-next v3 1/3] net: ti: icssm-prueth: Adds helper
 functions to configure and maintain FDB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Adds helper functions to configure and maintain FDB
Thread-Index: n9boZ3kHorfViJim7wqUTYIC+ep2RPQ2l15B
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

> Hi,
> 
>>> +void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth)
>>> +{
>>> +	struct fdb_tbl *t = prueth->fdb_tbl;
>>> +
>>> +	t->index_a = (struct fdb_index_array_t *)((__force const void *)
>>> +			prueth->mem[V2_1_FDB_TBL_LOC].va +
>>> +			V2_1_FDB_TBL_OFFSET);
>> 
>> We have
>> 
>>> +#define V2_1_FDB_TBL_LOC          PRUETH_MEM_SHARED_RAM
>> 
>> and existing code like:
>> 
>> void __iomem *sram_base = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
>> 
>> so it seems like
>> 
>> t->index_a = sram_base + V2_1_FDB_TBL_OFFSET;
>> 
>> with no needs for any casts, since sram_base is a void * so can be
>> assigned to any pointer type.
>> 
>> And there are lots of cascading defines like:
>> 
>> /* 4 queue descriptors for port 0 (host receive). 32 bytes */
>> #define HOST_QUEUE_DESC_OFFSET          (HOST_QUEUE_SIZE_ADDR + 16)
>> 
>> /* table offset for queue size:
>> * 3 ports * 4 Queues * 1 byte offset = 12 bytes
>> */
>> #define HOST_QUEUE_SIZE_ADDR            (HOST_QUEUE_OFFSET_ADDR + 8)
>> /* table offset for queue:
>> * 4 Queues * 2 byte offset = 8 bytes
>> */
>> #define HOST_QUEUE_OFFSET_ADDR          (HOST_QUEUE_DESCRIPTOR_OFFSET_ADDR + 8)
>> /* table offset for Host queue descriptors:
>> * 1 ports * 4 Queues * 2 byte offset = 8 bytes
>> */
>> #define HOST_QUEUE_DESCRIPTOR_OFFSET_ADDR       (HOST_Q4_RX_CONTEXT_OFFSET + 8)
>> 
>> allowing code like:
>> 
>>	sram = sram_base + HOST_QUEUE_SIZE_ADDR;
>>	sram = sram_base + HOST_Q1_RX_CONTEXT_OFFSET;
>>	sram = sram_base + HOST_QUEUE_OFFSET_ADDR;
>>	sram = sram_base + HOST_QUEUE_DESCRIPTOR_OFFSET_ADDR;
>>	sram = sram_base + HOST_QUEUE_DESC_OFFSET;
>> 
> 
> Sure, we will check the feasibility and come back.
> 

We have updated the code to use sram_base + offset directly without any casts,
added the __iomem attribute to the structure, and modified the usage of its
members at all related places accordingly. With these modifications sparse is
able to check all such accesses.

We will post these changes in the next version for review.

Thanks and Regards,
Parvathi.

