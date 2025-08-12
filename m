Return-Path: <netdev+bounces-212786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F151B21F73
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C500350417D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D02E03EA;
	Tue, 12 Aug 2025 07:24:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.nospprt.eu (gw.nospprt.eu [37.120.174.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE02DFF13
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.174.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983445; cv=none; b=UFo0HbMx3w+CUcJjthOLgo3DYUp+N6XaeswI18Lm23FPEbGMsY43lwsf0BzSASyZQk2IOGNt6Yb1kZb1wZmZ/r3JGD8+RqY+oaFcymXlnY1Ege/4ngwAuLYAvxMMQggFjwUvZDhM/7LHJY6H/kVKiwVuRuRelgZRLLFiIIWc0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983445; c=relaxed/simple;
	bh=SUv/IZQZX/VDgRy2vgtl4dHvtFyHZguC2+vt+84w+Gg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jammZRjag0oIiXQR+nyGC/QIhDAweus4FQh7g6Pq2n/FtXqC/XiWelj80SOO6w3HtT8JkHQQSjXiCiV91u1+evm8gURGmy7KPvx7IIyBj/XWHp3Y+t8k0+k/iIW8LieWYNpBUuyWNvY6Qy5sPW9odLYFnnA8VgtqEC2jeyrU0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sh.werbittewas.de; spf=pass smtp.mailfrom=sh.werbittewas.de; arc=none smtp.client-ip=37.120.174.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sh.werbittewas.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sh.werbittewas.de
Received: from imap.nospprt.eu by smtp.nospprt.eu  with ESMTP id 57C7Njm9001222; Tue, 12 Aug 2025 09:23:46 +0200
Received:	by imap.nospprt.eu with ESMTPSA
	id Ho+KMAHsmmg8FwAAsBFz6g
	(envelope-from <lkml-xx-15438@sh.werbittewas.de>); Tue, 12 Aug 2025 09:23:45 +0200
Subject: Re: problems with hfsc since 5.10.238-patches in sched_hfsc.c
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        victor@mojatatu.com, pctammela@mojatatu.com
References: <ab86a457-aab0-1ea3-3161-2630491585d7@moenia.de>
 <CAM0EoM=6353sFS5dc81Gh6-86YK3rWQq5OUUV3Sumw1-BXKwnw@mail.gmail.com>
From: lkml-xx-15438@sh.werbittewas.de
Message-ID: <c992d237-5ad2-2970-d275-ea1cdfc15ac3@is-kassel.org>
Date: Tue, 12 Aug 2025 09:23:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoM=6353sFS5dc81Gh6-86YK3rWQq5OUUV3Sumw1-BXKwnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de
Content-Transfer-Encoding: 8bit

hi,

thank you for spending time on this problem.

we followed your suggestion to try the actual kernel (we've tried it
before without success), but now with clean build from scratch instead
of using the old tree with incremental patches and voila: we can't
reproduce the behaviour any more!

sorry for that. if there will be ever again such a problem, we will
first try to make a clean build before asking for help.

best regards

x.

Am 11.08.25 um 06:44 schrieb Jamal Hadi Salim:
> Hi,
> 
> On Sat, Aug 9, 2025 at 4:13 PM <lkml-xx-15438@sh.werbittewas.de> wrote:
>>
>> hi.
>>
>> hopefully the right list for this problem, else please tell me the right
>> one.
>>
>> Problem:
>> after updating to 5.10.238 (manually compiled) hfsc is malfunctioning here.
>> after a long time with noch changes and no problems, most packages are
>> dropped without notice.
>>
>> after some tries we've identified the patches
>>
>> - https://lore.kernel.org/all/20250425220710.3964791-3-victor@mojatatu.com/
>>
>> and
>>
>> -
>> https://lore.kernel.org/all/20250522181448.1439717-2-pctammela@mojatatu.com/
>>
>> which seems to lead to misbehaviour.
>>
>>
>> by changing the line in hfsc_enqueue()
>>
>> "if (first && !cl_in_el_or_vttree(cl)) {"
>>
>> back to
>>
>> "if (first) {"
>>
>> all went well again.
>>
>>
>> if it matters: we're using a simple net-ns-container for
>> forwarding/scheduling the local dsl-line
>>
>>
>> maybe we're using a config of hfsc, which is not ok (but we're doing
>> this over several years)
>>
>> our hfsc-init is like:
>>
>>
>> /sbin/tc qdisc add dev eth0 root handle 1: hfsc default 14
>>
>> /sbin/tc class add dev eth0 parent 1: classid 1:10 hfsc ls m2 36000kbit
>> ul m2 36000kbit
>>
>> /sbin/tc class add dev eth0 parent 1:10 classid 1:14 hfsc ls m1
>> 36000kbit d 10000ms m2 30000kbit ul m1 30000kbit d 10000ms m2 25000kbit
>>
>> (normally there are further lines, but above calls are sufficant to
>> either forward the packets before .238 or let them drop with .238 or
>> later. we're using an old tc (iproute2-5.11.0) on this system.
>>
>>
>> so, it would be nice, if someone can tell us, why the above
>> hfsc-init-calls are bad, or if they're ok and the changes in 5.10.238
>> have side-effects, which lead to this behaviour.
>>
>>
> 
> Please retry with the latest 5.10.xx since it seems some patches were
> left out in the backport. And if that still exhibits this problem try
> the latest  6.17 net tree because it will help isolate if the issue is
> only with 5.10.x.
> If the problem persists please share your script/netns setup. And in
> the future please Cc the stakeholders. It makes it easier to help.
> For the record, trying what you just described with kernel 5.10.238
> and iproute2 5.11.0 didnt recreate the issue. Basically:
> Creating a netns, running your commands, pings from the netns and
> netcat.. It all worked fine, no drops.
> 
> cheers,
> jamal
> 
> 
> 
> 
>> thanks a lot.
>>
>> regards
>>
>> x.
>>

