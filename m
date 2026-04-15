Return-Path: <netdev+bounces-278878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBHaESoU4GmPcQAAu9opvQ
	(envelope-from <netdev+bounces-278878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 00:41:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0507408C0E
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 00:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5009630A7CBC
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 22:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8BE279334;
	Wed, 15 Apr 2026 22:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8C3191D6
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292902; cv=none; b=Q9Rw3aqgg77rtLo9u+2WljFJseyvkccZi6jOe8z0WPXFh3LkAOTHzLsV1JONYrVwyJAdi+ommoe8z3q1tdTUj5wRpk9CZEzvifU/RrHMTjiENXr/ONmxXuiZlDtECZlr5BIzSbL9KaCNVg/1hmHoUY6o9W2PAhER9mqJaagXGCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292902; c=relaxed/simple;
	bh=Z4N8cTZJBDQmkP5CXP1jeTxG+4D9+qjs4UoRMOFY6XY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cL0Lp761KprvNOc+xsY4VSPi++HYCeLtWsXppT5IfiuIXaJ7LjuSkpSRXB6WdUMZNJ3bdTY+U7Cc9Vp37I/Ji3XtvHKrbjgmuitMvCb0YvyYhYoPHKfcZefVREqEI3CX3Lv1MvhymrYTVXCPpLgFFJfYGgUgcmGbL/fdtjZv/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso471585e9.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 15:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292899; x=1776897699;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIWwLJ/z71SMElCeVQxzvoG2kHlTfG0aEyp1Q0/iHKI=;
        b=XFBtteuI8OCjv5qpHvAc8ngazMlen6eaSv/ysf9MktXtheUKs4ptYGCcUtg/PxEDff
         oz1KcRUgLtcy5qE1Y+iycLiWpzmMBzZ+5xtEcGvUFMv+JQPNahkOlwC0fS5Xgtlgyo5z
         rP3vIIs/mk92n36Rdu91Q3W+JnQ/W6VjHQ3P+IiZbJ36743xOJctpm7oLBYAIMQn69Ip
         l3q+SFcIObZQAEPpCNGs2+iUC8wJf8KaWhpFgNqqyQ3TV3iPUOVnhsswWineqtT5xnNb
         8UOf5C3XXBea1UBjdI2CIRTEQlvSCGeTVx7YEYDVBjiZPtpso1CAoSKP193FVPkTIs/u
         Ze3A==
X-Forwarded-Encrypted: i=1; AFNElJ+qXDDsX9XUWdCHTEcVHjp9S0xMzzWDFeTamoIWsp5CGIeITNEEh4FyC/fXu1Rgn7UxYjTxbn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzicpLG6jGTc1UIMDFgvyfME3G6UpS9Fv/rKoX1H9YSBKlWdVub
	GObQj3vNHTHYQHpmcxwAWEQT+MgbpwJ5mZcYhZLONAfdIbe/+W9HZ2Es
X-Gm-Gg: AeBDievT6Df+MyyD/cYri6Y2LY8P1HDu8BTL26JE0/9KBLCo23yC+8Ub9LRCeEN8Aam
	M9DkWsqWB7UxOCHY8VHM36qE31Q7NAAh2+QV3uQP93rEMYn6qXv32BlDt8X81MQS6DWRrlecC5z
	gBLYez0+W+ovfGUO4+NEYQ9Dg6rmavVKbzpXP3AbuIiqH/HTBS41Hh1yAAyUcu1UKp0XXu2sarA
	131yDufQCYybnX8UybI7MhQ/bFzgXc1NPY4bg+Pnm46VALoorfG4xXN1/Sk6YMKTJT7YBt9k6Bv
	BRPTDF/NvhZR7bYBpida/SOqRyn7B469PSUhhCasfUutqwm34OXoHTat4ZdD6pMZro9G/nQrsXQ
	W6Kb7+5SHYkWmHfb50q+ve873jLcj3GRFyR3JXfxQwvGVWpG16sv2Hn98P2awi40BLiPKe1wF1s
	/CwkZykGBsmH3DO2qxxQoCUwtTuF5du7XUtgPtETR211FBJcjTEC0ILyk=
X-Received: by 2002:a05:600c:1e28:b0:488:9c3b:ff40 with SMTP id 5b1f17b1804b1-488f4829bc6mr14356225e9.15.1776292898554;
        Wed, 15 Apr 2026 15:41:38 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5827145sm4184545e9.13.2026.04.15.15.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 15:41:38 -0700 (PDT)
Message-ID: <eb2f03bf-302e-4fb6-8735-3194703505be@ovn.org>
Date: Thu, 16 Apr 2026 00:41:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, dev@openvswitch.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v4] openvswitch: cap upcall PID array size and
 pre-size vport replies
To: Weiming Shi <bestswngs@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260415125121.110874-2-bestswngs@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260415125121.110874-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278878-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,davemloft.net,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovn.org:mid]
X-Rspamd-Queue-Id: B0507408C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 2:51 PM, Weiming Shi wrote:
> The vport netlink reply helpers allocate a fixed-size skb with
> nlmsg_new(NLMSG_DEFAULT_SIZE, ...) but serialize the full upcall PID
> array via ovs_vport_get_upcall_portids().  Since
> ovs_vport_set_upcall_portids() accepts any non-zero multiple of
> sizeof(u32) with no upper bound, a CAP_NET_ADMIN user can install a PID
> array large enough to overflow the reply buffer, causing nla_put() to
> fail with -EMSGSIZE and hitting BUG_ON(err < 0).  On systems with
> unprivileged user namespaces enabled (e.g., Ubuntu default), this is
> reachable via unshare -Urn since OVS vport mutation operations use
> GENL_UNS_ADMIN_PERM.
> 
>  kernel BUG at net/openvswitch/datapath.c:2414!
>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  CPU: 1 UID: 0 PID: 65 Comm: poc Not tainted 7.0.0-rc7-00195-geb216e422044 #1
>  RIP: 0010:ovs_vport_cmd_set+0x34c/0x400
>  Call Trace:
>   <TASK>
>   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1116)
>   genl_rcv_msg (net/netlink/genetlink.c:1194)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   genl_rcv (net/netlink/genetlink.c:1219)
>   netlink_unicast (net/netlink/af_netlink.c:1344)
>   netlink_sendmsg (net/netlink/af_netlink.c:1894)
>   __sys_sendto (net/socket.c:2206)
>   __x64_sys_sendto (net/socket.c:2209)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
>  Kernel panic - not syncing: Fatal exception
> 
> Reject attempts to set more PIDs than nr_cpu_ids in
> ovs_vport_set_upcall_portids(), and pre-compute the worst-case reply
> size in ovs_vport_cmd_msg_size() based on that bound, similar to the
> existing ovs_dp_cmd_msg_size().  nr_cpu_ids matches the cap already
> used by the per-CPU dispatch configuration on the datapath side
> (ovs_dp_cmd_fill_info() serialises at most nr_cpu_ids PIDs), so the
> two sides stay consistent.
> 
> Fixes: 5cd667b0a456 ("openvswitch: Allow each vport to have an array of 'port_id's.")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v4 (per Ilya):
> - Use nr_cpu_ids instead of num_possible_cpus() for consistency with
>   the per-CPU dispatch on the datapath side.
> - Annotate ovs_vport_cmd_msg_size() per-attribute; split nested sums.
> v3: Cap at num_possible_cpus(); add ovs_vport_cmd_msg_size(); keep
>     BUG_ON(); fix Fixes tag.
> v2: Dynamically size reply skb; drop WARN_ON_ONCE, return plain errors.

Please, don't re-name the patch for every version if there are no changes
that actually invalidate the name.  It was definitely not necessary in the
past few versions of this patch.  Could've even kept the original name
from v1, it was fine.  But please, keep the current v4 name in v5.

These renames are messing up version tracking.  Also, please, add lore links
into the changelog for previous versions, especially if you're renaming the
patch, so reviewers can find the older versions.

In case you're using AI to help with these patches (which would explain the
constant renaming), you should disclose that by adding an Assisted-by tag:
  https://docs.kernel.org/process/coding-assistants.html#attribution

> ---
>  net/openvswitch/datapath.c | 33 +++++++++++++++++++++++++++++++--
>  net/openvswitch/vport.c    |  3 +++
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index e209099218b4..35e67e51b0d2 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -2184,9 +2184,38 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
>  	return err;
>  }
>  
> +static size_t ovs_vport_cmd_msg_size(void)
> +{
> +	size_t msgsize = NLMSG_ALIGN(sizeof(struct ovs_header));
> +
> +	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_PORT_NO */
> +	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_TYPE */
> +	msgsize += nla_total_size(IFNAMSIZ);    /* OVS_VPORT_ATTR_NAME */
> +	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_IFINDEX */
> +	msgsize += nla_total_size(sizeof(s32)); /* OVS_VPORT_ATTR_NETNSID */

Add an empty line here, it's hard to read when comments are sandwiched
between the code.  Same for all the blocks below (empty line before the
comment line).

> +	/* OVS_VPORT_ATTR_STATS */
> +	msgsize += nla_total_size_64bit(sizeof(struct ovs_vport_stats));
> +	/* OVS_VPORT_ATTR_UPCALL_STATS(OVS_VPORT_UPCALL_ATTR_SUCCESS +
> +	 *                             OVS_VPORT_UPCALL_ATTR_FAIL)
> +	 */
> +	msgsize += nla_total_size(nla_total_size_64bit(sizeof(u64)) +
> +				  nla_total_size_64bit(sizeof(u64)));
> +	/* OVS_VPORT_ATTR_UPCALL_PID (capped at nr_cpu_ids by
> +	 * ovs_vport_set_upcall_portids())

The explanation inside the parentheses is not needed, IMO.

The rest seems fine to me.

Best regards, Ilya Maximets.

