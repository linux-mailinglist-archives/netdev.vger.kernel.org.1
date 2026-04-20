Return-Path: <netdev+bounces-279615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFdDMoSA5WlvkgEAu9opvQ
	(envelope-from <netdev+bounces-279615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAAF426023
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0293009F90
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47E33B6D3;
	Mon, 20 Apr 2026 01:25:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFFF33ADBC
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776648320; cv=none; b=XIt+BvvsiXZlISlVL6TozFLkX2zWfRni0ngwOdh5MoBIbhMvQ7+pJcWpHmu+a4sKz+OYP5gKhywxOFWwEPQVmyOBV+6JPT7yUa+afDqM1eHi+xlZuw5h+eyGsZCzXWAmoqe0QQGRPCgJyt94eohRpWc/GP+Dw8yx9jBiMGcSTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776648320; c=relaxed/simple;
	bh=DNBmGi5di1mcjgMHoLWBib2W16O8tfsgqOz/z1nD+rM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MLmOV5MSQ14FVAe2x4Wo0OBxw82NPBYpb0xflu//WXx9HpOMTHq/7DhjM9nJwT5x6RH8VzdNiOWAJCIOuBVjlF7LBjnTcGI6Uq9hKwwV8x4hYIhQoye1tYMB3e2tmVg7ym95N7rjqFvXw2W+XTkrfuMTTpTr8UQRqg9rldum2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488b150559bso18763285e9.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 18:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776648316; x=1777253116;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEFS/Gmu9LntjZus6CGFhg0KSAztklqpPcI6yFvkRkw=;
        b=Dc6mH6Nrd/43rgpVNVA4RetKZCMGHGyjL+xMxCgz6gxE4sz5hbYxD5Txp9nvVog9t+
         AOD/MKu3EXlMN2pMX29IUp8z7Fb+ehOSIbUJijQqAa+E1f/a7DLyrec+5qrmwmS5Jgre
         ntT816GUTCax07kPeVFKf//LVAYDzlnuu/flQwp0DydCtuegkXY+OgpUl9zb2JzwZx8I
         oPYcBngS2fphfccx3pyv9rKKgr9UIA0SkSBTaQCB58fnc2CJoQoi4dhBUkPHWa/lF2G3
         GiIeNPYw4pfQJUxGwQuaNa8f6RfN2cW1lIcsDtnbM5nFqDs2qFTqJJNa9mDHMWxu1EM9
         HpOA==
X-Forwarded-Encrypted: i=1; AFNElJ9MdTTC8KHWC43rnsH+pKKqkmU178PCNo3d4Wk9g5N5WFACYmjf7TYjxEACNX/Bxs1Yv16t6OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIDCsS+U5as8jP5RwsyJiEkAISTQ/5AX3oqhtoHGVDR4Qp15X
	D3rOaGP7BSksGdAIn0rXRcuDGZ+D8hMelqzeGzFsC03XKVSsov2A5MzI
X-Gm-Gg: AeBDietkkjdqEVfLfcuTg/rW4LRMhzCA7e6pGKsNJ5tf/IHJeqt55AJfG6m8vHGAZ9f
	obgA3OEEoa8z9zXXzsX3n02q34cF7KvbqRe2LOhkwl5xFLC4dc7K/64f6r1VtHRtSDhg6CljdFl
	1OJGoPUfSxZsWIy6mXg5sXB3pO8dE12fPqhrmcS5Sz4BcEaWeGC76W832fvIwpTkiQoBTcY54NH
	S0HaqpoJCzlvntXt8Ry2f8lhE5AK1s5XT9/rvTwqEY9TRmPFYC5AEuo2FKJzhbgM4HzbHTs+Gpq
	xAiScCKtmG8qRYBm3PenUdbQSrL4IMaVo14srLWo5y5WNXSMxvY35tgl0flsa2C6TUB5x/5UEQ9
	parQPRNRUkDVKUHOnPe+1tx0K12LLVUg2MV50ZOq+eiaPnyiyoAyW13hVJsX2tn8TuOwswBlyx9
	Es+vsIMDc+hZbSTUz+/pihDg7PfHmnxSOhS+LHqoQgbu3YgpC6TcrAazj/kKIv3ZrCCQ==
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr167948465e9.23.1776648315672;
        Sun, 19 Apr 2026 18:25:15 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm81468495e9.1.2026.04.19.18.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 18:25:15 -0700 (PDT)
Message-ID: <7b8d789d-13c2-4a09-b19b-35874afc3d9e@ovn.org>
Date: Mon, 20 Apr 2026 03:25:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, dev@openvswitch.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v5] openvswitch: cap upcall PID array size and
 pre-size vport replies
To: Weiming Shi <bestswngs@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260416024653.153456-2-bestswngs@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260416024653.153456-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279615-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,davemloft.net,google.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:mid,ovn.org:email]
X-Rspamd-Queue-Id: 0BAAF426023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 4:46 AM, Weiming Shi wrote:
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
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---

sashiko AI review is concerned about a few things:

1. Potentially higher memory usage for these messages on systems with
   high core count.  This is not really a problem as we have similarly
   sized datapath info messages and even larger flow messages.

2. Technically a uAPI change since we're limiting the number of PIDs
   that can be supplied.  But, as I said before, this number should be
   limited by some value regardless, it's not good to have it unbounded,
   and also it is generally not a good idea to configure more handlers
   than cores, as it will worsen the "thundering herd" issue the
   per-vport dispatch method has.  Existing userspace by default sizes
   the number of threads to be lower than the number of cores.

In practice, per-vport dispatch is only used as a fallback in all modern
versions of Open vSwitch (since 2021).  So, we should also, probably,
explore the ways to deprecate it and eventually remove, which would likely
require at least removing the warning for when the dp->upcall_portids
array is smaller than the cpu_id, so the users are not always required to
supply the full array, e.g. for tests, but that's a separate topic.

For this particular patch:

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

