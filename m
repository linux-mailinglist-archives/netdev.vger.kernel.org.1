Return-Path: <netdev+bounces-239345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF66C6708C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3D28354164
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1461231A32;
	Tue, 18 Nov 2025 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ykNXXiDJ"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05081A4F3C;
	Tue, 18 Nov 2025 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433252; cv=none; b=sD3a2KX63W7dMjocui+MVMM0Hjb0xCN+TREQURR2h8nL5v28gfzyqLGjSGBW7k/x7r6xF7ANletDEh80NZEhcQDfzIWhzWrzppEtPTHbbWe5QFE7TEo+AoY+9MqpQ4wdjll/i/eVLWbzfQSSPLOearWR8+TNx9nUqQCdPXsFS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433252; c=relaxed/simple;
	bh=pBfMKeKI4nK96dld4bpTkIaDfA+Idfe37tvvE+pshSA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OHODY99LPANiK2yaxjEkZJ3ztxYS8Q0hhH8Yylgj7/qVTSN9czu4YGEamTiSzllYY4SxSoLRfVd3PvFcq8OXFshp+/RhQsma6Ph0QsbP4KmxUdj/jwmNG+Gd9VQ9BpjQsA00GJKWjpVKFafcwjFELo3T2n2Zo5lS77L1aS0htTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ykNXXiDJ; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pBfMKeKI4nK96dld4bpTkIaDfA+Idfe37tvvE+pshSA=;
	b=ykNXXiDJ95tMEXWe26mkupixNihyPKyLKfmKpyxP/ECZ/QxT6iiW0W7jPdb/rNRv7FWwoPmbx
	9s0HtOC1v8v3FWdDiZDSJsWrFrRZKHK5n/6ydtA3bTzRGzNp1LI1a6rrLYvufBqwS4fux0JxXcL
	LeoM2MDv1y8HpXiUVACDTXc=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d9TD54v9lz12Ldp;
	Tue, 18 Nov 2025 10:32:37 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 046FD18048A;
	Tue, 18 Nov 2025 10:34:06 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 10:34:05 +0800
Message-ID: <327ac0a2-35a7-4bde-aa7b-941bef2a5996@huawei.com>
Date: Tue, 18 Nov 2025 10:34:04 +0800
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
Subject: Re: [PATCH net-next 3/3] net: hibmcge: support pagepool for rx
To: Jakub Kicinski <kuba@kernel.org>
References: <20251114092222.2071583-1-shaojijie@huawei.com>
 <20251114092222.2071583-4-shaojijie@huawei.com>
 <20251117174957.631e7b40@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20251117174957.631e7b40@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/11/18 9:49, Jakub Kicinski wrote:
> On Fri, 14 Nov 2025 17:22:22 +0800 Jijie Shao wrote:
>> Support pagepool for rx, retaining the original
>> packet receiving process.
> Why retain the legacy path? Page pool is 7 years old, all major NIC
> vendors had dropped the support for non-page pool Rx path at this point.
> If there are bugs or performance regressions we will fix them and send
> the fixes to stable.

I have seen some drivers that retain the legacy packet receiving path.
The community does not recommend this practice now, and I will remove the legacy path in v2.

Thanks,
Jijie Shao


