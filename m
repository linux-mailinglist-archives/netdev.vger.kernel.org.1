Return-Path: <netdev+bounces-215925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19510B30EF9
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A581916D4F2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25523F27B;
	Fri, 22 Aug 2025 06:31:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036D1684B4;
	Fri, 22 Aug 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844277; cv=none; b=aoMvOtQ1ZTT1P9dkQkZHL9+lwHkz6s8GzLerMO5h34vMQciKc8q6sIvLSf/EZFKkU1jsEI4RVii/Sk/Ulb2cgWl3c+Bp9LVYIGV975HnmlchFkIr3bVgVGqH+v/5hRk8TBflevjXpLzKyy4k47WULVRixWZfldJ8H7nw+CrMc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844277; c=relaxed/simple;
	bh=6/NaqANrmLyuM39qP7BCORtnUZ/QctrWrMXQ54qP3Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoM7PB5PWupxDncw8Dsf7hRAd1xq+DKsg6aal9Ut8YJe2/wVsqROL77Y7HRdNMV+DBvMe5X3XP/1+kkSRk3fXIvITeU8wWaoQp6igvQUr1atBMmknO4J6l+7SEyui+XtRg0OMxq3e+Ydt8HvtCMXPSssM8t3huPXOrXbRzlkmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7b3.dynamic.kabel-deutschland.de [95.90.247.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6E01B61E647B3;
	Fri, 22 Aug 2025 08:30:17 +0200 (CEST)
Message-ID: <9416fdb1-d92e-4183-83d8-6a3001103045@molgen.mpg.de>
Date: Fri, 22 Aug 2025 08:30:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Prevent unwanted interface
 name changes
To: Calvin Owens <calvin@wbinvd.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, regressions@lists.linux.dev
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <aKXqVqj_bUefe1Nj@mozart.vkv.me> <aKYI5wXcEqSjunfk@mozart.vkv.me>
 <e71fe3bf-ec97-431e-b60c-634c5263ad82@intel.com>
 <aKcr7FCOHZycDrsC@mozart.vkv.me>
 <8f077022-e98a-4e30-901b-7e014fe5d5b2@intel.com>
 <aKfwuFXnvOzWx5De@mozart.vkv.me>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aKfwuFXnvOzWx5De@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: regressions@lists.linux.dev]

TLDR; for the regression folks: This is about a two year old commit 
first appearing in Linux 6.7 (so after the 6.6 LTS series release), part 
of which Red Hat reverted in their distro last year to address the 
userspace regression. Users hit by this might not be able to log into 
their systems due to the network not being configured.


Dear Calvin, dear Przemek,


Thank you for raising this issue.


Am 22.08.25 um 06:23 schrieb Calvin Owens:
> On Thursday 08/21 at 22:39 +0200, Przemek Kitszel wrote:
>> On 8/21/25 16:23, Calvin Owens wrote:
>>> On Thursday 08/21 at 10:00 +0200, Przemek Kitszel wrote:
>>>> On 8/20/25 19:41, Calvin Owens wrote:
>>>>> On Wednesday 08/20 at 08:31 -0700, Calvin Owens wrote:
>>>>>> On Wednesday 08/20 at 08:42 +0200, Michal Schmidt wrote:
>>>>>>> On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
>>>>>>>> The same naming regression which was reported in ixgbe and fixed in
>>>>>>>> commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
>>>>>>>> changes") still exists in i40e.
>>>>>>>>
>>>>>>>> Fix i40e by setting the same flag, added in commit c5ec7f49b480
>>>>>>>> ("devlink: let driver opt out of automatic phys_port_name generation").
>>>>>>>>
>>>>>>>> Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
>>>>>>>
>>>>>>> But this one's almost two years old. By now, there may be more users
>>>>>>> relying on the new name than on the old one.
>>>>>>> Michal
>>>>>>
>>>>>> Well, I was relying on the new ixgbe names, and I had to revert them
>>>>>> all in a bunch of configs yesterday after e67a0bc3ed4f :)
>>>>
>>>> we have fixed (changed to old naming scheme) ixgbe right after the
>>>> kernel was used by real users (modulo usual delay needed to invent
>>>> a good solution)
>>>
>>> No, the "fix" actually broke me for a *second time*, because I'd
>>> already converted my infrastructure to use the *new* names, which match
>>> i40e and the rest of the world.
>>>
>>> We've seen *two* user ABI regressions in the last several months in
>>> ixgbe now, both of which completely broke networking on the system.
>>>
>>> I'm not here to whine about that: I just want to save as many people out
>>> there in the real world as I can the trouble of having to do the same
>>> work (which has absolutely no benefit) over the next five years in i40e.
>>>
>>> If it's acceptable to break me for a second time to "fix" this, because
>>> I'm the minority of users (a viewpoint I am in agreement with), it
>>> should also be acceptable to break the minority of i40e users who are
>>> running newer kernels to "fix" it there too.
>>>
>>> Why isn't it?
>>
>> I think we agree that it is ok-ish to sometime break setups for bleeding
>> edge users, then fix (aka undo). It's bad that this time it was with
>> effect equivalent to the first breakage (hope that it was easier to fix
>> locally when it occurred second time in a row).
> 
> I just want to re-emphasize, it was *not* my intent to gripe at you
> about this. A big reason I test new kernels is in the hope I can hit
> things like this myself and get them fixed before they impact the wide
> userbase, I'm only frustrated I'm probably too late here to do that.
> 
>> But we dispute over change from Oct 2023, for me it is carved in stone
>> at this point. Every user either adjusted or worked it around [1]
> 
> IMHO the date of the release (Jan 2024) is more relevant than the
> commit date, but it's not really that different in this case.
> 
> I think there's merit to the idea that the lack of complaining is a sign
> that most users have not had to adjust yet, because if they had, they'd
> have complained about it. But I don't have any real data either way.
> 
> The objections raised over the new interface naming in ixgbe are in no
> way specific to ixgbe. You can s/ixgbe/i40e/ any mail about it and
> nothing really changes. They're generalized objections against the
> renaming of interfaces, so from a certain POV people *are* actively
> complaining.
> 
>>>>> And, even if it is e67a0bc3ed4f that introduced it, v6.7 was the first
>>>>> release with it. I strongly suspect most servers with i40e NICs running
>>>>> in the wild are running older kernels than that, and have not yet
>>>>> encountered the naming regression. But you probably have much better
>>>>> data about that than I do :)
>>>>
>>>> Red Hat patches their kernels with current code of the drivers that their
>>>> customers use (including i40e and ixgbe)
>>>> One could expect that changes made today to those will reach RHEL 10.3,
>>>> even if it would be named "kernel 6.12".
>>>>
>>>> (*) the changes will likely be also in 10.2, but I don't want to make
>>>> any promises from Intel or Red Hat here
>>>
>>> But how many i40e users are actually on the most recent version of RHEL?
>>> Not very many, is my guess. RHEL9 is 5.14, and has the old behavior.
>>
>> RHEL 9 backported devlink for i40e in July 2024 [0], together with undo
>> of interface name change [1] (this likely tells why there were zero
>> complains from RH users).
>>
>> [0]
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/commit/bcbc349375ecd977aa429c3eff4d182b74dcdd8a
>>
>> [1]
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/commit/5ab8aa31dc2b44fbd6761bb19463f5427b9be245
> 
> Heh. Thank you very much for checking that, and for the links.

Too bad Red Hat didn’t report this over a year ago upstream.

>>> If you actually have data on that, obviously that's different. But it
>>> sounds like you're guessing just like I am.
>>
>> I could only guess about other OS Vendors, one could check it also
>> for Ubuntu in their public git, but I don't think we need more data, as
>> ultimate judge here are Stable Maintainers
> 
> Maybe I'm barking up the wrong tree, it's udev after all that decides to
> read the thing in /sys and name the interfaces differently because it's
> there...
> 
> In any case, Debian stable is on 6.12 and didn't patch it (just
> checked), so I concede, it is simply too late :/

I disagree. Debian admins do not upgrade their servers to the newest 
stable release right away to exactly avoid such issues. So I’d argue, as 
with Red Hat, that the change should be reverted as soon as possible, 
before even more users are hit by this.

But, as Przemek is one of the two subsystem maintainers, I guess his 
opinion matters quite a lot.


Kind regards,

Paul

