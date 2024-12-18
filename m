Return-Path: <netdev+bounces-153113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507779F6CE0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DD91888470
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7C1FA82E;
	Wed, 18 Dec 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmIAfwgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA71AA1DC;
	Wed, 18 Dec 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545205; cv=none; b=u+oa0LbRXvDiM/yxueq7YzI6LZntw5wz9duQ5XtMRyXmhcUGyiGsekVCsRrkcig4/CgEruwzAK4lZtVy4Y10i7+WTY9KlkKhA9v1X6x2OjV8d7b5Qy2x2mFB+TBlDGTVwxpIroeeCXxFDrBLbMZjDhnbndMxS9dlb63A8nnXgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545205; c=relaxed/simple;
	bh=HtZvE9r1p96XpGdU4CxFFXQTsUZba8DZZF56FVc4JDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKCyou7AFAGZ05J8gXYGtPka5J2Smk+/Qe9duD6lTqPtU3HZS1k8tB5xzNGZ1vmeOtflbMoIk6d1bDQlLV6OUZ1D1D8jn4In3PyzSt5K2bSAC57D1/NNppw69aWb9K8Uh3K3/gT2zZIpwzIVH/w/3Yev/NshHd8j/nc01IySOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmIAfwgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0999DC4CECD;
	Wed, 18 Dec 2024 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734545205;
	bh=HtZvE9r1p96XpGdU4CxFFXQTsUZba8DZZF56FVc4JDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qmIAfwgjFmTqob+IDlOLIri0xDGzskdodSiFlgBEO5dxigCDq0rY0IWFHJKkF45uF
	 TitIIj9HG690RC12HrOTZyb9OiUZkpdHXKJuaX+pcJYEyWQfam6cbmT4rXubuQNz1J
	 zWeuK0YoIOz4Uk+2V6BarhRiw099SliGpXEMzWnMiRe6rrwlnKXw6Bvbj1ycdHVqdG
	 jh2GI8mgRTDlwaAv1+pTbsucoWNuKKjmy23qWAQDlm12Tas4XIF//lU3QzKqNuj6Ks
	 x8OaVauEWVKYEq95gxDkVnOykd9P+4mrP23fumlX+7GEY5jISZJtMtp1F09LkOmiJc
	 WlXNUizdo/TJw==
Message-ID: <c5f83a88-b881-4358-87ca-b3feb5405ae7@kernel.org>
Date: Wed, 18 Dec 2024 19:06:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [net?] general protection fault in put_page (4)
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot <syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
References: <6761aed9.050a0220.29fcd0.006b.GAE@google.com>
 <CANn89iLL9EgqDz8sjMke9okhJpxtzZkcPvaEQ3s01F89H5RP3A@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iLL9EgqDz8sjMke9okhJpxtzZkcPvaEQ3s01F89H5RP3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 17/12/2024 18:06, Eric Dumazet wrote:
> On Tue, Dec 17, 2024 at 6:03 PM syzbot
> <syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    78d4f34e2115 Linux 6.13-rc3
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16445730580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c532525a32eb57d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=38a095a81f30d82884c1
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b0b44580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f502df980000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/7129ee07f8aa/disk-78d4f34e.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/c23c0af59a16/vmlinux-78d4f34e.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/031aecf04ea7/bzImage-78d4f34e.xz
>>
>> The issue was bisected to:
>>
>> commit b83fbca1b4c9c45628aa55d582c14825b0e71c2b
>> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Date:   Mon Sep 2 10:45:53 2024 +0000
>>
>>     mptcp: pm: reduce entries iterations on connect
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=163682df980000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=153682df980000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=113682df980000

(...)

> I spent some time on this bug before releasing it, because I have
> other syzbot reports probably
> caused by the same issue, hinting at shinfo->nr_frags corruption.
> 
> I will hold these reports to avoid flooding the mailing list.

Thank you for having released this bug report!

The bisected commit looks unrelated. I don't know if we can tell syzbot
to "skip this commit and try harder".

I'm trying to run a 'git bisect' on my side since this morning: the
issue seems to be older, between v6.10 and v6.11 if I'm not mistaken.
When using the same kernel config, I'm getting quite a few issues on
older commits (compilation, other warnings, etc.), plus the compilation
is slow on my laptop. I will update you if I can find anything useful.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


