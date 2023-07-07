Return-Path: <netdev+bounces-16000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4074AE3A
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 11:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA8C281711
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10CDBE6E;
	Fri,  7 Jul 2023 09:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AFBA43
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 09:54:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E526A2
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688723692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjYax9mknKk0fs+MzxFMNHeOystZ6oX4KAfGFE9lleY=;
	b=P7LYracmNVI3fj88pertu2oQ0rNzMt1dr1Xd/8liRC1WVQ3dLI+WbXdQ2RNjfBtHwx0nYN
	TbHWrjjcu4FX6eKkw6TlwUz/jIGy9nnrsnOaN+xvKbL08H7uayNtfPMnL9FSjBQ+2r+Cq4
	qf+5RHMPy0QlVBAAuxPXJQ937yJax0Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-s506nKPgMXKSjEA4fTMBNw-1; Fri, 07 Jul 2023 05:54:50 -0400
X-MC-Unique: s506nKPgMXKSjEA4fTMBNw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6349a78b1aaso21819136d6.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 02:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688723690; x=1691315690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjYax9mknKk0fs+MzxFMNHeOystZ6oX4KAfGFE9lleY=;
        b=VfrEvRHOFROZvi2fkwfEfS2trjJo+gkWh8UVzpxzRfqZN+2RtGtUou9w+jmXG5Ti0t
         NNAd0pJzqSJnef64+7AXs1rE5bklNdY1PMI/qKOz9+1h8pAhuIvCycEqauNm/A3O9V4e
         Dsa2La7K4T7stQWPeJVHtrGcVAkp/4P4/DC6d61NxcRWwyswQiE5ui5zz8Jo7OAa10kC
         WXoMN9CVCKPPWOXHw6iVzZ+9L6A51pkfFrEGU0F0/1uzvKQV5oH0VXy9q6paGwYu0wji
         TvZgno9tZ969hH0DXFmLzc+l/Zv/TGWWIO9hvQ3NtylPs3Pqg8gdzIf2JLSkf+iAnvs7
         MKJQ==
X-Gm-Message-State: ABy/qLb5MvzEQTFsSoFqCI69FJW/QXCcfCYkGNkFe46RlbfjQxmKYOc7
	UmZP9xJAbs3JVJF154FQ5RqetvXg+jq8/FlbT6XmuU9Ejl+3HeVRtG+KorpSpck2JMoWENrskSc
	DepNw+5BVBU+vLRA9
X-Received: by 2002:a05:6214:c6a:b0:635:e211:dda with SMTP id t10-20020a0562140c6a00b00635e2110ddamr9274212qvj.2.1688723689776;
        Fri, 07 Jul 2023 02:54:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHC0HHCL7ov+V6fmnfvXAf9a7FMlpQuV2Byuwv1moVG5XnfZaaCEWuLUgAggitsjd8NZd/SGw==
X-Received: by 2002:a05:6214:c6a:b0:635:e211:dda with SMTP id t10-20020a0562140c6a00b00635e2110ddamr9274197qvj.2.1688723689501;
        Fri, 07 Jul 2023 02:54:49 -0700 (PDT)
Received: from [192.168.0.136] ([139.47.72.15])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a06d000b007678973eaa1sm1643519qky.127.2023.07.07.02.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 02:54:49 -0700 (PDT)
Message-ID: <caee20a1-5c70-ffc6-3ab4-b7848dfa3a72@redhat.com>
Date: Fri, 7 Jul 2023 11:54:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ovs-dev] [PATCH net-next 3/4] selftests: openvswitch: add basic
 ct test case parsing
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, Ilya Maximets <i.maximets@ovn.org>,
 Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 shuah@kernel.org, "David S. Miller" <davem@davemloft.net>
References: <20230628162714.392047-1-aconole@redhat.com>
 <20230628162714.392047-4-aconole@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <20230628162714.392047-4-aconole@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/28/23 18:27, Aaron Conole wrote:
> Forwarding via ct() action is an important use case for openvswitch, but
> generally would require using a full ovs-vswitchd to get working. Add a
> ct action parser for basic ct test case.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
> NOTE: 3 lines flag the line-length checkpatch warning, but there didnt
>        seem to be a really good way of breaking the lines smaller.
> 
>   .../selftests/net/openvswitch/openvswitch.sh  | 68 +++++++++++++++++++
>   .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++++
>   2 files changed, 107 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 5d60a9466dab3..40a66c72af0f0 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -12,6 +12,7 @@ TRACING=0
>   
>   tests="
>   	arp_ping				eth-arp: Basic arp ping between two NS
> +	ct_connect_v4				ip4-ct-xon: Basic ipv4 tcp connection using ct
>   	connect_v4				ip4-xon: Basic ipv4 ping between two NS
>   	netlink_checks				ovsnl: validate netlink attrs and settings
>   	upcall_interfaces			ovs: test the upcall interfaces"
> @@ -193,6 +194,73 @@ test_arp_ping () {
>   	return 0
>   }
>   
> +# ct_connect_v4 test
> +#  - client has 1500 byte MTU
> +#  - server has 1500 byte MTU
> +#  - use ICMP to ping in each direction
> +#  - only allow CT state stuff to pass through new in c -> s
> +test_ct_connect_v4 () {
> +
> +	which nc >/dev/null 2>/dev/null || return $ksft_skip
> +
> +	sbx_add "test_ct_connect_v4" || return $?
> +
> +	ovs_add_dp "test_ct_connect_v4" ct4 || return 1
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_ct_connect_v4" "ct4" "$ns" \
> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add 172.31.110.10/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 172.31.110.20/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	# Add forwarding for ARP and ip packets - completely wildcarded
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'ct_state(-trk),eth(),eth_type(0x0800),ipv4()' \
> +		     'ct(commit),recirc(0x1)' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'recirc_id(0x1),ct_state(+trk+new),in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10)' \
> +		     '2' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'recirc_id(0x1),ct_state(+trk+est),in_port(1),eth(),eth_type(0x0800),ipv4(src=172.31.110.10)' \
> +		     '2' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'recirc_id(0x1),ct_state(+trk+est),in_port(2),eth(),eth_type(0x0800),ipv4(dst=172.31.110.10)' \
> +		     '1' || return 1
> +	ovs_add_flow "test_ct_connect_v4" ct4 \
> +		     'recirc_id(0x1),ct_state(+trk+inv),eth(),eth_type(0x0800),ipv4()' 'drop' || \
> +		     return 1
> +
> +	# do a ping
> +	ovs_sbx "test_ct_connect_v4" ip netns exec client ping 172.31.110.20 -c 3 || return 1
> +
> +	# create an echo server in 'server'
> +	echo "server" | \
> +		ovs_netns_spawn_daemon "test_ct_connect_v4" "server" \
> +				nc -lvnp 4443
> +	ovs_sbx "test_ct_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.20 4443 || return 1
> +
> +	# Now test in the other direction (should fail)
> +	echo "client" | \
> +		ovs_netns_spawn_daemon "test_ct_connect_v4" "client" \
> +				nc -lvnp 4443
> +	ovs_sbx "test_ct_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.10 4443
> +	if [ $? == 0 ]; then
> +	   info "ct connect to client was successful"
> +	   return 1
> +	fi
> +
> +	info "done..."
> +	return 0
> +}
> +
>   # connect_v4 test
>   #  - client has 1500 byte MTU
>   #  - server has 1500 byte MTU
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 799bfb3064b90..704cb4adf79a9 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -62,6 +62,15 @@ def macstr(mac):
>       return outstr
>   
>   
> +def strcspn(str1, str2):
> +    tot = 0
> +    for char in str1:
> +        if str2.find(char) != -1:
> +            return tot
> +        tot += 1
> +    return tot
> +
> +
>   def strspn(str1, str2):
>       tot = 0
>       for char in str1:
> @@ -477,6 +486,36 @@ class ovsactions(nla):
>                       actstr = actstr[strspn(actstr, ", ") :]
>                       parsed = True
>   
> +            if parse_starts_block(actstr, "ct(", False):
> +                actstr = actstr[len("ct(") :]
> +                ctact = ovsactions.ctact()
> +
> +                for scan in (
> +                    ("commit", "OVS_CT_ATTR_COMMIT", None),
> +                    ("force_commit", "OVS_CT_ATTR_FORCE_COMMIT", None),
> +                    ("zone", "OVS_CT_ATTR_ZONE", int),
> +                    ("mark", "OVS_CT_ATTR_MARK", int),
> +                    ("helper", "OVS_CT_ATTR_HELPER", lambda x, y: str(x)),
> +                    ("timeout", "OVS_CT_ATTR_TIMEOUT", lambda x, y: str(x)),
> +                ):
> +                    if actstr.startswith(scan[0]):
> +                        actstr = actstr[len(scan[0]) :]
> +                        if scan[2] is not None:
> +                            if actstr[0] != "=":
> +                                raise ValueError("Invalid ct attr")
> +                            actstr = actstr[1:]
> +                            pos = strcspn(actstr, ",)")
> +                            datum = scan[2](actstr[:pos], 0)

It seems the scan function is only called with "0" as second argument. Wouldn't 
it be easier to omit that extra argument (which is the default value for "int" 
anyway) and simplify the lambda for "helper" and "timeout"?

Alternatively, we could have a function that tries both base-16 and base-10.

> +                            ctact["attrs"].append([scan[1], datum])
> +                            actstr = actstr[len(datum) :]

"datum" can be of type int and ints don't have len(). Maybe just use "pos" directly?

> +                        else:
> +                            ctact["attrs"].append([scan[1], None])
> +                        actstr = actstr[strspn(actstr, ", ") :]
> +
> +                self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
> +                actstr = actstr[strspn(actstr, "), ") :]
> +                parsed = True
> +
>               if not parsed:
>                   raise ValueError("Action str: '%s' not supported" % actstr)
>   

-- 
Adrián Moreno


