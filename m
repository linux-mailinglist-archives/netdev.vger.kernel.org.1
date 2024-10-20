Return-Path: <netdev+bounces-137291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54FE9A54BD
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E5B1C208FF
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB5193063;
	Sun, 20 Oct 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hc7JnvBs"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08077173;
	Sun, 20 Oct 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729438225; cv=none; b=Kijk5yJsEeSF7ez8t0nCDc+IN3GzJBGoeYnhQtzblw9FQ+VZFSfAhYmyja+vySeR04N41llyVnaBiWlGnyj0Ve5E7k/aMZUbaY80ntCQOpwmJtOTVeEEC2u3A2NlMm40liHpBmqcsYP9jNp76VA8UkaLzrTWU4L5CsTcyWXLjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729438225; c=relaxed/simple;
	bh=bM9ZZqz4WmWzq5QNnJvBx1l/8Iz8F0sW6q7v8+wAL3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0VXr7SHIi+xcYhGWrIZ8bbj895f/7UFR4NUJ874Z3wdp+cYKCYh8IJcLTctCAR2CENJAm8m4xrI3KOU3VBS/OU2sRcaLI8bVVIS6Sj/KZQL3LzIY22RiukE1CCE95k/r2Bx3T0kKtN2y2jbD7AdMVE2S03bgTn4hzulYWhRyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hc7JnvBs; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=FK43PhWV9jtGZYMkQYTxfBpmSUy+tu0x6sxNrI5L80Y=;
	t=1729438223; x=1729870223; b=hc7JnvBs5bfB9WVF4YXj/mMVxdFrecFFa2ucGy7P1fUfRmf
	E9XI45dQfBm8qmIFXrLizr/r7iAi6TrtXjVFxwynywBOWY+PUGlzZRUx4Sj/EKUyXXzngNrjRpBKy
	c4lDCcJo9RcxGbT6XH2BjSBtQ0yYdigJAxtuBwviuRTTrTyI3vCQrZOgP/ZYwDZLfj2Dv5ZvsuhB3
	XdWd/50yI18PsezHPDBfMfaTA27e9L//oWtZsDqNzjUbTdOJiGL5zpqbb9xMo8lvwRSu8XJuwYdXX
	DrqntcWka9TnOK8xeysoYleVOWVMyRpTJn8+AEMDFrAgnImZ3MrH/ql4fj3QW+Lw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t2Xsp-0008HD-TC; Sun, 20 Oct 2024 17:30:19 +0200
Message-ID: <1b59f661-4cdf-4951-9a44-cb4ef0cce2a2@leemhuis.info>
Date: Sun, 20 Oct 2024 17:30:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-10-16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20241016204258.821965-1-luiz.dentz@gmail.com>
 <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
 <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729438223;23b3d384;
X-HE-SMSGID: 1t2Xsp-0008HD-TC

On 18.10.24 18:45, Luiz Augusto von Dentz wrote:
> On Fri, Oct 18, 2024 at 1:30 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>> On 16.10.24 22:42, Luiz Augusto von Dentz wrote:
>>> The following changes since commit 11d06f0aaef89f4cad68b92510bd9decff2d7b87:
>>>
>>>   net: dsa: vsc73xx: fix reception from VLAN-unaware bridges (2024-10-15 18:41:52 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-16
>>
>> FWIW, from my point of view it would be nice if these changes could make
>> it to mainline this week. I know, they missed the weekly -net merge,
>> despite the quoted PR being sent on Wednesday (I assume it was too late
>> in the day). But the set contains a fix for a regression ("Bluetooth:
>> btusb: Fix not being able to reconnect after suspend") that to my
>> knowledge was reported and bisected at least *five* times already since
>> -rc1 (and the culprit recently hit 6.11.4 as well, so more people are
>> likely now affected by this :-/ ).

Meanwhile two more reports came it for this issue. And I became aware of
two more for the other Luiz mentioned. I noticed my chance that Fedora
became impatient and picked up both fixes.

>> Having "Bluetooth: btusb: Fix
>> regression with fake CSR controllers 0a12:0001" -mainlined rather sooner
>> that later would be nice, too, as it due to recent backports affects
>> afaics all stable series and iirc was reported at least two times
>> already (and who knows how many people are affected by those bugs that
>> never sat down to report them...).
> 
> +1
> 
> I really would like to send the PR sooner but being on the path of
> hurricane milton made things more complicated, anyway I think the most
> important ones are the regression fixes:

Linus, FWIW, in case you just those:

>       Bluetooth: btusb: Fix not being able to reconnect after suspend

That one is a2ce7481010a32 ("Bluetooth: btusb: Fix not being able to
reconnect after suspend") in -next and 4084286151fc91 in the PR above.
It was posted as
https://lore.kernel.org/all/20241014202326.381559-1-luiz.dentz@gmail.com/,
but Luiz at least fixed the Fixes: tag before committing the fix.

>       Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

That one is b29d4ac729754f ("Bluetooth: btusb: Fix regression with fake
CSR controllers 0a12:0001") in -next and 2c1dda2acc4192 in the PR above.
It was posted here:
https://lore.kernel.org/all/20241016154700.682621-1-luiz.dentz@gmail.com/
(not sure if there were any modifications afterwards).

Ciao, Thorsten

>> Side note: I recently learned from one of Linus public mails (I can't
>> find right now on lore, sorry) why the -net subsystem is usually merging
>> mid-week. TBH from a regression point of view I have to say I don't like
>> it much, as bad timing with sub-subsystem PRs leads to situation like
>> the one described above. It is not the first time I notice one, but most
>> of the time I did not consider to write a mail about it.
>>
>> Sure, telling sub-subsystems to send their PR earlier to the -net
>> maintainers could help, but even then we loose at least one or two days
>> (e.g. Wed and Thu) every week to get regression fixes mainlined before
>> the next -rc.
> 
> Yeah, that said I'm planning to switch to submit fixes more regularly
> (e.g weekly), which appears to be the cadence of the net tree, that
> way we narrow the window for landing fixes into linus tree.
> 
>> Ciao, Thorsten
>>
>>> for you to fetch changes up to 2c1dda2acc4192d826e84008d963b528e24d12bc:
>>>
>>>   Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001 (2024-10-16 16:10:25 -0400)
>>>
>>> ----------------------------------------------------------------
>>> bluetooth pull request for net:
>>>
>>>  - ISO: Fix multiple init when debugfs is disabled
>>>  - Call iso_exit() on module unload
>>>  - Remove debugfs directory on module init failure
>>>  - btusb: Fix not being able to reconnect after suspend
>>>  - btusb: Fix regression with fake CSR controllers 0a12:0001
>>>  - bnep: fix wild-memory-access in proto_unregister
>>>
>>> ----------------------------------------------------------------
>>> Aaron Thompson (3):
>>>       Bluetooth: ISO: Fix multiple init when debugfs is disabled
>>>       Bluetooth: Call iso_exit() on module unload
>>>       Bluetooth: Remove debugfs directory on module init failure
>>>
>>> Luiz Augusto von Dentz (2):
>>>       Bluetooth: btusb: Fix not being able to reconnect after suspend
>>>       Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001
>>>
>>> Ye Bin (1):
>>>       Bluetooth: bnep: fix wild-memory-access in proto_unregister
>>>
>>>  drivers/bluetooth/btusb.c    | 27 +++++++++------------------
>>>  net/bluetooth/af_bluetooth.c |  3 +++
>>>  net/bluetooth/bnep/core.c    |  3 +--
>>>  net/bluetooth/iso.c          |  6 +-----
>>>  4 files changed, 14 insertions(+), 25 deletions(-)
>>
> 
> 


