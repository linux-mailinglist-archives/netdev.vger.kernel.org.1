Return-Path: <netdev+bounces-140347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517FC9B61E2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D061F26066
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319901EBFF2;
	Wed, 30 Oct 2024 11:32:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1F1E5737;
	Wed, 30 Oct 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287932; cv=none; b=cL5NtUMTeR+xFYvDalva+fmQfXj+1JwAgoPaqfqKcIl5dDTQlNlNZ4N00OkiXKIGsdBmdQBgyhasskVLJotFZFhGPcCtzN4qeqvRZOgzyB6bTuOmgMpYJfD22BgNDxs4KrkP2YJ+az6ozMDdbR2B2xGPg4HlWggTnINuKEjzp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287932; c=relaxed/simple;
	bh=EYK+QPVFPOOzoh3+loCCfe6W6qgl2V6UuS0Rs1sugg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u0GNR1fEP4DPfih19Gb2PY4J4gsYgGIs/MjejvB2ybsEpZbo7UpMbRZFrqrmIyvGeEpUm521SaFQrQRhx6tXtyapRPs4/Z3joMHsIFwekCXqx76YCbWiVtF0c/ImXvk9mGDFKRsnUDgfXkXuslpMN/8jogOrDIswbjgHkvKONqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XdlL41MBVz1jvlv;
	Wed, 30 Oct 2024 19:30:36 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E5E41A0188;
	Wed, 30 Oct 2024 19:32:08 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Oct 2024 19:32:07 +0800
Message-ID: <3150691a-c4f9-440e-a1f5-19f01c4a21ff@huawei.com>
Date: Wed, 30 Oct 2024 19:32:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/10] mm: page_frag: add an entry in MAINTAINERS for
 page_frag
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>
References: <20241028115850.3409893-1-linyunsheng@huawei.com>
 <20241028115850.3409893-11-linyunsheng@huawei.com>
 <20241028162743.75bfd8a1@kernel.org>
 <06933039-a330-4ed9-9db1-9c75cd7ae9b7@huawei.com>
 <20241029073359.758d9b84@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241029073359.758d9b84@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/29 22:33, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 17:40:08 +0800 Yunsheng Lin wrote:
>> On 2024/10/29 7:27, Jakub Kicinski wrote:
>>> On Mon, 28 Oct 2024 19:58:50 +0800 Yunsheng Lin wrote:  
>>>> +M:	Yunsheng Lin <linyunsheng@huawei.com>  
>>>
>>> Why is this line still here? You asked for a second opinion
>>> and you got one from Paolo.  
>>
>> Because of the reason below?
>> https://lore.kernel.org/all/159495c8-71be-4a11-8c49-d528e8154841@huawei.com/
> 
> What is the reason in that link? You try to argue that the convention
> doesn't exist or that your case is different? The maintainer tells you
> their opinion in context of the posting.

I just argue that it seems natural and reasonable that someone being willing
and able to turn page_frag into a subsystem or library might become the
co-maintainer if she/he is also willing to co-maintain it.

> 
> It seems like you're more motivated by getting into MAINTAINERS than
> by the work itself :/
For the 'MAINTAINERS ' part, I guess we all want some acknowledge in some
way for the work if that is the 'motivated ' you are referring to.

For the 'work itself' part, my previous work of supporting frag API, unifying
frag & non-frag API for page_pool, removing page frag implementation in vhost_net
and recent trying of fixing IOMMU crash problem all seem to be motivated more by
getting into MAINTAINERS in your eyes?

With all due respect, it would be good to have less of speculation like
above and focus on more technical discussion.

