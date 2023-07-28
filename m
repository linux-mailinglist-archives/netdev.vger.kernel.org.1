Return-Path: <netdev+bounces-22317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AFB767024
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19EF28280A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93B13FF5;
	Fri, 28 Jul 2023 15:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451311CA0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:08:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02CE3C28
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690556905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRr5BONVtbzWtpOSxfQuykokzlwKEf5LYOHHxadZPWA=;
	b=RAK5aXSGTJWlVlVd+ZOMMCfi4Wgn/A3sglqLrBGfKQoN2mpR33PlfGSztVYzy9LZ2TG/NN
	Od1Xnnecqs/Z01iGTWvncgwuZot2kpitFxS8UOroYbgZdH+lmV+cT85B53Di4gSYoh27jH
	n48GEiBrXFqNghzqVZAbw3V7Pq7ES1I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-Xht2R3yEO2Saftw3kjrvoA-1; Fri, 28 Jul 2023 11:08:13 -0400
X-MC-Unique: Xht2R3yEO2Saftw3kjrvoA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31758708b57so1384439f8f.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556888; x=1691161688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRr5BONVtbzWtpOSxfQuykokzlwKEf5LYOHHxadZPWA=;
        b=MpoZXFki1prsSunQSHucGKPwCsLV8bQS5Wsf7mLukWs+CL4/s0BMxVjqoGwjf3dguQ
         TcoauJnQEU8SLbGtDdvDHQfDdGXPEZJs1fcbjoS8sB0rIxfDIZn/m2mtKdJlOATwB+dF
         s6/8fiEjz7w5wvaBmXNwh+0MAhNlLbbFAK5wY0xNQzqlvs8m/eaJSetI4xGRpLB55YST
         eVGTAJTcFS6XDWSog1vzipboJ6h1l2YymIvp/ST1jCG3sGTeWfdsKJ/4B+SpBIiKlXyB
         ibW6T2/aW4LCx3Zv+puBmbNFVx4U7/97Dr8fgxh792pENeS+VpgVOm0MXcP8GXcc9cU3
         /ARw==
X-Gm-Message-State: ABy/qLbuuWOAgpI4kTCdBsiL6ZdCN3iaeNhNBMnWE6rwGbE1tIzCI5ny
	q18tTrfRUApu/ICwQLjdA9IRZ7n2X16eXxopEwbIEDGfwDllH4icZKeg65YWZ27xH4h/sphczhX
	yhYtHosOfE3dXuMJn
X-Received: by 2002:a5d:658a:0:b0:314:1416:3be3 with SMTP id q10-20020a5d658a000000b0031414163be3mr2119905wru.70.1690556887871;
        Fri, 28 Jul 2023 08:08:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDQpKetLM+AJNeRN4DNiG6HRo9Vh1XlHIRHofIKZCzScYmXNlC46bR+kl3uHUWrSGWoAz78A==
X-Received: by 2002:a5d:658a:0:b0:314:1416:3be3 with SMTP id q10-20020a5d658a000000b0031414163be3mr2119878wru.70.1690556887518;
        Fri, 28 Jul 2023 08:08:07 -0700 (PDT)
Received: from [192.168.1.67] (198.red-88-3-59.dynamicip.rima-tde.net. [88.3.59.198])
        by smtp.gmail.com with ESMTPSA id l7-20020adfe587000000b00314172ba213sm4991169wrm.108.2023.07.28.08.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:08:07 -0700 (PDT)
Message-ID: <88eff25c-0849-118d-de1e-6ac7f59c9fd4@redhat.com>
Date: Fri, 28 Jul 2023 17:08:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [ovs-dev] [PATCH v2 net-next 4/5] selftests: openvswitch: add
 basic ct test case parsing
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Ilya Maximets <i.maximets@ovn.org>, Eric Dumazet <edumazet@google.com>,
 linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20230728115940.578658-1-aconole@redhat.com>
 <20230728115940.578658-5-aconole@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <20230728115940.578658-5-aconole@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/23 13:59, Aaron Conole wrote:
> Forwarding via ct() action is an important use case for openvswitch, but
> generally would require using a full ovs-vswitchd to get working. Add a
> ct action parser for basic ct test case.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Adrian Moreno <amorenoz@redhat.com>

> ---
> NOTE: 3 lines flag the line-length checkpatch warning, but there didnt
>        seem to be a really good way of breaking the lines smaller.
> 
>   .../selftests/net/openvswitch/openvswitch.sh  | 68 +++++++++++++++++++
>   .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++++
>   2 files changed, 107 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 5d60a9466dab..40a66c72af0f 100755
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
> index 2b869e89c51d..6e258ab9e635 100644
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
> @@ -496,6 +505,36 @@ class ovsactions(nla):
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
> +                            ctact["attrs"].append([scan[1], datum])
> +                            actstr = actstr[pos:]
> +                        else:
> +                            ctact["attrs"].append([scan[1], None])
> +                        actstr = actstr[strspn(actstr, ", ") :]
> +
> +                self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
> +                parsed = True
> +
> +            actstr = actstr[strspn(actstr, "), ") :]
>               if not parsed:
>                   raise ValueError("Action str: '%s' not supported" % actstr)
>   

-- 
Adrián Moreno


