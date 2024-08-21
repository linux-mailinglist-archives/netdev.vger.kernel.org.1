Return-Path: <netdev+bounces-120424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85AA95944E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF08B2295C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFD168487;
	Wed, 21 Aug 2024 06:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E6482DD;
	Wed, 21 Aug 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220020; cv=none; b=Ve/2wOgjxbzIFrqnXFBpGohwMP/VfKLShc4JkwyNtriPv1JF9VI4k8vaIT2STUhtFyZPddt4qy8zCDZw9ZfrXB2QXWizBW122SJSKjhHwpqP+G/ALyQqwibuQCtF7Y4QlLpG9CdkQMe3KMSiBYKYTtAGcGLNuqZEteHo1f8sMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220020; c=relaxed/simple;
	bh=Gb0QOccwzgZ0VCKpCex3oQXLmSiZSljI5eIaQz3q70I=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TMOlQBWt8GpYbRsjrk9tqehFjWXReGJGZPyXQwv1PdBe8R/1HVRiyiVAtOPieB8SnLudlyn8QXAn3a6tU3M5F8ESWDGy4tr6xAslwdbSkiolelZaAzdTBfe423MxUjDrtCeL9kVpQh5iS3oMy6Tr6JHLoPobclWyfyWQLN8X9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WpbGs73dczhXs7;
	Wed, 21 Aug 2024 13:58:13 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 719311401F2;
	Wed, 21 Aug 2024 14:00:14 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:00:13 +0800
Message-ID: <3e27ff27-e9c4-4334-99ea-e36f051fef6a@huawei.com>
Date: Wed, 21 Aug 2024 14:00:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 09/11] net: hibmcge: Add a Makefile and update
 Kconfig for hibmcge
To: Jakub Kicinski <kuba@kernel.org>
References: <20240820140154.137876-1-shaojijie@huawei.com>
 <20240820140154.137876-10-shaojijie@huawei.com>
 <20240820185442.117d75f1@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240820185442.117d75f1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/21 9:54, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 22:01:52 +0800 Jijie Shao wrote:
>> +config HIBMCGE
>> +	tristate "Hisilicon BMC Gigabit Ethernet Device Support"
>> +	default m
> Remove the default please drivers should default to n

Ok， I will remove that in V3.
Thansk，
	
	Jijie Shao



