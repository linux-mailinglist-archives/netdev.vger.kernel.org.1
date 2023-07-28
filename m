Return-Path: <netdev+bounces-22300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7DF766F7F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139C62827F3
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288F5CB0;
	Fri, 28 Jul 2023 14:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FB13FF1
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 14:31:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451EC3A9A
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690554672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeGRjWxDaYUdtoK9jxbdP+48ZJkpz3RFiBrIfQMbJzQ=;
	b=Bbvuv5Awvr4lMBatZcLPoqAcUkCH1QbRbX9rohhk/W/8IV6xaT9zmvn/qNT40HifzliV26
	HOCoWFQWqaTyQ5PqR0LuXrQmjdJ1zGp1IS3obCHmWFprk/eP9zbzjCdNOM1/WvMqSMqQAh
	B+Om1dGh2uKV7tevmk9HqoDRrpv4BNc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-laWqgb6DMDKvILcjJF_BSw-1; Fri, 28 Jul 2023 10:31:10 -0400
X-MC-Unique: laWqgb6DMDKvILcjJF_BSw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so14364815e9.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554669; x=1691159469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeGRjWxDaYUdtoK9jxbdP+48ZJkpz3RFiBrIfQMbJzQ=;
        b=YYOMb9dzo+LtVTJe9i0Mw70DR0XnCOIpktQ012OkmGVIxLDnCdZV3tQEDS5SJidvdz
         AvSoYRSEBh3h6BoLZqbaGF0WHj4TX9Za6UVE+726UUJgzKESqnxShKiVAp59OVFmSVKr
         68VvvATVIxgX3VoCrgzdM4mnyhgPct73kuTJW5/8LRNfy+XTl9ctW4prMo+9XdRQxhwk
         j7n8UrxfmxhZMjQe7QM9zKGDdIfmdR1oMCngdB34ckKzgkds+OB3adg3t+E2lQMkA5xx
         lI82Koqb6qEkO5Bw6vhDnfF9w2zvk5c29CFOx8IQixb339Q2ptse/7on7DiNGmSj4t7H
         wuWQ==
X-Gm-Message-State: ABy/qLZn3cXrErKQbqAnO+zU7ZlSlJ9PA0/WVeUWVUtHICXdlAiAQDHO
	yJqw96aKkhmQfqwo7MKQKRNyd0+pHueFac8TMrudECkUw/p0W4H7OqNjtu2lFPTZKfIAU6hp5Fi
	v3yoYlS0ZhU4Vpu/s
X-Received: by 2002:a7b:cd09:0:b0:3fb:a62d:1992 with SMTP id f9-20020a7bcd09000000b003fba62d1992mr1917314wmj.0.1690554668717;
        Fri, 28 Jul 2023 07:31:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHvR678AaOAPH0Ktddko3poH/AAsjmtvPyK2t555cXew7r0tr80sLKPjF+jQl7V+acgYsBVWQ==
X-Received: by 2002:a7b:cd09:0:b0:3fb:a62d:1992 with SMTP id f9-20020a7bcd09000000b003fba62d1992mr1917286wmj.0.1690554668382;
        Fri, 28 Jul 2023 07:31:08 -0700 (PDT)
Received: from [192.168.1.67] (198.red-88-3-59.dynamicip.rima-tde.net. [88.3.59.198])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003fc0505be19sm4227803wmi.37.2023.07.28.07.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:31:07 -0700 (PDT)
Message-ID: <990b0e22-63ad-f747-4ea2-0c3ba78b0b37@redhat.com>
Date: Fri, 28 Jul 2023 16:31:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 net-next 5/5] selftests: openvswitch: add ct-nat test
 case with ipv4
Content-Language: en-US
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>
References: <20230728115940.578658-1-aconole@redhat.com>
 <20230728115940.578658-6-aconole@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <20230728115940.578658-6-aconole@redhat.com>
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
> Building on the previous work, add a very simplistic NAT case
> using ipv4.  This just tests dnat transformation
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>   .../selftests/net/openvswitch/openvswitch.sh  | 64 ++++++++++++++++
>   .../selftests/net/openvswitch/ovs-dpctl.py    | 75 +++++++++++++++++++
>   2 files changed, 139 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 40a66c72af0f..dced4f612a78 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -14,6 +14,7 @@ tests="
>   	arp_ping				eth-arp: Basic arp ping between two NS
>   	ct_connect_v4				ip4-ct-xon: Basic ipv4 tcp connection using ct
>   	connect_v4				ip4-xon: Basic ipv4 ping between two NS
> +	nat_connect_v4				ip4-nat-xon: Basic ipv4 tcp connection via NAT
>   	netlink_checks				ovsnl: validate netlink attrs and settings
>   	upcall_interfaces			ovs: test the upcall interfaces"
>   
> @@ -300,6 +301,69 @@ test_connect_v4 () {
>   	return 0
>   }
>   
> +# nat_connect_v4 test
> +#  - client has 1500 byte MTU
> +#  - server has 1500 byte MTU
> +#  - use ICMP to ping in each direction
> +#  - only allow CT state stuff to pass through new in c -> s
> +test_nat_connect_v4 () {
> +	which nc >/dev/null 2>/dev/null || return $ksft_skip
> +
> +	sbx_add "test_nat_connect_v4" || return $?
> +
> +	ovs_add_dp "test_nat_connect_v4" nat4 || return 1
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_nat_connect_v4" "nat4" "$ns" \
> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add 172.31.110.10/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 172.31.110.20/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	ip netns exec client ip route add default via 172.31.110.20
> +
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		"ct_state(-trk),in_port(1),eth(),eth_type(0x0800),ipv4(dst=192.168.0.20)" \
> +		"ct(commit,nat(dst=172.31.110.20)),recirc(0x1)"
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		"ct_state(-trk),in_port(2),eth(),eth_type(0x0800),ipv4()" \
> +		"ct(commit,nat),recirc(0x2)"
> +
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		"recirc_id(0x1),ct_state(+trk-inv),in_port(1),eth(),eth_type(0x0800),ipv4()" "2"
> +	ovs_add_flow "test_nat_connect_v4" nat4 \
> +		"recirc_id(0x2),ct_state(+trk-inv),in_port(2),eth(),eth_type(0x0800),ipv4()" "1"
> +
> +	# do a ping
> +	ovs_sbx "test_nat_connect_v4" ip netns exec client ping 192.168.0.20 -c 3 || return 1
> +
> +	# create an echo server in 'server'
> +	echo "server" | \
> +		ovs_netns_spawn_daemon "test_nat_connect_v4" "server" \
> +				nc -lvnp 4443
> +	ovs_sbx "test_nat_connect_v4" ip netns exec client nc -i 1 -zv 192.168.0.20 4443 || return 1
> +
> +	# Now test in the other direction (should fail)
> +	echo "client" | \
> +		ovs_netns_spawn_daemon "test_nat_connect_v4" "client" \
> +				nc -lvnp 4443
> +	ovs_sbx "test_nat_connect_v4" ip netns exec client nc -i 1 -zv 172.31.110.10 4443
> +	if [ $? == 0 ]; then
> +	   info "connect to client was successful"
> +	   return 1
> +	fi
> +
> +	info "done..."
> +	return 0
> +}
> +
>   # netlink_validation
>   # - Create a dp
>   # - check no warning with "old version" simulation
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 6e258ab9e635..258c9ef263d9 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -530,6 +530,81 @@ class ovsactions(nla):
>                           else:
>                               ctact["attrs"].append([scan[1], None])
>                           actstr = actstr[strspn(actstr, ", ") :]
> +                    # it seems strange to put this here, but nat() is a complex
> +                    # sub-action and this lets it sit anywhere in the ct() action
> +                    if actstr.startswith("nat"):
> +                        actstr = actstr[3:]
> +                        natact = ovsactions.ctact.natattr()
> +
> +                        if actstr.startswith("("):
> +                            t = None
> +                            actstr = actstr[1:]
> +                            if actstr.startswith("src"):
> +                                t = "OVS_NAT_ATTR_SRC"
> +                                actstr = actstr[3:]
> +                            elif actstr.startswith("dst"):
> +                                t = "OVS_NAT_ATTR_DST"
> +                                actstr = actstr[3:]
> +
> +                            actstr, ip_block_min = parse_extract_field(
> +                                actstr, "=", "([0-9a-fA-F:\.\[]+)", str, False
> +                            )
> +                            actstr, ip_block_max = parse_extract_field(
> +                                actstr, "-", "([0-9a-fA-F:\.\[]+)", str, False
> +                            )
> +
> +                            # [XXXX:YYY::Z]:123
> +                            # following RFC 3986
> +                            # More complete parsing, ala RFC5952 isn't
> +                            # supported.
> +                            if actstr.startswith("]"):
> +                                actstr = actstr[1:]
> +                            if ip_block_min is not None and \
> +                               ip_block_min.startswith("["):
> +                                ip_block_min = ip_block_min[1:]
> +                            if ip_block_max is not None and \
> +                               ip_block_max.startswith("["):
> +                                ip_block_max = ip_block_max[1:]
> +
> +                            actstr, proto_min = parse_extract_field(
> +                                actstr, ":", "(\d+)", int, False
> +                            )
> +                            actstr, proto_max = parse_extract_field(
> +                                actstr, "-", "(\d+)", int, False
> +                            )

I'm still struggling to make this part work:
On the one hand, ipv6 seems not fully supported by ovs-dpctl.py. If I try adding 
an ipv6 flow I end up needing to add a function such as as the following and use 
it to parse "ipv6()" field:

def convert_ipv6(data):
     ip, _, mask = data.partition('/')
     max_ip = pow(2, 128) - 1

     if not ip:
         ip = mask = 0
     elif not mask:
         mask = max
     elif mask.isdigit():
         mask = (max_ip << (128 - int(mask))) & max_ip

     return ipaddress.IPv6Address(ip).packed, ipaddress.IPv6Address(mask).packed

OTOH, trying to support ipv6 makes ct ip/port range parsing more complex, for 
instance, this action: "ct(nat(src=10.0.0.240-10.0.0.254:32768-65535))"

fails, because it's parsed as:
ip_block_min = 10.0.0.240
ip_block_max = 10.0.0.254:32768
proto_min = None
proto_max = 65535

I would say we could drop ipv6 support for nat() action, making it simpler to 
parse or first detect if we're parsing ipv4 or ipv6 and use appropriate regexp 
on each case. E.g: 
https://github.com/openvswitch/ovs/blob/d460c473ebf9e9ab16da44cbfbb13a4911352195/python/ovs/flow/decoders.py#L430-L486

Another approach would be to stop trying to be human friendly and use an easier 
to parse syntax, something closer to key-value, e.g: 
"ct(ip_block_min=10.0.0.240, ip_block_max=10.0.0.254, proto_min=32768, 
proto_max=65535)". It'd be more verbose and not compatible with ovs tooling but 
this is a testing tool afterall. WDYT?


> +
> +                            if t is not None:
> +                                natact["attrs"].append([t, None])
> +
> +                                if ip_block_min is not None:
> +                                    natact["attrs"].append(
> +                                        ["OVS_NAT_ATTR_IP_MIN", ip_block_min]
> +                                    )
> +                                if ip_block_max is not None:
> +                                    natact["attrs"].append(
> +                                        ["OVS_NAT_ATTR_IP_MAX", ip_block_max]
> +                                    )
> +                                if proto_min is not None:
> +                                    natact["attrs"].append(
> +                                        ["OVS_NAT_ATTR_PROTO_MIN", proto_min]
> +                                    )
> +                                if proto_max is not None:
> +                                    natact["attrs"].append(
> +                                        ["OVS_NAT_ATTR_PROTO_MAX", proto_max]
> +                                    )
> +
> +                            for natscan in (
> +                                ("persist", "OVS_NAT_ATTR_PERSISTENT"),

odp-util.c defines this flag as "persistent", not sure if you intend to keep it 
compatible at all.

> +                                ("hash", "OVS_NAT_ATTR_PROTO_HASH"),
> +                                ("random", "OVS_NAT_ATTR_PROTO_RANDOM"),
> +                            ):
> +                                if actstr.startswith(natscan[0]):
> +                                    actstr = actstr[len(natscan[0]) :]
> +                                    natact["attrs"].append([natscan[1], None])
> +                                    actstr = actstr[strspn(actstr, ", ") :]
> +
> +                        ctact["attrs"].append(["OVS_CT_ATTR_NAT", natact])
> +                        actstr = actstr[strspn(actstr, ",) ") :]
>   
>                   self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
>                   parsed = True

-- 
Adrián Moreno


