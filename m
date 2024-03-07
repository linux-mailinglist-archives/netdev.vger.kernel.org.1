Return-Path: <netdev+bounces-78530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE78875938
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF99C286978
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6A13B787;
	Thu,  7 Mar 2024 21:29:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA813A279
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846952; cv=none; b=CvfA2MN1eXFLfJoJ5Fex1l0fPfVaLo4jTTfyDTSpe+mKdXnaO7f8et5CUni71sjF7hYHS3trbi7npv5iBX722jbFmlLZFnUwbg0b+X4k3QVTewQj9YwV7ErlB1pzLGN+DOZwSIIuLW34eIFhyPo/wYGcmm7pEp7eXmdYrxLSTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846952; c=relaxed/simple;
	bh=i5kHnbuo6hiZ2RUeN2Na2YJbTTr7vTSk6iC1AGaDLDY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DEALmGn2p77DojYx1bIuT1wG+M8dwFEzpA5NiPMyD0uDnV6Vu5pWEnT25xh/bPo4DFTrb5NBbKgwC3gEki2NVpSODmNMvOtDHVDJvyfnuOHgb+m2MvRG8jjWYXBREp9T7LUwir1UxoAIxxhM45MPfAaGVcYjsXdrM7PhOdQta78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B14CCE0002;
	Thu,  7 Mar 2024 21:29:05 +0000 (UTC)
Message-ID: <5f522987-994b-4a46-a489-cde796a4a960@ovn.org>
Date: Thu, 7 Mar 2024 22:29:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, cmi@nvidia.com, yotam.gi@gmail.com,
 aconole@redhat.com, echaudro@redhat.com, horms@kernel.org,
 Dumitru Ceara <dceara@redhat.com>
Subject: Re: [RFC PATCH 0/4] net: openvswitch: Add sample multicasting.
Content-Language: en-US
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org
References: <20240307151849.394962-1-amorenoz@redhat.com>
 <4dcf82da-c6ad-47c1-8308-3f87820aeb1b@ovn.org>
 <6d4da824-a33f-42ae-88ef-be094f563684@redhat.com>
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <6d4da824-a33f-42ae-88ef-be094f563684@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 3/7/24 21:59, Adrian Moreno wrote:
> 
> 
> On 3/7/24 17:54, Ilya Maximets wrote:
>> On 3/7/24 16:18, Adrian Moreno wrote:
>>> ** Background **
>>> Currently, OVS supports several packet sampling mechanisms (sFlow,
>>> per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
>>> userspace action that needs to be handled by ovs-vswitchd's handler
>>> threads only to be forwarded to some third party application that
>>> will somehow process the sample and provide observability on the
>>> datapath.
>>>
>>> The fact that sampled traffic share netlink sockets and handler thread
>>> time with upcalls, apart from being a performance bottleneck in the
>>> sample extraction itself, can severely compromise the datapath,
>>> yielding this solution unfit for highly loaded production systems.
>>>
>>> Users are left with little options other than guessing what sampling
>>> rate will be OK for their traffic pattern and system load and dealing
>>> with the lost accuracy.
>>>
>>> ** Proposal **
>>> In this RFC, I'd like to request feedback on an attempt to fix this
>>> situation by adding a flag to the userspace action to indicate the
>>> upcall should be sent to a netlink multicast group instead of unicasted
>>> to ovs-vswitchd.
>>>
>>> This would allow for other processes to read samples directly, freeing
>>> the netlink sockets and handler threads to process packet upcalls.
>>>
>>> ** Notes on tc-offloading **
>>> I am aware of the efforts being made to offload the sample action with
>>> the help of psample.
>>> I did consider using psample to multicast the samples. However, I
>>> found a limitation that I'd like to discuss:
>>> I would like to support OVN-driven per-flow (IPFIX) sampling because
>>> it allows OVN to insert two 32-bit values (obs_domain_id and
>>> ovs_point_id) that can be used to enrich the sample with "high level"
>>> controller metadata (see debug_drop_domain_id NBDB option in ovn-nb(5)).
>>>
>>> The existing fields in psample_metadata are not enough to carry this
>>> information. Would it be possible to extend this struct to make room for
>>> some extra "application-specific" metadata?
>>>
>>> ** Alternatives **
>>> An alternative approach that I'm considering (apart from using psample
>>> as explained above) is to use a brand-new action. This lead to a cleaner
>>> separation of concerns with existing userspace action (used for slow
>>> paths and OFP_CONTROLLER actions) and cleaner statistics.
>>> Also, ovs-vswitchd could more easily make the layout of this
>>> new userdata part of the public API, allowing third party sample
>>> collectors to decode it.
>>>
>>> I am currently exploring this alternative but wanted to send the RFC to
>>> get some early feedback, guidance or ideas.
>>
>>
>> Hi, Adrian.  Thanks for the patches!
>>
> 
> Thanks for the quick feedback.
> Also adding Dumitru who I missed to include in the original CC list.
> 
>> Though I'm not sure if broadcasting is generally the best approach.
>> These messages contain opaque information that is not actually
>> parsable by any other entity than a process that created the action.
>> And I don't think the structure of these opaque fields should become
>> part of uAPI in neither kernel nor OVS in userspace.
>>
> 
> I understand this can be cumbersome, specially given the opaque field is 
> currently also used for some purely-internal OVS actions (e.g: CONTROLLER).
> 
> However, for features such as OVN-driven per-flow sampling, where OVN-generated 
> identifiers are placed in obs_domain_id and obs_point_id, it would be _really_ 
> useful if this opaque value could be somehow decoded by external programs.
> 
> Two ideas come to mind to try to alleviate the potential maintainability issues:
> - As I suggested, using a new action maybe makes things easier. By splitting the 
> current "user_action_cookie" in two, one for internal actions and one for 
> "observability" actions, we could expose the latter in the OVS userspace API 
> without having to expose the former.
> - Exposing functions in OVS that decode the opaque value. Third party 
> applications could link against, say, libopenvswitch.so and use it to extract 
> obs_{domain,point}_ids.

Linking with OVS libraries is practically the same as just exposing
the internal structure, because once the external application is
running it either must have the same library version as the process
that installs the action, or it may not be able to parse the message.

Any form of exposing to an external application will freeze the
opaque arguments and effectively make them a form of uAPI.

The separate action with a defined uAPI solves this problem by just
creating a new uAPI, but I'm not sure why it is needed.

> 
> What do you think?
> 
>> The userspace() action already has a OVS_USERSPACE_ATTR_PID argument.
>> And it is not actually used when OVS_DP_F_DISPATCH_UPCALL_PER_CPU is
>> enabled.  All known users of OVS_DP_F_DISPATCH_UPCALL_PER_CPU are
>> setting the OVS_USERSPACE_ATTR_PID to UINT32_MAX, which is not a pid
>> that kernel could generate.
>>
>> So, with a minimal and pretty much backward compatible change in
>> output_userspace() function, we can honor OVS_USERSPACE_ATTR_PID if
>> it's not U32_MAX.  This way userspace process can open a separate
>> socket and configure sampling to redirect all packets there while
>> normal MISS upcalls would still arrive to per-cpu sockets.  This
>> should cover the performance concern.
>>
> 
> Do you mean creating a new thread to process samples or using handlers?
> The latter would still have performance impact and the former would likely fail 
> to process all samples in a timely manner if there are many.
> 
> Besides, the current userspace tc-offloading series uses netlink broadcast with 
> psample, can't we do the same for non-offloaded actions? It enable building 
> external observability applications without overloading OVS.

Creating a separate thread solves the performance issue.  But you can
also write a separate application that would communicate its PID to the
running OVS daemon.  Let's say the same application that configures
sampling in the OVS database can also write a PID there.

The thing is that existence of external application immediately breaks
opacity of the arguments and forces us to define uAPI.  However, if
there is an explicit communication between that application and OVS
userpsace daemon, then we can establish a contract (structure of opaque
values) between these two userspace applications without defining that
contract in the kernel uAPI.  But if we're going with multicast, that
anyone can subscribe to, then we have to define that contract in the
kernel uAPI.

Also, in order for this observability to work with userspace datapath
we'll have to implement userspace-to-userspace netlink multicast (does
that even exist?).  Running the sample collection within OVS as a thread
will be much less painful.

One other thing worth mentioning is that the PID approach I suggested
is just a minor tweak of what is already supported in the kernel.  It
doesn't prohibit introduction of a new action or a multicast group in
the future.  While premature uAPI definition may end up with another
action that nobody uses.  It can be added later if end up being
actually necessary.

Best regards, Ilya Maximets.

> 
> 
>> For the case without per-cpu dispatch, the feature comes for free
>> if userspace application wants to use it.  However, there is no
>> currently supported version of OVS that doesn't use per-cpu dispatch
>> when available.
>>  > What do you think?
>>  > Best regards, Ilya Maximets.
>>
> 


