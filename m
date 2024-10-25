Return-Path: <netdev+bounces-138959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6D9AF887
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B673B2192A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30E18BC2C;
	Fri, 25 Oct 2024 03:55:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB618A6D8
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828520; cv=none; b=oDBqw+173ltDvNQj3Q2ZoVvJLcR4tp9u+LVWFGW+nnUCup+qKCMDtnj6TYGndylcCA6116fki7Cces0b+lWKY7BNqJldWIWwLvgGGirUCs/mJTmn46Zt+U2L1O1Lrn/OeEMFMdkVHNxFxQG+g1WYHH3/Hd9yj9goIrpdlTBn3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828520; c=relaxed/simple;
	bh=2/gB0WF/dPjAmSqvdkhrXBddibqioOwExG/N94Xu0bU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=p5cRw5FFipibtwIU/fj/TvafoZXgN2xj2Dj5v1A77i/Yu1A1OdrAM1nhuIrkbVKfukqgbAx7grbzdrGyeAyw8sZ7ktEr2lwhUxci9+KFtnf56plj6HswHGKz5WsICRqh4O2rmpsO20NOCl49lQ7Q1tDfHxokJTR/G21crIrzo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XZTT60kdfz1ynGM;
	Fri, 25 Oct 2024 11:55:22 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B1B51400DC;
	Fri, 25 Oct 2024 11:55:14 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 11:55:13 +0800
Subject: Re: [PATCH 1/2] bna: Fix return value check for debugfs create APIs
To: Andrew Lunn <andrew@lunn.ch>
CC: Simon Horman <horms@kernel.org>, Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20241023080921.326-1-thunder.leizhen@huawei.com>
 <20241023080921.326-2-thunder.leizhen@huawei.com>
 <20241024121325.GJ1202098@kernel.org>
 <19322579-a24b-679a-051b-c202eb3750f7@huawei.com>
 <d7d04629-941b-4efb-84ee-92fbd0f42f9c@lunn.ch>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0ac107c9-ff97-46bf-fce0-712e5bb9d24f@huawei.com>
Date: Fri, 25 Oct 2024 11:55:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d7d04629-941b-4efb-84ee-92fbd0f42f9c@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/24 22:04, Andrew Lunn wrote:
>> Do you want to ignore all the return values of debugfs_create_dir() and debugfs_create_file()?
> 
> All return values from all debugfs_foo() calls.

I searched. Currently, bna only involves functions debugfs_create_dir() and
debugfs_create_file(). debugfs_remove() has no return value.


git grep -n "\bdebugfs_" drivers/net/ethernet/brocade/bna/
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:501:            bna_debugfs_root = debugfs_create_dir("bna", NULL);
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:514:                    debugfs_create_dir(name, bna_debugfs_root);
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:521:                                    debugfs_create_file(file->name,
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:544:                    debugfs_remove(bnad->bnad_dentry_files[i]);
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:551:            debugfs_remove(bnad->port_debugfs_root);
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:558:            debugfs_remove(bna_debugfs_root);


> 
> debugfs has been designed so that it should be robust if any previous
> call to debugfs failed. It will not crash, it will just keep going.
> 
> It does not matter if the contents of debugfs are messed up as a
> result, it is not an ABI, you cannot trust it to contain anything
> useful, and it might be missing all together, since it is optional.

Okay, thank you for your detailed explanation.

> 
> 	Andrew
> .
> 

-- 
Regards,
  Zhen Lei

