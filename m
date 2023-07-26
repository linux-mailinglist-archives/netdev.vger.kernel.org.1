Return-Path: <netdev+bounces-21251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897B762FE9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87F5281CE4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A168838;
	Wed, 26 Jul 2023 08:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1C253BC
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:33:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4249149D0
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690360377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBJ3EzvHylztOHpn8y+uIZAdi+4kyRQsnGPpUIan6vM=;
	b=OvcrJ1f0ysy8YQkNUyEiY1+yoHHQcWHWiCO/Xij+r0565GU9mS9Z/kGA7W0nbr3/kaUJCN
	GuGjyFmwY7Z3chkVKUicqwq5TTO+LjETIp9zKUDZL3N3BM6hz87HkXfYbJkwve7EHAkz8w
	JlsLQhxJ4oiQ0VOZFSb2cPKODL0CljA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-ms6hlXJ6NEmb5AkvBepF2w-1; Wed, 26 Jul 2023 04:32:56 -0400
X-MC-Unique: ms6hlXJ6NEmb5AkvBepF2w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so38404385e9.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360375; x=1690965175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBJ3EzvHylztOHpn8y+uIZAdi+4kyRQsnGPpUIan6vM=;
        b=KiiWfzbue99Zz0qy+Jdm1IbwiFeSIDvwAMh+UAjMpemuYBbPPwAo2kMhL63MQO8IxA
         3jK7FIzJKC3WObsFiVw90EEKhZrlo2YTO1+3H3wGEyRCEYLVK9LeUMMo883T41ywsU4O
         Adr8NNRJB/3/xMI6jh5vcKtFyGdwDs/PICUg3uJN6iQ9nZHU4L/6jXses0du49IpnI1O
         4J59VcLKgTNpcyTkTFpUbKWSCFDSVOWtK2bq/I8A23xuztxSc7g0rOdmFsEkvTpIcok6
         C7lod5hReHVCqeCr2omGv+MB6nRVUdSOTrfsIWFNNMvd4xQReV0y8BqZdDTo5nbc7gaM
         Rcjg==
X-Gm-Message-State: ABy/qLb4SR4R2HPKfSYNje3j8MrmgecTCjxdn/H04Y6WbwNUZ2CwHotK
	zgh5fYaBzWP8xC1K0hx8HATIehFgrfdLIcKWFFCLJ8vC35XUQWmho87/TxZB0WlOBbtFZvuhFwB
	Bfa1PZ92EB/HZ2Xx4
X-Received: by 2002:a7b:cbd0:0:b0:3fb:e254:b81e with SMTP id n16-20020a7bcbd0000000b003fbe254b81emr789941wmi.12.1690360374746;
        Wed, 26 Jul 2023 01:32:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGsYYmg/F039z1gtHLxXKVOYMzm4LW2nzaX6DhyNubdSqyIyhkWkcMDZiG1l0ikaDXt7K+bcQ==
X-Received: by 2002:a7b:cbd0:0:b0:3fb:e254:b81e with SMTP id n16-20020a7bcbd0000000b003fbe254b81emr789924wmi.12.1690360374342;
        Wed, 26 Jul 2023 01:32:54 -0700 (PDT)
Received: from [192.168.1.21] (217.pool92-172-46.dynamic.orange.es. [92.172.46.217])
        by smtp.gmail.com with ESMTPSA id t1-20020a7bc3c1000000b003f9bd9e3226sm1363590wmj.7.2023.07.26.01.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:32:53 -0700 (PDT)
Message-ID: <1eafeb9e-0016-91b5-5df3-c74d256b4b8b@redhat.com>
Date: Wed, 26 Jul 2023 10:32:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 4/7] net: openvswitch: add misc error drop
 reasons
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, i.maximets@ovn.org,
 eric@garver.life
References: <20230722094238.2520044-1-amorenoz@redhat.com>
 <20230722094238.2520044-5-amorenoz@redhat.com> <f7t4jltl4e9.fsf@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <f7t4jltl4e9.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/24/23 17:23, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
> 
>> Use drop reasons from include/net/dropreason-core.h when a reasonable
>> candidate exists.
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   net/openvswitch/actions.c   | 17 ++++++++++-------
>>   net/openvswitch/conntrack.c |  3 ++-
>>   net/openvswitch/drop.h      |  6 ++++++
>>   3 files changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
>> index 9279bb186e9f..42fa1e7eb912 100644
>> --- a/net/openvswitch/actions.c
>> +++ b/net/openvswitch/actions.c
> 
> Did you consider putting in a drop reason when one of the actions fails
> setting err?  For example, if dec_ttl fails with some error other than
> EHOSTUNREACH, it will drop into the kfree_skb() case... maybe we should
> have an action_failed drop reason that can be passed there.
> 

Another good idea! Thanks Aaron.


>> @@ -782,7 +782,7 @@ static int ovs_vport_output(struct net *net, struct sock *sk,
>>   	struct vport *vport = data->vport;
>>   
>>   	if (skb_cow_head(skb, data->l2_len) < 0) {
>> -		kfree_skb(skb);
>> +		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
>>   		return -ENOMEM;
>>   	}
>>   
>> @@ -853,6 +853,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
>>   			 struct sk_buff *skb, u16 mru,
>>   			 struct sw_flow_key *key)
>>   {
>> +	enum ovs_drop_reason reason;
>>   	u16 orig_network_offset = 0;
>>   
>>   	if (eth_p_mpls(skb->protocol)) {
>> @@ -862,6 +863,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
>>   
>>   	if (skb_network_offset(skb) > MAX_L2_LEN) {
>>   		OVS_NLERR(1, "L2 header too long to fragment");
>> +		reason = OVS_DROP_FRAG_L2_TOO_LONG;
>>   		goto err;
>>   	}
>>   
>> @@ -902,12 +904,13 @@ static void ovs_fragment(struct net *net, struct vport *vport,
>>   		WARN_ONCE(1, "Failed fragment ->%s: eth=%04x, MRU=%d, MTU=%d.",
>>   			  ovs_vport_name(vport), ntohs(key->eth.type), mru,
>>   			  vport->dev->mtu);
>> +		reason = OVS_DROP_FRAG_INVALID_PROTO;
>>   		goto err;
>>   	}
>>   
>>   	return;
>>   err:
>> -	kfree_skb(skb);
>> +	kfree_skb_reason(skb, reason);
>>   }
>>   
>>   static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
>> @@ -934,10 +937,10 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
>>   
>>   			ovs_fragment(net, vport, skb, mru, key);
>>   		} else {
>> -			kfree_skb(skb);
>> +			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
>>   		}
>>   	} else {
>> -		kfree_skb(skb);
>> +		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
>>   	}
>>   }
>>   
>> @@ -1011,7 +1014,7 @@ static int dec_ttl_exception_handler(struct datapath *dp, struct sk_buff *skb,
>>   		return clone_execute(dp, skb, key, 0, nla_data(actions),
>>   				     nla_len(actions), true, false);
>>   
>> -	consume_skb(skb);
>> +	kfree_skb_reason(skb, OVS_DROP_IP_TTL);
>>   	return 0;
>>   }
>>   
>> @@ -1564,7 +1567,7 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
>>   		/* Out of per CPU action FIFO space. Drop the 'skb' and
>>   		 * log an error.
>>   		 */
>> -		kfree_skb(skb);
>> +		kfree_skb_reason(skb, OVS_DROP_DEFERRED_LIMIT);
>>   
>>   		if (net_ratelimit()) {
>>   			if (actions) { /* Sample action */
>> @@ -1616,7 +1619,7 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>   	if (unlikely(level > OVS_RECURSION_LIMIT)) {
>>   		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
>>   				     ovs_dp_name(dp));
>> -		kfree_skb(skb);
>> +		kfree_skb_reason(skb, OVS_DROP_RECURSION_LIMIT);
>>   		err = -ENETDOWN;
>>   		goto out;
>>   	}
>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>> index fa955e892210..b03ebd4a8fae 100644
>> --- a/net/openvswitch/conntrack.c
>> +++ b/net/openvswitch/conntrack.c
>> @@ -29,6 +29,7 @@
>>   #include <net/netfilter/nf_conntrack_act_ct.h>
>>   
>>   #include "datapath.h"
>> +#include "drop.h"
>>   #include "conntrack.h"
>>   #include "flow.h"
>>   #include "flow_netlink.h"
>> @@ -1035,7 +1036,7 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
>>   
>>   	skb_push_rcsum(skb, nh_ofs);
>>   	if (err)
>> -		kfree_skb(skb);
>> +		kfree_skb_reason(skb, OVS_DROP_CONNTRACK);
>>   	return err;
>>   }
>>   
>> diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
>> index 2440c836727f..744b8d1b93a3 100644
>> --- a/net/openvswitch/drop.h
>> +++ b/net/openvswitch/drop.h
>> @@ -12,6 +12,12 @@
>>   	R(OVS_DROP_EXPLICIT_ACTION)		\
>>   	R(OVS_DROP_EXPLICIT_ACTION_ERROR)	\
>>   	R(OVS_DROP_METER)			\
>> +	R(OVS_DROP_RECURSION_LIMIT)		\
>> +	R(OVS_DROP_DEFERRED_LIMIT)		\
>> +	R(OVS_DROP_FRAG_L2_TOO_LONG)		\
>> +	R(OVS_DROP_FRAG_INVALID_PROTO)		\
>> +	R(OVS_DROP_CONNTRACK)			\
>> +	R(OVS_DROP_IP_TTL)			\
>>   	/* deliberate comment for trailing \ */
>>   
>>   enum ovs_drop_reason {
> 


