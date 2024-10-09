Return-Path: <netdev+bounces-133864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65F9974E6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05DD282A83
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E911C2DB8;
	Wed,  9 Oct 2024 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="qvipQYIp"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B81714A4
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498534; cv=none; b=utrLFMHYCfUf7mgaNT6lXJzPkfhffR6yOoADH7SuMDIgufTNbJ39/EOpgIknENfTj72Kbzbe4H8DRsBFxz0HuasQMfFDuxV/VQiF+fAVRpCrmtOcO8p5wW03kGAtdsSW7NmOZ/kKUhzmPVoMNr23DnYxtMGvyg/jPfBQ5EYGNBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498534; c=relaxed/simple;
	bh=OOoD2ITxqqhia7AncvgDfL9wFU9PNwPHS9XtXhaKNbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf5SqGHH8iSREGLWL9bdEhcP/dVlX4zM8x9LFdU1aMmxykabJyYqnnaGUZDP87JfeGhuPrHAeiMgPAgTpT13tMkbHnclRV5ESjVlyUO64nj77Gyn5cRU4+Z7qasHWb7+GC78JHuwxQI0RfkgXvNbId9K9cjoYdo4G1bPKOdvkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=qvipQYIp; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 267C98008E;
	Wed,  9 Oct 2024 18:28:50 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6FA2D13C2B0;
	Wed,  9 Oct 2024 11:28:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6FA2D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728498529;
	bh=OOoD2ITxqqhia7AncvgDfL9wFU9PNwPHS9XtXhaKNbY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvipQYIpq7cllw+gH7rsP4bMzx8xh2rrTuANqlS7tH616EXz6YQtlXuZrKjaHbpIR
	 v7mAKWtZuXw20tEqdA5ED1jTtqZA83oH96oiRNMWrQ7TXiXYaW0u25b4gE7TQUyLsq
	 DyryY+IMQo69xdSKxJ4YAkLrgQRuUaG2HtjUORPk=
Message-ID: <ce4efdf4-dd01-7363-f037-137815c43226@candelatech.com>
Date: Wed, 9 Oct 2024 11:28:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: nf-nat-core: allocated memory at module unload.
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Florian Westphal <fw@strlen.de>, netdev <netdev@vger.kernel.org>,
 kent.overstreet@linux.dev, pablo@netfilter.org
References: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com>
 <20241001193606.GA10530@breakpoint.cc>
 <CAJuCfpGyPNBQ=MTMeXzNZJcoiqok+zuW-3Ti0tFS7drhMFq1iQ@mail.gmail.com>
 <20241007112904.GA27104@breakpoint.cc>
 <CAJuCfpEDKkiXm1ye=gs3ohLDJM7gqQc0WwS=6egddbsZ1qRF9A@mail.gmail.com>
 <64e4009e-3a02-a139-4f82-f120f395e369@candelatech.com>
 <CAJuCfpH_g2ousOyUe19hwUpTGsQZa=w8sK9TCvU-aUsNKDdJTw@mail.gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CAJuCfpH_g2ousOyUe19hwUpTGsQZa=w8sK9TCvU-aUsNKDdJTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1728498531-uaJv6O3SOJmH
X-MDID-O:
 us5;at1;1728498531;uaJv6O3SOJmH;<greearb@candelatech.com>;2813669969b2b118972aacad644a9cd7
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/9/24 11:23, Suren Baghdasaryan wrote:
> On Wed, Oct 9, 2024 at 11:20 AM Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 10/7/24 08:10, Suren Baghdasaryan wrote:
>>> On Mon, Oct 7, 2024 at 4:29 AM Florian Westphal <fw@strlen.de> wrote:
>>>>
>>>> Suren Baghdasaryan <surenb@google.com> wrote:
>>>>> On Tue, Oct 1, 2024 at 12:36 PM Florian Westphal <fw@strlen.de> wrote:
>>>>>>
>>>>>> Ben Greear <greearb@candelatech.com> wrote:
>>>>>>
>>>>>> [ CCing codetag folks ]
>>>>>
>>>>> Thanks! I've been on vacation and just saw this report.
>>>>>
>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> I see this splat in 6.11.0 (plus a single patch to fix vrf xmit deadlock).
>>>>>>>
>>>>>>> Is this a known issue?  Is it a serious problem?
>>>>>>
>>>>>> Not known to me.  Looks like an mm (rcu)+codetag problem.
>>>>>>
>>>>>>> ------------[ cut here ]------------
>>>>>>> net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
>>>>>>> WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
>>>>>>> Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
>>>>>> ...
>>>>>>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
>>>>>>> RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
>>>>>>>    codetag_unload_module+0x19b/0x2a0
>>>>>>>    ? codetag_load_module+0x80/0x80
>>>>>>>    ? up_write+0x4f0/0x4f0
>>>>>>
>>>>>> "Well, yes, but actually no."
>>>>>>
>>>>>> At this time, kfree_rcu() has been called on all 4 objects.
>>>>>>
>>>>>> Looks like kfree_rcu no longer cares even about rcu_barrier(), and
>>>>>> there is no kvfree_rcu_barrier() in 6.11.
>>>>>>
>>>>>> The warning goes away when I replace kfree_rcu with call_rcu+kfree
>>>>>> plus rcu_barrier in module exit path.
>>>>>>
>>>>>> But I don't think its the right thing to do.
>>
>> Hello,
>>
>> Is this approach just ugly, or plain wrong?
> 
> I think the approach is correct.
> 
>>
>> kvfree_rcu_barrier does not existing in 6.10 kernel.
> 
> Yeah, I'll try backporting kvfree_rcu_barrier() to 6.10 and 6.11 for
> this change.

Ok, I will be happy to help test.

Please respond on this thread if you post something, pointing to whatever patch(es) should
be tested.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



