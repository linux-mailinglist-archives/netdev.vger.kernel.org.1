Return-Path: <netdev+bounces-136858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229669A343C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89E8285CEE
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 05:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774DB6F2F3;
	Fri, 18 Oct 2024 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Go7vf/Zo"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C617BB38;
	Fri, 18 Oct 2024 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229413; cv=none; b=R7w1p/lJ6pGtEYP3ziICF81LMoWqec1BnJ6U+7nobOv+vq4PW3Yiu46MZxCfAuf5lD9bPet73gjWymV8qpmagWEW4VrArPiAWgqIlpbV3NYn5df4UncYjSEDCceo5mEiUbLqwaCmm/loriA7iRDHktWcpv9jTml+bNj7Ulz6c3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229413; c=relaxed/simple;
	bh=i2JG6iOdU+US1puDHuYMpfrUUGgcgbRBM306Va9Y76A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tRI9ATxY/bc9Y+CLepag+rTps7RBjB8mGci7HjjZ3id8KiYLP++1lJbChzf45aXl8vEsmSTddFUg6hVZQ7eaUrcydyfLBPluB+i6334p4DYP6Okn+rQJjUPDbb9H6YYOAfDTZT1o9zBKLaCAPyhx2ytNvKmjOP7Pg70uy4Cp68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Go7vf/Zo; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=y7QDHEBPVPCiqGkJs8dtBm5r21yBywH+t7cYhsoCvTc=; t=1729229411;
	x=1729661411; b=Go7vf/ZoACQ2D4OGogUk2lGCL7MUw4tcTsRHKhoPjJqtoGMP74bfX3SE92lCO
	wue6ldw9cw5j5J2sV4Outk/24k8ECm7GhlgDjYdHEB/8/k5+xC7rMqvZBjWRdz6mTynYF+4WpWQF7
	n6pLBj3KKGGUeFI5lcoKS2XxNjog4KG+Yen3F0NICexoiUlFiiccEHcrwNuBF2+EzMGgVbWA9I6dx
	G9CUxxEcbJmQ9VFwamaTaCA1RIhsrgTXzNqHz229XVwomMtsS9OxL5k4Ii2rpQ+pCI/dbOqDfZNEG
	r1vfpxLcEw72USdIWpN40KiiEeQZOMCOjCE95YIfCZAbEea0MQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t1fYu-0001dY-K2; Fri, 18 Oct 2024 07:30:08 +0200
Message-ID: <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
Date: Fri, 18 Oct 2024 07:30:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: pull request: bluetooth 2024-10-16
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20241016204258.821965-1-luiz.dentz@gmail.com>
Content-Language: en-US, de-DE
In-Reply-To: <20241016204258.821965-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729229411;c42839ea;
X-HE-SMSGID: 1t1fYu-0001dY-K2

[CCing Linus, the two other -net maintainers, and the regressions lists]

On 16.10.24 22:42, Luiz Augusto von Dentz wrote:
> The following changes since commit 11d06f0aaef89f4cad68b92510bd9decff2d7b87:
> 
>   net: dsa: vsc73xx: fix reception from VLAN-unaware bridges (2024-10-15 18:41:52 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-16

FWIW, from my point of view it would be nice if these changes could make
it to mainline this week. I know, they missed the weekly -net merge,
despite the quoted PR being sent on Wednesday (I assume it was too late
in the day). But the set contains a fix for a regression ("Bluetooth:
btusb: Fix not being able to reconnect after suspend") that to my
knowledge was reported and bisected at least *five* times already since
-rc1 (and the culprit recently hit 6.11.4 as well, so more people are
likely now affected by this :-/ ). Having "Bluetooth: btusb: Fix
regression with fake CSR controllers 0a12:0001" -mainlined rather sooner
that later would be nice, too, as it due to recent backports affects
afaics all stable series and iirc was reported at least two times
already (and who knows how many people are affected by those bugs that
never sat down to report them...).

Side note: I recently learned from one of Linus public mails (I can't
find right now on lore, sorry) why the -net subsystem is usually merging
mid-week. TBH from a regression point of view I have to say I don't like
it much, as bad timing with sub-subsystem PRs leads to situation like
the one described above. It is not the first time I notice one, but most
of the time I did not consider to write a mail about it.

Sure, telling sub-subsystems to send their PR earlier to the -net
maintainers could help, but even then we loose at least one or two days
(e.g. Wed and Thu) every week to get regression fixes mainlined before
the next -rc.

Ciao, Thorsten

> for you to fetch changes up to 2c1dda2acc4192d826e84008d963b528e24d12bc:
> 
>   Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001 (2024-10-16 16:10:25 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - ISO: Fix multiple init when debugfs is disabled
>  - Call iso_exit() on module unload
>  - Remove debugfs directory on module init failure
>  - btusb: Fix not being able to reconnect after suspend
>  - btusb: Fix regression with fake CSR controllers 0a12:0001
>  - bnep: fix wild-memory-access in proto_unregister
> 
> ----------------------------------------------------------------
> Aaron Thompson (3):
>       Bluetooth: ISO: Fix multiple init when debugfs is disabled
>       Bluetooth: Call iso_exit() on module unload
>       Bluetooth: Remove debugfs directory on module init failure
> 
> Luiz Augusto von Dentz (2):
>       Bluetooth: btusb: Fix not being able to reconnect after suspend
>       Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001
> 
> Ye Bin (1):
>       Bluetooth: bnep: fix wild-memory-access in proto_unregister
> 
>  drivers/bluetooth/btusb.c    | 27 +++++++++------------------
>  net/bluetooth/af_bluetooth.c |  3 +++
>  net/bluetooth/bnep/core.c    |  3 +--
>  net/bluetooth/iso.c          |  6 +-----
>  4 files changed, 14 insertions(+), 25 deletions(-)


