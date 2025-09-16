Return-Path: <netdev+bounces-223532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C48B59696
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F0B3AF71C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CAF1A9FB4;
	Tue, 16 Sep 2025 12:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAAF3A1D2;
	Tue, 16 Sep 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027016; cv=none; b=PmIC4yMvF854hrnUkYltCd5vPrMFkk7QWi1ZVhKsYbHJMpLb0sb7UkQ2ukgD4fK7245rkFvLKk///3xXzQtyDK+A65Un8mu8xwbM2uB4r4U798+22xp1hyFNlXXQ8lSEZ0xcCY1g9VjJx+9Ka73b9NoBHmQNvqcR9DczUo6jbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027016; c=relaxed/simple;
	bh=uFtjepYjm5+nQjKzH3LSpGOqC5GBj0n7yBC1XHaSZE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=su1QC++TKbHsnAQvS1aa55b/uqs9oaQQoJ9zyCoLQY4xVqCbL9+/ZHchnLurVczRKgtiac+gTjcKI22hB8539h6JHRYzruL/WdxoFX7t86Ju3ED7qD3UEcidTC14Wsohff5c3g0Fy5rQ+YcFPsiTrd4KaBBh/eO3LqzzwszfiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BAC02B;
	Tue, 16 Sep 2025 05:50:04 -0700 (PDT)
Received: from [10.1.31.217] (XHFQ2J9959.cambridge.arm.com [10.1.31.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8F0B3F673;
	Tue, 16 Sep 2025 05:50:09 -0700 (PDT)
Message-ID: <80840307-942d-4e7b-849d-2ca9bb4bbefa@arm.com>
Date: Tue, 16 Sep 2025 13:50:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [sound?] kernel BUG in filemap_fault (2)
Content-Language: en-GB
To: syzbot <syzbot+263f159eb37a1c4c67a4@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, chaitanyas.prakash@arm.com, davem@davemloft.net,
 david@redhat.com, edumazet@google.com, hdanton@sina.com, horms@kernel.org,
 jack@suse.cz, kuba@kernel.org, kuniyu@google.com,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, perex@perex.cz,
 syzkaller-bugs@googlegroups.com, tiwai@suse.com, willemb@google.com
References: <68c69e17.050a0220.3c6139.04e1.GAE@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <68c69e17.050a0220.3c6139.04e1.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/09/2025 11:51, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit bdb86f6b87633cc020f8225ae09d336da7826724
> Author: Ryan Roberts <ryan.roberts@arm.com>
> Date:   Mon Jun 9 09:27:23 2025 +0000
> 
>     mm/readahead: honour new_order in page_cache_ra_order()

I'm not sure what original bug you are claiming this is fixing? Perhaps this?

https://lore.kernel.org/linux-mm/6852b77e.a70a0220.79d0a.0214.GAE@google.com/

If so, the fix for that was squashed into the original patch before it was
merged upstream. That is now Commit 38b0ece6d763 ("mm/filemap: allow arch to
request folio size for exec memory").

Thanks,
Ryan


> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1100b934580000
> start commit:   b4911fb0b060 Merge tag 'mmc-v6.16-rc1' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6ddf055b5c86f8
> dashboard link: https://syzkaller.appspot.com/bug?extid=263f159eb37a1c4c67a4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157cf48c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146a948c580000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: mm/readahead: honour new_order in page_cache_ra_order()
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


