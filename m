Return-Path: <netdev+bounces-203338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66780AF5329
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1213BB61B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDE327A44D;
	Wed,  2 Jul 2025 13:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E80276036;
	Wed,  2 Jul 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461644; cv=none; b=uYtUTzhjYnmp5Rk4K3S7QqM14FXoS6eNmmdOMgParjUo4HCnFSFrKpevT0AwhweD6j5SOzflHMe67WcaDMy2CB294p1gTgKUWGpywUo5CmHbs9lGFKtCUqwftzlpIGRUG10Oi9xNppuYv+9WwesH15kGXvM9QH1gnbcc3YNfG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461644; c=relaxed/simple;
	bh=Cm6WaicpJR1AIZzJJeuWpanHV1tucP02+gdRbf+KF/Q=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TIiEFllvYU5/cUHLcEmV5FzPZDh9rbG281hgFSSO8mE4xhvLE9X0uULOPrzuaRtfaVVA8hFGK4d8iOoMZx+yQ/g9gH2jY1jv4+2gZhSD7TgnY8ePQDp8uJLTmgROPYndcxuuciPYWh4rJUsZapy7Ay6MDNpHLWSSq40H24o8mAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bXKrY6Gsfz2TSH5;
	Wed,  2 Jul 2025 21:05:33 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 59E561A0190;
	Wed,  2 Jul 2025 21:07:20 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 21:07:19 +0800
Message-ID: <f3994ddd-9b9b-4bbb-bba4-89f7b4ae07f7@huawei.com>
Date: Wed, 2 Jul 2025 21:07:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/4] There are some bugfix for the HNS3 ethernet
 driver
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20250702125731.2875331-1-shaojijie@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250702125731.2875331-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/7/2 20:57, Jijie Shao wrote:
> There are some bugfix for the HNS3 ethernet driver

Sorry, ignore this patch set, they should be sent to net not net-next ...

>
> Hao Lan (1):
>    net: hns3: fixed vf get max channels bug
>
> Jian Shen (1):
>    net: hns3: fix concurrent setting vlan filter issue
>
> Jijie Shao (1):
>    net: hns3: default enable tx bounce buffer when smmu enabled
>
> Yonglong Liu (1):
>    net: hns3: disable interrupt when ptp init failed
>
>   .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 ++++++++++++++++
>   .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
>   .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++
>   .../hisilicon/hns3/hns3pf/hclge_main.c        | 36 +++++++++++--------
>   .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  9 +++--
>   .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  6 +---
>   6 files changed, 94 insertions(+), 23 deletions(-)
>

