Return-Path: <netdev+bounces-263210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KjAKbPlpmnjZAAAu9opvQ
	(envelope-from <netdev+bounces-263210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:44:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202571F0901
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45ED43075AB6
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A71258EE0;
	Tue,  3 Mar 2026 13:36:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A531DE8BB
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544995; cv=none; b=SmvokkXZrhc9jHTDTnAcVxTOFAKyo6sFxph3r5l0q7Oopb7qyOw5a5cEOXO6E7bXBjdYpXF+JwHO6kwrSIwiOrtWeOiOiINGgjTtRoTJtAV1BeqhAwaT0rjFgprw9yVms5NUjBgnHWnogoVdsGZd/wmFb41tAQ+ibfBtR/+yYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544995; c=relaxed/simple;
	bh=tCnqC+170NJFb/oOFJQ/CHcUJGs65+aWaHGP52a7jz4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fbygJbn3Yd5O/G+IG39MH7a3D0pM/G8/fqb3wnvnwxFl9ySnF8G6sAW54zb665B8i6gdzJR5RcIPIBO08IWSMTMf/OZJT0f8HZPGhLQ7pWD1VvuH+5R2TKpHYDlMXpHN/EflxRU+rZbqMMrXJJ/t4Tma6dxUnW9UQugLATDzjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-483703e4b08so51947785e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 05:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544993; x=1773149793;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5luiAfSAj/kG9+4CRrPULEuJaq0EdAn0SaqDgSj+ro=;
        b=qS5iunvpBmBAz2mG1UDI8jvRcyxsKVpmY7jO/EX95Rjd3H8YStSlOOJOhtfTLNqeHM
         pmHcm/OGo6AjCcZahSfHA/nOsZon3wrgDjQ2QTLpb8UJvdV/gAPzd8eIPElnjHHjFxZx
         oAmkBEVgCzxoylQ3moS8ajbVQS/v/StWaoaY0l+fDTijdtFlxr7eLFc+LZZS2ttZCmBU
         7O7omRo9CJKunP3+8VGKykJK2xeksQTSWnBGJh4RP6hf3QNq/3LAqXwrAEMnDnjuMSsZ
         lNRqWEMLeeVItZYvO1+wE8O/njGaxteDAzXiOPFRTsD+nnCg+cEjB5eOWK8KcaArxptJ
         YH+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3qUr4Gh+hTdDqJEwPqCYGc+9NPHxxg4eRG1FdYnB3NcaafArH1t1V71Gi4eHLUxWiUmiusjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+PwhtZlgzVI1z2AWFOu64srAWyUHMKPvtvayWEu23cyKBw1R
	RzgB9flKF3NzVPb+l35/zWY6iPY5o5Of5BYWv4A4ahQLmBrk5wguCABC
X-Gm-Gg: ATEYQzyYxxGJ3bY89DmBZM7DpMogZ6WC8mukg9IIIwfeYUEM5ezW7Pp2QlGEOdHULSJ
	3xXSuNSPPCIP84Ul1PE/h1CXNt645vuwb76bq8jxrj3Rq6sn4RuY/WulN525vmCvTxjD8VH4LPU
	actMgtLCd9vBgzHVeVyG6NrWMiPksVpS/LmEpFRhIfFIu866olia0z0JC+aDIwDJ2zwvcJPENc9
	fkQzl6k3LFhHPz51EhGCrZbheBX83Pmhysr/E8ft2CftlUkhrjriJBbjXT8YhbtWo1OZXIeRMD0
	FGFnBeeltvNt4AHtCEHLwr8SAxvEM51jgEV+m9iLmwJEL8hhIwR13SbChauEqBj8+Y1rWJmCf4C
	gmMfQ3W24iIC5sovcKt++ZTNPoE6G5nVyn33VyqV+WVNfzYvvAacPPy/uvtJmbqxvpqCtZ7mVwa
	IxQVXQ6wTTaqNmFWqrVpYhqWvcWE55XZBJA+Y23BNq2WKXfkLFkhoRQ34=
X-Received: by 2002:a05:600c:8b8b:b0:477:a53c:8ca1 with SMTP id 5b1f17b1804b1-48513e9cc65mr37605575e9.14.1772544992339;
        Tue, 03 Mar 2026 05:36:32 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b34b6252sm19043271f8f.10.2026.03.03.05.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 05:36:31 -0800 (PST)
Message-ID: <966e73e0-f661-4413-b722-9bb9140f69c4@ovn.org>
Date: Tue, 3 Mar 2026 14:36:29 +0100
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
Subject: Re: [PATCH net-next v4] net: openvswitch: clean up some kernel-doc
 warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
References: <20260303012052.4065482-1-rdunlap@infradead.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260303012052.4065482-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 202571F0901
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-263210-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.934];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:email,openvswitch.org:email]
X-Rspamd-Action: no action

On 3/3/26 2:20 AM, Randy Dunlap wrote:
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
> v4: more updates/corrections from Ilya (Thanks!);
>     use "net-next" (Jakub);
> v3: update descriptions based on Ilya's feedback;
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
>  include/uapi/linux/openvswitch.h |   76 +++++++++++++++++++++++++----
>  1 file changed, 68 insertions(+), 8 deletions(-)
> 
> --- linux-next-20260227.orig/include/uapi/linux/openvswitch.h
> +++ linux-next-20260227/include/uapi/linux/openvswitch.h
> @@ -70,12 +70,15 @@ enum ovs_datapath_cmd {
>   * set on the datapath port (for OVS_ACTION_ATTR_MISS).  Only valid on
>   * %OVS_DP_CMD_NEW requests. A value of zero indicates that upcalls should
>   * not be sent.
> + * @OVS_DP_ATTR_MASKS_CACHE_SIZE: Number of the entries in the flow table
> + * masks cache.
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
> @@ -83,18 +86,23 @@ enum ovs_datapath_cmd {
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
> @@ -181,6 +189,7 @@ enum ovs_packet_cmd {
>   * %OVS_USERSPACE_ATTR_EGRESS_TUN_PORT attribute, which is sent only if the
>   * output port is actually a tunnel port. Contains the output tunnel key
>   * extracted from the packet as nested %OVS_TUNNEL_KEY_ATTR_* attributes.
> + * @OVS_PACKET_ATTR_PROBE: Packet operation is a feature probe.
>   * @OVS_PACKET_ATTR_MRU: Present for an %OVS_PACKET_CMD_ACTION and
>   * @OVS_PACKET_ATTR_LEN: Packet size before truncation.
>   * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received fragment
> @@ -196,21 +205,26 @@ enum ovs_packet_cmd {
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
> @@ -257,6 +271,11 @@ enum ovs_vport_type {
>   * upcalls should not be sent.
>   * @OVS_VPORT_ATTR_STATS: A &struct ovs_vport_stats giving statistics for
>   * packets sent or received through the vport.
> + * @OVS_VPORT_ATTR_IFINDEX: Get the vport ifindex or put the desired ifindex.
> + * Only valid for vport type %OVS_VPORT_TYPE_INTERNAL.

This one is still a bit misleading.  How about:

"Provides the ifindex of a vport, or sets the desired ifindex while
creating a new vport with type %OVS_VPORT_TYPE_INTERNAL." ?

> + * @OVS_VPORT_ATTR_NETNSID: Provides the netns id of the vport if it's not local.
> + * @OVS_VPORT_ATTR_UPCALL_STATS: Provides upcall statistics for a vport.
> + * Contains nested %OVS_VPORT_UPCALL_ATTR_* attributes.
>   *
>   * These attributes follow the &struct ovs_header within the Generic Netlink
>   * payload for %OVS_VPORT_* commands.
> @@ -272,7 +291,9 @@ enum ovs_vport_type {
>   * ovs_header plus %OVS_VPORT_ATTR_PORT_NO determine the vport.
>   */
>  enum ovs_vport_attr {
> +	/* private: */
>  	OVS_VPORT_ATTR_UNSPEC,
> +	/* public: */
>  	OVS_VPORT_ATTR_PORT_NO,	/* u32 port number within datapath */
>  	OVS_VPORT_ATTR_TYPE,	/* u32 OVS_VPORT_TYPE_* constant. */
>  	OVS_VPORT_ATTR_NAME,	/* string name, up to IFNAMSIZ bytes long */
> @@ -280,23 +301,27 @@ enum ovs_vport_attr {
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
>  #define OVS_VPORT_ATTR_MAX (__OVS_VPORT_ATTR_MAX - 1)
>  
>  /**
> - * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_UPCALL* commands
> - * @OVS_VPORT_UPCALL_SUCCESS: 64-bit upcall success packets.
> - * @OVS_VPORT_UPCALL_FAIL: 64-bit upcall fail packets.
> + * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_ATTR_UPCALL_STATS

nit: May be good to add a period at the end.

> + * @OVS_VPORT_UPCALL_ATTR_SUCCESS: 64-bit upcall success packets.
> + * @OVS_VPORT_UPCALL_ATTR_FAIL: 64-bit upcall fail packets.
>   */
Best regards, Ilya Maximets.

