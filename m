Return-Path: <netdev+bounces-262188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC4iNxddo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:24:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553B1C9017
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B857E3608C4B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2A4BCAB8;
	Sat, 28 Feb 2026 17:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB84BC03C
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301363; cv=none; b=tbrMyMcUPlfHK2ZuwIxjFM3m1fe2E9OPTwss4H8l/kGk1RIURKEWA8UZpv5RmFnvsCdNHLsKp6BzcEIRLuMtH8MKX8ASxw6/ei0Dh+AB6iCmIwg/Ni2qAogaGiSUgxnpK0f3MaU5oLt/8jCCqHp+S1tQVRqIwqGbjrx6aLMV8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301363; c=relaxed/simple;
	bh=y7HFRTf+VRUMFbRUs3H8ApQKE1pQJOQx9pm4xYWtQS0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C4z7JKQ9CiZWF97aKYUehbNvWD7uGSNs6woDnsuQnVnjiYQahoxvH0YcH+J//O9+EO2nPLF6Vs99Ze/nhWfLu4DRvH+S/V2wIjO9kSwIP2usUDKYcsYZcHMmzkYPcmhgMn9zQOf6GVCal6Pdesu5hEQRRUfN3Fzf3sYHjWZkmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso20784135e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772301359; x=1772906159;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVOfXFkW9qUlDICje5YC3TLYE3k9aMBBe3oPS4yXVMc=;
        b=Kdv3+9iH93VULXHIthUkBeiAz6GWHWv3BhIKOjmxW89ghbIwhkHZZ6yvtdbdWf18En
         4EnjLXHBOkJUfX1RXhtNemOpJ12Jn17Yh1elJ73GhGDHhht9ePhuNrAprWuFh/6h7gXx
         ZQyD3nrXTbN0d1UePQ0PW0xcZjzNAq3w1UKNzoJx9TEh0nwMeDaOqK+yl4K9NU4ORnFk
         ZIj7GhCie85Alj1lbLfuxwT6X5XBV4imykNsCQsd/tPzMixg0+/65mg7O0a8uRV5oG1/
         QE520U61fW4HltBq+TfXWihCv8A0pJHfF0zpBmOz0lFvUJnSYfaC0LtB3GRErRofECky
         +cxw==
X-Forwarded-Encrypted: i=1; AJvYcCU3/eaDaSbL+o1IcNo1G2n0jdspwtXtGN3NNWZ/dBlWhTqd+rc5p36VEQ2CAd8zvJQbpURW8lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDb+OMUwFiQjY7ifzdMIg/OUWEtJ5wzNNsQU6l1X5D9gba42wW
	o6ryoos/jLSueLYiouX68wDH6AlPgZpkF9wt1xaKf9ixgjvBTFT2ZBC2
X-Gm-Gg: ATEYQzwdUPNXes3Ka6ZLOiRKDawZadZ2bvUa5ryLqE3/NQarxMCEqeVzitC2cX2rBoo
	D4hSuzzxBwd9vjXZT7cL785CGHBzZgvTCXG4MUeb/uvPPpzThjEXST78biQTZHMWXDDD+w3HgZs
	JvypCAN2Azgn37/AQ+kOzcKA5wIlKzcA/B68tKS34ZIuRa/hBwpBmhmEe2E8IeOcFiJNE7IKZzT
	jiuOvAKvIrFk19MGMvJgWzuwqEOGaz3BRJ89uIJDK6u6vDg7qPMl3BtYhGOeRAB9kKa+WeT70RA
	I7SR2eBBypk1hJgaUufITSV85CtKeZ4PDzpUgJLBREiFp6NuBVAhv+h4OrDccrYw5pK+CZ+7jhN
	MlF+0VN8zaWYGQf0hR/4F7YhJd3XFFlZweQ5R6X4Sx5MuDH7roXGYDZ1RAtD/9Nu+OtvNkMl1Fw
	XeUAj1jxDVdzuW9Xhpa6mAou3zJeGl6DUkfW3Hzi46zckzMeiCv4o3Q0mHEk0=
X-Received: by 2002:a05:600c:8b5b:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-483c990c263mr133071915e9.7.1772301359298;
        Sat, 28 Feb 2026 09:55:59 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770e7sm194452885e9.9.2026.02.28.09.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 09:55:58 -0800 (PST)
Message-ID: <4bf254a7-8e4c-4436-befb-1e0a2835100d@ovn.org>
Date: Sat, 28 Feb 2026 18:55:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org
Subject: Re: [PATCH net v2] net: openvswitch: clean up some kernel-doc
 warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
References: <20260228010058.2385110-1-rdunlap@infradead.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260228010058.2385110-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-262188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvswitch.org:email,infradead.org:email,ovn.org:mid,ovn.org:email]
X-Rspamd-Queue-Id: 3553B1C9017
X-Rspamd-Action: no action

On 2/28/26 2:00 AM, Randy Dunlap wrote:
> Fix some kernel-doc warnings in openvswitch.h:
> 
> Mark enum placeholders that are not used as "private" so that kernel-doc
> comments are not needed for them.
> 
> Correct names for 2 enum values:
> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>  '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>  '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'
> 
> Convert one comment from "/**" kernel-doc to a plain C "/*" comment:
> Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
>  '/**', but isn't a kernel-doc comment.
>  * Omit attributes for notifications.
> 
> Add more kernel-doc:
> - add kernel-doc for kernel-only enums;
> - add missing kernel-doc for enum ovs_datapath_attr;
> - add missing kernel-doc for enum ovs_flow_attr;
> - add missing kernel-doc for enum ovs_sample_attr;
> - add kernel-doc for enum ovs_check_pkt_len_attr;
> - add kernel-doc for enum ovs_action_attr;
> - add kernel-doc for enum ovs_action_push_eth;
> - add kernel-doc for enum ovs_vport_attr;
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: correct -net to net for tree destination/designation;
>     add more kernel-doc for various enums;
> 
> Cc: Aaron Conole <aconole@redhat.com>
> Cc: Eelco Chaudron <echaudro@redhat.com>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: dev@openvswitch.org
> 
>  include/uapi/linux/openvswitch.h |   72 ++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 7 deletions(-)
> 
> --- linux-next-20260227.orig/include/uapi/linux/openvswitch.h
> +++ linux-next-20260227/include/uapi/linux/openvswitch.h
> @@ -70,12 +70,14 @@ enum ovs_datapath_cmd {
>   * set on the datapath port (for OVS_ACTION_ATTR_MISS).  Only valid on
>   * %OVS_DP_CMD_NEW requests. A value of zero indicates that upcalls should
>   * not be sent.
> + * @OVS_DP_ATTR_MASKS_CACHE_SIZE: Size of the flow table masks cache (bytes).

This one is not in bytes, it's number or cache entries.  See the
net/openvswitch/flow_table.c:tbl_mask_cache_alloc().

>   * @OVS_DP_ATTR_PER_CPU_PIDS: Per-cpu array of PIDs for upcalls when
>   * OVS_DP_F_DISPATCH_UPCALL_PER_CPU feature is set.
>   * @OVS_DP_ATTR_STATS: Statistics about packets that have passed through the
>   * datapath.  Always present in notifications.
>   * @OVS_DP_ATTR_MEGAFLOW_STATS: Statistics about mega flow masks usage for the
>   * datapath. Always present in notifications.
> + * @OVS_DP_ATTR_USER_FEATURES: OVS_DP_F_* flags.
>   * @OVS_DP_ATTR_IFINDEX: Interface index for a new datapath netdev. Only
>   * valid for %OVS_DP_CMD_NEW requests.
>   *
> @@ -83,18 +85,23 @@ enum ovs_datapath_cmd {
>   * payload for %OVS_DP_* commands.
>   */
>  enum ovs_datapath_attr {
> +	/* private: */
>  	OVS_DP_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_DP_ATTR_NAME,		/* name of dp_ifindex netdev */
>  	OVS_DP_ATTR_UPCALL_PID,		/* Netlink PID to receive upcalls */
>  	OVS_DP_ATTR_STATS,		/* struct ovs_dp_stats */
>  	OVS_DP_ATTR_MEGAFLOW_STATS,	/* struct ovs_dp_megaflow_stats */
>  	OVS_DP_ATTR_USER_FEATURES,	/* OVS_DP_F_*  */
> +	/* private: */
>  	OVS_DP_ATTR_PAD,
> +	/* public: */
>  	OVS_DP_ATTR_MASKS_CACHE_SIZE,
>  	OVS_DP_ATTR_PER_CPU_PIDS,   /* Netlink PIDS to receive upcalls in
>  				     * per-cpu dispatch mode
>  				     */
>  	OVS_DP_ATTR_IFINDEX,
> +	/* private: */
>  	__OVS_DP_ATTR_MAX
>  };
>  
> @@ -181,6 +188,7 @@ enum ovs_packet_cmd {
>   * %OVS_USERSPACE_ATTR_EGRESS_TUN_PORT attribute, which is sent only if the
>   * output port is actually a tunnel port. Contains the output tunnel key
>   * extracted from the packet as nested %OVS_TUNNEL_KEY_ATTR_* attributes.
> + * @OVS_PACKET_ATTR_PROBE: Packet operation is a feature probe.
>   * @OVS_PACKET_ATTR_MRU: Present for an %OVS_PACKET_CMD_ACTION and
>   * @OVS_PACKET_ATTR_LEN: Packet size before truncation.
>   * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received fragment
> @@ -196,21 +204,26 @@ enum ovs_packet_cmd {
>   * payload for %OVS_PACKET_* commands.
>   */
>  enum ovs_packet_attr {
> +	/* private: */
>  	OVS_PACKET_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_PACKET_ATTR_PACKET,      /* Packet data. */
>  	OVS_PACKET_ATTR_KEY,         /* Nested OVS_KEY_ATTR_* attributes. */
>  	OVS_PACKET_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. */
>  	OVS_PACKET_ATTR_USERDATA,    /* OVS_ACTION_ATTR_USERSPACE arg. */
>  	OVS_PACKET_ATTR_EGRESS_TUN_KEY,  /* Nested OVS_TUNNEL_KEY_ATTR_*
>  					    attributes. */
> +	/* private: */
>  	OVS_PACKET_ATTR_UNUSED1,
>  	OVS_PACKET_ATTR_UNUSED2,
> +	/* public: */
>  	OVS_PACKET_ATTR_PROBE,      /* Packet operation is a feature probe,
>  				       error logging should be suppressed. */
>  	OVS_PACKET_ATTR_MRU,	    /* Maximum received IP fragment size. */
>  	OVS_PACKET_ATTR_LEN,	    /* Packet size before truncation. */
>  	OVS_PACKET_ATTR_HASH,	    /* Packet hash. */
>  	OVS_PACKET_ATTR_UPCALL_PID, /* u32 Netlink PID. */
> +	/* private: */
>  	__OVS_PACKET_ATTR_MAX
>  };
>  
> @@ -257,6 +270,10 @@ enum ovs_vport_type {
>   * upcalls should not be sent.
>   * @OVS_VPORT_ATTR_STATS: A &struct ovs_vport_stats giving statistics for
>   * packets sent or received through the vport.
> + * @OVS_VPORT_ATTR_IFINDEX: Get the vport ifindex or put the desired ifindex

May want to clarify that a desired ifindex can only be requested for the
vport type %OVS_VPORT_TYPE_INTERNAL.

> + * @OVS_VPORT_ATTR_NETNSID: Get the vport id of a peer netns. If there isn't
> + * one, a new netns is allocated.

'vport id of a peer netns' is confusing.  It'd say 'netns id of the vport,
if it's not local'.  The allocation part is an internal detail, I don't
think we need to document that.

> + * @OVS_VPORT_ATTR_UPCALL_STATS: Provides upcall stats for a device.

s/device/vport/
s/stats/statistics/

But also, this one contains nested %OVS_VPORT_UPCALL_ATTR_* attributes.

>   *
>   * These attributes follow the &struct ovs_header within the Generic Netlink
>   * payload for %OVS_VPORT_* commands.
> @@ -272,7 +289,9 @@ enum ovs_vport_type {
>   * ovs_header plus %OVS_VPORT_ATTR_PORT_NO determine the vport.
>   */
>  enum ovs_vport_attr {
> +	/* private: */
>  	OVS_VPORT_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_VPORT_ATTR_PORT_NO,	/* u32 port number within datapath */
>  	OVS_VPORT_ATTR_TYPE,	/* u32 OVS_VPORT_TYPE_* constant. */
>  	OVS_VPORT_ATTR_NAME,	/* string name, up to IFNAMSIZ bytes long */
> @@ -280,10 +299,13 @@ enum ovs_vport_attr {
>  	OVS_VPORT_ATTR_UPCALL_PID, /* array of u32 Netlink socket PIDs for */
>  				/* receiving upcalls */
>  	OVS_VPORT_ATTR_STATS,	/* struct ovs_vport_stats */
> +	/* private: */
>  	OVS_VPORT_ATTR_PAD,
> +	/* public: */
>  	OVS_VPORT_ATTR_IFINDEX,
>  	OVS_VPORT_ATTR_NETNSID,
>  	OVS_VPORT_ATTR_UPCALL_STATS,
> +	/* private: */
>  	__OVS_VPORT_ATTR_MAX
>  };
>  
> @@ -291,12 +313,13 @@ enum ovs_vport_attr {
>  
>  /**
>   * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_UPCALL* commands

Not a problem of this patch, but this line is also wrong, there are no
such commands.  These are attributes for OVS_VPORT_ATTR_UPCALL_STATS.

> - * @OVS_VPORT_UPCALL_SUCCESS: 64-bit upcall success packets.
> - * @OVS_VPORT_UPCALL_FAIL: 64-bit upcall fail packets.
> + * @OVS_VPORT_UPCALL_ATTR_SUCCESS: 64-bit upcall success packets.
> + * @OVS_VPORT_UPCALL_ATTR_FAIL: 64-bit upcall fail packets.
>   */
>  enum ovs_vport_upcall_attr {
>  	OVS_VPORT_UPCALL_ATTR_SUCCESS,
>  	OVS_VPORT_UPCALL_ATTR_FAIL,
> +	/* private: */
>  	__OVS_VPORT_UPCALL_ATTR_MAX
>  };
>  
> @@ -431,6 +454,7 @@ enum ovs_frag_type {
>  	OVS_FRAG_TYPE_NONE,
>  	OVS_FRAG_TYPE_FIRST,
>  	OVS_FRAG_TYPE_LATER,
> +	/* private: */
>  	__OVS_FRAG_TYPE_MAX
>  };
>  
> @@ -604,6 +628,8 @@ struct ovs_nsh_key_md1 {
>   * a wildcarded match. Omitting attribute is treated as wildcarding all
>   * corresponding fields. Optional for all requests. If not present,
>   * all flow key bits are exact match bits.
> + * @OVS_FLOW_ATTR_PROBE: Flow operation is a feature probe, error logging
> + * should be suppressed.
>   * @OVS_FLOW_ATTR_UFID: A value between 1-16 octets specifying a unique
>   * identifier for the flow. Causes the flow to be indexed by this value rather
>   * than the value of the %OVS_FLOW_ATTR_KEY attribute. Optional for all
> @@ -617,7 +643,9 @@ struct ovs_nsh_key_md1 {
>   * payload for %OVS_FLOW_* commands.
>   */
>  enum ovs_flow_attr {
> +	/* private: */
>  	OVS_FLOW_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_FLOW_ATTR_KEY,       /* Sequence of OVS_KEY_ATTR_* attributes. */
>  	OVS_FLOW_ATTR_ACTIONS,   /* Nested OVS_ACTION_ATTR_* attributes. */
>  	OVS_FLOW_ATTR_STATS,     /* struct ovs_flow_stats. */
> @@ -629,13 +657,14 @@ enum ovs_flow_attr {
>  				  * logging should be suppressed. */
>  	OVS_FLOW_ATTR_UFID,      /* Variable length unique flow identifier. */
>  	OVS_FLOW_ATTR_UFID_FLAGS,/* u32 of OVS_UFID_F_*. */
> +	/* private: */
>  	OVS_FLOW_ATTR_PAD,
>  	__OVS_FLOW_ATTR_MAX
>  };
>  
>  #define OVS_FLOW_ATTR_MAX (__OVS_FLOW_ATTR_MAX - 1)
>  
> -/**
> +/*
>   * Omit attributes for notifications.
>   *
>   * If a datapath request contains an %OVS_UFID_F_OMIT_* flag, then the datapath
> @@ -652,6 +681,8 @@ enum ovs_flow_attr {
>   * %UINT32_MAX samples all packets and intermediate values sample intermediate
>   * fractions of packets.
>   * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
> + * @OVS_SAMPLE_ATTR_ARG: same as @OVS_SAMPLE_ATTR_PROBABILITY, for in-kernel
> + * use, passing &struct sample_arg.

I wouldn't call it 'the same', more like 'extended', or just omit that part of
the description, keeping only what's after the comma.  Or maybe "For in-kernel
use, passing &struct sample_arg derived from other attributes.".

>   * Actions are passed as nested attributes.

This line belongs to OVS_SAMPLE_ATTR_ACTIONS.

>   *
>   * Executes the specified actions with the given probability on a per-packet
> @@ -659,11 +690,15 @@ enum ovs_flow_attr {
>   * parent @OVS_ACTION_ATTR_SAMPLE.
>   */
>  enum ovs_sample_attr {
> +	/* private: */
>  	OVS_SAMPLE_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_SAMPLE_ATTR_PROBABILITY, /* u32 number */
>  	OVS_SAMPLE_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. */
> +	/* private: */
>  	__OVS_SAMPLE_ATTR_MAX,
>  
> +	/* public: */
>  #ifdef __KERNEL__
>  	OVS_SAMPLE_ATTR_ARG          /* struct sample_arg  */
>  #endif
> @@ -693,12 +728,15 @@ struct sample_arg {
>   * @OVS_USERSPACE_ATTR_ACTIONS: If present, send actions with upcall.
>   */
>  enum ovs_userspace_attr {
> +	/* private: */
>  	OVS_USERSPACE_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_USERSPACE_ATTR_PID,	      /* u32 Netlink PID to receive upcalls. */
>  	OVS_USERSPACE_ATTR_USERDATA,  /* Optional user-specified cookie. */
>  	OVS_USERSPACE_ATTR_EGRESS_TUN_PORT,  /* Optional, u32 output port
>  					      * to get tunnel info. */
>  	OVS_USERSPACE_ATTR_ACTIONS,   /* Optional flag to get actions. */
> +	/* private: */
>  	__OVS_USERSPACE_ATTR_MAX
>  };
>  
> @@ -819,7 +857,9 @@ struct ovs_action_hash {
>   * @OVS_CT_ATTR_TIMEOUT: Variable length string defining conntrack timeout.
>   */
>  enum ovs_ct_attr {
> +	/* private: */
>  	OVS_CT_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_CT_ATTR_COMMIT,     /* No argument, commits connection. */
>  	OVS_CT_ATTR_ZONE,       /* u16 zone id. */
>  	OVS_CT_ATTR_MARK,       /* mark to associate with this connection. */
> @@ -831,6 +871,7 @@ enum ovs_ct_attr {
>  	OVS_CT_ATTR_EVENTMASK,  /* u32 mask of IPCT_* events. */
>  	OVS_CT_ATTR_TIMEOUT,	/* Associate timeout with this connection for
>  				 * fine-grain timeout tuning. */
> +	/* private: */
>  	__OVS_CT_ATTR_MAX
>  };
>  
> @@ -859,7 +900,9 @@ enum ovs_ct_attr {
>   * @OVS_NAT_ATTR_PROTO_RANDOM: Flag for fully randomized L4 port mapping
>   */
>  enum ovs_nat_attr {
> +	/* private: */
>  	OVS_NAT_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_NAT_ATTR_SRC,
>  	OVS_NAT_ATTR_DST,
>  	OVS_NAT_ATTR_IP_MIN,
> @@ -869,38 +912,44 @@ enum ovs_nat_attr {
>  	OVS_NAT_ATTR_PERSISTENT,
>  	OVS_NAT_ATTR_PROTO_HASH,
>  	OVS_NAT_ATTR_PROTO_RANDOM,
> +	/* private: */
>  	__OVS_NAT_ATTR_MAX,
>  };
>  
>  #define OVS_NAT_ATTR_MAX (__OVS_NAT_ATTR_MAX - 1)
>  
> -/*
> +/**
>   * struct ovs_action_push_eth - %OVS_ACTION_ATTR_PUSH_ETH action argument.
>   * @addresses: Source and destination MAC addresses.
> - * @eth_type: Ethernet type
>   */
>  struct ovs_action_push_eth {
>  	struct ovs_key_ethernet addresses;
>  };
>  
> -/*
> +/**
>   * enum ovs_check_pkt_len_attr - Attributes for %OVS_ACTION_ATTR_CHECK_PKT_LEN.
>   *
>   * @OVS_CHECK_PKT_LEN_ATTR_PKT_LEN: u16 Packet length to check for.
>   * @OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_GREATER: Nested OVS_ACTION_ATTR_*
>   * actions to apply if the packer length is greater than the specified
>   * length in the attr - OVS_CHECK_PKT_LEN_ATTR_PKT_LEN.
> - * @OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_LESS_EQUAL - Nested OVS_ACTION_ATTR_*
> + * @OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_LESS_EQUAL: Nested OVS_ACTION_ATTR_*
>   * actions to apply if the packer length is lesser or equal to the specified
>   * length in the attr - OVS_CHECK_PKT_LEN_ATTR_PKT_LEN.
> + * @OVS_CHECK_PKT_LEN_ATTR_ARG: similar to @OVS_CHECK_PKT_LEN_ATTR_PKT_LEN,
> + * used in-kernel, passes &struct check_pkt_len_arg.

Similar commenent as for OVS_SAMPLE_ATTR_ARG.

>   */
>  enum ovs_check_pkt_len_attr {
> +	/* private: */
>  	OVS_CHECK_PKT_LEN_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_CHECK_PKT_LEN_ATTR_PKT_LEN,
>  	OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_GREATER,
>  	OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_LESS_EQUAL,
> +	/* private: */
>  	__OVS_CHECK_PKT_LEN_ATTR_MAX,
>  
> +	/* public: */
>  #ifdef __KERNEL__
>  	OVS_CHECK_PKT_LEN_ATTR_ARG          /* struct check_pkt_len_arg  */
>  #endif
> @@ -968,6 +1017,10 @@ enum ovs_psample_attr {
>   * from the packet.
>   * @OVS_ACTION_ATTR_SAMPLE: Probabilitically executes actions, as specified in
>   * the nested %OVS_SAMPLE_ATTR_* attributes.
> + * @OVS_ACTION_ATTR_RECIRC: Execute actions on the clone of the packet
> + * (u32 recirc_id).

I'd say "Recirculate the clone of the packet through the datapath with the new id".

> + * @OVS_ACTION_ATTR_HASH: Compute hash prior to recirculation, using
> + * &struct ovs_action_hash.

s/Compute hash prior to recirculation/Compute the packet hash/
or something like that.  The action itself is not tied to recirculation,
even though it's most commonly used together with it.

>   * @OVS_ACTION_ATTR_PUSH_MPLS: Push a new MPLS label stack entry onto the
>   * top of the packets MPLS label stack.  Set the ethertype of the
>   * encapsulating frame to either %ETH_P_MPLS_UC or %ETH_P_MPLS_MC to
> @@ -997,6 +1050,7 @@ enum ovs_psample_attr {
>   * start of the packet or at the start of the l3 header depending on the value
>   * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
>   * argument.
> + * @OVS_ACTION_ATTR_DEC_TTL: Nested OVS_DEC_TTL_ATTR_* action.

"Decreate TTL or hop limit of the packet.  Execute nested %OVS_DEC_TTL_ATTR_*
actions if the value is less or equal to 1."

>   * @OVS_ACTION_ATTR_DROP: Explicit drop action.
>   * @OVS_ACTION_ATTR_PSAMPLE: Send a sample of the packet to external observers
>   * via psample.
> @@ -1010,7 +1064,9 @@ enum ovs_psample_attr {
>   */
>  
>  enum ovs_action_attr {
> +	/* private: */
>  	OVS_ACTION_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_ACTION_ATTR_OUTPUT,	      /* u32 port number. */
>  	OVS_ACTION_ATTR_USERSPACE,    /* Nested OVS_USERSPACE_ATTR_*. */
>  	OVS_ACTION_ATTR_SET,          /* One nested OVS_KEY_ATTR_*. */
> @@ -1040,9 +1096,11 @@ enum ovs_action_attr {
>  	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
>  	OVS_ACTION_ATTR_PSAMPLE,      /* Nested OVS_PSAMPLE_ATTR_*. */
>  
> +	/* private: */
>  	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
>  				       * from userspace. */
>  
> +	/* public: */
>  #ifdef __KERNEL__
>  	OVS_ACTION_ATTR_SET_TO_MASKED, /* Kernel module internal masked
>  					* set action converted from


