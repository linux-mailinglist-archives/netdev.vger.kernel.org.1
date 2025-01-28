Return-Path: <netdev+bounces-161251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13844A20331
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 03:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717EF162F16
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 02:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4416418A959;
	Tue, 28 Jan 2025 02:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA6D32C85;
	Tue, 28 Jan 2025 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738032144; cv=none; b=nSUiUx/4GIdqGzE4KIPS0BTlJoYl1/PC9FV/wNvZfht7TyuYUqhPtKujBLff6/ufSdEq/Be3HXl3bFqXsgDdWX44p8aGOlxPBu10/mX+wh9HKH8ZQXTmyTgexkGgi1kw7y2wOt9UKa1uXBYqEFVMlFNLQv8BcsIGQt2D0FnmRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738032144; c=relaxed/simple;
	bh=ZyR0BCxiyI298zf48IFj26c3SNlnS1Pxgu7G0TavxhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO6mIKhKpEXbx/0U2lBng9h6plO21TPEuLwu38Y5kh9e8ClD21FafuQjGUNAEiDYUWYE2v46BYnCR7i37clDQxnW4jlOryHEZ8pn9h5L5N/LyU1yXFU+laZC8xgtNEDlNNnw+7WRvqCpk2MyY8dIFFLmngrxdwSh9kmp20hyOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Jan 2025 11:42:20 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 6BDC72007046;
	Tue, 28 Jan 2025 11:42:20 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 28 Jan 2025 11:42:20 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 99E4FAB186;
	Tue, 28 Jan 2025 11:42:19 +0900 (JST)
Message-ID: <336580ad-e8f6-436a-bf62-adcd348c553b@socionext.com>
Date: Tue, 28 Jan 2025 11:42:19 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] net: stmmac: Fix usage of maximum queue number
 macros
To: Huacai Chen <chenhuacai@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
 <Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk>
 <CAAhV-H78fbK+jAsootOaZW=eQ3RPna3VQTxHd33vDSueYkyYtA@mail.gmail.com>
 <f1912a83-0840-4e82-9a60-9a59f1657694@lunn.ch>
 <CAAhV-H73FNTzhjwkZwO4RAZFF1Ri6EzpJL3jnWW4rPRFZQRZZA@mail.gmail.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAAhV-H73FNTzhjwkZwO4RAZFF1Ri6EzpJL3jnWW4rPRFZQRZZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Huacai, Andrew,

On 2025/01/27 22:47, Huacai Chen wrote:
> Hi, Andrew,
> 
> On Mon, Jan 27, 2025 at 9:21 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>>> I'm not very familiar with the difference between net and net-next,
>>> but I think this series should be backported to stable branches.
>>
>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> According to the rules a "bug" should break build or break runtime or
> a security issue, but shouldn't be spelling fixes.
> 
> But from my point of view, this series is not just "spelling fixes",
> and not "trivial fixes without benefit for users". It is obviously a
> copy-paste error and may confuse developers, so I think the patches
> really have "benefits".
> 
>>
>>
>>    It must either fix a real bug that bothers people or just add a
>>    device ID.
>>
>> Does this really bother people? Have we seen bug reports?
> No bug report is because MTL_MAX_RX_QUEUES is accidentally equal to
> MTL_MAX_TX_QUEUES and it just works, not because the logic is correct.
> And Kunihiko's patch can also be treated as a report.
> 
>>
>> There is another aspect to this. We are adding warnings saying that
>> the device tree blob is broken. That should encourage users to upgrade
>> their device tree blob. But most won't find any newer version. If this
>> goes into net-next, the roll out will be a lot slower, developers on
>> the leading edge will find the DT issue and submit a DT patch. By the
>> time this is in a distro kernel, maybe most of the DT issues will
>> already be fixed?
> Goto net or goto net-next are both fine to me, I just think this
> series should be backported to stable branches. There are lots of
> patches backported even though they are less important than this
> series (maybe not in the network subsystem).

Currently both macros define the same value and there is no critical
break for previous kernels.

When different values are defined for these macros, this can cause
problems, however, I don't think that these different values are
adopted (backported) in the current stable kernels.

So I think it's reasonable to repost this series to net-next.

Thank you,

---
Best Regards
Kunihiko Hayashi

