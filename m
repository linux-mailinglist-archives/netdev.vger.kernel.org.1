Return-Path: <netdev+bounces-136150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B199A08E5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440041F217E8
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBD207A2C;
	Wed, 16 Oct 2024 11:57:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6D206971;
	Wed, 16 Oct 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079876; cv=none; b=DXlzrHDvqLg1pW/mvAIaSepCeHv5V68XmAn++K70tzDrmwgLePqae1vUJU2uOfZkTiXt5SLToA9WjO0oeqLAn1y8xpDsiXy2TqNw4WHSh7/wnxI7aUes8Lnm6X5gCqQFhoWaE7lnwkquRQ3jOmwWdaz2AsJ1H1hslWWe0U26hdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079876; c=relaxed/simple;
	bh=9iy5D+bFHX0Y0BfJmTvTzF3UgB+Xx82yDzDPyqZWrt4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xkx5b85vdf9W4yG3ZAY9ezzaIEzKyZbSGxVKQlkSR/sCHuSR2d+6VwKLC2kLa0iVKJhTXRyLFpM9pvDxK5CECcDMZvZNRaMm8mu8/LFyuHSSD2h729zOKhZmFKfkA96a3VvN+WEu9riiuY4vbLsgPMRLQfD6XDl/kedPenQ50nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XT8Y73vBdzfcYf;
	Wed, 16 Oct 2024 19:55:23 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 98C4718009B;
	Wed, 16 Oct 2024 19:57:50 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 19:57:49 +0800
Message-ID: <da026e0f-8465-464f-a75d-c9baac48d8f5@huawei.com>
Date: Wed, 16 Oct 2024 19:57:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <lanhao@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 6/9] net: hns3: don't auto enable misc vector
To: Jakub Kicinski <kuba@kernel.org>
References: <20241011094521.3008298-1-shaojijie@huawei.com>
 <20241011094521.3008298-7-shaojijie@huawei.com>
 <20241015182220.10ea0425@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241015182220.10ea0425@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/16 9:22, Jakub Kicinski wrote:
> On Fri, 11 Oct 2024 17:45:18 +0800 Jijie Shao wrote:
>> +	irq_set_status_flags(hdev->misc_vector.vector_irq, IRQ_NOAUTOEN);
>>   	ret = request_irq(hdev->misc_vector.vector_irq, hclge_misc_irq_handle,
> You can pass IRQF_NO_AUTOEN to request_irq() instead, no?

Yeah， I wil fix it in V2

Thanks
Jijie Shao




