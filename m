Return-Path: <netdev+bounces-78132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24587429A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401BD1C20F24
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305C01B952;
	Wed,  6 Mar 2024 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oG8qB4dn"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94F1BC22
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763681; cv=none; b=dXn7uhRcRY9RN9GgQ5eZiHJHK83ga0bAnuK//9Hx3SfCFWRHBCrF9ayupch+iUdvHdFqBuJHWR7GmveUtpmiPx0zfDz/EPECYvwfCCBRUwzBNkdU8KPNIR28+GabZb8KJ1HRLj7MOqWNiWh/jezCg79auEAUvUyoqIQ00/IA+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763681; c=relaxed/simple;
	bh=eU1sr+hp7JfMSbX+l3VOXfOsC9h2A1gLGwVEArMa7IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL5F73sgZkRMIRNmIxttEzU2y69M48o1wLwCkDyiMg+N0CBKJ8sSPiJHDHqBk19v5xGwMWG6RZMWWKDLUNBkfoQLCQXvF6VfdnKZHUpuUOtDz5vuvMLtOGytMrsOHFe8cKTl2I+6T+n/x9dIDIDbxNGMZedqCx71MK0oW7gxZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oG8qB4dn; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5f75c8d-847f-4f9e-81d6-8297e8ca48b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709763676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mQaAT+EytOA0LmuhOL4TbxhsnILNUCoGNWXSstdJ+E=;
	b=oG8qB4dn3+Zpe7k+ZD79P9DOVVqorpphvmNgcVeWGgFYrOrvpEXvCv9guHAYhs3+LmbuO9
	QVvi9PVpEeIcVg6UF2Tk+hda2YCMrlhWwI18aYiaC8dU22ObYoAf/s3mZbADF5VVNOTBt9
	CsT8hSwyOArBgcS+PAcnQFSSIboU2wI=
Date: Wed, 6 Mar 2024 14:21:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v12 14/15] p4tc: add set of P4TC table kfuncs
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net,
 victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240225165447.156954-1-jhs@mojatatu.com>
 <20240225165447.156954-15-jhs@mojatatu.com>
 <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev>
 <CAM0EoMniOaKn4W_WN9rmQZ1JY3qCugn34mmqCy9UdCTAj_tuTQ@mail.gmail.com>
 <f88b5f65-957e-4b5d-8959-d16e79372658@linux.dev>
 <CAM0EoMk=igKT5ZEwcfdQqP6O3u8tO7VOpkNsWE1b92ia2eZVpw@mail.gmail.com>
 <496c78b7-4e16-42eb-a2f4-99472cd764fd@linux.dev>
 <CAM0EoMmB0s5WzZ-CgGWBF9YdaWi7O0tHEj+C8zuryGhKz7+FpA@mail.gmail.com>
 <7aaeee73-4197-4ea8-834a-2265ef078bab@linux.dev>
 <CAM0EoMnkJpBnD5G3CfWnGkzE1cQKDp_mz02BW+aHK4rbTnOQCQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAM0EoMnkJpBnD5G3CfWnGkzE1cQKDp_mz02BW+aHK4rbTnOQCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/6/24 12:22 PM, Jamal Hadi Salim wrote:
>> I think my question was, who can use the act_bpf_kern object when all tc bpf
>> prog is unloaded? If no one can use it, it should as well be cleaned up when the
>> bpf prog is unloaded.
>>
>> or the kernel p4 pipeline can use the act_bpf_kern object even when there is no
>> bpf prog loaded?

[ ... ]

>>> I am looking at the conntrack code and i dont see how they release
>>> entries from the cotrack table when the bpf prog goes away.

[ ... ]

> I asked earlier about conntrack (where we took the inspiration from):
> How is what we are doing different from contrack? If you can help me
> understand that i am more than willing to make the change.
> Conntrack entries can be added via the kfunc(same for us). Contrack
> entries can also be added from the control plane and can be found by
> ebpf lookups(same for us). They can be deleted by the control plane,
> timers, entry evictions to make space for new entries, etc (same for
> us). Not sure if they can be deleted by ebpf side (we can). Perusing
> the conntrack code, I could not find anything  that indicated that
> entries created from ebpf are deleted when the ebpf program goes away.
> 
> To re-emphasize: Maybe there's something subtle i am missing that we
> are not doing that conntrack is doing?
> Conntrack does one small thing we dont: It allocs and returns to ebpf
> the memory for insertion. I dont see that as particularly useful for
> our case (and more importantly how that results in the entries being
> deleted when the ebpf prog goes away)

afaik, the conntrack kfunc inserts "struct nf_conn" that can also be used by 
other kernel parts, so it is reasonable to go through the kernel existing 
eviction logic. It is why my earlier question on "is the act_bpf_kern object 
only useful for the bpf prog alone but not other kernel parts". From reading 
patch 14, it seems to be only usable by bpf prog. When all bpf program is 
unloaded, who will still read it and do something useful? If I mis-understood 
it, this will be useful to capture in the commit message to explain how it could 
be used by other kernel parts without bpf prog running.


