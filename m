Return-Path: <netdev+bounces-121848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9795F03D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA61F22A13
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE06157A6C;
	Mon, 26 Aug 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWYcG9Pr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAE155351;
	Mon, 26 Aug 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673483; cv=none; b=MVkAYk722YNdE+pqLelmMOEaz2cUXgjNjfmKR9wu9kI2FrGEm0YRph1sIadHQhijVGGStSFFgGm3EaBuDb0kLZOqIyic6QFzrVwZEt7+3gpOGCdJldcpUPDe68DCEv5WEXx8Yo5CBSRjvMvYvqbP4bx3MopeeQg4e580mL4psl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673483; c=relaxed/simple;
	bh=QgIwlyhJMKlvwcUhs6fgookAUVkK/bKJx1cVwJwaESc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A1Z6//4Wz2Phho5WNzQpJacKCV0KtLXII9ElVzzKHTzhUkbK7l0luyv0XSt9A4an+WF8zsBfg1HVaUBHS4brn7ESfZ1wQoqGFE2ELSiNQI7JoATVGd4J2bWjLYV+evuujXYs/uqoxDWyeuWN68Hd9B2zi+UFD+X/zmjvgniYpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWYcG9Pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11695C51400;
	Mon, 26 Aug 2024 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724673483;
	bh=QgIwlyhJMKlvwcUhs6fgookAUVkK/bKJx1cVwJwaESc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rWYcG9PrG7TB48zrApTVIymSNQ8QsNpfxziwQMRqclJEzDBj35GtBOQWUyThXrFI3
	 xl7UdlexX2501/K2vUJvofe/2dSvXZIZ6NDU9VzFB/bDXJsbp66olcmmvOtH99Cq7P
	 dOSFoDm8c3zASrpioZJnYiHXmM0n6hyRK7bj0XrJEGTqLAimHhyja3GVDTZIdSO8ea
	 JFzLAUa7AMTTvGd6VWEJiXssfJKxV320Ruo5CPx7vjcwL+1d7fwNk2G6smxw4++1dQ
	 dUnqI3VC5cc//ijpYnKL6iLM8xSAvuVyiv8SkFpYYVsN7uOBhMzSTCBdJ9cfLh+Q4E
	 gjcdg9iCb1ygQ==
Message-ID: <21137e85-c791-4ff7-9492-00ace243d488@kernel.org>
Date: Mon, 26 Aug 2024 13:57:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_pm_nl_set_flags
Content-Language: en-GB
To: syzbot <syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <00000000000049861306209237f4@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <00000000000049861306209237f4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thank you for having released this bug report!

On 26/08/2024 10:50, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8af174ea863c net: mana: Fix race of mana_hwc_post_rx_wqe a..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=1718a993980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
> dashboard link: https://syzkaller.appspot.com/bug?extid=455d38ecd5f655fc45cf
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a653d5980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/86225fd99eec/disk-8af174ea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fc4394f330d4/vmlinux-8af174ea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1f30959324a7/bzImage-8af174ea.xz
> 
> The issue was bisected to:
> 
> commit 322ea3778965da72862cca2a0c50253aacf65fe6
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Date:   Mon Aug 19 19:45:26 2024 +0000
> 
>     mptcp: pm: only mark 'subflow' endp as available
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=159fb015980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=179fb015980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=139fb015980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
> Fixes: 322ea3778965 ("mptcp: pm: only mark 'subflow' endp as available")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5507 at net/mptcp/pm_netlink.c:1467 __mark_subflow_endp_available net/mptcp/pm_netlink.c:1467 [inline]
> WARNING: CPU: 1 PID: 5507 at net/mptcp/pm_netlink.c:1467 mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1948 [inline]
> WARNING: CPU: 1 PID: 5507 at net/mptcp/pm_netlink.c:1467 mptcp_nl_set_flags net/mptcp/pm_netlink.c:1971 [inline]
> WARNING: CPU: 1 PID: 5507 at net/mptcp/pm_netlink.c:1467 mptcp_pm_nl_set_flags+0x926/0xd50 net/mptcp/pm_netlink.c:2032
> Modules linked in:
> CPU: 1 UID: 0 PID: 5507 Comm: syz.3.20 Not tainted 6.11.0-rc4-syzkaller-00138-g8af174ea863c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_netlink.c:1467 [inline]
> RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1948 [inline]
> RIP: 0010:mptcp_nl_set_flags net/mptcp/pm_netlink.c:1971 [inline]
> RIP: 0010:mptcp_pm_nl_set_flags+0x926/0xd50 net/mptcp/pm_netlink.c:2032

Arf, my bad, I already fixed the issue in our tree. In fact, I had more
than 15 patches to send, so I decided to split the series, and the fix
is not in -net yet. I forgot syzbot was also checking the netlink API,
imitating a user adding, and removing local MPTCP endpoints. I should
have moved the WARN to a later commit, I will try to remember that next
time!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


