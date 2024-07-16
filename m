Return-Path: <netdev+bounces-111727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EF9325A8
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20963280F1B
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54B195FD1;
	Tue, 16 Jul 2024 11:31:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00381799D;
	Tue, 16 Jul 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129476; cv=none; b=GPvNNG5DZfXg3QoWMe1d0QDJh5E5fKW1VxDFTzXkjy/FlpjP04lzZ4IYomCKRhzSS0QKCpc3e6S7pwQSKqQhVkSLIHxS39TMroyeFA42ayN0ODCdw+9aZz9yOZs5tn4VOOCOMOpTZZXJhiZYcTbgAq3LLxeQ19h+rO9NWBwjYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129476; c=relaxed/simple;
	bh=L33uyFI7RX8PO4QK0+4vl3nNe+GsaGHQL1/SAZSmmPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XVgatJZbsfXWRVG2/KF3JLZhKHM+dnGakmLZDkzgEaiEG42LCWgE9u+quxdVhU0lMSddWFjrdh8+FZeOlZYQvQF0kT5u+JKXC2JH6Mnuaa80EVdW1WQ2qMjFx314UORJQi1BTonK/lpziEnTf9I3rAK9ACk+1b0gouL7/OSWf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WNcG45cQXz1JClG;
	Tue, 16 Jul 2024 19:26:20 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 4346014038F;
	Tue, 16 Jul 2024 19:31:11 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 19:31:11 +0800
Message-ID: <80276e4a-87be-9cc3-76c6-ad0e5d4238b0@huawei.com>
Date: Tue, 16 Jul 2024 19:31:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [BUG REPORT] kernel BUG at lib/dynamic_queue_limits.c:99!
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, Linux kernel mailing list
	<linux-kernel@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>
References: <08227db9-6ed7-4909-838d-ce9a0233fba3@huawei.com>
 <8036617e-62f3-17cb-f43a-80531e10e241@huawei.com>
 <20240712174321.603b4436@kernel.org> <20240712174412.5226dd28@kernel.org>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20240712174412.5226dd28@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Hi,

On 2024/7/13 8:44, Jakub Kicinski wrote:
> On Fri, 12 Jul 2024 17:43:21 -0700 Jakub Kicinski wrote:
>> CC: virtio_net maintainers and Jiri who added BQL
> 
> Oh, sounds like the fix may be already posted:
> https://lore.kernel.org/all/20240712080329.197605-2-jean-philippe@linaro.org/

Thanks, this patch indeed resolved the issue.

