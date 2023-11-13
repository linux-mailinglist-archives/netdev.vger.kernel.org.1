Return-Path: <netdev+bounces-47311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049B37E994B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BCC1C2042F
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE011A58D;
	Mon, 13 Nov 2023 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="rrupzoxD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E114AAA
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:44:28 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909A10D0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:44:26 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso639671466b.2
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699868665; x=1700473465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKZjtgpnnLQh+0V9JV6PvyamgQo+q0/U616zzLgd1z4=;
        b=rrupzoxDRI5Xuc+VCl2uVcB3eaKbb3wJ81HR+Jx0Sd6cnFnYWlB9Jq1gob2y6Y8dQJ
         1w9I+xUCPEADpfKPbYag0uXtGn2Vn97nVckaTzOHtMXOCLFn97bJ6k31vcGU0e2vpL3i
         /jO46TWmzNvtbL9m23ybcPKm0lHtvVwXYdlHnp5lgqGiFtqCFJThkI7oPNjWrhjfiAIb
         xXUJDmJfzGHL+RvC+EUok7eRCZiICP+RIbUSWYfZpbmU22bJSqi6jtSOrf2+6PCVye0I
         92SNZOSd+/BcTh5SpuSSJ1DBsWwfD+zCRkipJrjYItWP+3iJhjpWo0QoRmwHXsiKCVN2
         trcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699868665; x=1700473465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKZjtgpnnLQh+0V9JV6PvyamgQo+q0/U616zzLgd1z4=;
        b=P0n4WaJ8aia7QFBr8e5pInk91nXng87iwhadc1s8ieDmo2TJBfNzEntdJjiasz5miT
         pa85XkZdXpkY5HLaIE+91ebuT52EgRcW3Q+Uu3b1qdAw0YgxrLw3UrXeRSO0Pv3UPBhv
         1mwZeeWKCWKfMQqFx0WNIuhNYDi86WjhcAfdxFeuoI/SIP5cwO0/fx+QkBKUxsW1ycY/
         NCRev6U48egt+V6ydMvl2PMZd2RMsMlbkz50zoyE+i0L1xl/eRjphoWYaDcIueXTYHdG
         u35ksNOPh77MZkzGcEH59E0eekfilXjQvO4MF+4nfH+brjvbkqN4fLFkgAZ4O7S9oYa/
         KUsQ==
X-Gm-Message-State: AOJu0Yyp1mY/fTWziVkYYLuNM84/u7kH8hVDPDp7S34mNEOV3ipkliP/
	xbQWxEeqCHQiloZrWgtUnrKvmg==
X-Google-Smtp-Source: AGHT+IGvFxMwXnktXzma/iI+XYQlPU8iz2KySxCexac6BaFRQDD7rSoi/VhP1KYfxcxTa5YLtkzVUQ==
X-Received: by 2002:a17:906:3e50:b0:9e5:d867:ac72 with SMTP id t16-20020a1709063e5000b009e5d867ac72mr3436436eji.77.1699868664808;
        Mon, 13 Nov 2023 01:44:24 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id kl10-20020a170907994a00b009e5fcdf77acsm3751031ejc.176.2023.11.13.01.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:44:24 -0800 (PST)
Message-ID: <32765b21-cab2-56f0-3e90-1f5d5c376280@blackwall.org>
Date: Mon, 13 Nov 2023 11:44:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 02/10] net: bridge: add document for
 IFLA_BRPORT enum
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-3-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231110101548.1900519-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 12:15, Hangbin Liu wrote:
> Add document for IFLA_BRPORT enum so we can use it in
> Documentation/networking/bridge.rst.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   include/uapi/linux/if_link.h | 227 +++++++++++++++++++++++++++++++++++
>   1 file changed, 227 insertions(+)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 32d6980b78d1..a196a6e4dafb 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -792,11 +792,238 @@ struct ifla_bridge_id {
>   	__u8	addr[6]; /* ETH_ALEN */
>   };
>   
> +/**
> + * DOC: The bridge mode enum defination

s/defination/definition/

drop "The", Bridge mode enum definition

> + *
> + * @BRIDGE_MODE_HAIRPIN
> + *   Controls whether traffic may be send back out of the port on which it
> + *   was received. This option is also called reflective relay mode, and is
> + *   used to support basic VEPA (Virtual Ethernet Port Aggregator)
> + *   capabilities. By default, this flag is turned off and the bridge will
> + *   not forward traffic back out of the receiving port.
> + */
> +

unnecessary newline

>   enum {
>   	BRIDGE_MODE_UNSPEC,
>   	BRIDGE_MODE_HAIRPIN,
>   };
>   
> +/**
> + * DOC: The bridge port enum defination

s/defination/definition/
drop "The"

> + *
> + * @IFLA_BRPORT_STATE
> + *   The operation state of the port. Except state 0 (disable STP or BPDU
> + *   filter feature), this is primarily used by user space STP/RSTP
> + *   implementation.

This is wrong, port states are used by the kernel STP implementation as 
well.

> + *
> + *     * 0 - port is in STP *DISABLED* state. Make this port completely
> + *       inactive for STP. This is also called BPDU filter and could be used
> + *       to disable STP on an untrusted port, like a leaf virtual devices.
> + *       The traffic forwarding is also stopped on this port.
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

s/allowed/to allow/

> + *   flag on will disables the bridge port if a STP BPDU packet is received.

s/disables/will disable/

> + *
> + *   If running Spanning Tree on bridge, hostile devices on the network may

"If the bridge has Spanning Tree enabled..."

> + *   send BPDU on a port and cause network failure. Setting *guard on* will
> + *   detect and stop this by disabling the port. The port will be restarted
> + *   if link is brought down, or removed and reattached.
> + *
> + * @IFLA_BRPORT_PROTECT
> + *   Controls whether a given port is allowed to become root port or not.

"a root port"

> + *   Only used when STP is enabled on the bridge. By default the flag is off.
> + *
> + *   This feature is also called root port guard. If BPDU is received from a
> + *   leaf (edge) port, it should not be elected as root port. This could
> + *   be used if using STP on a bridge and the downstream bridges are not fully
> + *   trusted; this prevents a hostile guest from rerouting traffic.
> + *
> + * @IFLA_BRPORT_FAST_LEAVE
> + *   This flag allows the bridge to immediately stop multicast traffic on a

multicast traffic forwarding

> + *   port that receives IGMP Leave message. It is only used with IGMP snooping
> + *   is enabled on the bridge. By default the flag is off.

It is only used when IGMP snooping is enabled

> + *
> + * @IFLA_BRPORT_LEARNING
> + *   Controls whether a given port will learn MAC addresses from received
> + *   traffic or not. If learning if off, the bridge will end up flooding any
> + *   traffic for which it has no FDB entry. By default this flag is on.

The second sentence is not necessary, that is the default behaviour
for unknown destinations whether learning is enabled or not, it has no
effect on it. You can mention that it learns source MAC addresses
explicitly.

> + *
> + * @IFLA_BRPORT_UNICAST_FLOOD
> + *   Controls whether unicast traffic for which there is no FDB entry will
> + *   be flooded towards this given port. By default this flag is on.

"... towards this port"

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
> + *   Configure the port's multicast router presence. A port with
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
> + *   are interested in unicast and signaled this via IGMP/MLD reports previously.
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
> + *
> + * @IFLA_BRPORT_BCAST_FLOOD
> + *   Controls flooding of broadcast traffic on the given port. By default
> + *   this flag is on.
> + *
> + * @IFLA_BRPORT_GROUP_FWD_MASK
> + *   Set the group forward mask. This is a bitmask that is applied to
> + *   decide whether to forward incoming frames destined to link-local
> + *   addresses. The addresses of the form are 01:80:C2:00:00:0X (defaults
> + *   to 0, which means the bridge does not forward any link-local frames
> + *   coming on this port).
> + *
> + * @IFLA_BRPORT_NEIGH_SUPPRESS
> + *   Controls whether neighbor discovery (arp and nd) proxy and suppression
> + *   is enabled on the port. By default this flag is off.
> + *
> + * @IFLA_BRPORT_ISOLATED
> + *   Controls whether a given port will be isolated, which means it will be
> + *   able to communicate with non-isolated ports only. By default this
> + *   flag is off.
> + *
> + * @IFLA_BRPORT_BACKUP_PORT
> + *   Set a backup port. If the port loses carrier all traffic will be
> + *   redirected to the configured backup port. Set the value to 0 to disable
> + *   it.
> + *
> + * @IFLA_BRPORT_MRP_RING_OPEN
> + *
> + * @IFLA_BRPORT_MRP_IN_OPEN
> + *
> + * @IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT
> + *   The number of per-port EHT hosts limit. The default value is 512.
> + *   Setting to 0 is not allowed.
> + *
> + * @IFLA_BRPORT_MCAST_EHT_HOSTS_CNT
> + *   The current number of tracked hosts, read only.
> + *
> + * @IFLA_BRPORT_LOCKED
> + *   Controls whether a port will be locked, meaning that hosts behind the
> + *   port will not be able to communicate through the port unless an FDB
> + *   entry with the units MAC address is in the FDB. The common use case is that
> + *   hosts are allowed access through authentication with the IEEE 802.1X
> + *   protocol or based on whitelists. By default this flag is off.
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
> + *   limit to 0 disables the limit. The default value is 0.

"Setting a limit of 0"

> + *
> + * @IFLA_BRPORT_NEIGH_VLAN_SUPPRESS
> + *   Controls whether neighbor discovery (arp and nd) proxy and suppression is
> + *   enabled for a given VLAN on a given port. By default this flag is off.

given VLAN? This is per-port, not per-vlan.

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


