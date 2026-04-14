Return-Path: <netdev+bounces-278505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAKUJWNe3mn+CQAAu9opvQ
	(envelope-from <netdev+bounces-278505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:33:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8063FBECF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1799230378A9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA47E3E95B3;
	Tue, 14 Apr 2026 15:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168951DF73A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180687; cv=none; b=TfjoEY9Xx+GGnJJHPIN0ou/tSi4Zhp9Ivd2o0pTeizFSFiVSIytkzejwG+2UjJzwoNNUiv07pSTJzNwBx0XkzGyMFEwWA2AZj/skbIZ5UE4S9zRLIncoNje52sisNK+mHP4CxVN4ypjFF+WfxYzxM1jSykJqaMXQJV89Jfw29UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180687; c=relaxed/simple;
	bh=WuNj9JF9bU0GMYQzgIuP7sCH3ngQGftE1GMDpR9Wm/M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BEgQS6dLjARg9zl28cDheFiKwMRLe5GfA+ShZeolJm7SOjLI0XWUYBfhjOm+E7Jvb5UAgSVc/aNlaVv0g4KuA8l0he+FjXmD8DzUK1Gn1QJpDdDJpSur2lLLoiuUnud5zlwkvSYklNOkOEwGkV9DS+HuzmTAuusriB/lIhcb894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so40150175e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180684; x=1776785484;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Pj9b0fM9cmpNeFlYwGUH1VTF02ayW3JaE8vvtW+Z3I=;
        b=JAfzRzUtRIs8v6acjKvyJ96a+b1ug5ZRzbu8LphY4QY5HPlAyFQovhjqA4tr6D+OyC
         FEBaSnzycowA0+cTD4oWBaj0tlcnCC0J/1T3aQSRBdbHqqXwXSZ8X9TO0aSY+hoHFQUU
         bEZEHPXSnRaL1GCl7S17XGdiziMhkOfC+LrQyVJxKCThWrzfptmr9nFa25zf4skLzhK0
         d8I8Rn/Z+ilblSMf3FQNXGIkPXVRvr8JkxN+ojFAmpjIVh8Am/epr+VFaUPpOIf1/+4Y
         QSgw7qxGbZ3hBP2aezMvXj/TsTwCwgvw3Yv81d/Xwy4Px0y3kv00A6h7+TTChTa17DOY
         jmeg==
X-Forwarded-Encrypted: i=1; AFNElJ9y2UFWr2xaFm9yJiBNDxEvsw4ofskG9Tatwwi1somVELUOUW+CcCqiIge04dTrPIK86dLKVcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWb2q3TfGx6x/vnBHW0yIi8ErcVyhwBCRpZclhBibEs3ZDypzy
	TZpHjqAoZyhW4uTAHdYAkCkucplyKeqsPdLMswlss1viJxkgPf+eQ4QS
X-Gm-Gg: AeBDies16TZ/jtgRCa/ikqJKUUYg2GIIpyDZCAbg1PRKOVG/FU2ykPGpEGQSl0TuI+3
	dmBxxR0fGM9UbjfH73nnUjMa0uheNcZO8H7pS7nY+XF27/jfoheBJO8R1HyzF/5vnd2k0QB7VCK
	NyqNgeUyU10rj8FRb6eCnacssFO3BHTRMsAOzrJlMHM0/IHAjij4rm7yy/zseePkgF/m0kT7Lyc
	XyWN1H4vv49/gRAFUsTRfr9ajNfS2VlwrI4QjgjoefzBqGDZLlKjbKSO2Qjmnf+47n77IyUW7J3
	E9XOt9IeUNfzphJioWRIbKWPI3YTMMKIOznWQI7e38IhV/CBiFAsXxP65ECXVDhNzaHEFqwGy9a
	mFECROoi3o1DIROtxHMG3s8+Yb6Lh3aDGF71ku/la3q4wbNnqnrhpl4o0vT5YXbkNkJ9yaAiCKM
	C1prNU+bbBfKS/QRE3h4Zc95ONMPZ1Nb4jLnUVgVJ5PNlZGU75XOE/4xg=
X-Received: by 2002:a05:600c:450a:b0:488:a882:b7 with SMTP id 5b1f17b1804b1-488d6ad17e6mr236089985e9.29.1776180684163;
        Tue, 14 Apr 2026 08:31:24 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d9fa22sm120779635e9.7.2026.04.14.08.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 08:31:23 -0700 (PDT)
Message-ID: <2f3d5e0c-481c-4d0e-997a-65fabc3d84c0@ovn.org>
Date: Tue, 14 Apr 2026 17:31:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Simon Horman <horms@kernel.org>,
 Thomas Graf <tgraf@redhat.com>, Pravin B Shelar <pshelar@nicira.com>,
 Alex Wang <alexw@nicira.com>, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v3 net] openvswitch: limit vport upcall portids to the
 number of CPUs
To: Weiming Shi <bestswngs@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260413035514.2113886-3-bestswngs@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260413035514.2113886-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278505-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,davemloft.net,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,ovn.org:mid]
X-Rspamd-Queue-Id: EF8063FBECF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 5:55 AM, Weiming Shi wrote:
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
>   kernel BUG at net/openvswitch/datapath.c:2414!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   CPU: 1 UID: 0 PID: 65 Comm: poc Not tainted 7.0.0-rc7-00195-geb216e422044 #1
>   RIP: 0010:ovs_vport_cmd_set+0x34c/0x400
>   Call Trace:
>    <TASK>
>    genl_family_rcv_msg_doit (net/netlink/genetlink.c:1116)
>    genl_rcv_msg (net/netlink/genetlink.c:1194)
>    netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>    genl_rcv (net/netlink/genetlink.c:1219)
>    netlink_unicast (net/netlink/af_netlink.c:1344)
>    netlink_sendmsg (net/netlink/af_netlink.c:1894)
>    __sys_sendto (net/socket.c:2206)
>    __x64_sys_sendto (net/socket.c:2209)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>    </TASK>
>   Kernel panic - not syncing: Fatal exception
> 
> Reject attempts to set more PIDs than num_possible_cpus() in

Any reason not to use nr_cpu_ids?  If not, then its better to switch to
that to be consistent with the per-cpu dispatch configuration.

> ovs_vport_set_upcall_portids(), and pre-compute the worst-case reply
> size in ovs_vport_cmd_msg_size() based on that bound, similar to the
> existing ovs_dp_cmd_msg_size().
> 
> Fixes: 5cd667b0a456 ("openvswitch: Allow each vport to have an array of 'port_id's.")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v3:
>  - Cap PID array at num_possible_cpus() in ovs_vport_set_upcall_portids().
>  - Add ovs_vport_cmd_msg_size() for worst-case reply allocation.
>  - Keep BUG_ON()s, fix Fixes tag.
> v2:
>  - Dynamically size reply skb instead of using fixed NLMSG_DEFAULT_SIZE.
>  - Drop WARN_ON_ONCE; use plain error returns instead.
> 
>  net/openvswitch/datapath.c | 23 +++++++++++++++++++++--
>  net/openvswitch/vport.c    |  3 +++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index e209099218b4..4049bfa1c4df 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -2184,9 +2184,28 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
>  	return err;
>  }
>  
> +static size_t ovs_vport_cmd_msg_size(void)
> +{
> +	size_t msgsize = NLMSG_ALIGN(sizeof(struct ovs_header));
> +
> +	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_PORT_NO */
> +	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_TYPE */
> +	msgsize += nla_total_size(IFNAMSIZ);
> +	msgsize += nla_total_size(sizeof(u32)); /* OVS_VPORT_ATTR_IFINDEX */
> +	msgsize += nla_total_size(sizeof(s32)); /* OVS_VPORT_ATTR_NETNSID */
> +	msgsize += nla_total_size_64bit(sizeof(struct ovs_vport_stats));
> +	msgsize += nla_total_size(nla_total_size_64bit(sizeof(u64)) +
> +				  nla_total_size_64bit(sizeof(u64)));
> +	msgsize += nla_total_size(num_possible_cpus() * sizeof(u32));
> +	msgsize += nla_total_size(nla_total_size(sizeof(u16)) +
> +				  nla_total_size(nla_total_size(0)));

Please, add comments about which attributes are included for each line where
it is not obvious.  Plain u16 or u64, for example, are not obvious.  Put them
on separate lines when they do not fit.  E.g.:

	/* OVS_VPORT_ATTR_OPTIONS(OVS_TUNNEL_ATTR_DST_PORT +
	 *                        OVS_TUNNEL_ATTR_EXTENSION(OVS_VXLAN_EXT_GBP))
	 */
	msgsize += nla_total_size(nla_total_size(sizeof(u16)) +
				  nla_total_size(nla_total_size(0)));

Best regards, Ilya Maximets.

