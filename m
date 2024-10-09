Return-Path: <netdev+bounces-133859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFA9974CB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215871F220D4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFF13F43A;
	Wed,  9 Oct 2024 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="WdpMpE+s"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22482381C4
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498058; cv=none; b=nDQpNu60v4TLwjE1PYN+NV/pTj3IrYcefucCg+GBNxF5xUVAjHzqtDxOq+SSgHz7f68VnuKAxk7TQ4uYzZwip4sKTEXlnaj2B0/Com2V1Mv8/DT6mT23bh7NLRR1bslXpnuURrb5ib1axtusBZad1+Fanj4zLAbMEE8Vec37V4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498058; c=relaxed/simple;
	bh=AZ/rwsxovaTr4I0o85qEuf9ol9T0Po2UgDg/DFgZLY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tk4IrfTblGZYLMc5ZtnKkFwy6Dgtz3JtkMLF7feDvZqltOXl2qOYT9fwJymESsEcXM8KKYWo1EyS85GjMT4NsYOMDu8w5TRsP+ACP9k1E82qTITHIivWYryd01Bc4Utnc/rh74/JStD+B+tbpqJ/liEbD+y0q+cDrufT4WfHQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=WdpMpE+s; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 002EE94006F;
	Wed,  9 Oct 2024 18:20:53 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 2787213C2B0;
	Wed,  9 Oct 2024 11:20:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2787213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728498053;
	bh=AZ/rwsxovaTr4I0o85qEuf9ol9T0Po2UgDg/DFgZLY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WdpMpE+s1ds9lgpyggqnr+v3UriDJvxVKQI6oFOiaTq4u/uKNrbCGOjy9MQqVWoEl
	 7m2DXVtowGfmmTcDWk/2gh1doHWevkas7kOfbvbgDecnQ50X+SIM6kq2Wye/BJoCHM
	 dSz18Z1Atvr83tPRfJjfzMYCaRJdckFnPm9aod30=
Message-ID: <64e4009e-3a02-a139-4f82-f120f395e369@candelatech.com>
Date: Wed, 9 Oct 2024 11:20:52 -0700
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
To: Suren Baghdasaryan <surenb@google.com>, Florian Westphal <fw@strlen.de>
Cc: netdev <netdev@vger.kernel.org>, kent.overstreet@linux.dev,
 pablo@netfilter.org
References: <bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com>
 <20241001193606.GA10530@breakpoint.cc>
 <CAJuCfpGyPNBQ=MTMeXzNZJcoiqok+zuW-3Ti0tFS7drhMFq1iQ@mail.gmail.com>
 <20241007112904.GA27104@breakpoint.cc>
 <CAJuCfpEDKkiXm1ye=gs3ohLDJM7gqQc0WwS=6egddbsZ1qRF9A@mail.gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CAJuCfpEDKkiXm1ye=gs3ohLDJM7gqQc0WwS=6egddbsZ1qRF9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1728498055-d7Ylo8pwYnvS
X-MDID-O:
 us5;at1;1728498055;d7Ylo8pwYnvS;<greearb@candelatech.com>;2813669969b2b118972aacad644a9cd7
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/7/24 08:10, Suren Baghdasaryan wrote:
> On Mon, Oct 7, 2024 at 4:29 AM Florian Westphal <fw@strlen.de> wrote:
>>
>> Suren Baghdasaryan <surenb@google.com> wrote:
>>> On Tue, Oct 1, 2024 at 12:36 PM Florian Westphal <fw@strlen.de> wrote:
>>>>
>>>> Ben Greear <greearb@candelatech.com> wrote:
>>>>
>>>> [ CCing codetag folks ]
>>>
>>> Thanks! I've been on vacation and just saw this report.
>>>
>>>>
>>>>> Hello,
>>>>>
>>>>> I see this splat in 6.11.0 (plus a single patch to fix vrf xmit deadlock).
>>>>>
>>>>> Is this a known issue?  Is it a serious problem?
>>>>
>>>> Not known to me.  Looks like an mm (rcu)+codetag problem.
>>>>
>>>>> ------------[ cut here ]------------
>>>>> net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
>>>>> WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
>>>>> Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
>>>> ...
>>>>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
>>>>> RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
>>>>>   codetag_unload_module+0x19b/0x2a0
>>>>>   ? codetag_load_module+0x80/0x80
>>>>>   ? up_write+0x4f0/0x4f0
>>>>
>>>> "Well, yes, but actually no."
>>>>
>>>> At this time, kfree_rcu() has been called on all 4 objects.
>>>>
>>>> Looks like kfree_rcu no longer cares even about rcu_barrier(), and
>>>> there is no kvfree_rcu_barrier() in 6.11.
>>>>
>>>> The warning goes away when I replace kfree_rcu with call_rcu+kfree
>>>> plus rcu_barrier in module exit path.
>>>>
>>>> But I don't think its the right thing to do.

Hello,

Is this approach just ugly, or plain wrong?

kvfree_rcu_barrier does not existing in 6.10 kernel.

Thanks,
Ben

>>>>
>>>> (referring to nf_nat_unregister_fn(), kfree_rcu(priv, rcu_head);).
>>>>
>>>> Reproducer:
>>>> unshare -n iptables-nft -t nat -A PREROUTING -p tcp
>>>> grep nf_nat /proc/allocinfo # will list 4 allocations
>>>> rmmod nft_chain_nat
>>>> rmmod nf_nat                # will WARN.
>>>>
>>>> Without rmmod, the 4 allocations go away after a few seconds,
>>>> grep will no longer list them and then rmmod won't splat.
>>>
>>> I see. So, the kfree_rcu() was already called but freeing did not
>>> happen yet, in the meantime we are unloading the module.
>>
>> Yes.
>>
>>> We could add
>>> a synchronize_rcu() at the beginning of codetag_unload_module() so
>>> that all pending kfree_rcu()s complete before we check codetag
>>> counters:
>>>
>>> bool codetag_unload_module(struct module *mod)
>>> {
>>>          struct codetag_type *cttype;
>>>          bool unload_ok = true;
>>>
>>>          if (!mod)
>>>                  return true;
>>>
>>> +      synchronize_rcu();
>>>          mutex_lock(&codetag_lock);
>>
>> This doesn't help as kfree_rcu doesn't wait for this.
>>
>> Use of kvfree_rcu_barrier() instead does work though.
> 
> I see. That sounds like an acceptable fix. Please post it and I'll ack it.
> Thanks!
> 
-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



