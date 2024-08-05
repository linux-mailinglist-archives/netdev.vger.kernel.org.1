Return-Path: <netdev+bounces-115762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E433A947B90
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393CBB21B30
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8D158DC3;
	Mon,  5 Aug 2024 13:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CB18026;
	Mon,  5 Aug 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863348; cv=none; b=fv/6/9uH7QXoulG/GguEoqqstt9JzzYUM/8r9a8d8/lpe9HzlX8SKKk5zr8eOXAJFv/Il/Q3ROWmgWBpNQXqiwC+nP6lKVQNMhGIQ/20c+Yq/42vhLhDihbK8oLLRduZ+7k5v+kXByrCtRk/JG6lKHx9W7IeIGQSY71uOU60Ydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863348; c=relaxed/simple;
	bh=SalwmJQW37lEdHbkFWCA2XulYGIfArUBkh5e/AyHoGg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OFh0pXcc6UczSy3SZMdyVdaOhqkqB/ATLEWczFTYBCjlM9DPbqjHfZj112RbvRe5SvOU2JVQwTCAUhZH3PtBS8CuoLnnDz1L2dD/TLLqGyJzN5uACgS/D2tkFlXLsRzThAsfQDaAoag7AXXfUM1nzdJLuVGmqr8huSzkjEdmqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wcxb81F1wzyPnp;
	Mon,  5 Aug 2024 21:08:52 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FC0F18009F;
	Mon,  5 Aug 2024 21:08:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 21:08:56 +0800
Message-ID: <27598a0e-f796-4f5d-8dce-bf7841d19182@huawei.com>
Date: Mon, 5 Aug 2024 21:08:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 02/10] net: hibmcge: Add read/write registers
 supported through the bar space
To: Simon Horman <horms@kernel.org>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-3-shaojijie@huawei.com>
 <20240805125558.GA2633937@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240805125558.GA2633937@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/5 20:55, Simon Horman wrote:
> Hi,
>
> I may well be wrong but I think that FIELD_PREP can only be used with
> a compile-time constant as the mask.
>
> In any case, with Clang-18 W=1 allmodconfig builds on x86_64 I see:

Thanks， I'll fix this warning in V2.

>
>    CC      drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.o
>     CC      drivers/net/ethernet/hisilicon/hibmcge/hbg_main.o
> In file included from drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c:8:
> drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h:31:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>     31 |         reg_value |= FIELD_PREP(mask, val);
>        |                      ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
>    115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
>     72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>     73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
>        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     74 |                                  _pfx "type of reg too small for mask"); \
>        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> ././include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
>    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
>    498 |         __compiletime_assert(condition, msg, prefix, suffix)
>        |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
>    490 |                 if (!(condition))                                       \
>        |                       ^~~~~~~~~
> 1 warning generated.
> In file included from drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c:8:
> drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h:31:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>     31 |         reg_value |= FIELD_PREP(mask, val);
>        |                      ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
>    115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
>     72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>     73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
>        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     74 |                                  _pfx "type of reg too small for mask"); \
>        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> ././include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
>    510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
>    498 |         __compiletime_assert(condition, msg, prefix, suffix)
>        |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
>    490 |                 if (!(condition))                                       \
>        |                       ^~~~~~~~~
> 1 warning generated.
>
> ...

