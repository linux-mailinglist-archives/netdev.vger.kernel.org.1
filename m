Return-Path: <netdev+bounces-248295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83670D06A99
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 01:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85971300D914
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 00:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6721F09B3;
	Fri,  9 Jan 2026 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llUkBRG2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0581EB5E1;
	Fri,  9 Jan 2026 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920203; cv=none; b=XhoL4uB8oGBnQwJmS7t2v6w3s2QfrTW6IX3gvrfVoRrmKceZlAgxZ2tgyUzxfykwy0R5NKehxIoeHCuuZLONr3Y94+P7IrUwBV2pjfyWdotgvNccDAY0b3WuEwEifsXNW4zJwWUgbh3KgHV4kO0O5SBlQ25N7YY2OZHYfoxCyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920203; c=relaxed/simple;
	bh=vqJZDHh2cmNS2nIPBQoeIp5cRhAVJY3HXNq5Hq1PjdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ILvrztNYOT/jXRMk8b3ptiQRnTqf3Ev9hF7dBNFIkVLj4adltLlX06OECXmp4qXPqXbHAouz2FwK+Q97Ko2ysaPb2jDk9aKqxPO2rUBJWCy1PXNXTathVDAlEBcODCJmID6S37VpmhvKQjuG+kwQlMzbqr9wbWoa+FHBn7POwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llUkBRG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA65AC116C6;
	Fri,  9 Jan 2026 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767920203;
	bh=vqJZDHh2cmNS2nIPBQoeIp5cRhAVJY3HXNq5Hq1PjdY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=llUkBRG2NSn6UsqwqLz/oHPISJ0M6tgohqLshJcRTUAaCvJPGssOSHxTeuzWXc5Vd
	 7vbViCE1UOD0NvRSdIwZtYunQBuvbsvBio2HrLIo5ylu+N6zza+wrPhGVuJDTkh8co
	 rtIyPYiuq88rrehyG4bV9cvW4eXAjMVLu8RR+NgsBy4c3vf5Q0Qh75WumGMeas+m/V
	 pWqy4UPF5aF++ZHSLHX2FkunE7VBUF1VitKXBtn/PDB157uQIOCq5wRxlMegkyiFNs
	 gPOM4AlfLcwtRKZj7sD6IwrNydeFcSPvodlHGvUYxwgTzmR1bNySj5AxEGPSyHMXlo
	 nzrPJ2qVePSdw==
Message-ID: <e3ff455b-1c02-4f3b-9b57-1a9c7d5bd5fb@kernel.org>
Date: Thu, 8 Jan 2026 17:56:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] kernel BUG in fib6_add_rt2node (2)
Content-Language: en-US
To: syzbot <syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <695d4d3a.050a0220.1c677c.0349.GAE@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <695d4d3a.050a0220.1c677c.0349.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 10:58 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1d528e794f3d Merge branch 'bpf-fix-bpf_d_path-helper-proto..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=159c51c2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5198eaf003f1d1

This config at

commit 59ba823e689f832f389ea6af6e7ae5842b3c860a (HEAD -> net-next,
net-next/main)
Merge: 76de4e1594b7 f2a3b12b305c
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Thu Jan 8 11:37:07 2026 -0800

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

> dashboard link: https://syzkaller.appspot.com/bug?extid=cb809def1baaac68ab92
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139c51c2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b2961a580000

and this reproducer does not show a problem for me.

