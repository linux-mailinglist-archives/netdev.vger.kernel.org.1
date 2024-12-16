Return-Path: <netdev+bounces-152060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347D69F28C9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466AC166F56
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 03:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C67450F2;
	Mon, 16 Dec 2024 03:21:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F951322B;
	Mon, 16 Dec 2024 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734319288; cv=none; b=VPViPxWKVGlBA3PaxLS7AXe3RdyNx2D542yR5MyApdTHPzPTQ6Jd5qqN0KxEGFdpDOVUbcoCpmYkP2MA9j+eSA3hPY07DVrDy+HJGswgwmDg9h1/uMNLMTJc0nd7z3tsFZ5HUGbk8g3G5dwplmVIIt0Cgzi2MEdXhYF9UEAFjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734319288; c=relaxed/simple;
	bh=q1M641oKkjUnlUKdKbYD9g6YcEyzXBLg4OOxWUtUTAE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QPXkjgxHdmIK6pveVh0W59qxg+frokvSvtAjw6wI28tj+acE7SYPRHMrgPIsOd483AT67dRN7XWl+/2oKRC7gmQnHPGjKWgEEBd1REJhwzHMiIKICGMSWVHyEh30WbWCGzn0+zkPga6iAJkvNe4Pr8DO12SRLoTPn5UriDrzzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YBQBr4hLDz1T7Fg;
	Mon, 16 Dec 2024 11:18:44 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 02B9D1A016C;
	Mon, 16 Dec 2024 11:21:17 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 11:21:15 +0800
Message-ID: <a6c4d8d4-bbc3-49d2-9d8d-90398c8231e1@huawei.com>
Date: Mon, 16 Dec 2024 11:21:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hkelam@marvell.com>
Subject: Re: [PATCH V7 net-next 1/7] net: hibmcge: Add debugfs supported in
 this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20241212142334.1024136-1-shaojijie@huawei.com>
 <20241212142334.1024136-2-shaojijie@huawei.com>
 <20241215134443.28770bbe@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241215134443.28770bbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/16 5:44, Jakub Kicinski wrote:
> On Thu, 12 Dec 2024 22:23:28 +0800 Jijie Shao wrote:
>> +#define str_true_false(state) ((state) ? "true" : "false")
> Didn't notice until I started applying this..
> str_true_false() is an existing helper:
> https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/string_choices.h#L68

It seems that this header file provides a lot of useful helpers, I will send v8 to use them.

Thanks,
Jijie Shao



