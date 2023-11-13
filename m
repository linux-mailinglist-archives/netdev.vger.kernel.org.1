Return-Path: <netdev+bounces-47359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C757E9CBD
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442BA1C2084F
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B281D527;
	Mon, 13 Nov 2023 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fxGg2Z8R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E151DFC0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:07:51 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D9D6E
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 05:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VpfCUDpp5tANXHf2ycVEMUXS6Ph6TPaSO+o/OJt2oi8=; b=fxGg2Z8R1l2IY0sULfd4fH0a37
	jqS7Ms6F3VIbRApkjWjdp/ETR76LSLocOlkqMQVkiTcWIVivyyh75nQOLAsxd+GWxMx77XCy/n2om
	8pGjWagrrFOvCHor1APwD0Qpf9NatNzjFFtNz43vG69diz3dfpVNOfMsC32worLmeXinRTBHYqofF
	81JwKXzhSQDsYntmmvFMxnt9zqliTdYj3h9udlrKv2DonOcXqU4X+BAk7/Cmx4KPBp9dpOsbbXHZE
	k2LeuoZeKt+IYK7u8FzAr642t1v6DZvx4CtqRW/IjapqTAfZrSribpeATrOnarNdjZwVsGn8WX7v4
	4Sd0w/Bw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2WfK-0006Ek-AY; Mon, 13 Nov 2023 14:07:46 +0100
Received: from [194.230.158.57] (helo=localhost.localdomain)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2WfJ-000IZ0-SV; Mon, 13 Nov 2023 14:07:46 +0100
Subject: Re: [PATCH iproute2] ip, link: Add support for netkit
To: Nikolay Aleksandrov <razor@blackwall.org>, stephen@networkplumber.org
Cc: martin.lau@kernel.org, netdev@vger.kernel.org
References: <20231113032323.14717-1-daniel@iogearbox.net>
 <b444e479-b2fc-fffd-cd6d-e82fd3e6e64b@blackwall.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d8a6b803-7602-4156-0572-a17d5fc321b7@iogearbox.net>
Date: Mon, 13 Nov 2023 14:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b444e479-b2fc-fffd-cd6d-e82fd3e6e64b@blackwall.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

On 11/13/23 1:42 PM, Nikolay Aleksandrov wrote:
> On 11/13/23 05:23, Daniel Borkmann wrote:
>> Add base support for creating/dumping netkit devices.
>>
>> Minimal example usage:
>>
>>    # ip link add type netkit
>>    # ip -d a
>>    [...]
>>    7: nk0@nk1: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>>      netkit mode l3 type peer policy forward numtxqueues 1 numrxqueues 1 [...]
>>    8: nk1@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>>      netkit mode l3 type primary policy forward numtxqueues 1 numrxqueues 1 [...]
>>
>> Example usage with netns (for BPF examples, see BPF selftests linked below):
>>
>>    # ip netns add blue
>>    # ip link add nk0 type netkit peer nk1 netns blue
>>    # ip link set up nk0
>>    # ip addr add 10.0.0.1/24 dev nk0
>>    # ip -n blue link set up nk1
>>    # ip -n blue addr add 10.0.0.2/24 dev nk1
>>    # ping -c1 10.0.0.2
>>    PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
>>    64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=0.021 ms
>>
>> Example usage with L2 mode and peer blackholing when no BPF is attached:
>>
>>    # ip link add foo type netkit mode l2 forward peer blackhole bar
>>    # ip -d a
>>    [...]
>>    13: bar@foo: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>>       link/ether 5e:5b:81:17:02:27 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>>       netkit mode l2 type peer policy blackhole numtxqueues 1 numrxqueues 1 [...]
>>    14: foo@bar: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>>       link/ether de:01:a5:88:9e:99 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>>       netkit mode l2 type primary policy forward numtxqueues 1 numrxqueues 1 [...]
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Link: https://git.kernel.org/torvalds/c/35dfaad7188c
>> Link: https://git.kernel.org/torvalds/c/05c31b4ab205
>> Link: https://git.kernel.org/torvalds/c/ace15f91e569
>> ---
>>   (Targeted for iproute2 v6.7.0.)
>>
> 
>>   ip/Makefile              |   2 +-
>>   ip/iplink.c              |   4 +-
>>   ip/iplink_netkit.c       | 160 +++++++++++++++++++++++++++++++++++++++
>>   man/man8/ip-address.8.in |   3 +-
>>   man/man8/ip-link.8.in    |  44 +++++++++++
>>   5 files changed, 209 insertions(+), 4 deletions(-)
>>   create mode 100644 ip/iplink_netkit.c
>>
>> diff --git a/ip/Makefile b/ip/Makefile
>> index 8fd9e295..3535ba78 100644
>> --- a/ip/Makefile
>> +++ b/ip/Makefile
>> @@ -13,7 +13,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
>>       ipvrf.o iplink_xstats.o ipseg6.o iplink_netdevsim.o iplink_rmnet.o \
>>       ipnexthop.o ipmptcp.o iplink_bareudp.o iplink_wwan.o ipioam6.o \
>>       iplink_amt.o iplink_batadv.o iplink_gtp.o iplink_virt_wifi.o \
>> -    ipstats.o
>> +    iplink_netkit.o ipstats.o
>>   RTMONOBJ=rtmon.o
>> diff --git a/ip/iplink.c b/ip/iplink.c
>> index 9a548dd3..6989cc4d 100644
>> --- a/ip/iplink.c
>> +++ b/ip/iplink.c
>> @@ -46,8 +46,8 @@ void iplink_types_usage(void)
>>           "          dsa | dummy | erspan | geneve | gre | gretap | gtp | ifb |\n"
>>           "          ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
>>           "          ipip | ipoib | ipvlan | ipvtap |\n"
>> -        "          macsec | macvlan | macvtap |\n"
>> -        "          netdevsim | nlmon | rmnet | sit | team | team_slave |\n"
>> +        "          macsec | macvlan | macvtap | netdevsim |\n"
>> +        "          netkit | nlmon | rmnet | sit | team | team_slave |\n"
>>           "          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |\n"
>>           "          xfrm | virt_wifi }\n");
>>   }
>> diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
>> new file mode 100644
>> index 00000000..c539777a
>> --- /dev/null
>> +++ b/ip/iplink_netkit.c
>> @@ -0,0 +1,160 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * iplink_netkit.c netkit device management
>> + *
>> + * Authors:        Daniel Borkmann <daniel@iogearbox.net>
>> + */
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <sys/socket.h>
>> +#include <linux/if_link.h>
>> +
>> +#include "rt_names.h"
>> +#include "utils.h"
>> +#include "ip_common.h"
>> +
>> +static void explain(struct link_util *lu, FILE *f)
>> +{
>> +    fprintf(f,
>> +        "Usage: ... %s [ mode MODE ] [ POLICY ] [ peer [ POLICY <options> ] ]\n"
>> +        "\n"
>> +        "MODE: l3 | l2\n"
>> +        "POLICY: forward | blackhole\n"
>> +        "(first values are the defaults if nothing is specified)\n"
>> +        "\n"
>> +        "To get <options> type 'ip link add help'.\n",
>> +        lu->id);
>> +}
>> +
>> +static bool seen_mode, seen_peer;
>> +static struct rtattr *data;
>> +
>> +static int netkit_parse_opt(struct link_util *lu, int argc, char **argv,
>> +                struct nlmsghdr *n)
>> +{
>> +    __u32 ifi_flags, ifi_change, ifi_index;
>> +    struct ifinfomsg *ifm, *peer_ifm;
>> +    int err;
>> +
>> +    ifm = NLMSG_DATA(n);
>> +    ifi_flags = ifm->ifi_flags;
>> +    ifi_change = ifm->ifi_change;
>> +    ifi_index = ifm->ifi_index;
>> +    ifm->ifi_flags = 0;
>> +    ifm->ifi_change = 0;
>> +    ifm->ifi_index = 0;
>> +    while (argc > 0) {
>> +        if (matches(*argv, "mode") == 0) {
> 
> matches() should not be used anymore, only strcmp
> 
>> +            __u32 mode = 0;
>> +
>> +            NEXT_ARG();
>> +            if (seen_mode)
>> +                duparg("mode", *argv);
>> +            seen_mode = true;
>> +
>> +            if (strcmp(*argv, "l3") == 0)
>> +                mode = NETKIT_L3;
>> +            else if (strcmp(*argv, "l2") == 0)
>> +                mode = NETKIT_L2;
> 
> minor nit: curly braces for all cases

Thanks will address all and send a v2.

Cheers,
Daniel

