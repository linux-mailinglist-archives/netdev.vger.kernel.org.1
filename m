Return-Path: <netdev+bounces-139838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D459B45DC
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1DA28375C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE1204006;
	Tue, 29 Oct 2024 09:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90021E1025;
	Tue, 29 Oct 2024 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194819; cv=none; b=LX4NBORdQnA6opujR4+6QcKwXAdg20zgQmSbPd/LvdJ3qf3tTxiqg0o8qQkZFEYeZ3Q0rq2NwcPDqmGkojwToWbu6YoxxS4q0gdeV9GVm4/lSFUVAVaqYlMoIWX6nZiAKNp/ZITH4lDKE5vdu66WZ8IVO2PpeLGANyRCv2fNt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194819; c=relaxed/simple;
	bh=k19dXDDfPoCfEEEhS/A/dF/+3doFQJCc7F40wLd3Yxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ikkkr2ojJR4PLBK5fDwTEsBqcIvHM+kVd8KvbI1ndFSo+2f3L5O7WhX9Uj17RLrkxOo1V80W+I5XeN6zr6hvsfOIqdKnn2RHyuKeLrpSLwxESrJfVcc2r9SCpx6E0wILaDt+szaSbHk+wApUkekoY3abBdrqG/r7BQJ8hPawJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xd4tb11l4z1T9Mh;
	Tue, 29 Oct 2024 17:37:59 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 962331402D0;
	Tue, 29 Oct 2024 17:40:08 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 17:40:08 +0800
Message-ID: <06933039-a330-4ed9-9db1-9c75cd7ae9b7@huawei.com>
Date: Tue, 29 Oct 2024 17:40:08 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241028162743.75bfd8a1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/29 7:27, Jakub Kicinski wrote:
> On Mon, 28 Oct 2024 19:58:50 +0800 Yunsheng Lin wrote:
>> +M:	Yunsheng Lin <linyunsheng@huawei.com>
> 
> Why is this line still here? You asked for a second opinion
> and you got one from Paolo.

Because of the reason below?
https://lore.kernel.org/all/159495c8-71be-4a11-8c49-d528e8154841@huawei.com/

