Return-Path: <netdev+bounces-77784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F0873020
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC461F213B6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E55CDF1;
	Wed,  6 Mar 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nAXrGGdB"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934945CDDC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711944; cv=none; b=W2i192IknteQwh02lLQJCw3Bsq0MLwrFf+QxIvA6iOllXMfhExCxVpwr/FM3q7Da/jv9CMDjDiQemiRqs7E/N1NdAT9yPU3WWVblWOMvypwtNXgYAEq4y9MeOdmNkz6DbpkUz7DQW8UL1Uc4LZAgPLpKQySO8oh2T1whqjtA1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711944; c=relaxed/simple;
	bh=4nTzqRh2Da9+8jGOqLVDfEZtt/wUSEj0nyjdCZP2Ywo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMIs8xbqFRYuVd6g+x5+xAG6245VkF5971Iqvq5yF2NkM6c8NsbBANLGXr2MIJ/RIqw8ERqsoritkX62L65PCxh5OaBxHbObYLe5PZEduosd5dueqtVL1q+D13E+/HQR22hiJpapPjay456ZSY+zkzLe+Bmjc4PA0tnlOokexKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nAXrGGdB; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7aaeee73-4197-4ea8-834a-2265ef078bab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709711938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMdKN/veBvBZl77DmaY151Schj3OAuh7OxlNW/BLu6g=;
	b=nAXrGGdBbQdUdnkNDA0RBfdaM0nkRv2H/UfctRgaGjhMARmkjoODK6z6T5Ek4R6mb31PiN
	nMhroCz5VA9f7LYxd6Tai65xSjh6m3soj7X7caiPOtItHpArT3l/ERx4PIrLWrqVqBCp4u
	QV2T2p7Uwhiio13pBruGdoN4eu9koBU=
Date: Tue, 5 Mar 2024 23:58:47 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAM0EoMmB0s5WzZ-CgGWBF9YdaWi7O0tHEj+C8zuryGhKz7+FpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/5/24 4:30 AM, Jamal Hadi Salim wrote:
> On Tue, Mar 5, 2024 at 2:40 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 3/3/24 9:20 AM, Jamal Hadi Salim wrote:
>>
>>>>>>> +#define P4TC_MAX_PARAM_DATA_SIZE 124
>>>>>>> +
>>>>>>> +struct p4tc_table_entry_act_bpf {
>>>>>>> +     u32 act_id;
>>>>>>> +     u32 hit:1,
>>>>>>> +         is_default_miss_act:1,
>>>>>>> +         is_default_hit_act:1;
>>>>>>> +     u8 params[P4TC_MAX_PARAM_DATA_SIZE];
>>>>>>> +} __packed;
>>>>>>> +
>>>>>>> +struct p4tc_table_entry_act_bpf_kern {
>>>>>>> +     struct rcu_head rcu;
>>>>>>> +     struct p4tc_table_entry_act_bpf act_bpf;
>>>>>>> +};
>>>>>>> +
>>>>>>>      struct tcf_p4act {
>>>>>>>          struct tc_action common;
>>>>>>>          /* Params IDR reference passed during runtime */
>>>>>>>          struct tcf_p4act_params __rcu *params;
>>>>>>> +     struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
>>>>>>>          u32 p_id;
>>>>>>>          u32 act_id;
>>>>>>>          struct list_head node;
>>>>>>> @@ -24,4 +40,39 @@ struct tcf_p4act {
>>>>>>>
>>>>>>>      #define to_p4act(a) ((struct tcf_p4act *)a)
>>>>>>>
>>>>>>> +static inline struct p4tc_table_entry_act_bpf *
>>>>>>> +p4tc_table_entry_act_bpf(struct tc_action *action)
>>>>>>> +{
>>>>>>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf;
>>>>>>> +     struct tcf_p4act *p4act = to_p4act(action);
>>>>>>> +
>>>>>>> +     act_bpf = rcu_dereference(p4act->act_bpf);
>>>>>>> +
>>>>>>> +     return &act_bpf->act_bpf;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline int
>>>>>>> +p4tc_table_entry_act_bpf_change_flags(struct tc_action *action, u32 hit,
>>>>>>> +                                   u32 dflt_miss, u32 dflt_hit)
>>>>>>> +{
>>>>>>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf, *act_bpf_old;
>>>>>>> +     struct tcf_p4act *p4act = to_p4act(action);
>>>>>>> +
>>>>>>> +     act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL);
>>>>>>
>>>>>>
>>>>>> [ ... ]
>>
>>
>>>>>>> +static int
>>>>>>> +__bpf_p4tc_entry_create(struct net *net,
>>>>>>> +                     struct p4tc_table_entry_create_bpf_params *params,
>>>>>>> +                     void *key, const u32 key__sz,
>>>>>>> +                     struct p4tc_table_entry_act_bpf *act_bpf)
>>>>>>> +{
>>>>>>> +     struct p4tc_table_entry_key *entry_key = key;
>>>>>>> +     struct p4tc_pipeline *pipeline;
>>>>>>> +     struct p4tc_table *table;
>>>>>>> +
>>>>>>> +     if (!params || !key)
>>>>>>> +             return -EINVAL;
>>>>>>> +     if (key__sz != P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
>>>>>>> +             return -EINVAL;
>>>>>>> +
>>>>>>> +     pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
>>>>>>> +     if (!pipeline)
>>>>>>> +             return -ENOENT;
>>>>>>> +
>>>>>>> +     table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
>>>>>>> +     if (!table)
>>>>>>> +             return -ENOENT;
>>>>>>> +
>>>>>>> +     if (entry_key->keysz != table->tbl_keysz)
>>>>>>> +             return -EINVAL;
>>>>>>> +
>>>>>>> +     return p4tc_table_entry_create_bpf(pipeline, table, entry_key, act_bpf,
>>>>>>> +                                        params->profile_id);
>>>>>>
>>>>>> My understanding is this kfunc will allocate a "struct
>>>>>> p4tc_table_entry_act_bpf_kern" object. If the bpf_p4tc_entry_delete() kfunc is
>>>>>> never called and the bpf prog is unloaded, how the act_bpf object will be
>>>>>> cleaned up?
>>>>>>
>>>>>
>>>>> The TC code takes care of this. Unloading the bpf prog does not affect
>>>>> the deletion, it is the TC control side that will take care of it. If
>>>>> we delete the pipeline otoh then not just this entry but all entries
>>>>> will be flushed.
>>>>
>>>> It looks like the "struct p4tc_table_entry_act_bpf_kern" object is allocated by
>>>> the bpf prog through kfunc and will only be useful for the bpf prog but not
>>>> other parts of the kernel. However, if the bpf prog is unloaded, these bpf
>>>> specific objects will be left over in the kernel until the tc pipeline (where
>>>> the act_bpf_kern object resided) is gone.
>>>>
>>>> It is the expectation on bpf prog (not only tc/xdp bpf prog) about resources
>>>> clean up that these bpf objects will be gone after unloading the bpf prog and
>>>> unpinning its bpf map.
>>>>
>>>
>>> The table (residing on the TC side) could be shared by multiple bpf
>>> programs. Entries are allocated on the TC side of the fence.
>>
>>
>>> IOW, the memory is not owned by the bpf prog but rather by pipeline.
>>
>> The struct p4tc_table_entry_act_(bpf_kern) object is allocated by
>> bpf_p4tc_entry_create() kfunc and only bpf prog can use it, no?
>> afaict, this is bpf objects.
>>
> 
> Bear with me because i am not sure i am following.
> When we looked at conntrack as guidance we noticed they do things
> slightly differently. They have an allocate kfunc and an insert
> function. If you have alloc then you need a complimentary release. The
> existence of the release in conntrack, correct me if i am wrong, seems
> to be based on the need to free the object if an insert fails. In our
> case the insert does first allocate then inserts all in one operation.
> If either fails it's not the concern of the bpf side to worry about
> it. IOW, i see the ownership as belonging to the P4TC side  (it is
> both allocated, updated and freed by that side). Likely i am missing
> something..

It is not the concern about the kfuncs may leak object.

I think my question was, who can use the act_bpf_kern object when all tc bpf 
prog is unloaded? If no one can use it, it should as well be cleaned up when the 
bpf prog is unloaded.

or the kernel p4 pipeline can use the act_bpf_kern object even when there is no 
bpf prog loaded?


> 
>>> We do have a "whodunnit" field, i.e we keep track of which entity
>>> added an entry and we are capable of deleting all entries when we
>>> detect a bpf program being deleted (this would be via deleting the tc
>>> filter). But my thinking is we should make that a policy decision as
>>> opposed to something which is default.
>>
>> afaik, this policy decision or cleanup upon tc filter delete has not been done
>> yet. I will leave it to you to figure out how to track what was allocated by a
>> particular bpf prog on the TC side. It is not immediately clear to me and I
>> probably won't have a good idea either.
>>
> 
> I am looking at the conntrack code and i dont see how they release
> entries from the cotrack table when the bpf prog goes away.
> 
>> Just to be clear that it is almost certain to be unacceptable to extend and make
>> changes on the bpf side in the future to handle specific resource
>> cleanup/tracking/sharing of the bpf objects allocated by these kfuncs. This
>> problem has already been solved and works for different bpf program types,
>> tc/cgroup/tracing...etc. Adding a refcnted bpf prog pointer alongside the
>> act_bpf_kern object will be a non-starter.
>>
>> I think multiple people have already commented that these kfuncs
>> (create/update/delete...) resemble the existing bpf map. If these kfuncs are
>> replaced with the bpf map ops, this bpf resource management has already been
>> handled and will be consistent with other bpf program types.
>>
>> I expect the act_bpf_kern object probably will grow in size over time also.
>> Considering this new p4 pipeline and table is residing on the TC side, I will
>> leave it up to others to decide if it is acceptable to have some unused bpf
>> objects left attached there.
> 
> There should be no dangling things at all.
> Probably not a very good example, but this would be analogous to
> pinning a map which is shared by many bpf progs. Deleting one or all
> the bpf progs doesnt delete the contents of the bpf map, you have to
> explicitly remove it. Deleting the pipeline will be equivalent to
> deleting the map. IOW, resource cleanup is tied to the pipeline..

bpf is also used by many subsystems (e.g. tracing/cgroup/...). The bpf users 
have a common expectation on how bpf resources will be cleaned up when writing 
bpf for different subsystems, i.e. map/link/pinned-file. Thus, p4 pipeline is 
not the same as a pinned bpf map here. The p4-tc bpf user cannot depend on the 
common bpf ecosystem to cleanup all resources.

It is going back to how link/fd and the map ops discussion by others in the 
earlier revisions which we probably don't want to redo here. I think I have been 
making enough noise such that we don't have to discuss potential future changes 
about how to release this resources when the bpf prog is unloaded.

