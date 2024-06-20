Return-Path: <netdev+bounces-105338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD6910850
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2281C23422
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C261AD9F0;
	Thu, 20 Jun 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptwCBJjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DB1ACE94;
	Thu, 20 Jun 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893815; cv=none; b=Z+K/RLD9L7iLzU4scI2YX82aLg+CtFiwvOEm5ZMdO5Le5MgDm+nUyLotzKyEfdPy/FhYk6Wo7snvK+vfVuPU26J2BJANL068mB7BR1vf13XImiibk1LqkgmijRQurbSYbs/k8m1M/xvNon4kXg+wIDcXFZQ3l2vNJCIDPjy7kSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893815; c=relaxed/simple;
	bh=CB0GfU5+WRIGYKX3xpnEIAeKadPq26rv8xPeG4YddIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkdcJm9J//IolwNqLp7j4ZOboeDqytzggc/muKh89omk5ONBCcQj7ltWAFHANEUJ09UZPtyGJBoAHG9N3C66ajtBQ/jmX075RnCMAnI9dPbbA7zAdSe6tzGj8+pKO7p1ypGBD60Y5mEoSkvn9LfszMFcz5r8deVg4Va1m+3l/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptwCBJjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74523C2BD10;
	Thu, 20 Jun 2024 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893814;
	bh=CB0GfU5+WRIGYKX3xpnEIAeKadPq26rv8xPeG4YddIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ptwCBJjjCoTf0NzrLBidJt/G48pusMeozirAqpkLd+rdk1yO3dNNTfILnOZxbNjka
	 UdkJyocoAQD4/PZzVXaJoNnihizBOnbf6uZoFFscYseHRY+DCw9yAkARKiwkOka53a
	 G09HHJNlbnnlgWgmNOGv+VUIURvYOXuxJTVdJwlZQ9spKzD4YGtWt7bySJxqEZ36J7
	 XWpwt0tLBRNddqr6FgT9DIdQlfJaxXpuDeJjPC6bKt1wFU3p4AnFJQ+Ash+Eqj1JXb
	 hsiWoS3/9tKHIu0ELtHwlBGlHSqQm2Ff9jdrE88pHUEh1nfTU1XQh9ssqGwegZFVz1
	 sgneK8K5QL+mA==
Message-ID: <5267ecb3-6380-4c70-a0ae-5830679d2935@kernel.org>
Date: Thu, 20 Jun 2024 16:30:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240612075829.18241-1-brgl@bgdev.pl>
 <CABBYNZLrwgj848w97GP+ijybt-yU8yMNnW5UWhb2y5Zq6b5H9A@mail.gmail.com>
 <CAMRc=Mdb31YGUUXRWACnx55JawayFaRjEPYSdjOCMrYr5xDYag@mail.gmail.com>
 <CABBYNZLPv3zk_UX67yPetQKWiQ-g+Dv9ZjZydhwG3jfaeV+48w@mail.gmail.com>
 <CAMRc=Mdsw5c_BDwUwP2Ss4Bogz-d+waZVd8LLaZ5oyc9dWS2Qg@mail.gmail.com>
 <CAMRc=Mf2koxQH8Pw--6g5O3FTFn_qcyfwTVQjUqxwJ5qW1nzjw@mail.gmail.com>
 <CABBYNZ+7SrLSDeCLF0WDM01prRgAEHMD=9mhu5MfWOuGwoAkNQ@mail.gmail.com>
 <CAMRc=MdozeAzWJCSrDdxVBZ=fwP2yn_j-KZaTDT2Dp7YjKP8-g@mail.gmail.com>
 <CABBYNZKA7-PAODStTZO33KfHOrGmZHjbEQcP+DKq-CVNwEce4w@mail.gmail.com>
 <CABBYNZ+x-HPCEwQVPONr6pF-Kvss=gJxqdosNGUfFFQDLz75DA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CABBYNZ+x-HPCEwQVPONr6pF-Kvss=gJxqdosNGUfFFQDLz75DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/06/2024 16:20, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, Jun 20, 2024 at 10:16 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Bartosz,
>>
>> On Wed, Jun 19, 2024 at 3:40 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> On Wed, Jun 19, 2024 at 8:59 PM Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>>
>>>> Hi Bartosz,
>>>>
>>>> On Wed, Jun 19, 2024 at 3:35 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>
>>>>> On Wed, Jun 12, 2024 at 5:00 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>
>>>>>> On Wed, Jun 12, 2024 at 4:54 PM Luiz Augusto von Dentz
>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Bartosz,
>>>>>>>
>>>>>>> On Wed, Jun 12, 2024 at 10:45 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>>>
>>>>>>>> On Wed, Jun 12, 2024 at 4:43 PM Luiz Augusto von Dentz
>>>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Bartosz,
>>>>>>>>>
>>>>>>>>> On Wed, Jun 12, 2024 at 3:59 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>>>>>
>>>>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>>>>
>>>>>>>>>> Hi Marcel, Luiz,
>>>>>>>>>>
>>>>>>>>>> Please pull the following power sequencing changes into the Bluetooth tree
>>>>>>>>>> before applying the hci_qca patches I sent separately.
>>>>>>>>>>
>>>>>>>>>> Link: https://lore.kernel.org/linux-kernel/20240605174713.GA767261@bhelgaas/T/
>>>>>>>>>>
>>>>>>>>>> The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:
>>>>>>>>>>
>>>>>>>>>>   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
>>>>>>>>>>
>>>>>>>>>> are available in the Git repository at:
>>>>>>>>>>
>>>>>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-initial-for-v6.11
>>>>>>>>>>
>>>>>>>>>> for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f42869128dd:
>>>>>>>>>>
>>>>>>>>>>   power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets (2024-06-12 09:20:13 +0200)
>>>>>>>>>>
>>>>>>>>>> ----------------------------------------------------------------
>>>>>>>>>> Initial implementation of the power sequencing subsystem for linux v6.11
>>>>>>>>>>
>>>>>>>>>> ----------------------------------------------------------------
>>>>>>>>>> Bartosz Golaszewski (2):
>>>>>>>>>>       power: sequencing: implement the pwrseq core
>>>>>>>>>>       power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
>>>>>>>>>
>>>>>>>>> Is this intended to go via bluetooth-next or it is just because it is
>>>>>>>>> a dependency of another set? You could perhaps send another set
>>>>>>>>> including these changes to avoid having CI failing to compile.
>>>>>>>>>
>>>>>>>>
>>>>>>>> No, the pwrseq stuff is intended to go through its own pwrseq tree
>>>>>>>> hence the PR. We cannot have these commits in next twice.
>>>>>>>
>>>>>>> Not following you here, why can't we have these commits on different
>>>>>>> next trees? If that is the case how can we apply the bluetooth
>>>>>>> specific ones without causing build regressions?
>>>>>>>
>>>>>>
>>>>>> We can't have the same commits twice with different hashes in next
>>>>>> because Stephen Rothwell will yell at us both.
>>>>>>
>>>>>> Just pull the tag I provided and then apply the Bluetooth specific
>>>>>> changes I sent on top of it. When sending to Linus Torvalds/David
>>>>>> Miller (not sure how your tree gets upstream) mention that you pulled
>>>>>> in the pwrseq changes in your PR cover letter.
>>>>
>>>> By pull the tag you mean using merge commits to merge the trees and
>>>> not rebase, doesn't that lock us down to only doing merge commits
>>>> rather than rebases later on? I have never used merge commits before.
>>>> There is some documentation around it that suggests not to use merges:
>>>>
>>>> 'While merges from downstream are common and unremarkable, merges from
>>>> other trees tend to be a red flag when it comes time to push a branch
>>>> upstream. Such merges need to be carefully thought about and well
>>>> justified, or there’s a good chance that a subsequent pull request
>>>> will be rejected.'
>>>> https://docs.kernel.org/maintainer/rebasing-and-merging.html#merging-from-sibling-or-upstream-trees
>>>>
>>>> But then looking forward in that documentation it says:
>>>>
>>>> 'Another reason for doing merges of upstream or another subsystem tree
>>>> is to resolve dependencies. These dependency issues do happen at
>>>> times, and sometimes a cross-merge with another tree is the best way
>>>> to resolve them; as always, in such situations, the merge commit
>>>> should explain why the merge has been done. Take a moment to do it
>>>> right; people will read those changelogs.'
>>>>
>>>> So I guess that is the reason we want to merge the trees, but what I'm
>>>> really looking forward to is for the 'proper' commands and commit
>>>> message to use to make sure we don't have problems in the future.
>>>>
>>>
>>> You shouldn't really need to rebase your branch very often anyway.
>>> This is really for special cases. But even then you can always use:
>>> `git rebase --rebase-merges` to keep the merge commits.
>>>
>>> The commands you want to run are:
>>>
>>> git pull git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
>>> tags/pwrseq-initial-for-v6.11
>>> git am or b4 shazam on the patches targeting the Bluetooth subsystem
>>> git push
>>
>> Not quite working for me:
>>
>> From git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
>>  * tag                         pwrseq-initial-for-v6.11 -> FETCH_HEAD
>> hint: You have divergent branches and need to specify how to reconcile them.
>> hint: You can do so by running one of the following commands sometime before
>> hint: your next pull:
>> hint:
>> hint:   git config pull.rebase false  # merge
>> hint:   git config pull.rebase true   # rebase
>> hint:   git config pull.ff only       # fast-forward only
>> hint:
>> hint: You can replace "git config" with "git config --global" to set a default
>> hint: preference for all repositories. You can also pass --rebase, --no-rebase,
>> hint: or --ff-only on the command line to override the configured default per
>> hint: invocation.
>> fatal: Need to specify how to reconcile divergent branches.
>>
>> Perhaps I need to configure pull.rebase to be false?
> 
> Looks like I just needed -no-ff, will be pushing it after it finishes compiling.

Ah, so there was a tag. You miss proper config option... Well, I am
surprised you do not have default pull.rebase set. How did you manage to
pull anything from anyone? Git requires it since some time.

Best regards,
Krzysztof


