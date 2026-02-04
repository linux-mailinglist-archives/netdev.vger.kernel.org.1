Return-Path: <netdev+bounces-256723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNxmKS9Zg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:35:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41619E72DC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDC1F300AB35
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DE3AE6F3;
	Wed,  4 Feb 2026 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y56QOekS"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE53B9608;
	Wed,  4 Feb 2026 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215700; cv=none; b=ctAyY7MD0bc9z4VKCx/Abd46eEubJfV8BrRkPFz3kXWWMFnKAgm4Y9RmIIW6nICzIG+nkvPztM1uz1wOPQwlAPvByUFu7n8KeVhpekKJ3dBnsxTp5McS4mUcgHWcZXbQbuhyQ6O/mz9JO9Nc9G9hnYN6CrzcfQH1NQQ82clEWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215700; c=relaxed/simple;
	bh=E1QzV7dpj99WOETuQcWjgnvKYogE09R5cEVpjvLjii0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wa/BCSnEd5n+7FhlFVy99cMqAEwtVi06gSG+V1VP8qGIAbhRrwqT0KjGAbsp83yDoAgBRlib8FVBjLCClEVVaXnUwM86cm40R16f0le9imQDLaToBIfTyKeLYjIV7obdW7ie0QwN1Q3CaS1SJbtPZPbtqzaba6Kxyi3Hc+eGEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y56QOekS; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=E1QzV7dpj99WOETuQcWjgnvKYogE09R5cEVpjvLjii0=;
	b=Y56QOekSbrMT0uZ9IZaZZXK1D2QTQzwgm/ucpraL5bzE6EazvGSyxAhHBJxAM88XC4LI5gSAD
	btOFGZ4MHlReEgnTzWE26MHrSihANiViI4pURQL+Q1v7RjYRB4aq2EtqS0hEVnqe8uYXyoqOBNF
	7G1IH0bvCeWZ5ThC/5xcdSQ=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4f5jS92drFz1cyQ9;
	Wed,  4 Feb 2026 22:30:17 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5627940539;
	Wed,  4 Feb 2026 22:34:51 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 4 Feb 2026 22:34:50 +0800
Message-ID: <ffb73716-75c0-4f97-82d0-daee39613964@huawei.com>
Date: Wed, 4 Feb 2026 22:34:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<lantao5@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: hns3: fix double free issue for tx spare buffer
To: Jakub Kicinski <kuba@kernel.org>
References: <20260202105837.1909444-1-shaojijie@huawei.com>
 <20260203183816.3bb02543@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260203183816.3bb02543@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256723-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41619E72DC
X-Rspamd-Action: no action


on 2026/2/4 10:38, Jakub Kicinski wrote:
> On Mon, 2 Feb 2026 18:58:37 +0800 Jijie Shao wrote:
>> The driver missed to clear ring->tx_spare to NULL when
>> fail to initialize tx spare buffer. And it will try to
>> free the tx spare buffer in hns3_fini_ring() if tx_spare
>> is not NULL. So it may cause double free issue.
> Please update this commit message so that reviewers don't have
> to do as much research.

ok, I will send v2 to update the commit message

Thanks,
Jijie Shao



