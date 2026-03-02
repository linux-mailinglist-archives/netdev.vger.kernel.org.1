Return-Path: <netdev+bounces-262614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLRMIURxpWlXAgYAu9opvQ
	(envelope-from <netdev+bounces-262614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:15:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BDD1D74B7
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3CAF3031CFB
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659173603DD;
	Mon,  2 Mar 2026 11:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7233C197
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450026; cv=none; b=gWvt96hcCuJNbngfl9JFcoiNy9HiWUnJopp2OAPCYix533mJ36Lj3507oBCrK/5w3noq2jhq7jvkXW4o8Ukej5iJc8Xvm/v7VwGCDIV8tbB2vFineRUg0Ajmctvt19hhJsbfWzs5tAnH5pFK81THFY6yfEQlQ76UHCf+1UV6Pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450026; c=relaxed/simple;
	bh=AMvKmX05Cr2tqwC2SUlz7QD62ziyXubyahUranvDTl8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vn8wJ2iSbVYAcVQ4FYEPEFoT+oHP8aj5BE5BijW9yf1uYJNNp7JU3EpwENW1TzB3u8NGaZsAudYq3cfkAO8+rqx7h+eKkJNHJY7TEjHid+G5o402Jp2lI/8tLFHJ0DHk6tjOsHEg870QwlNrmhd6JIDPRW0N1fRc+ZavLhAr6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4837634de51so17349925e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450023; x=1773054823;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyoMRXDyFfhS3Rk53Xzf5Czota/8NWkZSd5RJqjsoEE=;
        b=mZsJyrP8+CCURalNGNSpUACAQXkkLfwqu32xX9QwSy9G1qxbENhf1y/t8VdTszn/Uj
         T6/0BqCa7ZGHBN5KTNdf09FHnyiWIiU+teLHDpyJn1pXaYLbglOzCTsHpOEWWPV+iuvc
         R9fZ3B/nmbbPLPjKQ24QCiKFCKjTx+5b9AY2L3g5qvbtYksIOuM5iu48GkSzCah/5TWK
         7PXOQOWoyVPSi8btCqqcs+IgOXCjLFSpO6LgCuxAPUHRjltIeanv4InAPtXvimWLa4Mr
         uOd5foYFXdeFx0mESJm4hk5puwWXTMieDrRhdxKAmyx+xIwb8j2stT3xIStrS6dtozcI
         fdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8iUOf/8915iQeAx68SKRaGT6gpxJ0tmHWeW5InzCbuhjUqGxVuTQhQz0l5Qhk04eQE7VTq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKM1FAME25JTX8iW9nh2MTfpenbcWZOGNGHWb1ozGneuDio+F
	H5GFxjg0EyBMuhthML19KrDrJBExnsdzdCYJKYpwynDI85jUVSRcaWXY
X-Gm-Gg: ATEYQzxOdcEtBV+i9VnJ6BXfB+wiJudA/4yIeDxxS/wpkUMSTiAfsGZW8EMdFaPQGKE
	behHWckYcH/ObCBZuTjhNHlfgIS9xohO1/e0xJ09hNgQG4WlQqH8lwdDpLV0i2p8/iC/dbWRAA6
	xBZpQwd7cgjYuemnvM+AXXMAkpgS2LOt4Hot6vFmAfGhOtGV7OatShJui1/5npcCsZVRDlYC6s4
	mkjgGueW/VrB++5xvoDMyx2LkIekHZDJSUODjv0TMd8LYgGlNQHrGCklXQDiRhImMu2PajY5RSZ
	vBr6bAAvGA45TvZyqFNCA48yngAnwSG9HEYp0Dv4PQ1100g65VKB/oGPLv75OPZ3n29/XmzZHlK
	AUTElmD0zrF7duqOTqiW0jVMCuY9yEuglB+Nw8ZU7TiFPe9dQNs+ZPJMvomSRTbNFw8dV0+LGuv
	qgbe5z28u9yUxOW5jKAUAT1/FCH6mQr0pXce3AHnRL/P+6+Jga++Kebs1KrKafeO/5NicPcg==
X-Received: by 2002:a05:600c:444d:b0:482:eec4:772 with SMTP id 5b1f17b1804b1-483c9c2d742mr185704375e9.32.1772450022788;
        Mon, 02 Mar 2026 03:13:42 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776a3sm171659325e9.7.2026.03.02.03.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:13:42 -0800 (PST)
Message-ID: <77c7a4f1-3fc1-4a3f-a147-f6771a85b234@ovn.org>
Date: Mon, 2 Mar 2026 12:13:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net v3] net: openvswitch: clean up some kernel-doc
 warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org, i.maximets@ovn.org
References: <20260301011714.3070073-1-rdunlap@infradead.org>
Content-Language: en-US
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260301011714.3070073-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-262614-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.929];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvswitch.org:email]
X-Rspamd-Queue-Id: E1BDD1D74B7
X-Rspamd-Action: no action

On 3/1/26 2:17 AM, Randy Dunlap wrote:
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
>  include/uapi/linux/openvswitch.h |   77 +++++++++++++++++++++++++----
>  1 file changed, 68 insertions(+), 9 deletions(-)
> 
> --- linux-next-20260227.orig/include/uapi/linux/openvswitch.h
> +++ linux-next-20260227/include/uapi/linux/openvswitch.h
> @@ -70,31 +70,39 @@ enum ovs_datapath_cmd {
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
> - * valid for %OVS_DP_CMD_NEW requests.
> + * valid for %OVS_DP_CMD_NEW requests and vport type %OVS_VPORT_TYPE_INTERNAL.

This comment was meant for the OVS_VPORT_ATTR_IFINDEX, not the DP.

>   *
>   * These attributes follow the &struct ovs_header within the Generic Netlink
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
> @@ -257,6 +271,10 @@ enum ovs_vport_type {
>   * upcalls should not be sent.
>   * @OVS_VPORT_ATTR_STATS: A &struct ovs_vport_stats giving statistics for
>   * packets sent or received through the vport.
> + * @OVS_VPORT_ATTR_IFINDEX: Get the vport ifindex or put the desired ifindex
> + * @OVS_VPORT_ATTR_NETNSID: Get the netns id of the vport, if it's not local.

s/Get the/Provides/ maybe?  Users can't really request these, the values
are just always in the get/dump reply whenever applicable.

> + * @OVS_VPORT_ATTR_UPCALL_STATS: Provides upcall statistics for a vport.
> + * Contains nested %OVS_VPORT_UPCALL_ATTR_* attributes.
>   *
>   * These attributes follow the &struct ovs_header within the Generic Netlink
>   * payload for %OVS_VPORT_* commands.

Best regards, Ilya Maximets.


