Return-Path: <netdev+bounces-213213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2AB24223
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8603658592A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A82D12F7;
	Wed, 13 Aug 2025 07:04:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C32586EF;
	Wed, 13 Aug 2025 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068677; cv=none; b=pU+sLVLmyxndnUk+JGWL6phkZl05mCMdGdnfXCx5P/7J8mhVEmjAo3IIRfaUEAxUjqQPJVP6ofWkM3NWG9jRs3MrdRARiAHnasSWzMWoq0Jwi4TvHeCbxQcIwP7LAGie83UZ14l5uhWd6N9s+u1nKjh5sWrGdLUNQ+xvkQ1v6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068677; c=relaxed/simple;
	bh=wysd32bDODbsKslM9YR2ayXJcD2oQrFIl5iQWT9iOYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsjQJGyGClfiq5URL51OcV8Exizg0B4nB/IhPhxydARrEaWxEq+SHTWI1ZUjZniqOVmPJUZDxyBlmW5om4PrtZBH68JJLgxeUxucIS2iBdGra5P8+G/TsOQe6qIe3mPNS3dG2YOY3pDTfW1UQl/hPRnp6nm6KDkaz2BeiJQMPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c1znK3wZnz1R7ks;
	Wed, 13 Aug 2025 15:01:41 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 70515140159;
	Wed, 13 Aug 2025 15:04:31 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 15:04:29 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <gongfan1@huawei.com>
CC: <andrew+netdev@lunn.ch>, <christophe.jaillet@wanadoo.fr>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<fuguiming@h-partners.com>, <guoxin09@huawei.com>, <gur.stavi@huawei.com>,
	<helgaas@kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <lee@trager.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <mpe@ellerman.id.au>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<vadim.fedorenko@linux.dev>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>,
	<zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v12 1/8] hinic3: Async Event Queue interfaces
Date: Wed, 13 Aug 2025 15:04:24 +0800
Message-ID: <20250813070424.20124-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <059cb5e921093c4ac303dff8389de55be1f41574.1754998409.git.zhuyikai1@h-partners.com>
References: <059cb5e921093c4ac303dff8389de55be1f41574.1754998409.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:124:13: warning: cast to restricted __le32
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:124:13: warning: restricted __le32 degrades to integer
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:124:13: warning: restricted __le32 degrades to integer
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:127:17: warning: cast to restricted __le32
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:127:17: warning: restricted __le32 degrades to integer
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:127:17: warning: restricted __le32 degrades to integer
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:134:23: warning: incorrect type in argument 1 (different base types)
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:134:23:    expected unsigned int [usertype] *buf
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:134:23:    got restricted __le32 [usertype] *
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:135:16: warning: cast to restricted __le32
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:135:16: warning: restricted __le32 degrades to integer
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:135:16: warning: restricted __le32 degrades to integer
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:154:22: warning: incorrect type in assignment (different base types)
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:154:22:    expected restricted __le32 [usertype] aeqe
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:154:22:    got unsigned int [usertype]
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:156:21: warning: cast to restricted __le32
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:156:21: warning: restricted __le32 degrades to integer
> ../drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c:156:21: warning: restricted __le32 degrades to integer

Sorry for oversight on LE modifications and sparse build.
We will fix endian warnings in next patch.

