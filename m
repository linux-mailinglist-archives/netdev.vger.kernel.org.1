Return-Path: <netdev+bounces-25697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F25775320
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831CF281A7F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A0812;
	Wed,  9 Aug 2023 06:49:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D77F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:49:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E5B133
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691563748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+spbz4J3bhwqjRYn2F5Qr2QV08EAPSQFUKiPOH/5Tfc=;
	b=Zh9izBwKOoCmvgEVNulUqdU/MwFXDIUUPjvb4rvEC04in6Skx7J7Uvg5umN94J6IJu831E
	cjJ7f3HbU7vX1/GFLOeXRhETuiOpPw/Q4MCCDdxXeyZlolLBdcsChNW2rQmk89k/y0sZBG
	3CPx96lnDo6FnDJdD5o6nnHxb8ChAYk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-QCLynJbVNSmzPZkkGW4HIg-1; Wed, 09 Aug 2023 02:49:06 -0400
X-MC-Unique: QCLynJbVNSmzPZkkGW4HIg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31800070d70so587028f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 23:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563746; x=1692168546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+spbz4J3bhwqjRYn2F5Qr2QV08EAPSQFUKiPOH/5Tfc=;
        b=Cc9VhP6SuJWZNTdVPpUEH12IaKWFEfhXcGe1mMcUYxhSIgclr6Tx7L2wSottArZxbH
         vqj0mB0XQdps8obhFmx5lnJf5APlBSvOiArYnBX4KZWZ7fK5hLbZf8iJGFknvBLQQMCy
         6acniLL2off+ILVdWjwgfx9YxArvxv9m8MwxJK1PgSTIqSecb0HOv3z7wxdY9+d9+XsZ
         cxakgaQIRKOCWeSoJTBcRK4dP7G1TGwYVQX/Lwk6mhF2F72oMFcBK6jsOLkizAK1lxiF
         +IrYhXPcqCHUPMfxiSuuYHnLZVIECO0PfYh/UIltvqfJJfDZC2TPYagT+AND7Q1mDu5p
         0Xyg==
X-Gm-Message-State: AOJu0Yy0nybGNPp0Nk79xxCpiYAepYRI8qem0ZJXENxemAA0y6gI67mB
	EJWqXiW4yEqvqzWH6wHeZp6Ss/VoNZznoLERrBArl0SX3w25Q+ANpF8e0L47PKqsW3xysUXvcNH
	dD2Dkl2kvN1PMBrcK
X-Received: by 2002:a5d:45d1:0:b0:317:f4c2:a99c with SMTP id b17-20020a5d45d1000000b00317f4c2a99cmr1266687wrs.32.1691563745829;
        Tue, 08 Aug 2023 23:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmejo40EvSxfottPFeEPkCozfVkJLfC6fsEqAC3NfJLV8iPub/Upwp8MsNxiU80t+q6gpjsw==
X-Received: by 2002:a5d:45d1:0:b0:317:f4c2:a99c with SMTP id b17-20020a5d45d1000000b00317f4c2a99cmr1266674wrs.32.1691563745444;
        Tue, 08 Aug 2023 23:49:05 -0700 (PDT)
Received: from [192.168.1.131] ([139.47.21.132])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b00317f3fd21b7sm5569263wrs.80.2023.08.08.23.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 23:49:04 -0700 (PDT)
Message-ID: <cd7a3188-e477-aaa0-5c71-04efcac9c927@redhat.com>
Date: Wed, 9 Aug 2023 08:49:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next v3 3/7] net: openvswitch: add explicit drop action
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, Eric Garver <eric@garver.life>,
 i.maximets@ovn.org, dev@openvswitch.org
References: <20230807164551.553365-1-amorenoz@redhat.com>
 <20230807164551.553365-4-amorenoz@redhat.com> <f7tbkfh4mcr.fsf@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <f7tbkfh4mcr.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/8/23 16:53, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
> 
>> From: Eric Garver <eric@garver.life>
>>
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
>>    location:0xffffffffc0d9b462, protocol: 2048, reason: 196611)
>>
>> reason: 196611 --> 0x30003 (OVS_DROP_EXPLICIT_ACTION)
>>
>> Signed-off-by: Eric Garver <eric@garver.life>
>> Co-developed-by: Adrian Moreno <amorenoz@redhat.com>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   include/uapi/linux/openvswitch.h                     |  2 ++
>>   net/openvswitch/actions.c                            |  9 +++++++++
>>   net/openvswitch/drop.h                               |  2 ++
>>   net/openvswitch/flow_netlink.c                       | 10 +++++++++-
>>   tools/testing/selftests/net/openvswitch/ovs-dpctl.py |  3 +++
>>   5 files changed, 25 insertions(+), 1 deletion(-)
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
>> index 9b66a3334aaa..285b1243b94f 100644
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
>> index 3cd6489a5a2b..be51ff5039fb 100644
>> --- a/net/openvswitch/drop.h
>> +++ b/net/openvswitch/drop.h
>> @@ -10,6 +10,8 @@
>>   #define OVS_DROP_REASONS(R)			\
>>   	R(OVS_DROP_FLOW)		        \
>>   	R(OVS_DROP_ACTION_ERROR)		\
>> +	R(OVS_DROP_EXPLICIT_ACTION)		\
>> +	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\
>>   	/* deliberate comment for trailing \ */
>>   
>>   enum ovs_drop_reason {
>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
>> index 41116361433d..88965e2068ac 100644
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
>> @@ -3453,6 +3456,11 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>>   			skip_copy = true;
>>   			break;
>>   
>> +		case OVS_ACTION_ATTR_DROP:
>> +			if (!nla_is_last(a, rem))
>> +				return -EINVAL;
>> +			break;
>> +
>>   		default:
>>   			OVS_NLERR(log, "Unknown Action type %d", type);
>>   			return -EINVAL;
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index fbdac15e3134..5fee330050c2 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> @@ -301,6 +301,7 @@ class ovsactions(nla):
>>           ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
>>           ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
>>           ("OVS_ACTION_ATTR_DEC_TTL", "none"),
>> +        ("OVS_ACTION_ATTR_DROP", "uint32"),
>>       )
>>   
>>       class ctact(nla):
>> @@ -447,6 +448,8 @@ class ovsactions(nla):
>>                       print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
>>                   elif field[0] == "OVS_ACTION_ATTR_TRUNC":
>>                       print_str += "trunc(%d)" % int(self.get_attr(field[0]))
>> +                elif field[0] == "OVS_ACTION_ATTR_DROP":
>> +                    print_str += "drop"
> 
> Any reason that you don't include the int(self.get_attr(field[0])) here
> and add it only to 7/7?
> 

This was included in Eric's original patch so I kept it and enhanced it later. 
But you're right it doesn't really make any sense. I'll move the chunk from 
patch 7 to this one.

>>               elif field[1] == "flag":
>>                   if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
>>                       print_str += "ct_clear"
> 

Thanks.
-- 
Adrián Moreno


