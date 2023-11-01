Return-Path: <netdev+bounces-45537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A77DE053
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D047BB210D2
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 11:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F0B1119B;
	Wed,  1 Nov 2023 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ZK8wcVHl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391411193
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 11:29:44 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE7123
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 04:29:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so11391279a12.0
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 04:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698838177; x=1699442977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tM1jAapLszbc9pcqHJwbKHHNFd+11IhP2y8LPF6wVQ=;
        b=ZK8wcVHl7VXEc6D5zZhKdFLPjKikIceF3EdKMyJdqZn6y3lOy4mj8zaU+S/+Lkakqn
         xoNglETsTeAkT6j+Ho3EW0/VprROdYr6so/4iz9LfTukBJRFGVGbomMRExLFCN/G2QDw
         wIKhl8q3Nyc8JaT731H1H2jZnYOpUI86s2iub/dWjnKdvY7+ullFRxGS8P9C0Nlw0loQ
         vZcjCOYPKwgS93uJpuc/S7/QKkPYwFlfy1u9ke+RNNqUx94xMa3+OAY58qccq8HilNYA
         aWjltdLvdJPu/HLq65N0CiBUhJsp27m69FddT9J1MUnnfXsrM5arTYM14lmV1CfQrVPK
         ypaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698838177; x=1699442977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tM1jAapLszbc9pcqHJwbKHHNFd+11IhP2y8LPF6wVQ=;
        b=Gxa8rGg2i+3cVSee+7wRhlVv7dAP8VAut1JqILIYJghK2TzCn0Gk+L38rWwHv8Mwx/
         qCk+W44tlToU5M46TW8mkgUs8mWmw9esLEoFtqGh7HgYy7Twmk1XZ14orLQ6fJHXvZV8
         0k6VY6xOoG9DoJSbZMhDu0AcLE7EzOE4g6cI0INbU7DtZsLRzwlVIC0iUM0gJo8Px1G+
         SmH7NaERRtGgT+B4U/slV2yDvF0ADSGuV6KhEcEj1YyMsreNxt47J/WkDi+VPZ4vzP2d
         V77u7IJ1kgKa9B2F662HphaCmIEijG0JDPivUAY7wx2It71ecOyWL8AEJm/RwJeZ8gPI
         ttHQ==
X-Gm-Message-State: AOJu0YzuPY3eM39kTsG8yLAOWNU375bhtRkYHu8RlxtmB0e1L53x+R/9
	g17Od3ovj58ySFeXLCWGD9+b2w==
X-Google-Smtp-Source: AGHT+IGfCfF+84eKhWw+5EGCnj7BtJ/XEalazhdP3obWOmdrbmQKOisY5rUKPIxvYjqutgcNFCVPhw==
X-Received: by 2002:a17:907:2d91:b0:9ae:5765:c134 with SMTP id gt17-20020a1709072d9100b009ae5765c134mr1995651ejc.15.1698838176084;
        Wed, 01 Nov 2023 04:29:36 -0700 (PDT)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id k12-20020a1709065fcc00b009ce03057c48sm2295262ejv.214.2023.11.01.04.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 04:29:35 -0700 (PDT)
Message-ID: <68045f82-4306-165b-c4b2-96432cc8c422@blackwall.org>
Date: Wed, 1 Nov 2023 13:29:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC Draft PATCHv2 net-next] Doc: update bridge doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20231027071842.2705262-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231027071842.2705262-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/23 10:18, Hangbin Liu wrote:
> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> In this patch, I copied and modifed most of the bridge description from iproute2.
> But the Bridge internals part is incomplete as there are too much
> attributes while I'm not very familiar. So I only added 2 identifiers as
> example. Some part of the documents are generated by ChatGPT as I'm not
> good at summarizing.

interesting :)

> 
> As a draft patch, please tell me what other part I need to add or
> update. Thanks!
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: Drop the python tool that generate iproute man page from kernel doc
> ---
>   Documentation/networking/bridge.rst | 205 ++++++++++++-
>   include/uapi/linux/if_bridge.h      |  24 ++
>   include/uapi/linux/if_link.h        | 454 ++++++++++++++++++++++++++++
>   net/bridge/br_sysfs_br.c            |  94 ++++++
>   4 files changed, 767 insertions(+), 10 deletions(-)
> 

Hi,
I have written some initial comments, there will definitely be more.
One general thing - please split this in 2 patches at least. 1 for the
documentation, and 1 for the netlink uAPI changes. You can even split it
further into logical parts if you'd like, it will make it easier to
review and people can focus on different parts better. Please CC DSA
folks as well.

> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index c859f3c1636e..b36bd737c05e 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -4,18 +4,203 @@
>   Ethernet Bridging
>   =================
>   
> -In order to use the Ethernet bridging functionality, you'll need the
> -userspace tools.
> +Introduction
> +============
>   
> -Documentation for Linux bridging is on:
> -   https://wiki.linuxfoundation.org/networking/bridge
> +A bridge is a way to connect two Ethernet segments together in a protocol

s/two/multiple/

> +independent way. Packets are forwarded based on Ethernet address, rather

"based on Layer 2 destination Ethernet address" ?

> +than IP address (like a router). Since forwarding is done at Layer 2, all
> +protocols can go transparently through a bridge.

Here "all protocols" sounds misleading. I'd remove this sentence or make
it more accurate about which protocols (e.g. all Layer 3 protocols can 
pass through or something like that).

>   
> -The bridge-utilities are maintained at:
> -   git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
> +Bridge internals
> +================
>   
> -Additionally, the iproute2 utilities can be used to configure
> -bridge devices.
> +Here are the core structs of bridge code.

the core structs? These are outdated structures used in ioctl.

Also: s/structs/structures/

>   
> -If you still have questions, don't hesitate to post to the mailing list
> -(more info https://lists.linux-foundation.org/mailman/listinfo/bridge).
> +.. kernel-doc:: include/uapi/linux/if_bridge.h
> +   :identifiers: __bridge_info
>   
> +.. kernel-doc:: include/uapi/linux/if_bridge.h
> +   :identifiers: __port_info
> +
> +Bridge uAPI
> +===========
> +
> +The Linux bridge uAPI are exported via the netlink interface. Here are

I'd say: "Modern Linux bridge uAPI is accessed via Netlink interface."
Or something in those lines.

> +all the bridge and bridge port netlink attribute definations.

Something like:
"You can find below the files where the bridge and bridge port netlink 
attributes are defined"

> +
> +Bridge netlink attributes
> +-------------------------
> +
> +.. kernel-doc:: include/uapi/linux/if_link.h
> +   :doc: The bridge emum defination
> +
> +Bridge port netlink attributes
> +------------------------------
> +
> +.. kernel-doc:: include/uapi/linux/if_link.h
> +   :doc: The bridge port emum defination
> +
> +Bridge sysfs
> +------------
> +
> +All the sysfs parameters are also exported via the bridge netlink API.
> +Here you can find the explanation based on the correspond netlink attributes.

I don't get this one?
Also please mention the sysfs interface is deprecated and should not be 
extended if new options are added.

> +
> +.. kernel-doc:: net/bridge/br_sysfs_br.c
> +   :doc: The sysfs bridge attrs
> +
> +STP
> +===
> +
> +The STP (Spanning Tree Protocol) function in a Linux bridge is a critical

not a function, it's a protocol implementation, "in a Linux bridge" 
should be "in the Linux bridge driver"

> +feature that helps prevent loops in Ethernet networks by identifying and
> +disabling redundant links within a network. The primary purpose of STP is

This is confusing also, you speak about plural Ethernet networks and 
then speak about a single network, this will need some clarification.

> +to ensure network reliability and redundancy while preventing broadcast
> +storms and other undesirable network behaviors. In a Linux bridge context,

loops

> +STP is crucial for network stability and availability.
> +
> +STP is a Layer 2 protocol that operates at the Data Link Layer of the OSI
> +model. It was originally developed as IEEE 802.1D and has since evolved into
> +multiple versions, including Rapid Spanning Tree Protocol (RSTP) and
> +Multiple Spanning Tree Protocol (MSTP). The Linux bridge typically support
> +the original Spanning Tree Protocol (STP) and Rapid Spanning Tree Protocol
> +(RSTP), but not MSTP.

Not true, there is kernel help for mstp (br_mstp.c) and there are 
user-space mstp implementations for the Linux bridge, although I'm not 
sure how complete they are. I'd drop the last sentence.

> +
> +Bridge Ports and STP States
> +---------------------------
> +
> +In the context of STP, bridge ports can be in one of the following states:
> +  * Blocking: The port is disabled for data traffic and only listens to
> +    BPDUs (Bridge Protocol Data Units) from other devices to determine the
> +    network topology.

I think "listens for" as written below in Listening as well.

> +  * Listening: The port begins to participate in the STP process and listens
> +    for BPDUs.
> +  * Learning: The port continues to listen to BPDUs and begins to learn MAC
> +    addresses from incoming frames but does not forward data frames.

"listen for"

> +  * Forwarding: The port is fully operational and forwards both BPDUs and
> +    data frames.
> +  * Disabled: The port is administratively disabled and does not participate
> +    in the STP process.

Not only STP, but also data frames are not forwarded in this state.

> +
> +Root Bridge and Convergence
> +---------------------------
> +
> +Within a network, one bridge is elected as the "Root Bridge." All other
> +bridges participate in STP to determine the shortest path to the Root Bridge.
> +

I'd add how is the root bridge chosen.

> +STP ensures network convergence by calculating the shortest path and disabling
> +redundant links. When network topology changes occur (e.g., a link failure),
> +STP recalculates the network topology to restore connectivity while avoiding loops.
> +
> +Proper configuration of STP parameters, such as the bridge priority, can
> +influence which bridge becomes the Root Bridge. Careful configuration can
> +optimize network performance and path selection.
> +
> +Multicast
> +=========
> +
> +The multicast functionality in a Linux bridge refers to the ability of the

Something in the line of:
"The Linux bridge driver has multicast support allowing it to process 
IGMP and MLD (full names w/ abbrev) messages, and to efficiently forward 
multicast data packets."
You can include IGMP/MLD versions as well. Also you should mention EHT 
support which is important for IGMPv3/MLDv2.

> +bridge to efficiently forward multicast traffic, such as Internet Group
> +Management Protocol (IGMP) or Multicast Listener Discovery (MLD) messages,
> +and multicast data packets within a local network segment. This is an
> +important capability in environments where applications or services rely
> +on multicast communication.

The last sentence is unnecessary.

> +
> +By default, Linux bridges are capable of forwarding multicast traffic.

You should explain what is multicast snooping, then say something in the 
line of:
"When created, the Linux bridge devices have multicast snooping enabled 
by default"

> +The bridge acts as a Layer 2 (Data Link Layer) device and forwards multicast
> +packets to all bridge ports (except the source port) within the same VLAN.

Not entirely true, there is per-VLAN multicast support. You should 
mention that it is disabled by default but can be enabled.

> +
> +After enable multicast snooping, the Linux bridge can filter multicast

"When multicast snooping is enabled the Linux bridge driver will forward 
multicast traffic based on the destination MAC address only to ports 
which have joined the respective destination multicast group."

Or if you think of something cleaner..

> +traffic based on the destination MAC address, making it more efficient in
> +forwarding multicast frames. It maintains a Multicast Filtering Database (MFD)

There is no MFD concept in the bridge, you can call it that but you
cannot find any such reference. I'd mention MDB instead.

> +that records which multicast groups are associated with each bridge port.

"It maintains a Multicast forwarding database (MDB) which keeps track of 
port and group relationships."
This may be paraphrased better, but you get what I mean.

> +Multicast traffic is forwarded only to ports with associated group
> +memberships.

With above changed, this will need to be adjusted too.

> +
> +VLAN
> +====
> +
> +VLAN (Virtual LAN) functionality can be integrated with the Linux bridge to > +provide a way to manage and segregate network traffic into different 
virtual

What is a LAN? You need to expand that as well. Also this sounds
confusing, it should be something like:
"The Linux bridge driver has VLAN (Virtual Local Area Network) support
which provides a way to segregate network traffic..."

> +LANs within a single physical network infrastructure. This integration allows
> +for greater flexibility in network configuration and traffic isolation.

The last sentence is unnecessary.

> +
> +After enable VLAN filter on bridge, the bridge can handle VLAN-tagged frames

What is a VLAN-tagged frame? Add some short explanation before using it.

You should mention that vlan filtering is disabled by default. There is 
also a lot more vlan information that can be added, the bridge has many 
different vlan related options.

> +and forward them to the appropriate destinations based on the VLAN tag.

Not entirely correct, it is not only based on the VLAN tag. You should 
explain how it is used in the forwarding decision.

> +
> +The Linux bridge supports the IEEE 802.1Q and 802.1AD protocol for VLAN
> +tagging.

Maybe start with this and include it in the vlan explanation in the
beginning? :)

> +
> +Switchdev
> +=========
> +
> +Linux Bridge Switchdev is a feature in the Linux kernel that extends the
> +capabilities of the traditional Linux bridge to work more efficiently with
> +hardware switches that support switchdev. This technology is particularly
> +useful in data center and networking environments where high-performance
> +and low-latency packet forwarding is essential.

The last sentence is misleading, switchdev is used for many different 
types of devices.
> +
> +With Linux Bridge Switchdev, certain networking functions like forwarding,
> +filtering, and learning of Ethernet frames can be offloaded to the hardware

"to a hardware switch"

> +switch. This offloading reduces the burden on the Linux kernel and CPU,
> +leading to improved network performance and lower latency.
> +
> +To use Linux Bridge Switchdev, you need hardware switches that support the
> +switchdev interface. This means that the switch hardware needs to have the
> +necessary drivers and functionality to work in conjunction with the Linux
> +kernel.

I'd add DSA maintainers to the CC list, and also ask switchdev driver
maintainers to add more here. Switchdev can be explained much better.

> +
> +Netfilter
> +=========
> +
> +The bridge netfilter module allows packet filtering and firewall functionality
> +on bridge interfaces. As the Linux bridge, which traditionally operates at
> +Layer 2 and connects multiple network interfaces or segments, doesn't have
> +built-in packet filtering capabilities.
> +
> +With bridge netfilter, you can define rules to filter or manipulate Ethernet
> +frames as they traverse the bridge. These rules are typically based on
> +Ethernet frame attributes such as MAC addresses, VLAN tags, and more.
> +You can use the *ebtables* or *nftables* tools to create and manage these
> +rules. *ebtables* is a tool specifically designed for managing Ethernet frame
> +filtering rules, while *nftables* is a more versatile framework for managing
> +rules that can also be used for bridge filtering.
> +
> +The bridge netfilter is commonly used in scenarios where you want to apply
> +security policies to the traffic at the data link layer. This can be useful
> +for segmenting and securing networks, enforcing access control policies,
> +and isolating different parts of a network.
> +
> +FAQ
> +===
> +
> +What does a bridge do?
> +----------------------
> +
> +A bridge transparently relays traffic between multiple network interfaces.

s/relays/forwards/

> +In plain English this means that a bridge connects two or more physical
> +Ethernets together to form one bigger (logical) Ethernet.

Something like
"Ethernet networks, to form one larger (logical) Ethernet network."

> +
> +Is it protocol independent?

Unclear, what layer?
> +---------------------------
> +
> +Yes. The bridge knows nothing about protocols, it only sees Ethernet frames.

It sees all frames, it *uses* only L2 headers/information.

> +As such, the bridging functionality is protocol independent, and there should
> +be no trouble relaying IPX, NetBEUI, IP, IPv6, etc. > +
> +Contact Info
> +============
> +
> +The code is currently maintained by Roopa Prabhu <roopa@nvidia.com> and
> +Nikolay Aleksandrov <razor@blackwall.org>. Bridge bugs and enhancements
> +are discussed on the linux-netdev mailing list netdev@vger.kernel.org and
> +bridge@lists.linux-foundation.org.
> +
> +The list is open to anyone interested: http://vger.kernel.org/vger-lists.html#netdev
> +
> +External Links
> +==============
> +
> +The old Documentation for Linux bridging is on:
> +https://wiki.linuxfoundation.org/networking/bridge
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index f95326fce6bb..63e39de1055b 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -52,6 +52,19 @@
>   #define BR_STATE_FORWARDING 3
>   #define BR_STATE_BLOCKING 4
>   
> +/**
> + * struct __bridge_info - the bridge information
> + *
> + * @designated_root: Designated bridge's root bridge identifier
> + *
> + * @bridge_id: Current bridge identifier
> + *
> + * @root_path_cost: The cost of bridge root path
> + *
> + * @max_age: The hello packet timeout
> + *
> + * @hello_time: The time in seconds between hello packets sent by the bridge
> + */

Mention somewhere STP. All of the above is about STP.

>   struct __bridge_info {
>   	__u64 designated_root;
>   	__u64 bridge_id;
> @@ -74,6 +87,17 @@ struct __bridge_info {
>   	__u32 gc_timer_value;
>   };
>   
> +/**
> + * struct __port_info - the bridge port information
> + *
> + * @designated_root: Designated bridge's root bridge identifier
> + *
> + * @designated_bridge: Designated bridge's identifier
> + *
> + * @port_id: Current port id
> + *
> + * @designated_port: Designated port number
> + */

Same STP comment.

>   struct __port_info {
>   	__u64 designated_root;
>   	__u64 designated_bridge;
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index fac351a93aed..6adc0c70e345 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -461,6 +461,238 @@ enum in6_addr_gen_mode {
>   
>   /* Bridge section */
>   
> +/**
> + * DOC: The bridge emum defination

s/emum/enum/

Below the time is not in seconds though. It is expected in clock_t 
(seconds multiplied by USER_HZ) and also exported. That should be
better explained as it has caused confusion a lot.

> + *
> + * @IFLA_BR_FORWARD_DELAY
> + *   The bridge forwarding delay in seconds, ie the time spent in LISTENING

Remove ie. "is the time"

> + *   state (before moving to LEARNING) and in LEARNING state (before moving
> + *   to FORWARDING). Only relevant if STP is enabled.
> + *
> + *   The valid values are between 2 and 30. The default value is 15.
> + *
> + * @IFLA_BR_HELLO_TIME
> + *   The time in seconds between hello packets sent by the bridge,
> + *   when it is a root bridge or a designated bridges. Only relevant if

"or a designated bridge" but this is a bit confusing, needs better
explanation

> + *   STP is enabled.
> + *
> + *   The valid values are between 1 and 10. The default value is 2.
> + *
> + * @IFLA_BR_MAX_AGE
> + *   The hello packet timeout, ie the time in seconds until another

Remove ie. "is the time"

> + *   bridge in the spanning tree is assumed to be dead, after reception of
> + *   its last hello message. Only relevant if STP is enabled.
> + *
> + *   The valid values are between 6 and 40. The default value is 20.
> + *
> + * @IFLA_BR_AGEING_TIME
> + *   Configure the bridge's FDB entries ageing time, ie the number of
> + *   seconds a MAC address will be kept in the FDB after a packet has been
> + *   received from that address. after this time has passed, entries are
> + *   cleaned up. Allow values outside the 802.1 standard specification for
> + *   special cases:
> + *
> + *     * 0 - entry never ages (all permanent)
> + *     * 1 - entry disappears (no persistence)
> + *
> + *   The default value is 300.
> + *
> + * @IFLA_BR_STP_STATE
> + *   Turn spanning tree protocol on (*IFLA_BR_STP_STATE* > 0) or off
> + *   (*IFLA_BR_STP_STATE* == 0) for this bridge.
> + *
> + * @IFLA_BR_PRIORITY
> + *   set this bridge's spanning tree priority, used during STP root bridge
> + *   election.
> + *
> + *   The valid values are between 0 and 65535.
> + *
> + * @IFLA_BR_VLAN_FILTERING
> + *   Turn VLAN filtering on (*IFLA_BR_VLAN_FILTERING* > 0) or off
> + *   (*IFLA_BR_VLAN_FILTERING* == 0). When disabled, the bridge will not
> + *   consider the VLAN tag when handling packets.
> + *
> + * @IFLA_BR_VLAN_PROTOCOL
> + *   Set the protocol used for VLAN filtering.
> + *
> + *   The valid values are 0x8100(802.1Q) or 0x88A8(802.1AD).
> + *
> + * @IFLA_BR_GROUP_FWD_MASK
> + *   The group forward mask. This is the bitmask that is applied to
> + *   decide whether to forward incoming frames destined to link-local
> + *   addresses, ie addresses of the form 01:80:C2:00:00:0X (defaults to 0,
> + *   ie the bridge does not forward any linklocal frames coming on this port).
> + *

All "only readable from kernel" should be changed to ", read only".

> + * @IFLA_BR_ROOT_ID
> + *   The bridge root id, only readable from kernel.
> + *
> + * @IFLA_BR_BRIDGE_ID
> + *   The bridge id, only readable from kernel.
> + *
> + * @IFLA_BR_ROOT_PORT
> + *   The bridge root port, only readable from kernel.
> + *
> + * @IFLA_BR_ROOT_PATH_COST
> + *   The bridge root path cost, only readable from kernel.
> + *
> + * @IFLA_BR_TOPOLOGY_CHANGE
> + *   The bridge topology change, only readable from kernel.
> + *
> + * @IFLA_BR_TOPOLOGY_CHANGE_DETECTED
> + *   The bridge topology change detected, only readable from kernel.
> + *
> + * @IFLA_BR_HELLO_TIMER
> + *   The bridge hello timer, only readable from kernel.
> + *
> + * @IFLA_BR_TCN_TIMER
> + *   The bridge tcn timer, only readable from kernel.
> + *
> + * @IFLA_BR_TOPOLOGY_CHANGE_TIMER
> + *   The bridge topology change timer, only readable from kernel.
> + *
> + * @IFLA_BR_GC_TIMER
> + *   The bridge gc timer, only readable from kernel.
> + *
> + * @IFLA_BR_GROUP_ADDR
> + *   set the MAC address of the multicast group this bridge uses for STP.
> + *   The address must be a link-local address in standard Ethernet MAC address
> + *   format, ie an address of the form 01:80:C2:00:00:0X, with X in [0, 4..f].
> + *
> + * @IFLA_BR_FDB_FLUSH
> + *   Flush bridge's fdb dynamic entries.
> + *
> + * @IFLA_BR_MCAST_ROUTER
> + *   Set bridge's multicast router if IGMP snooping is enabled.
> + *   The valid values are:
> + *
> + *     * 0 - disabled.
> + *     * 1 - automatic (queried).
> + *     * 2 - permanently enabled.
> + *
> + * @IFLA_BR_MCAST_SNOOPING
> + *   Turn multicast snooping on (*IFLA_BR_MCAST_SNOOPING* > 0) or off
> + *   (*IFLA_BR_MCAST_SNOOPING* == 0). Default is on.
> + *
> + * @IFLA_BR_MCAST_QUERY_USE_IFADDR
> + *   whether to use the bridge's own IP address as source address for IGMP
> + *   queries (*IFLA_BR_MCAST_QUERY_USE_IFADDR* > 0) or the default of 0.0.0.0
> + *   (*IFLA_BR_MCAST_QUERY_USE_IFADDR* == 0).
> + *
> + * @IFLA_BR_MCAST_QUERIER
> + *   Enable (*IFLA_BR_MULTICAST_QUERIER* > 0) or disable
> + *   (*IFLA_BR_MULTICAST_QUERIER* == 0) IGMP querier, ie sending of multicast
> + *   queries by the bridge.
> + *
> + *   The default value is 0 (disabled).

No need for the new line above, either add it for all attributes or
don't add it for any.

> + *
> + * @IFLA_BR_MCAST_HASH_ELASTICITY
> + *   Set multicast database hash elasticity, ie the maximum chain length in
> + *   the multicast hash table.
> + *
> + *   The default value is 4.

This attribute is deprecated and has no effect.

> + *
> + * @IFLA_BR_MCAST_HASH_MAX
> + *   Set maximum size of multicast hash table

"of the"

> + *
> + *   The default value is 512, value must be a power of 2.

Incorrect,
br_private.h:#define BR_MULTICAST_DEFAULT_HASH_MAX 4096

> + *
> + * @IFLA_BR_MCAST_LAST_MEMBER_CNT
> + *   Set multicast last member count, ie the number of queries the bridge
> + *   will send before stopping forwarding a multicast group after a "leave"
> + *   message has been received.

This needs to be explained better. Remove "ie", "It is the number of 
queries the bridge will send", this part needs to be extended what are 
these queries and are they group-specific or general etc. The interval
and time values below need better explanations of their units and what
they represent in general. I won't add a comment below each.

Also please remove the extra new lines between the comments and the
definitions.

> + *
> + *   The default value is 2.
> + *
> + * @IFLA_BR_MCAST_STARTUP_QUERY_CNT
> + *   Set the number of IGMP queries to send during startup phase.

What is a startup phase?

> + *
> + *   The default value is 2.
> + *
> + * @IFLA_BR_MCAST_LAST_MEMBER_INTVL
> + *   The interval between queries to find remaining members of a group, after
> + *   a "leave" message is received.

Again this needs to be reworded, the leave message is for a specific
group.

> + *
> + *   The default value is 1.

What is 1?

> + *
> + * @IFLA_BR_MCAST_MEMBERSHIP_INTVL
> + *   The interval after which the bridge will leave a group, if no membership
> + *   reports for this group are received.
> + *
> + *   The default value is 260.

What is 260? Please be more specific.

> + *
> + * @IFLA_BR_MCAST_QUERIER_INTVL
> + *   The interval between queries sent by other routers. if no queries are
> + *   seen after this delay has passed, the bridge will start to send its own
> + *   queries (as if **IFLA_BR_MCAST_QUERIER_INTVL** was enabled).

Mention the type of queries it will send.

> + *
> + *   The default value is 255.
> + *
> + * @IFLA_BR_MCAST_QUERY_INTVL
> + *   The interval between queries sent by the bridge after the end of the
> + *   startup phase.
> + *
> + *   The default value is 125.
> + *
> + * @IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
> + *   The Max Response Time/Maximum Response Delay for IGMP/MLD queries
> + *   sent by the bridge.
> + *
> + *   The default value is 10.
> + *
> + * @IFLA_BR_MCAST_STARTUP_QUERY_INTVL
> + *   The interval between queries in the startup phase.
> + *
> + *   The default value is 125 / 4.
> + *
> + * @IFLA_BR_NF_CALL_IPTABLES
> + *   Enable (*NF_CALL_IPTABLES* > 0) or disable (*NF_CALL_IPTABLES* == 0)
> + *   iptables hooks on the bridge.
> + *
> + * @IFLA_BR_NF_CALL_IP6TABLES
> + *   Enable (*NF_CALL_IP6TABLES* > 0) or disable (*NF_CALL_IP6TABLES* == 0)
> + *   ip6tables hooks on the bridge.
> + *
> + * @IFLA_BR_NF_CALL_ARPTABLES
> + *   Enable (*NF_CALL_ARPTABLES* > 0) or disable (*NF_CALL_ARPTABLES* == 0)
> + *   arptables hooks on the bridge.
> + *
> + * @IFLA_BR_VLAN_DEFAULT_PVID
> + *   The default PVID (native/untagged VLAN ID) for this bridge.
> + *
> + * @IFLA_BR_PAD
> + *   Bridge attribute padding type for netlink message.
> + *
> + * @IFLA_BR_VLAN_STATS_ENABLED
> + *   Enable (*IFLA_BR_VLAN_STATS_ENABLED* == 1) or disable
> + *   (*IFLA_BR_VLAN_STATS_ENABLED* == 0) per-VLAN stats accounting.
> + *
> + * @IFLA_BR_MCAST_STATS_ENABLED
> + *   Enable (*IFLA_BR_MCAST_STATS_ENABLED* > 0) or disable
> + *   (*IFLA_BR_MCAST_STATS_ENABLED* == 0) multicast (IGMP/MLD) stats
> + *   accounting.
> + *
> + * @IFLA_BR_MCAST_IGMP_VERSION
> + *   Set the IGMP version.
> + *
> + *   The valid values are 2 and 3. The default value is 2.
> + *
> + * @IFLA_BR_MCAST_MLD_VERSION
> + *   Set the MLD version.
> + *
> + *   The valid values are 1 and 2. The default value is 1.
> + *
> + * @IFLA_BR_VLAN_STATS_PER_PORT
> + *   Enable (*IFLA_BR_VLAN_STATS_PER_PORT* == 1) or disable
> + *   (*IFLA_BR_VLAN_STATS_PER_PORT* == 0) per-VLAN per-port stats accounting.
> + *   Can be changed only when there are no port VLANs configured.
> + *
> + * @IFLA_BR_MULTI_BOOLOPT
> + *   Bridge multi bool options, need combine with enum br_boolopt_id.

?? This one is unclear. The multi_boolopt is used to control new boolean
options to avoid adding new netlink attributes. The bridge is the
largest netlink option user and we're trying to limit the maximum
netlink option type (RTNL_MAX_TYPE).

> + *
> + * @IFLA_BR_MCAST_QUERIER_STATE
> + *   Bridge mcast querier states, only readable from kernel.
> + */
> +
>   enum {
>   	IFLA_BR_UNSPEC,
>   	IFLA_BR_FORWARD_DELAY,
> @@ -520,11 +752,233 @@ struct ifla_bridge_id {
>   	__u8	addr[6]; /* ETH_ALEN */
>   };
>   
> +/**
> + * BRIDGE_MODE_HAIRPIN
> + *   Controls whether traffic may be send back out of the port on which it
> + *   was received. This option is also called reflective relay mode, and is
> + *   used to support basic VEPA (Virtual Ethernet Port Aggregator)
> + *   capabilities. By default, this flag is turned off and the bridge will
> + *   not forward traffic back out of the receiving port.
> + */
> +
>   enum {
>   	BRIDGE_MODE_UNSPEC,
>   	BRIDGE_MODE_HAIRPIN,
>   };
>   
> +/**
> + * DOC: The bridge port emum defination

s/emum/enum/

> + *
> + * @IFLA_BRPORT_STATE
> + *   The operation state of the port. Except state 0 (disable STP or BPDU
> + *   filter feature), this is primarily used by user space STP/RSTP
> + *   implementation.
> + *
> + *     * 0 - port is in STP *DISABLED* state. Make this port completely
> + *       inactive for STP. This is also called BPDU filter and could be used
> + *       to disable STP on an untrusted port, like a leaf virtual devices.

It also stops traffic forwarding.

> + *     * 1 - port is in STP *LISTENING* state. Only valid if STP is enabled
> + *       on the bridge. In this state the port listens for STP BPDUs and
> + *       drops all other traffic frames.
> + *     * 2 - port is in STP *LEARNING* state. Only valid if STP is enabled on
> + *       the bridge. In this state the port will accept traffic only for the
> + *       purpose of updating MAC address tables.
> + *     * 3 - port is in STP *FORWARDING* state. Port is fully active.
> + *     * 4 - port is in STP *BLOCKING* state. Only valid if STP is enabled on
> + *       the bridge. This state is used during the STP election process.
> + *       In this state, port will only process STP BPDUs.
> + *
> + * @IFLA_BRPORT_PRIORITY
> + *   The STP port priority. The valid values are between 0 and 255.
> + *
> + * @IFLA_BRPORT_COST
> + *   The STP path cost of the port. The valid values are between 1 and 65535.
> + *
> + * @IFLA_BRPORT_MODE
> + *   Set the bridge port mode. See *BRIDGE_MODE_HAIRPIN* for more details.
> + *
> + * @IFLA_BRPORT_GUARD
> + *   Controls whether STP BPDUs will be processed by the bridge port. By
> + *   default, the flag is turned off allowed BPDU processing. Turning this
> + *   flag on will disables the bridge port if a STP BPDU packet is received.
> + *
> + *   If running Spanning Tree on bridge, hostile devices on the network may
> + *   send BPDU on a port and cause network failure. Setting *guard on* will
> + *   detect and stop this by disabling the port. The port will be restarted
> + *   if link is brought down, or removed and reattached.
> + *
> + * @IFLA_BRPORT_PROTECT
> + *   Controls whether a given port is allowed to become root port or not.
> + *   Only used when STP is enabled on the bridge. By default the flag is off.
> + *
> + *   This feature is also called root port guard. If BPDU is received from a
> + *   leaf (edge) port, it should not be elected as root port. This could
> + *   be used if using STP on a bridge and the downstream bridges are not fully
> + *   trusted; this prevents a hostile guest from rerouting traffic.
> + *
> + * @IFLA_BRPORT_FAST_LEAVE
> + *   This flag allows the bridge to immediately stop multicast traffic on a
> + *   port that receives IGMP Leave message. It is only used with IGMP snooping
> + *   is enabled on the bridge. By default the flag is off.
> + *
> + * @IFLA_BRPORT_LEARNING
> + *   Controls whether a given port will learn MAC addresses from received
> + *   traffic or not. If learning if off, the bridge will end up flooding any
> + *   traffic for which it has no FDB entry. By default this flag is on.
> + *
> + * @IFLA_BRPORT_UNICAST_FLOOD
> + *   Controls whether unicast traffic for which there is no FDB entry will
> + *   be flooded towards this given port. By default this flag is on.
> + *
> + * @IFLA_BRPORT_PROXYARP
> + *   Enable proxy ARP on this port.
> + *
> + * @IFLA_BRPORT_LEARNING_SYNC
> + *   Controls whether a given port will sync MAC addresses learned on device
> + *   port to bridge FDB.
> + *
> + * @IFLA_BRPORT_PROXYARP_WIFI
> + *   Enable proxy ARP on this port which meets extended requirements by
> + *   IEEE 802.11 and Hotspot 2.0 specifications.
> + *
> + * @IFLA_BRPORT_ROOT_ID
> + *
> + * @IFLA_BRPORT_BRIDGE_ID
> + *
> + * @IFLA_BRPORT_DESIGNATED_PORT
> + *
> + * @IFLA_BRPORT_DESIGNATED_COST
> + *
> + * @IFLA_BRPORT_ID
> + *
> + * @IFLA_BRPORT_NO
> + *
> + * @IFLA_BRPORT_TOPOLOGY_CHANGE_ACK
> + *
> + * @IFLA_BRPORT_CONFIG_PENDING
> + *
> + * @IFLA_BRPORT_MESSAGE_AGE_TIMER
> + *
> + * @IFLA_BRPORT_FORWARD_DELAY_TIMER
> + *
> + * @IFLA_BRPORT_HOLD_TIMER
> + *
> + * @IFLA_BRPORT_FLUSH
> + *   Flush bridge ports' fdb dynamic entries.
> + *
> + * @IFLA_BRPORT_MULTICAST_ROUTER
> + *   Configure this port for having multicast routers attached. A port with

The first sentence should be changed, maybe something like:
"Configure the port's multicast router presence" or
"Configure how the port detects multicast routers".

> + *   a multicast router will receive all multicast traffic.
> + *   The valid values are:
> + *
> + *     * 0 disable multicast routers on this port
> + *     * 1 let the system detect the presence of routers (default)
> + *     * 2 permanently enable multicast traffic forwarding on this port
> + *     * 3 enable multicast routers temporarily on this port, not depending
> + *         on incoming queries.
> + *
> + * @IFLA_BRPORT_PAD
> + *
> + * @IFLA_BRPORT_MCAST_FLOOD
> + *   Controls whether a given port will flood multicast traffic for which
> + *   there is no MDB entry. By default this flag is on.
> + *
> + * @IFLA_BRPORT_MCAST_TO_UCAST
> + *   Controls whether a given port will replicate packets using unicast
> + *   instead of multicast. By default this flag is off.
> + *
> + *   This is done by copying the packet per host and changing the multicast
> + *   destination MAC to a unicast one accordingly.
> + *
> + *   *mcast_to_unicast* works on top of the multicast snooping feature of the
> + *   bridge. Which means unicast copies are only delivered to hosts which
> + *   are interested in it and signalized this via IGMP/MLD reports previously.

interested in it? You should define "it". Also "signaled".

> + *
> + *   This feature is intended for interface types which have a more reliable
> + *   and/or efficient way to deliver unicast packets than broadcast ones
> + *   (e.g. WiFi).
> + *
> + *   However, it should only be enabled on interfaces where no IGMPv2/MLDv1
> + *   report suppression takes place. IGMP/MLD report suppression issue is
> + *   usually overcome by the network daemon (supplicant) enabling AP isolation
> + *   and by that separating all STAs.
> + *
> + *   Delivery of STA-to-STA IP multicast is made possible again by enabling
> + *   and utilizing the bridge hairpin mode, which considers the incoming port
> + *   as a potential outgoing port, too (see *BRIDGE_MODE_HAIRPIN* option).
> + *   Hairpin mode is performed after multicast snooping, therefore leading
> + *   to only deliver reports to STAs running a multicast router.
> + *
> + * @IFLA_BRPORT_VLAN_TUNNEL
> + *   Controls whether vlan to tunnel mapping is enabled on the port.
> + *   By default this flag is off.
> +*
> + * @IFLA_BRPORT_BCAST_FLOOD
> + *   Controls flooding of broadcast traffic on the given port. By default
> + *   this flag is on.
> + *
> + * @IFLA_BRPORT_GROUP_FWD_MASK
> + *   Set the group forward mask. This is the bitmask that is applied to

"a bitmask"

> + *   decide whether to forward incoming frames destined to link-local
> + *   addresses, ie addresses of the form 01:80:C2:00:00:0X (defaults to 0,

i.e.

> + *   ie the bridge does not forward any linklocal frames coming on this port).

s/ie/which means/
s/linklocal/link-local/

> + *
> + * @IFLA_BRPORT_NEIGH_SUPPRESS
> + *   Controls whether neigh discovery (arp and nd) proxy and suppression
> + *   is enabled on the port. By default this flag is off.

neighbor

> + *
> + * @IFLA_BRPORT_ISOLATED
> + *   Controls whether a given port will be isolated, which means it will be
> + *   able to communicate with non-isolated ports only. By default this
> + *   flag is off.
> + *
> + * @IFLA_BRPORT_BACKUP_PORT
> + *   Enable or disable the port backup. If the port loses carrier all
> + *   traffic will be redirected to the configured backup port.

"Set a backup port", then mention what value disables it.

> + *
> + * @IFLA_BRPORT_MRP_RING_OPEN
> + *
> + * @IFLA_BRPORT_MRP_IN_OPEN
> + *
> + * @IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT
> + *
> + * @IFLA_BRPORT_MCAST_EHT_HOSTS_CNT
> + *
> + * @IFLA_BRPORT_LOCKED
> + *   Controls whether a port will be locked, meaning that hosts behind the
> + *   port will not be able to communicate through the port unless an FDB
> + *   entry with the units MAC address is in the FDB. The common use is that

use case

> + *   hosts are allowed access through authentication with the IEEE 802.1X
> + *   protocol or based on whitelists or like setups. By default this flag is

remove "or like setups"

> + *   off.
> + *
> + * @IFLA_BRPORT_MAB
> + *
> + * @IFLA_BRPORT_MCAST_N_GROUPS
> + *
> + * @IFLA_BRPORT_MCAST_MAX_GROUPS
> + *   Sets the maximum number of MDB entries that can be registered for a
> + *   given port. Attempts to register more MDB entries at the port than this
> + *   limit allows will be rejected, whether they are done through netlink
> + *   (e.g. the bridge tool), or IGMP or MLD membership reports. Setting a
> + *   limit to 0 has the effect of disabling the limit.

remove "has the effect of", and say "disables the limit" or "removes the
limit".

> + *
> + *   The default value is 0.
> + *
> + * @IFLA_BRPORT_NEIGH_VLAN_SUPPRESS
> + *   Controls whether neigh discovery (arp and nd) proxy and suppression is

neighbor

> + *   enabled for a given VLAN on a given port. By default this flag is off.
> + *
> + *   Note that this option only takes effect when *IFLA_BRPORT_NEIGH_SUPPRESS*
> + *   is enabled for a given port.
> + *
> + * @IFLA_BRPORT_BACKUP_NHID
> + *   The FDB nexthop object ID to attach to packets being redirected to a
> + *   backup port that has VLAN tunnel mapping enabled (via the
> + *   *IFLA_BRPORT_VLAN_TUNNEL* option). Setting a value of 0 (default) has
> + *   the effect of not attaching any ID.
> + */
> +
>   enum {
>   	IFLA_BRPORT_UNSPEC,
>   	IFLA_BRPORT_STATE,	/* Spanning tree state     */
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index ea733542244c..b43492789c44 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -933,6 +933,100 @@ static ssize_t vlan_stats_per_port_store(struct device *d,
>   static DEVICE_ATTR_RW(vlan_stats_per_port);
>   #endif
>   
> +
> +/**
> + * DOC: The sysfs bridge attrs
> + *
> + * @forward_delay: IFLA_BR_FORWARD_DELAY
> + *
> + * @hello_time: IFLA_BR_HELLO_TIME
> + *
> + * @max_age: IFLA_BR_MAX_AGE
> + *
> + * @ageing_time: IFLA_BR_AGEING_TIME
> + *
> + * @stp_state: IFLA_BR_STP_STATE
> + *
> + * @group_fwd_mask: IFLA_BR_GROUP_FWD_MASK
> + *
> + * @priority: IFLA_BR_PRIORITY
> + *
> + * @bridge_id: IFLA_BR_BRIDGE_ID
> + *
> + * @root_id: IFLA_BR_ROOT_ID
> + *
> + * @root_path_cost: IFLA_BR_ROOT_PATH_COST
> + *
> + * @root_port: IFLA_BR_ROOT_PORT
> + *
> + * @topology_change: IFLA_BR_TOPOLOGY_CHANGE
> + *
> + * @topology_change_detected: IFLA_BR_TOPOLOGY_CHANGE_DETECTED
> + *
> + * @hello_timer: IFLA_BR_HELLO_TIMER
> + *
> + * @tcn_timer: IFLA_BR_TCN_TIMER
> + *
> + * @topology_change_timer: IFLA_BR_TOPOLOGY_CHANGE_TIMER
> + *
> + * @gc_timer: IFLA_BR_GC_TIMER
> + *
> + * @group_addr: IFLA_BR_GROUP_ADDR
> + *
> + * @flush: IFLA_BR_FDB_FLUSH
> + *
> + * @no_linklocal_learn: BR_BOOLOPT_NO_LL_LEARN
> + *
> + * @multicast_router: IFLA_BR_MCAST_ROUTER
> + *
> + * @multicast_snooping: IFLA_BR_MCAST_SNOOPING
> + *
> + * @multicast_querier: IFLA_BR_MCAST_QUERIER
> + *
> + * @multicast_query_use_ifaddr: IFLA_BR_MCAST_QUERY_USE_IFADDR
> + *
> + * @hash_elasticity: IFLA_BR_MCAST_HASH_ELASTICITY
> + *
> + * @hash_max: IFLA_BR_MCAST_HASH_MAX
> + *
> + * @multicast_last_member_count: IFLA_BR_MCAST_LAST_MEMBER_CNT
> + *
> + * @multicast_startup_query_count: IFLA_BR_MCAST_STARTUP_QUERY_CNT
> + *
> + * @multicast_last_member_interval: IFLA_BR_MCAST_LAST_MEMBER_INTVL
> + *
> + * @multicast_membership_interval: IFLA_BR_MCAST_MEMBERSHIP_INTVL
> + *
> + * @multicast_querier_interval: IFLA_BR_MCAST_QUERIER_INTVL
> + *
> + * @multicast_query_interval: IFLA_BR_MCAST_QUERY_INTVL
> + *
> + * @multicast_query_response_interval: IFLA_BR_MCAST_QUERY_RESPONSE_INTVL
> + *
> + * @multicast_startup_query_interval: IFLA_BR_MCAST_STARTUP_QUERY_INTVL
> + *
> + * @multicast_stats_enabled: IFLA_BR_MCAST_STATS_ENABLED
> + *
> + * @multicast_igmp_version: IFLA_BR_MCAST_IGMP_VERSION
> + *
> + * @multicast_mld_version: IFLA_BR_MCAST_MLD_VERSION
> + *
> + * @nf_call_iptables: IFLA_BR_NF_CALL_IPTABLES
> + *
> + * @nf_call_ip6tables: IFLA_BR_NF_CALL_IP6TABLES
> + *
> + * @nf_call_arptables: IFLA_BR_NF_CALL_ARPTABLES
> + *
> + * @vlan_filtering: IFLA_BR_VLAN_FILTERING
> + *
> + * @vlan_protocol: IFLA_BR_VLAN_PROTOCOL
> + *
> + * @default_pvid: IFLA_BR_VLAN_DEFAULT_PVID
> + *
> + * @vlan_stats_enabled: IFLA_BR_VLAN_STATS_ENABLED
> + *
> + * @vlan_stats_per_port: IFLA_BR_VLAN_STATS_PER_PORT
> + */
>   static struct attribute *bridge_attrs[] = {
>   	&dev_attr_forward_delay.attr,
>   	&dev_attr_hello_time.attr,

Thanks,
  Nik

