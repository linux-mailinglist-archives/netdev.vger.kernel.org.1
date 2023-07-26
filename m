Return-Path: <netdev+bounces-21249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CFD762FE4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C972819CB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC86D19;
	Wed, 26 Jul 2023 08:31:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C308AD37
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:31:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348F1738
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690360291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wp9+I8NC0xj7y0BfVIvHQSAcG3btMKJs7PfoyYy0J0=;
	b=OPAqGlw5J6NDRtICIjNEukNKkq6lFtGKZxu4U8W3NNWSeYvZcmmIB7cyiDqaWHNW4eIB58
	F31AxbqsA/QgltH4x2b90b7mocunWJFmgLGVQGnadc1fPLlTk/+xUImHAaMusl2U8QfIUL
	RBYLSdJ0V68GmYTf5l28a1VgV7ecLyM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-krc0Cv7_NuG_FxWzahF_BA-1; Wed, 26 Jul 2023 04:31:30 -0400
X-MC-Unique: krc0Cv7_NuG_FxWzahF_BA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbcae05906so38613115e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360289; x=1690965089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wp9+I8NC0xj7y0BfVIvHQSAcG3btMKJs7PfoyYy0J0=;
        b=NdGasoE25vyoTqlYgq32FFvPOvTwLYFyzB9zA4UzLTSSw9THNxt+b7HX4TajMvlWz7
         NyNm1OjuR1Jbv4x+oClwkTMLUCGboMuLpW8gXcNINgq0RB7B4DbzQeOfhQCYkHUfO/hD
         HVg6rqnbfZ11pQ+BYhwectLDzYVL3XynJOdufRhE1DuecoTPp9J603B0KrqGsijT405x
         DeNpr2S4YOEcbl6zbioeC4Jr+causqNXedHqWCL9bypr8B8w+cGEjhaGllWVRoO/S0Z2
         ydVYlbbChaNa6kx+nKE/6k20U1uobmYJj9f8vDxmxkOp1cFlOppoxkDyHbIhS+fMan1P
         cazQ==
X-Gm-Message-State: ABy/qLY4gsaM1nWQoD+h/EzEgsOftY+omtteQrU2qvT3LYn/hC9gxj1B
	eQrZPvCaBVAJMmBjMYkJsmODGAVJ3uLJVNSaac70vPtsuWKR3/7OkrPRbDV5+nMQKa1e47qliDI
	kcyfIPHuMw7Q5XC+6
X-Received: by 2002:a05:600c:450:b0:3fd:2d35:b96a with SMTP id s16-20020a05600c045000b003fd2d35b96amr864589wmb.39.1690360289193;
        Wed, 26 Jul 2023 01:31:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxWvK2iagMSpJsqe6ktfajE3a+GUfY32c8Y96d6FVB0l/ZrRRS7UBIrGdPi1V2X2l2hI1f+g==
X-Received: by 2002:a05:600c:450:b0:3fd:2d35:b96a with SMTP id s16-20020a05600c045000b003fd2d35b96amr864574wmb.39.1690360288830;
        Wed, 26 Jul 2023 01:31:28 -0700 (PDT)
Received: from [192.168.1.21] (217.pool92-172-46.dynamic.orange.es. [92.172.46.217])
        by smtp.gmail.com with ESMTPSA id k17-20020a7bc311000000b003fc02218d6csm1326163wmj.25.2023.07.26.01.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:31:28 -0700 (PDT)
Message-ID: <6a3f00e7-def7-cef0-6a0a-200480d5a486@redhat.com>
Date: Wed, 26 Jul 2023 10:31:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 2/7] net: openvswitch: add explicit drop action
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, Eric Garver <eric@garver.life>,
 dev@openvswitch.org, i.maximets@ovn.org
References: <20230722094238.2520044-1-amorenoz@redhat.com>
 <20230722094238.2520044-3-amorenoz@redhat.com> <f7tcz0hl62h.fsf@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <f7tcz0hl62h.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/24/23 16:47, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
> 
>> From: Eric Garver <eric@garver.life>
>>
>> This adds an explicit drop action. This is used by OVS to drop packets
>> for which it cannot determine what to do. An explicit action in the
>> kernel allows passing the reason _why_ the packet is being dropped or
>> zero to indicate no particular error happened (i.e: OVS intentionally
>> dropped the packet).
>>
>> Since the error codes coming from userspace mean nothing for the kernel,
>> we squash all of them into only two drop reasons:
>> - OVS_DROP_EXPLICIT_ACTION_ERROR to indicate a non-zero value was passed
>> - OVS_DROP_EXPLICIT_ACTION to indicate a zero value was passed (no
>>    error)
>>
>> e.g. trace all OVS dropped skbs
>>
>>   # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
>>   [..]
>>   106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
>>    location:0xffffffffc0d9b462, protocol: 2048, reason: 196610)
>>
>> reason: 196610 --> 0x30002 (OVS_DROP_EXPLICIT_ACTION)
>>
>> Signed-off-by: Eric Garver <eric@garver.life>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   include/uapi/linux/openvswitch.h                     | 2 ++
>>   net/openvswitch/actions.c                            | 9 +++++++++
>>   net/openvswitch/drop.h                               | 2 ++
>>   net/openvswitch/flow_netlink.c                       | 8 +++++++-
>>   tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 3 +++
>>   5 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>> index e94870e77ee9..efc82c318fa2 100644
>> --- a/include/uapi/linux/openvswitch.h
>> +++ b/include/uapi/linux/openvswitch.h
>> @@ -965,6 +965,7 @@ struct check_pkt_len_arg {
>>    * start of the packet or at the start of the l3 header depending on the value
>>    * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
>>    * argument.
>> + * @OVS_ACTION_ATTR_DROP: Explicit drop action.
>>    *
>>    * Only a single header can be set with a single %OVS_ACTION_ATTR_SET.  Not all
>>    * fields within a header are modifiable, e.g. the IPv4 protocol and fragment
>> @@ -1002,6 +1003,7 @@ enum ovs_action_attr {
>>   	OVS_ACTION_ATTR_CHECK_PKT_LEN, /* Nested OVS_CHECK_PKT_LEN_ATTR_*. */
>>   	OVS_ACTION_ATTR_ADD_MPLS,     /* struct ovs_action_add_mpls. */
>>   	OVS_ACTION_ATTR_DEC_TTL,      /* Nested OVS_DEC_TTL_ATTR_*. */
>> +	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
>>   
>>   	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>>   				       * from userspace. */
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index af676dcac2b4..194379d58b62 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
>> @@ -1485,6 +1485,15 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>   				return dec_ttl_exception_handler(dp, skb,
>>   								 key, a);
>>   			break;
>> +
>> +		case OVS_ACTION_ATTR_DROP: {
>> +			enum ovs_drop_reason reason = nla_get_u32(a)
>> +				? OVS_DROP_EXPLICIT_ACTION_ERROR
>> +				: OVS_DROP_EXPLICIT_ACTION;
>> +
>> +			kfree_skb_reason(skb, reason);
>> +			return 0;
>> +		}
>>   		}
>>   
>>   		if (unlikely(err)) {
>> diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
>> index cdd10629c6be..f9e9c1610f6b 100644
>> --- a/net/openvswitch/drop.h
>> +++ b/net/openvswitch/drop.h
>> @@ -9,6 +9,8 @@
>>   
>>   #define OVS_DROP_REASONS(R)			\
>>   	R(OVS_DROP_FLOW)		        \
>> +	R(OVS_DROP_EXPLICIT_ACTION)		\
>> +	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\
>>   	/* deliberate comment for trailing \ */
>>   
>>   enum ovs_drop_reason {
>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
>> index 41116361433d..244280922a14 100644
>> --- a/net/openvswitch/flow_netlink.c
>> +++ b/net/openvswitch/flow_netlink.c
>> @@ -38,6 +38,7 @@
>>   #include <net/tun_proto.h>
>>   #include <net/erspan.h>
>>   
>> +#include "drop.h"
>>   #include "flow_netlink.h"
>>   
>>   struct ovs_len_tbl {
>> @@ -61,6 +62,7 @@ static bool actions_may_change_flow(const struct nlattr *actions)
>>   		case OVS_ACTION_ATTR_RECIRC:
>>   		case OVS_ACTION_ATTR_TRUNC:
>>   		case OVS_ACTION_ATTR_USERSPACE:
>> +		case OVS_ACTION_ATTR_DROP:
>>   			break;
>>   
>>   		case OVS_ACTION_ATTR_CT:
>> @@ -2394,7 +2396,7 @@ static void ovs_nla_free_nested_actions(const struct nlattr *actions, int len)
>>   	/* Whenever new actions are added, the need to update this
>>   	 * function should be considered.
>>   	 */
>> -	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 23);
>> +	BUILD_BUG_ON(OVS_ACTION_ATTR_MAX != 24);
>>   
>>   	if (!actions)
>>   		return;
>> @@ -3182,6 +3184,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>   			[OVS_ACTION_ATTR_CHECK_PKT_LEN] = (u32)-1,
>>   			[OVS_ACTION_ATTR_ADD_MPLS] = sizeof(struct ovs_action_add_mpls),
>>   			[OVS_ACTION_ATTR_DEC_TTL] = (u32)-1,
>> +			[OVS_ACTION_ATTR_DROP] = sizeof(u32),
>>   		};
>>   		const struct ovs_action_push_vlan *vlan;
>>   		int type = nla_type(a);
>> @@ -3453,6 +3456,9 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>   			skip_copy = true;
>>   			break;
>>   
>> +		case OVS_ACTION_ATTR_DROP:
>> +			break;
>> +
> 
> We may want to have an explicit check in this area to warn about an
> action list like:
> 
>    output:1,drop(something),output:2
> 
> I see the action handling code will correctly return when we encounter
> drop action, so it should stop the current skb context from being
> accessed further.  But it may also be good to prevent extra actions from
> being attempted in the first place.
> 

Sounds like a good idea! Thanks. I'll add it in the next version.

>>   		default:
>>   			OVS_NLERR(log, "Unknown Action type %d", type);
>>   			return -EINVAL;
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index 12ba5265b88f..61c4d7b75261 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> @@ -280,6 +280,7 @@ class ovsactions(nla):
>>           ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
>>           ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
>>           ("OVS_ACTION_ATTR_DEC_TTL", "none"),
>> +        ("OVS_ACTION_ATTR_DROP", "uint32"),
>>       )
>>   
>>       class ctact(nla):
>> @@ -426,6 +427,8 @@ class ovsactions(nla):
>>                       print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
>>                   elif field[0] == "OVS_ACTION_ATTR_TRUNC":
>>                       print_str += "trunc(%d)" % int(self.get_attr(field[0]))
>> +                elif field[0] == "OVS_ACTION_ATTR_DROP":
>> +                    print_str += "drop"
>>               elif field[1] == "flag":
>>                   if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
>>                       print_str += "ct_clear"
> 

-- 
Adrián Moreno


