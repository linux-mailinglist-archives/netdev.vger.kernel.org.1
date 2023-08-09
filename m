Return-Path: <netdev+bounces-25703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E6775367
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C31C2111A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36CBECD;
	Wed,  9 Aug 2023 07:02:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396D7F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:02:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522CA1FEA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691564537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P79pgGJ6Bkw1izAajc3n2b3sSEFN4cdJbb6tS7lt5eI=;
	b=VrgdLF//hIbsEeb/CqSbVCwaYcDaoOXZxNOSsMPNJI0AN2apbpofUnW9Y5UQdLBEXz2Kii
	pNqVuNIYKS5DwrONt0/XF62F6QeJKCdayvItysQ3NcBWEc9d/TkfS1zOmnNSXhpKUfJnXm
	4yEJzZpUZ5Xwr9D9TL+7lfmgKlkLJ8g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-SQA4zo64OA6qtVyFstgfpg-1; Wed, 09 Aug 2023 03:02:16 -0400
X-MC-Unique: SQA4zo64OA6qtVyFstgfpg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe4f953070so23001505e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 00:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691564535; x=1692169335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P79pgGJ6Bkw1izAajc3n2b3sSEFN4cdJbb6tS7lt5eI=;
        b=J6T1U+JdZ9GvfvR9L5TeWI/o9/OrDaDtf9A1U/AAXQ677c5Cu9e3t18MS7vkUFbkx6
         NhupYfkncaFiD0Zvi90KzxZV2UDcVbEylNezcNuwouvlc8RllEiY+CDMg3Bl0rOhwQ4c
         pKOpIy7jpV7XabPNJDyiz9VnGcMtt8A9VT6BT6N94H5XB8pjdaweDKVkQndDf5xedh4u
         6fGqC7/DlaTyfR3s3wtt7fAa0FissKb+N0lQwapVH8pPFGqUjbT4IOr7FL9EOK5qwaYP
         HBqgbMJZU9mK77l3TUj3VROYiVV6gGMe6NHcnO3vrumQ0amWvcHdTuzqqFcqvDsN1jJL
         ICcA==
X-Gm-Message-State: AOJu0YzbwxoLfmg2xdnVmKP85RNUmmrX1z3nSRox6fEYde4C/xEpLNwk
	Pr7RppcoskHjbcfFri1YwwDYa8dyXriuz3grp8hBfIwkq1uhVJMDs/oxZMdNDKZ6SCBG+dbx0ZN
	QJJVEjxZblNugGIQO
X-Received: by 2002:a7b:c44f:0:b0:3fd:1daf:abd8 with SMTP id l15-20020a7bc44f000000b003fd1dafabd8mr1339417wmi.40.1691564535010;
        Wed, 09 Aug 2023 00:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO9EqUExQdD90PrANbRTwysrRy8v82AMAjvK+qAXhp2ZG3Pm4t1bu6vd/4jkW4JQsPn1wVTw==
X-Received: by 2002:a7b:c44f:0:b0:3fd:1daf:abd8 with SMTP id l15-20020a7bc44f000000b003fd1dafabd8mr1339406wmi.40.1691564534667;
        Wed, 09 Aug 2023 00:02:14 -0700 (PDT)
Received: from [192.168.1.131] ([139.47.21.132])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c205700b003fbb618f7adsm991417wmg.15.2023.08.09.00.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:02:14 -0700 (PDT)
Message-ID: <9b6b05e7-ff29-b8cd-66e1-fb931778bee5@redhat.com>
Date: Wed, 9 Aug 2023 09:02:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next v3 7/7] selftests: openvswitch: add explicit drop
 testcase
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, i.maximets@ovn.org, eric@garver.life,
 dev@openvswitch.org
References: <20230807164551.553365-1-amorenoz@redhat.com>
 <20230807164551.553365-8-amorenoz@redhat.com> <f7t1qgd4lxk.fsf@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <f7t1qgd4lxk.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/8/23 17:02, Aaron Conole wrote:
> Adrian Moreno <amorenoz@redhat.com> writes:
> 
>> Make ovs-dpctl.py support explicit drops as:
>> "drop" -> implicit empty-action drop
>> "drop(0)" -> explicit non-error action drop
> 
> I also suggest a test in netlink_checks to make sure drop can't be
> followed by additional actions.  Something like:
> 
>    3,drop(0),2
> 
> which should generate a NL message that has the drop attribute with
> additional action data following it.

Ack, will do.

The check I've added in flow_netlink.c does not include any custom message. Just 
returning -EINVAL in __ovs_nla_copy_actions() ends up printing "Flow actions may 
not be safe on all matching packets" to dmesg. Maybe it's too generic or even 
misleading in some cases but I saw other action verifications do the same so I 
thought it might be kind of expected at this point.

Do you think a custom message (in addition to the generic one) is needed?

Thanks.
--
Adrián

> 
>> "drop(42)" -> explicit error action drop
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   .../selftests/net/openvswitch/openvswitch.sh  | 25 +++++++++++++++++++
>>   .../selftests/net/openvswitch/ovs-dpctl.py    | 21 ++++++++++++----
>>   2 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index a10c345f40ef..c568ba1b7900 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -217,6 +217,31 @@ test_drop_reason() {
>>   		return 1
>>   	fi
>>   
>> +	# Drop UDP 6000 traffic with an explicit action and an error code.
>> +	ovs_add_flow "test_drop_reason" dropreason \
>> +		"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=17),udp(dst=6000)" \
>> +                'drop(42)'
>> +	# Drop UDP 7000 traffic with an explicit action with no error code.
>> +	ovs_add_flow "test_drop_reason" dropreason \
>> +		"in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10,proto=17),udp(dst=7000)" \
>> +                'drop(0)'
>> +
>> +	ovs_drop_record_and_run \
>> +            "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
>> +	ovs_drop_reason_count 0x30004 # OVS_DROP_EXPLICIT_ACTION_ERROR
>> +	if [[ "$?" -ne "1" ]]; then
>> +		info "Did not detect expected explicit error drops: $?"
>> +		return 1
>> +	fi
>> +
>> +	ovs_drop_record_and_run \
>> +            "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
>> +	ovs_drop_reason_count 0x30003 # OVS_DROP_EXPLICIT_ACTION
>> +	if [[ "$?" -ne "1" ]]; then
>> +		info "Did not detect expected explicit drops: $?"
>> +		return 1
>> +	fi
>> +
>>   	return 0
>>   }
>>   
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index 5fee330050c2..912dc8c49085 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> @@ -449,7 +449,7 @@ class ovsactions(nla):
>>                   elif field[0] == "OVS_ACTION_ATTR_TRUNC":
>>                       print_str += "trunc(%d)" % int(self.get_attr(field[0]))
>>                   elif field[0] == "OVS_ACTION_ATTR_DROP":
>> -                    print_str += "drop"
>> +                    print_str += "drop(%d)" % int(self.get_attr(field[0]))
>>               elif field[1] == "flag":
>>                   if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
>>                       print_str += "ct_clear"
>> @@ -471,10 +471,21 @@ class ovsactions(nla):
>>           while len(actstr) != 0:
>>               parsed = False
>>               if actstr.startswith("drop"):
>> -                # for now, drops have no explicit action, so we
>> -                # don't need to set any attributes.  The final
>> -                # act of the processing chain will just drop the packet
>> -                return
>> +                # If no reason is provided, the implicit drop is used (i.e no
>> +                # action). If some reason is given, an explicit action is used.
>> +                actstr, reason = parse_extract_field(
>> +                    actstr,
>> +                    "drop(",
>> +                    "([0-9]+)",
>> +                    lambda x: int(x, 0),
>> +                    False,
>> +                    None,
>> +                )
>> +                if reason is not None:
>> +                    self["attrs"].append(["OVS_ACTION_ATTR_DROP", reason])
>> +                    parsed = True
>> +                else:
>> +                    return
>>   
>>               elif parse_starts_block(actstr, "^(\d+)", False, True):
>>                   actstr, output = parse_extract_field(
> 


