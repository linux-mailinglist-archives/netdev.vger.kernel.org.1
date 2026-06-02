Return-Path: <netdev+bounces-294354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TAs8LeUmH2q5iAAAu9opvQ
	(envelope-from <netdev+bounces-294354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:54:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF396313B9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:54:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EqZ6N0at;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294354-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294354-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 828133051669
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19739A068;
	Tue,  2 Jun 2026 18:52:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC527456;
	Tue,  2 Jun 2026 18:52:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426361; cv=none; b=fCXf9leBhtddws+wLdYh4bntmLkOsXiczO/VubEP7x3WmVrOGUBWjuKbfkPJSenbHBTNjgEBtSn8RqXnNclwOwJXjK7UKVyMiteB6lHLU8m9qL/Aj9B2O4SyKkW9gJAtry1DPq2HxCdTRxcfYSr9qc4D2qwuLNCiMTZVVqDI2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426361; c=relaxed/simple;
	bh=yizmoEufT4LuJhOhvRfAjHi3x1bh3w5DKeNV82JMsg0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CkWbIECJycXXFyelk1FmqSLLLWkglU42xRY7fQr8ny744glviavGVrICDGukmx3xx/7Ni9K9OizoY+Lw/xAuMJMgT55qwuTIQWyZHJyTSSyuk4MPCL9rLh12pUWpluWabt4WDJg6agfM4M2agTh4W24WJwZGT4/XVjTkC5UPgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqZ6N0at; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB151F00893;
	Tue,  2 Jun 2026 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780426359;
	bh=Bo6aOVo8LDHYo2+MLRqTwaQ3pBoJA7p61l98fgTZFnU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EqZ6N0atmayUWpAwRnzKQM1LXZHTW3jRr16qguQTHRm5LYAymnOT39UgqR8nflSAf
	 2zrgtUADyKkrCKNcBoFBlGshQ7Oym5n07GpvvbOkAsayP6jv94Ckw3LX+r4uSH55QS
	 UQpn45Q5P28Zqe1wixlNqFPssct8eJ/nB0AHuQZTcRxEXphYNUTeibzVfTLkiLb5GA
	 8zaDHIoD2fG2O6MqxR2olx+3NcrjDh5Fta1HHcslec1LoH9xFlvR0OiabWJv7UuJLt
	 v5lZi07Q5MOjXNE5c4Ol4Xphhg8ZT/pXgZOfVHEQT7IlTvubM80ICSIAZOAcFAyifE
	 4m2G2kdGZiJBg==
Content-Type: multipart/mixed; boundary="===============8360416226903704082=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab4c5a06490725f0b61352897e74199fd78b444c15c55cd06c44f08e6a4d258b@mail.kernel.org>
In-Reply-To: <20260602181428.2318919-2-ntspring@meta.com>
References: <20260602181428.2318919-2-ntspring@meta.com>
Subject: Re: [PATCH v11 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
From: bot+bpf-ci@kernel.org
To: ntspring@meta.com,netdev@vger.kernel.org
Cc: edumazet@google.com,ncardwell@google.com,kuniyu@google.com,davem@davemloft.net,kuba@kernel.org,dsahern@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,linux-kselftest@vger.kernel.org,ntspring@meta.com,bpf@vger.kernel.org,martin.lau@linux.dev,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 18:52:39 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294354-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,meta.com,linux.dev,iogearbox.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ntspring@meta.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,m:ast@kernel.org,m:andrii@kernel.org,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AF396313B9

--===============8360416226903704082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index de9f68a9c0cf..3b6565a53b96 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c

[ ... ]

> @@ -7633,6 +7635,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>  	tcp_rsk(req)->af_specific = af_ops;
>  	tcp_rsk(req)->ts_off = 0;
>  	tcp_rsk(req)->req_usec_ts = false;
> +	tcp_rsk(req)->txhash = net_tx_rndhash();

[ ... ]

> @@ -7656,7 +7659,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>  	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
>  	inet_rsk(req)->ir_iif = inet_request_bound_dev_if(sk, skb);
>
> -	dst = af_ops->route_req(sk, skb, &fl, req, isn);
> +	if (want_cookie) {
> +		isn = cookie_init_sequence(af_ops, skb, &req->mss);
> +		tcp_rsk(req)->txhash = isn;
> +	}

Should this txhash assignment be guarded so it only applies to IPv6?

For the want_cookie path here, isn is the SYN cookie.  For IPv4 that
cookie comes from __cookie_v4_init_sequence() -> secure_tcp_syn_cookie(),
whose low bits encode the mss index (mssind).  tcp_make_synack() then
does:

net/ipv4/tcp_output.c:tcp_make_synack()
	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash),
		     PKT_HASH_TYPE_L4);

so for IPv4 the SYN-ACK skb->hash becomes the mssind-biased cookie value
instead of the uniformly-random net_tx_rndhash() the old code assigned
below.  skb->hash drives TX queue selection (netdev_pick_tx/XPS), so
under an IPv4 SYN flood the SYN-ACK transmit-queue distribution would be
biased by mssind.

This seems to be the same bias the commit message says the v4 path
should avoid:

  IPv4 sockets retain net_tx_rndhash() since IPv4 ECMP does not use
  sk_txhash and the v4 cookie has mssind bits that would bias queue
  distribution.

That net_tx_rndhash() guard was applied in cookie_tcp_reqsk_init() (the
full-socket path), but the parallel assignment here in tcp_conn_request()
is not guarded by sk_family / AF_INET6.  For IPv6 the cookie-as-txhash
looks intentional (it keeps the SYN-ACK on the same ECMP path that
cookie_v6_check() later picks), so only the IPv4 case appears affected.

> +
> +	dst = af_ops->route_req(sk, skb, &fl, req, want_cookie ? 0 : isn);
>  	if (!dst)
>  		goto drop_and_free;
>

[ ... ]

> @@ -7714,7 +7722,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>  	}
>  #endif
>  	tcp_rsk(req)->snt_isn = isn;
> -	tcp_rsk(req)->txhash = net_tx_rndhash();
>  	tcp_rsk(req)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26839485409
--===============8360416226903704082==--

