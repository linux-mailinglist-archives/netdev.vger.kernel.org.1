Return-Path: <netdev+bounces-301526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzeqNV08O2rdTwgAu9opvQ
	(envelope-from <netdev+bounces-301526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:09:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E15B6BADD3
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:09:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b="Na6//G2Q";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301526-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301526-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C32E305DABF
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 02:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236C2848A7;
	Wed, 24 Jun 2026 02:09:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330F283FC4
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:09:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782266968; cv=none; b=OoVnTHbfOVsxn3ux8SmyEIrX0/YVjySaHleMNWfdnIbgxBhXhnKbMEdIsGjp8Jd+AOrNWNF27NRM2nvU1/spKkvWRcZ/1DDhU3pVlLehVvYaBW3CxWtooVKMsmgKW2+Qy7ZcqGEu0wj3beBf1L0A81aL4txd/0q+55sqQVeFWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782266968; c=relaxed/simple;
	bh=G4PMbo4gAnTzujbJkIZfw7/qAPPtRarxDgz83R4PCvw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=MLcqLOoeO0ELXwLlx7iwRwW20UhMXMC1RBpy26aRSysU9hXvnjjlfqErxsl91tDbjSX9ZkiZuM3ouzySAEiucwkR/Za1lGF+K40iKyrXDm4azSKNAsQGPkP2gnuQ+LC4ytVAbVv0unApd8m4y45s+UnvJKc8OPJetNvLxDQsaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Na6//G2Q; arc=none smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139a71baa35so1295252c88.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 19:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782266964; x=1782871764; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+uR5pjN31cxoCLjhADvr4TVIpAsDKEZa8OS2FHuarI=;
        b=Na6//G2QOQ2pdHXufiqMCilSSeGJQa3XAPAKvypst7ZiDO52u4Eub9NGmHFD0+ux24
         3oSQmYcgCcxFzSmhKnOqZsFTfbucyvXCBl/zY/Ev4l6h96NHAbcWXhPf+l3jJy0pfhF8
         sTfJWU7PqWvv/cY/PzEEozCqOJq644su5FPEtYjlyrs7vZoJZy7AZHVsWMni3v69CgTK
         oPUYNNRORBQkKoZKxRT3xR/Wgvfl4/V4s703hsVgHHTT5sQIxrjjUcMXdQbQvR3yA/tG
         3qAC8/MEmvL1Dnvm4LefVZrKXGsnDvXx49xLQ28Lv9GO0JyPkNWeh8XIdgVqbRN1vy3e
         OjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782266964; x=1782871764;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+uR5pjN31cxoCLjhADvr4TVIpAsDKEZa8OS2FHuarI=;
        b=GvSR75fTWC3/VnOlWtMV2JPy605trlsmqbN6x+i2M9n/pBOn+qKgFC/0ZkfbIjgSH3
         WkF+Q3ZPVEWl3dzTU2PhIa2UDs3tc9UMif4HNdLByHAK4I/Sz3evZhv60jv6LWYUK4hb
         4BhwX/ffpqypT7esSztcE0A/wq0mOr0Jnf7BARTFU/OJRrC9uUf54Dvv2loRAFO9Gfnh
         0fP/P1sDaT8Kb53MmB62nLE3yquK/1rbI2uqP0h+lpGXEzqis4DsVX2fXYDP9epycK7N
         Ue7orZW15A2mqynHp13i/8IqDL5Y4Q6kiF6btb+gjjjgwArIp9b5YfyN+0QcGSri6axi
         3uRw==
X-Forwarded-Encrypted: i=1; AHgh+RrilHq0vMoUueDD7AACfbWI7oCMqxmRRIn9JmuEmonXLWIzNOnRgcovq+7s1cTvHQGqxAfU+u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdh0AkL/HXdetCLAlFq0z+yvG9TEgGbuWQMb1XBZur7UVmJgi8
	/64crFWk2V76EeIUQeXrqVLuoGBHRBb4E4QvAxKYyHEF7RiFPAUG6iR3xhbcbNM5y0w=
X-Gm-Gg: AfdE7ck1+U0S+54a6tzIClZtgdYLmK1wS4z3QCwgp7Ybtaj8f2wvPqOm8zPTu/Phs4e
	S6mYMWWhUxG9gZBGAY3VhzwrllS5p2B24dDVdvepKvBWACTkB4T7Dj/aBlko+NqoZXWKy328xhr
	1pjWc85CDloi/m7CpdH6jo4qmOz3czM3Jkk/Y2jsrGQYC85dTRgMVzBr3ayeriuTel3Nvst/vAg
	uNcp708xAOPWShxovWcxTURHglXKZm63Rfqqr89yhOBqcusi4Z4GDNMskl5XHizj/aml2ZuzObY
	9S9wMXtk7uy3NfjmkJLUqpRm+5yzw3VmR9q1dF8rMt5EIZRiEjhhznYTb+lyB70EVtux/9lGe6O
	LqxEPweDFMd5f4+xmoJwyJ+WWuVZWT6jlWyx6t1rsdHOOQOHqZSfAn5Bz5SYwJsYFHhLEqdIjKL
	N3598Aa6TgwzjV
X-Received: by 2002:a05:7300:188b:b0:30c:61d4:d463 with SMTP id 5a478bee46e88-30c69126ce2mr1814952eec.3.1782266964407;
        Tue, 23 Jun 2026 19:09:24 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba57dc4sm19421070eec.9.2026.06.23.19.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 19:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 22:09:20 -0400
Message-Id: <DJGWWQQD3B0P.2O1D9MO17YRK4@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <jordan@jrife.io>,
 <kuba@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 3/7] bpf: add bpf_icmp_send kfunc
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-4-mahe.tardy@gmail.com>
In-Reply-To: <20260622120515.137082-4-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301526-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,etsalapatis.com:mid,etsalapatis.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E15B6BADD3

On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs. We also extend this kfunc to tc
> program as a convenience.
>
> This reuses concepts from netfilter reject target codepath with the
> differences that:
> * Packets are cloned since the BPF user can still let the packet pass
>   (SK_PASS from the cgroup_skb progs for example) and the current skb
>   need to stay untouched (cgroup_skb hooks only allow read-only skb
>   payload).
> * We protect against recursion since the kfunc, by generating an ICMP
>   error message, could retrigger the BPF prog that invoked it.
>
> For now, we support cgroup_skb and tc program types. For cgroup_skb and
> tc egress, almost everything should be good. However for tc ingress:
> - packet will not be routed yet: need to set the net device for
>   icmp_send, thus the call to ip[6]_route_reply_fill_dst.
> - fragments could trigger hook: icmp_send will only reply to fragment 0.
> - ensure the ip headers is linearized before processing, and zero out
>   the SKB control block after cloning to prevent icmp_send()/icmpv6_send(=
)
>   from misinterpreting garbage data as IP options.
>
> Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> The interface accepts a type parameter to facilitate future extension to
> other ICMP control message types.
>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce..fc69a14650e4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -84,6 +84,8 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <linux/icmpv6.h>
> +#include <net/icmp.h>
>
>  #include "dev.h"
>
> @@ -12546,6 +12548,101 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md=
 *x, u32 len)
>  	return 0;
>  }
>
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supporte=
d)
> + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> + *
> + * Sends an ICMP control message in response to the packet. The original=
 packet
> + * is cloned before sending the ICMP message, so the BPF program can sti=
ll let
> + * the packet pass if desired.
> + *
> + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6=
) are
> + * supported.
> + *
> + * Return: 0 on success, negative error code on failure:
> + *         -EINVAL: Invalid code parameter
> + *         -EBADMSG: Packet too short or malformed
> + *         -ENOMEM: Memory allocation failed
> + *         -EBUSY: Recursion detected
> + *         -EHOSTUNREACH: Routing failed
> + *         -EPROTONOSUPPORT: Non-IP protocol
> + *         -EOPNOTSUPP: Unsupported ICMP type
> + */
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int c=
ode)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	struct sock *sk;
> +
> +	sk =3D skb_to_full_sk(skb);
> +	if (sk && sk->sk_kern_sock &&
> +	    (sk->sk_protocol =3D=3D IPPROTO_ICMP || sk->sk_protocol =3D=3D IPPR=
OTO_ICMPV6))
> +		return -EBUSY;
> +
> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP):
> +		if (type !=3D ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH)
> +			return -EINVAL;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
> +			kfree_skb(nskb);
> +			return -EBADMSG;
> +		}
> +
> +		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> +
> +		icmp_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +#endif
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (type !=3D ICMPV6_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {

Minor nit, but this may also fail with SKB_DROP_REASON_NOMEM. Now this is o=
nly
possible if the IP header is not in the linear space which may well be
impossible (?), but do we want to differentiate with
pskb_network_may_pull_reason()?

> +			kfree_skb(nskb);
> +			return -EBADMSG;
> +		}
> +
> +		if (!skb_dst(nskb) && ip6_route_reply_fill_dst(nskb) < 0) {
> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		memset(IP6CB(nskb), 0, sizeof(struct inet6_skb_parm));
> +
> +		icmpv6_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +#endif
> +	default:
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> @@ -12588,6 +12685,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
>  BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
>
> +BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
> +BTF_ID_FLAGS(func, bpf_icmp_send)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
>  	.owner =3D THIS_MODULE,
>  	.set =3D &bpf_kfunc_check_set_skb,
> @@ -12618,6 +12719,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_s=
et_sock_ops =3D {
>  	.set =3D &bpf_kfunc_check_set_sock_ops,
>  };
>
> +static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send =3D {
> +	.owner =3D THIS_MODULE,
> +	.set =3D &bpf_kfunc_check_set_icmp_send,
> +};
> +
>  static int __init bpf_kfunc_init(void)
>  {
>  	int ret;
> @@ -12639,6 +12745,9 @@ static int __init bpf_kfunc_init(void)
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR=
,
>  					       &bpf_kfunc_set_sock_addr);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_=
kfunc_set_tcp_reqsk);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf=
_kfunc_set_icmp_send);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_=
kfunc_set_icmp_send);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_=
kfunc_set_icmp_send);

Based on Sashiko's feedback, since we mostly care about cgroup_skb
should we just make it exclusive to them and drop CLS_ACT?

>  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kf=
unc_set_sock_ops);
>  }
>  late_initcall(bpf_kfunc_init);
> --
> 2.34.1


