Return-Path: <netdev+bounces-300813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vnl3EsKUNmrBBQcAu9opvQ
	(envelope-from <netdev+bounces-300813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:25:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A7E6A8EF5
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:25:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=jHcV0dZI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300813-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300813-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CDDD3010504
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E23C22579E;
	Sat, 20 Jun 2026 13:25:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FC18DB35
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:25:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781961919; cv=none; b=OXfqF2AeSvZWCd4YiWyr4By6TQex40COM+T/AIYMlpF6dPUzW+NtBe6ziecaMrCVjk/93CQt4TDjqQwrENN85Fc05aimquu2PHMQpqsjLavX1r/OWUbQ5f/iazyHjFUgDlEZIqRKsvaUcjwqiLb7yjrh/Xd0HyGtDaOffZgIGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781961919; c=relaxed/simple;
	bh=Asuxszf/bAwC9ualoko64JrOS2xrhOR5jGL/gDpMV/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcNYS0fGp5KyJSUHGH244BLh8mO7Z2aDa38VjtxfB8QX5TMKyULypMRzus0wVMqvAs7zAFtBL3lC3wFsCtSgOI7NoIvs+Z/KfhpeCyzFtkVblbbRtw56EHS78AbGJ70Bn89E/7Gokg8qj0fknIkdz14rz/Nudm50vDbjKxQsXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHcV0dZI; arc=none smtp.client-ip=95.215.58.174
Message-ID: <6f34efb8-c7e7-490c-bef1-c4c7da9a706e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781961915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afi4i6B2BdOEvMjupBy9U4sefc34AGzac9BLN7m560Q=;
	b=jHcV0dZIrmogmx86GXkj6i17E67BCMvSa6cyRpNc4KlXMAYX27kdbi6PHog1WPauMz7Rdu
	UtwvBrU2Dpc2yPJZcmAnxTJJlSu2cQN4jAh3qgdD/J6lTov9gVmYNVgtIBvQGSBpS5Pon1
	f+/56RKU3j9aFs3d2/DvXynaIjF54gc=
Date: Sat, 20 Jun 2026 21:24:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf, sockmap: disallow update and delete from tc,
 xdp and flow_dissector
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Lorenz Bauer <lmb@cloudflare.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260620034632.2308-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260620034632.2308-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-300813-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:sdf@fomichev.me,m:lmb@cloudflare.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91A7E6A8EF5


On 6/20/26 11:46 AM, Sechang Lim wrote:
> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
> sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
> write. That gives the order stab->lock -> sk_callback_lock.
>
> The reverse order comes from the SK_SKB stream parser.
> sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
> verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
> __tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
> deletes from the sockmap and takes stab->lock:
>
>    WARNING: possible circular locking dependency detected
>    7.1.0-rc6 Not tainted
>    ------------------------------------------------------
>    syz.9.8824 is trying to acquire lock:
>    (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>    but task is already holding lock:
>    (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>
>    -> #1 (clock-AF_INET){++.-}-{3:3}:
>           _raw_write_lock_bh
>           sock_map_del_link net/core/sock_map.c:167
>           sock_map_unref net/core/sock_map.c:184
>           sock_map_update_common net/core/sock_map.c:509
>           sock_map_update_elem_sys net/core/sock_map.c:588
>           map_update_elem kernel/bpf/syscall.c:1805
>
>    -> #0 (&stab->lock){+.-.}-{3:3}:
>           _raw_spin_lock_bh
>           __sock_map_delete net/core/sock_map.c:421
>           sock_map_delete_elem net/core/sock_map.c:452
>           bpf_prog_06044d24140080b6
>           tcx_run net/core/dev.c:4451
>           sch_handle_egress net/core/dev.c:4541
>           __dev_queue_xmit net/core/dev.c:4808
>           ...
>           tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>           strp_data_ready net/strparser/strparser.c:402
>           sk_psock_strp_data_ready net/core/skmsg.c:1174
>           tcp_data_queue net/ipv4/tcp_input.c:5661
>
>    Possible unsafe locking scenario:
>
>           CPU0                    CPU1
>           ----                    ----
>      rlock(clock-AF_INET);
>                                   lock(&stab->lock);
>                                   lock(clock-AF_INET);
>      lock(&stab->lock);
>
>     *** DEADLOCK ***
>
> A tc, xdp or flow_dissector program has no reason to update or delete a
> sockmap, and redirect does not go through here. Drop them from
> may_update_sockmap() so the verifier rejects it. It also closes the
> matching sockhash inversion.
>
> Fixes: 0126240f448d ("bpf: sockmap: Allow update from BPF")
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v2:
>   - reject sockmap update/delete from tc, xdp and flow_dissector (John
>     Fastabend)
>   - fix the changelog (Jiayuan Chen)
>
> v1:
>   - https://lore.kernel.org/all/20260616091153.2966617-1-rhkrqnwk98@gmail.com/
>
>   kernel/bpf/verifier.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..94d225521b5a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8766,11 +8766,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
>   			return true;
>   		break;
>   	case BPF_PROG_TYPE_SOCKET_FILTER:
> -	case BPF_PROG_TYPE_SCHED_CLS:
> -	case BPF_PROG_TYPE_SCHED_ACT:
> -	case BPF_PROG_TYPE_XDP:
>   	case BPF_PROG_TYPE_SK_REUSEPORT:
> -	case BPF_PROG_TYPE_FLOW_DISSECTOR:
>   	case BPF_PROG_TYPE_SK_LOOKUP:
>   		return true;
>   	default:

CI failed.

https://github.com/kernel-patches/bpf/actions/runs/27859622337/job/82454035306

Please drop or change such trigger.


Also, please drop Fixes tag and target to bpf-next for the same reason 
in you another thread.


Nit:

You can also manually fork and create pull request against

https://github.com/kernel-patches/bpf/ to run full test to run the full

test and make sure all tests pass before you send patch.


