Return-Path: <netdev+bounces-233385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B062C1297C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 556E44E1CA6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2125A2C7;
	Tue, 28 Oct 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Tw4NOIvc"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FB1662E7;
	Tue, 28 Oct 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616541; cv=none; b=NfMJ8RFWmeyevN98j3hz4hC34BMqVytP++BOMLKZHfbqw7oRmwwpm04bddwh8Dz/9eruXaRpT7yLNMVcCjMfqbEZFNgjRxULasBCc2f+sYL5CM893/Pfj2jgDdwdoHathT2P1dAKWnx1fgefMZWwMogCVbKTDi/woyUPjIrDObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616541; c=relaxed/simple;
	bh=uns5HrGmuITUIqjhk0AYfVm1iY5hzrj4fRpnfjYl+mA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jq6fxAhztcED9a50vIN8YvKo5pfianR0xLb0aT66KvKdNZVq3TTdaN3RsObl0g7DYNIkh+08pKHpk0/P7YVUprzj1x1sDi3EP0xgMmd9JjRXFGJ8woaMW9JIs+hGhEAuJu0uD3KOUHbn2fkWZv+PdR24qxXXWi/zKDtjcFfFn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Tw4NOIvc; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=it2CGwrr8XPuER+Fzwz3Cppb788D/OOVWmIQqhmKuOk=;
	b=Tw4NOIvcrG2onfPI4rJ5m3fGpfEYdbNiM2l79HoeyadfiaSXDXWUWCN185iTdcXRd8RYzoCll
	ftO77acbkCIHDk51zSapOxp3u8B/0rkv6CIDNHvLfHL7vDPlmfbXtZuDipuO0+tKJY0N5or7I7N
	qxYWmPoow/rR1R4BuJrvypo=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cwYMs2Ky1z1T4Fg;
	Tue, 28 Oct 2025 09:54:33 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C4F1140155;
	Tue, 28 Oct 2025 09:55:35 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 09:55:34 +0800
Message-ID: <a0853cd9-cab5-441d-b181-8ba97f2f58b0@huawei.com>
Date: Tue, 28 Oct 2025 09:55:33 +0800
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
Subject: Re: [PATCH net 2/2] net: hns3: fix null pointer in debugfs issue
To: Jakub Kicinski <kuba@kernel.org>
References: <20251023131338.2642520-1-shaojijie@huawei.com>
 <20251023131338.2642520-3-shaojijie@huawei.com>
 <20251027175451.21b7bfe4@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20251027175451.21b7bfe4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/10/28 8:54, Jakub Kicinski wrote:
> On Thu, 23 Oct 2025 21:13:38 +0800 Jijie Shao wrote:
>> Currently, when debugfs and reset are executed concurrently,
>> some resources are released during the reset process,
>> which may cause debugfs to read null pointers or other anomalies.
>>
>> Therefore, in this patch, interception protection has been added
>> to debugfs operations that are sensitive to reset.
> You need to explain what prevents the state from changing immediately
> after you did the bit check. With no obvious locking in place I don't
> see how this reliably fixes the issue.

In July, we used seqfile to refactor debugfs.

Before the refactoring, all debugfs operations would check the reset status
(HNS3_NIC_STATE_INITED and HNS3_NIC_STATE_RESETTING) in the entry function.
After the refactoring, the entry function was removed, which led to the loss of protection.

This patch restores the protection behavior that existed before the refactoring.
Now our tests have already detected the null pointer issue.

As for the problem you mentioned, we have been discussing it recently.
There is a small time gap, checking the status before reading from debugfs is fine,
but there could still be issues if the device enters the reset state during the read process:

check state pass
	debugfs read start...
		do reset
			debugfs read end
			
Currently, we are still assessing the risk and discussing solutions for this issue.
After adding the entry protection, executing debugfs and reset concurrently has not
resulted in null pointers or other exceptions.

Thanks,
Jijie Shao


