Return-Path: <netdev+bounces-35271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342147A8601
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 16:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC467281E67
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F30C3AC27;
	Wed, 20 Sep 2023 14:02:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486F36B12
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:02:06 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24034D7;
	Wed, 20 Sep 2023 07:02:03 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qixmD-0004OH-7z; Wed, 20 Sep 2023 16:02:01 +0200
Message-ID: <cd12622b-bfc6-093d-5c10-493e10935440@leemhuis.info>
Date: Wed, 20 Sep 2023 16:02:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix handling of
 HCI_QUIRK_STRICT_DUPLICATE_FILTER
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 patchwork-bot+bluetooth@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, Stefan Agner <stefan@agner.ch>
References: <20230829205936.766544-1-luiz.dentz@gmail.com>
 <169343402479.21564.11565149320234658166.git-patchwork-notify@kernel.org>
 <de698d06-9784-43ed-9437-61d6edf9672b@leemhuis.info>
 <CABBYNZK2PPkLra8Au-fdN2nG2YLkfFRmPtEPQL0suLzBv=HHcA@mail.gmail.com>
 <574ca8dd-ee97-4c8b-a154-51faf83cabdf@leemhuis.info>
 <CABBYNZJ=5VH2+my7Gw1fMCaGgdOQfbWNtBGOc27_XQqCP7jD-A@mail.gmail.com>
 <ff2abfbe-a46b-414b-a757-8185495838b7@leemhuis.info>
In-Reply-To: <ff2abfbe-a46b-414b-a757-8185495838b7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695218523;629cc3e1;
X-HE-SMSGID: 1qixmD-0004OH-7z
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

@Luiz Augusto von Dentz: did you make any progress to get this into net
to make sure this rather sooner then later heads to mainline? Doesn't
looks like it from here, but maybe I'm missing something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke


On 14.09.23 20:08, Thorsten Leemhuis wrote:
> On 14.09.23 19:51, Luiz Augusto von Dentz wrote:
>> On Wed, Sep 13, 2023 at 10:13 PM Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>> On 12.09.23 21:09, Luiz Augusto von Dentz wrote:
>>>> On Mon, Sep 11, 2023 at 6:40 AM Linux regression tracking (Thorsten
>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>> On 31.08.23 00:20, patchwork-bot+bluetooth@kernel.org wrote:
>>>>>> This patch was applied to bluetooth/bluetooth-next.git (master)
>>>>>> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>>>>>> On Tue, 29 Aug 2023 13:59:36 -0700 you wrote:
>>>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>>>
>>>>>>> When HCI_QUIRK_STRICT_DUPLICATE_FILTER is set LE scanning requires
>>>>>>> periodic restarts of the scanning procedure as the controller would
>>>>>>> consider device previously found as duplicated despite of RSSI changes,
>>>>>>> but in order to set the scan timeout properly set le_scan_restart needs
>>>>>>> to be synchronous so it shall not use hci_cmd_sync_queue which defers
>>>>>>> the command processing to cmd_sync_work.
>>>>>>> [...]
>>>>>>
>>>>>> Here is the summary with links:
>>>>>>   - Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
>>>>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/52bf4fd43f75
>>>>>
>>>>> That is (maybe among others?) a fix for a regression from 6.1, so why
>>>>> was this merged into a "for-next" branch instead of a branch that
>>>>> targets the current cycle?
>> [...]
>>> That answer doesn't answer the question afaics, as both 6.1 and 6.4 were
>>> released in the past year -- the fix thus should not wait till the next
>>> merge window, unless it's high risk or something. See this statement
>>> from Linus:
>>> https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/
>> Thanks for the feedback, I will try to push fixes to net more often.
> 
> Great, many thx!
> 
>>>> but I could probably have it marked for stable just
>>>> to make sure it would get backported to affected versions.
>>> That would be great, too!
>> Well now that it has already been merged via -next tree shall we still
>> attempt to mark it as stable? Perhaps we need to check if it was not
>> backported already based on the Fixes tag.
> 
> Changes only get backported once they hit mainline, which hasn't
> happened yet. And to get them into the net branch (and from there to
> mainline) a new commit is needed anyway, so you might as well add the
> stable tag to it. Side note: And don't worry that identical commit is
> already in -next, git handles that well afaik (but if you rebase
> bluetooth-next for other reasons anyway you might as well remove it).
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

