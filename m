Return-Path: <netdev+bounces-139091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F39B020E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F262850B5
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A3203700;
	Fri, 25 Oct 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0k65mNY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F642036EA;
	Fri, 25 Oct 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858776; cv=none; b=OGdPZGgQdvBnI6GOYmwH42o3tOgEybQFTWMlfTfIAvloFZ6M5TzCvXSQ6Y/qY5TULfczAkwoJzHREomO09+bSjyJTmtJ3XIM/91F0ldpTuCq8VHqoCCUs9f5j/ZcpHFgB7W5/wdm3e3Adt4rz9TU/ToQAnarNbwfeSlau/vxL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858776; c=relaxed/simple;
	bh=4OfbtInGdWFG2PxojSwt9ZulIvrT4ba5PqsybEwaudk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNewCzd0kBdhpSmBzBiKfJuF917ZhJL7KCeL/yog63Bp11avhJJPShzoTcLwnO8Hv6SKRAvdH2Q+5jokRI1RFPSmwYmM/SYbcRATow2LFsej30CruI/VhiPm/O2PuPWGiYxGi4CGZEk17OONeBYJaStMS5LztK7Cp94IBTOvLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0k65mNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D040C4CEC3;
	Fri, 25 Oct 2024 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729858776;
	bh=4OfbtInGdWFG2PxojSwt9ZulIvrT4ba5PqsybEwaudk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0k65mNYEOXJgA0k5/VubpltyxxSImUuB4PUA2MGC3GIQe9buv+zD3TuzEhLz2KHE
	 101oBJIT82F7mD3ng6FnNSWQEOzM+7h7M677qsjYvic9VMS3GfJdf/2ggrWWwiLQ+V
	 wW48tRxykoO7NrXrF3hC/AbNyBgPQhwHekVFtxu9K0rXmezkrQZQuNQasEsB4dawSt
	 WYSoBM/C7JJO1yCOQE+U91NLBydJ5hq6svDxMFh82JyaCwMc632GuRYBCJ4cLwkeqv
	 uBO04XglpFnPTFOIV8gosSs8Xs0fjSOCLAeS0yt3GQIp/+WmkBMAwrbA1m43T1R7kS
	 ooOaH2B3lITsw==
Date: Fri, 25 Oct 2024 08:19:34 -0400
From: Sasha Levin <sashal@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kees@kernel.org, broonie@kernel.org
Subject: Re: [GIT PULL] Networking for v6.12-rc5
Message-ID: <ZxuM1hGE7UBRV48M@sashalap>
References: <20241024140101.24610-1-pabeni@redhat.com>
 <ZxpZcz3jZv2wokh8@sashalap>
 <87cyjpj6qx.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyjpj6qx.fsf@mail.lhotse>

On Fri, Oct 25, 2024 at 12:44:54PM +1100, Michael Ellerman wrote:
>Sasha Levin <sashal@kernel.org> writes:
>> Sorry for the spam below, this is another attempt to solicit feedback to
>> the -next analysis tools that a few of us were working on.
>>
>> Bigger changes since the last attempt:
>>
>>    - Count calendar days rather than number of tags for the histogram.
>
>I think this is a good change, but the presentation of the information
>probably needs a bit of work.
>
>Some of the commits below are in next-20241024, which was tagged less
>than one day ago, but some are not. But they're all shown as "0 days",
>which I think will confuse people.
>
>I think you need to differentiate between 0 days in linux-next vs
>*never* in linux-next. Otherwise folks are going to yell at you and say
>"that commit was in linux-next!".
>
>>    - Make histogram more concise when possible (the below is *not* a good
>>      example of the new functionality).
>>    - Add more statistics to the report.
>>
>> On Thu, Oct 24, 2024 at 04:01:01PM +0200, Paolo Abeni wrote:
>>>Hi Linus!
>>>
>>>Oddily this includes a fix for posix clock regression; in our previous PR
>>>we included a change there as a pre-requisite for networking one.
>>>Such fix proved to be buggy and requires the follow-up included here.
>>>Thomas suggested we should send it, given we sent the buggy patch.
>>>
>>>The following changes since commit 07d6bf634bc8f93caf8920c9d61df761645336e2:
>>>
>>>  Merge tag 'net-6.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-10-17 09:31:18 -0700)
>>>
>>>are available in the Git repository at:
>>>
>>>  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc5
>>
>> Days in linux-next:
>> ----------------------------------------
>>   0 | █████████████████████████████████████████████████ (14)
>>   1 | ███████ (2)
>
>So I think here you need something like (numbers made up):
>
>Days in linux-next:
>----------------------------------------
>   0 | ███████████████ (4)
> < 1 | █████████████████████████████████████████████████ (10)
>   1 | ███████ (2)
>
>To make it clear that some commits were not in linux-next at all,
>whereas some were but for such a short time that they can hardly have
>seen any testing. (Which still has some value, because at least we know
>they didn't cause a merge conflict and passed at least some build
>testing that sfr does during the linux-next merge).

Makes sense, added in https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/commit/?id=116b9550ccd6fb5e7f2ba9375af59392e03abb57

>>   2 | █████████████████████ (6)
>>   3 | ██████████████████████████████████████████ (12)
>>   4 |
>>   5 |
>>   6 | ███ (1)
>>   7 |
>>   8 | ███ (1)
>>   9 |
>> 10 |
>> 11 |
>> 12 |
>> 13 |
>> 14+| ██████████████ (4)
>>
>> Commits with 0 days in linux-next (14 of 40: 35.0%):
>> --------------------------------
>> 3e65ede526cf4 net: dsa: mv88e6xxx: support 4000ps cycle counter period
>> 7e3c18097a709 net: dsa: mv88e6xxx: read cycle counter period from hardware
>> 67af86afff74c net: dsa: mv88e6xxx: group cycle counter coefficients
>> 64761c980cbf7 net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition
>> 4c262801ea60c hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event
>> ee76eb24343bd net: dsa: microchip: disable EEE for KSZ879x/KSZ877x/KSZ876x
>> 246b435ad6685 Bluetooth: ISO: Fix UAF on iso_sock_timeout
>> 1bf4470a3939c Bluetooth: SCO: Fix UAF on sco_sock_timeout
>> 989fa5171f005 Bluetooth: hci_core: Disable works on hci_unregister_dev
>
>The commits below here are in today's linux-next (next-20241024):
>
>> 6e62807c7fbb3 posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()
>> 10ce0db787004 r8169: avoid unsolicited interrupts
>> b22db8b8befe9 net: sched: use RCU read-side critical section in taprio_dump()
>> f504465970aeb net: sched: fix use-after-free in taprio_change()
>> 34d35b4edbbe8 net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers
>
>The first question that comes to mind here is what's the diffstat for
>these like.
>
>There's a big difference if these are all tight few-line fixes to
>individual drivers or sprawling hundred line changes that touch arch
>code etc.
>
>Listing the diffstat for all of them individually would be way too
>spammy. Passing all the sha's to git show and using diffstat seems to
>give a reasonable overview, eg:
>
>$ git show -p 3e65ede526cf4 7e3c18097a709 67af86afff74c 64761c980cbf7 4c262801ea60c ee76eb24343bd 246b435ad6685 1bf4470a3939c 989fa5171f005 | diffstat -p1
>
> drivers/net/dsa/microchip/ksz_common.c |   21 +++++++++++----------
> drivers/net/dsa/mv88e6xxx/chip.h       |    8 +++-----
> drivers/net/dsa/mv88e6xxx/ptp.c        |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------
> drivers/net/hyperv/netvsc_drv.c        |   30 ++++++++++++++++++++++++++++++
> drivers/net/usb/qmi_wwan.c             |    1 +
> include/net/bluetooth/bluetooth.h      |    1 +
> net/bluetooth/af_bluetooth.c           |   22 ++++++++++++++++++++++
> net/bluetooth/hci_core.c               |   24 +++++++++++++++---------
> net/bluetooth/hci_sync.c               |   12 +++++++++---
> net/bluetooth/iso.c                    |   18 ++++++++++++------
> net/bluetooth/sco.c                    |   18 ++++++++++++------
> 11 files changed, 208 insertions(+), 89 deletions(-)
>
>I know the pull request has a diffstat, but they are significantly different.

I agree with needing diffstat, but I don't think we should just add them
all together. Instead, I've added diffstat on a per-commit basis to the
commits with 0 days. Something like:

Commits with 0 days in linux-next (5 of 26: 19.2%):
--------------------------------
a1b2c3d blah blah blah
  drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 25 ++++++++++++++-----------
  1 file changed, 14 insertions(+), 11 deletions(-)

e4f5g6h more blah
  security/keys/trusted.c          | 15 +++++++++------
  security/keys/trusted-keys.c     | 12 ++++++++----
  2 files changed, 17 insertions(+), 10 deletions(-)

This way it's easy to ignore one-liners, and look at bigger commits that
skipped -next.

>Apologies for bike-shedding this so hard, it's just because I think it
>would be a good addition to the development culture.

No worries, these are great improvements. Thanks!

-- 
Thanks,
Sasha

