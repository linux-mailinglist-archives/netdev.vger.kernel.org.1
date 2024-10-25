Return-Path: <netdev+bounces-138915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC09AF686
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234271F226FD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889A4436A;
	Fri, 25 Oct 2024 01:12:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87E61FCE;
	Fri, 25 Oct 2024 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818720; cv=none; b=JCygXhAUOU3vwBRLGJA5lKsB3eVBvo8WVKBOtDncQLz3RnaPDF+SJ8rjmP7H2M9y4x8dE8J8OeCfEbZ4Iza31zGGJ91siGDmvWGeujCPGHuLrw7eMI0FhcnUjc6zwzVVFYIkTqJ4bE2RCiDciDYwR8EoNrV2syq74SI/OH1A+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818720; c=relaxed/simple;
	bh=M1nraTNc2QYb99lQD6OmxueQGnEuVGKbB0/JhBsbwbo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JkaEZjjrlkZ0dwh8Bc6ZuAsRzlD5xSkX+hkU1cVmUvkZxcAYJG+K+PKQdYIdcbmpHPeJKQN1RNxZOevAbJKKQfHTWadQWpvAYPsmR7tFavJTQbW6tVr8r95zuv/YUBcxgReRo2XXxjBXUKzeBq8oXSFBHkgHblZvZRhQV7IOKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XZPqV18cszQsBm;
	Fri, 25 Oct 2024 09:11:02 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id D44B9140337;
	Fri, 25 Oct 2024 09:11:55 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 09:11:54 +0800
Message-ID: <38d83f29-96b2-44b4-ae1e-51196112b26f@huawei.com>
Date: Fri, 25 Oct 2024 09:11:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <liuyonglong@huawei.com>,
	<wangpeiyang1@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 2/9] net: hns3: add sync command to sync io-pgtable
To: Paolo Abeni <pabeni@redhat.com>, "shenjian (K)" <shenjian15@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<salil.mehta@huawei.com>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-3-shaojijie@huawei.com>
 <214d37cc-96c0-4d47-bea0-3985e920d88c@redhat.com>
 <e8f83833-940a-3542-5c68-3dc25a230383@huawei.com>
 <79005e6e-543e-444b-9acc-f59ac7b04675@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <79005e6e-543e-444b-9acc-f59ac7b04675@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/24 19:05, Paolo Abeni wrote:
> On 10/24/24 11:38, shenjian (K) wrote:
>> 在 2024/10/24 16:36, Paolo Abeni 写道:
>>> On 10/18/24 12:10, Jijie Shao wrote:
>> We considered this issue, and since this is not a software defect, we
>> were not too
>>
>> sure which commit should be blamed.
>>
>> It makes sense to choose the commit introducing the support for the
>> buggy H/W, we will add
>>
>> it.
> Please additionally rephrase the commit message including the more
> verbose explanation above, thanks!
>
> Paolo

ok, Thanks!



