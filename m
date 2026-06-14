Return-Path: <netdev+bounces-299226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4JLcBrCyLmrn1wQAu9opvQ
	(envelope-from <netdev+bounces-299226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:54:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BACE68139B
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:54:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aDssUIR0;
	dkim=pass header.d=redhat.com header.s=google header.b=rX5jE8SH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299226-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299226-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA4C3007AFE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 13:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FD63C378F;
	Sun, 14 Jun 2026 13:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8888387369
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 13:54:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781445292; cv=none; b=pqBHtHFr4WUPAzTMMBmQo89rgybvP22KNYd4lwcNzvaHg/tvigeDGZtBR5Ipr9a4QXux03nQ8exHA+sl5GYxTLlM9hWj77FF5FTusx1AUQTYfeh0A6dmXgJEAtnfNzDG51gxCyobKFJw3WYsndL8KB53lKANTDydRn+Y/Ok6lrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781445292; c=relaxed/simple;
	bh=8IsoR48HYHt8z+6h+CkbVkeNVCfnjoxPmIGyuZitupw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDTSwHebCQhrOoggWvF6LLnRP0t55ZTsiMCTP6hRX7uCseuC8lng9Uy/KYg6McMabzpEOVFr/FgOReEE8l1bpvJL1WpSfSe9bqc3L7u0nW1ZIIVbujNxcyNJBeKT1eN+Kg7R8Hl2U523dGlbKFHuOEjzRA5/Elhsaf7I2Iik/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDssUIR0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rX5jE8SH; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781445289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+581tBiHg3KRDIQb4ilM0CwMAPM/nzYQ3rJCv1cD2EY=;
	b=aDssUIR0EuOyLG98pgLftToIneZQUMLUf0o48VLfMgsiZa96coZ8kz//zIQrTGzz45JaMa
	lrTKg0Q6cnyRGOOfYOyVIK/ybAe4+0zEnNILb4xvkgzdn7Q9yNicVDLlssY7tiUf7PXcfo
	pZFonsQWZa7QGWHx6kdNEYNJuWSFVlA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-ArdIrOzbPT-kUeJIFz269A-1; Sun, 14 Jun 2026 09:54:48 -0400
X-MC-Unique: ArdIrOzbPT-kUeJIFz269A-1
X-Mimecast-MFC-AGG-ID: ArdIrOzbPT-kUeJIFz269A_1781445287
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eec2ba533so1611390f8f.3
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781445287; x=1782050087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+581tBiHg3KRDIQb4ilM0CwMAPM/nzYQ3rJCv1cD2EY=;
        b=rX5jE8SHxumxpskZ/a2PJckMo6Qgv9YvWSvqcb5mfPB/a4CppXbkJgxPH/ObktOQpQ
         cOy1Y4Jh2UWdyOOOaF/sHvpNc1M6WJVpFcFAaEKMB1tncSEPnART8kw7ideNg6HDqgwF
         QGEMOGNCJe761MAnPAFrb0sKuGlqou35v+DHkTwqHl7MC9Ey9NR6fvD7JidB/ZGPJOrv
         cR1I+/SMzChgsCL4XFx/OpocVMli5vwuf6uOfAkkKXWGtwIYSei7JS2heLun+jYSrGLz
         1QZvXvhpjY5Hjy1O3+q+EmOAwJxMDW4FzHH0f7be/LIERXkEARnrmkPVakHDeKi2eYKR
         k94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781445287; x=1782050087;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+581tBiHg3KRDIQb4ilM0CwMAPM/nzYQ3rJCv1cD2EY=;
        b=YVlNsjthdyseawIL1I5McWBZNxrp5FxG8WkXtcJOZpCf3iO6d6JoZGf0bt408gC05L
         tls8OXmHtIcHajburVsL4HKORDZYo2lwvgrwaB0z/20SkUAjz4MPzEat6UjhUvs5qo/f
         X1OlcZy1tBmFBx7khoADscjFx7UKxcne2RAZYneC1kpp/i7lQikVIm4+gBbKRlrBicLD
         1UfHNCv+l6f6UXyaUv1q2lNdk5bdys5jHko8ju5+9QzCS9jZfHyd47Jh31ofNABj4dBE
         08RZgM1sqprPQXGi6h5lxds06ofYLiUbOisHvxQqVeqye0m7KJBTeTrmk3e+zbOr4g22
         pahQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XiEVZWaIU4eyAhA4e4PK+kijrrPtE0s+mOZBU+fB/mMs4foqxK165EFmOIIk3muvYWTmypAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6f+syHXPp0mJ/EURb5Vd4A5OvsS5yBIj7sMmjCM6s9h2yWbf
	RJMkwi9UGWyewHIDw9gOYKPhTWBJum3bv3BqL2eUgTbkXD4gjeoUcNqJ6CPyLMGotLOa8tz5jnJ
	Uvt+oC+d3RS524hxGtdTXaX+5Zypu6qngNpvuOD2F/cGuyksfWZ7JkKWqDw==
X-Gm-Gg: Acq92OHUxIjxDYcGXlnKWWDhMlMEy1Zs7JNNK/FsAj3rFPBmBX3ry3Xw1D1t2zcP6V/
	6xUPzuupEqbvHmqiLSUgTTw8wpOLBJwV+y4ecEHBv8CRii1Jckj54zAq5X8L9YdXtg/QUg92tlO
	LA65y4RVOR+LmacoOEigmcGxsBA3xL25eJ+vkFBLRNTZG11G5s+Vha31zE1Assm041r+hrmK/OH
	EmvpLwMaSFocD01GsJuzN3TCcpqjJ3kpDI6bMpi6V2bs7/Pu80tlPFP+I19Fk4JayyQB/koy6If
	fUvQ8+i3s+RAGH1xK1tqGHC6grGPddPmqol5Oz6HrDsU1EUYL+93sGTs7ARjGnK5piePzcZSXQU
	Hsz56SsNIVFu2MWjkuVHzpXOO0uAyzE1nNPuHQ5zEx+9dOVvyNFHYRvc=
X-Received: by 2002:a05:6000:40c9:b0:45e:f684:7347 with SMTP id ffacd0b85a97d-46074b822a5mr9486007f8f.12.1781445287244;
        Sun, 14 Jun 2026 06:54:47 -0700 (PDT)
X-Received: by 2002:a05:6000:40c9:b0:45e:f684:7347 with SMTP id ffacd0b85a97d-46074b822a5mr9485972f8f.12.1781445286781;
        Sun, 14 Jun 2026 06:54:46 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b1056sm25168865f8f.18.2026.06.14.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 06:54:46 -0700 (PDT)
Message-ID: <6ab86192-f0d4-4a00-83c9-3fd6449dc9dd@redhat.com>
Date: Sun, 14 Jun 2026 15:54:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
To: Neil Spring <ntspring@meta.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net
References: <20260612010047.1377331-1-ntspring@meta.com>
 <20260612010047.1377331-2-ntspring@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260612010047.1377331-2-ntspring@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299226-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ntspring@meta.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BACE68139B

On 6/12/26 3:00 AM, Neil Spring wrote:
> Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
> and spurious-retransmission events, but the cached route is reused and
> the new hash is not propagated into the ECMP path selection logic.  Two
> changes are needed to make rehash select a different local ECMP path:
> 
> 1. Add __sk_dst_reset() alongside sk_rethink_txhash() in
>    tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
>    tcp_plb_check_rehash() so the cached dst is invalidated and the
>    next transmit triggers a fresh route lookup.
> 
> 2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
>    SYN/ACK retransmits and syncookies) in tcp_v6_connect(),
>    inet6_sk_rebuild_header(), inet6_csk_route_req(),
>    inet6_csk_route_socket(), tcp_v6_send_response(), and
>    cookie_v6_check() so fib6_select_path() picks a path based on the
>    new hash.
> 
> The mp_hash override only applies to fib_multipath_hash_policy 0 (the
> default L3 policy).  Its hash includes the flow label, but that is 0 by
> default -- np->flow_label is unset, and auto_flowlabels only computes
> the on-wire label later, per packet -- so flows to the same peer share
> one local path.  Keying the hash on sk_txhash makes the local path
> per-connection and lets a rehash re-select it.  Policies 1-3 are left
> unchanged.
> 
> The mp_hash assignment is factored into a small helper,
> ip6_ecmp_set_mp_hash(), shared by inet6_csk_route_req(),
> inet6_csk_route_socket(), tcp_v6_connect(), inet6_sk_rebuild_header(),
> tcp_v6_send_response(), and cookie_v6_check().  It applies
> (txhash >> 1) ?: 1 for policy 0 (the >> 1 keeps mp_hash in the 31-bit
> range; ?: 1 keeps it non-zero, since 0 would fall back to
> rt6_multipath_hash()).  inet6_csk_route_socket() calls it only for
> sk_protocol == IPPROTO_TCP so that non-TCP callers (e.g., L2TP via
> inet6_csk_xmit) fall through to rt6_multipath_hash() and retain their
> existing flow-key-based ECMP behavior.
> 
> tcp_v6_send_response() also sets mp_hash from the response txhash so
> that a control packet (a RST from the full socket, or an ACK from a
> time-wait socket) selects the same local ECMP nexthop as the
> connection's txhash rather than falling back to the flow hash.  The
> time-wait socket's tw_txhash is copied from sk_txhash when the
> connection enters TIME_WAIT, so it reflects any rehash that occurred.
> 
> Setting mp_hash explicitly is necessary because the default ECMP hash
> derives from fl6->flowlabel via np->flow_label, which is not updated
> from sk_txhash (REPFLOW is off by default).  ip6_make_flowlabel()
> cannot help either, as it runs after the route lookup.
> 
> As a consequence, for policy 0 the local ECMP path of an IPv6 TCP
> flow follows sk_txhash even when fl6->flowlabel is non-zero, e.g. a
> reflected (REPFLOW) or explicitly set (IPV6_FLOWLABEL_MGR) flow
> label.  This is intentional: only local path selection changes, so
> rehash can recover from a failed path; the on-wire flow label is
> unchanged.
> 
> sk_set_txhash() is moved before ip6_dst_lookup_flow() in
> tcp_v6_connect() so the initial ECMP path is selected by the same
> txhash that subsequent route rebuilds will use.  This avoids
> unintended path changes when the cached dst is naturally invalidated
> (e.g., by PMTU discovery or route changes).
> 
> The rehash sites (tcp_write_timeout(), tcp_plb_check_rehash(), and
> tcp_rcv_spurious_retrans()) call __sk_rethink_txhash_reset_dst(),
> which re-rolls the txhash and, when it changed, drops the cached dst
> so the next transmit re-runs route selection.  The dst reset is
> guarded by sk->sk_family == AF_INET6 since IPv4 ECMP does not
> currently use sk_txhash for path selection.  For IPv4-mapped IPv6
> sockets this produces a redundant dst reset on a cold path
> (RTO/PLB); the subsequent IPv4 route lookup returns the same result.
> The helper is deliberately separate from sk_rethink_txhash() itself:
> dst_negative_advice() calls sk_rethink_txhash() before its own dst op,
> so resetting the dst inside sk_rethink_txhash() would skip that op
> (e.g. rt6_remove_exception_rt()).
> 
> For syncookies, cookie_init_sequence() computes the cookie value
> before route_req() and sets txhash so the SYN-ACK selects the same
> ECMP path that cookie_v6_check() will use when the full socket is
> created.  cookie_tcp_reqsk_init() derives txhash from the cookie so
> the full socket's ECMP path matches the SYN-ACK.  Both the SYN-ACK
> assignment in tcp_conn_request() and the full-socket assignment in
> cookie_tcp_reqsk_init() are keyed on the packet family
> (skb->protocol == ETH_P_IPV6), not sk->sk_family: a dual-stack
> AF_INET6 listener also serves IPv4 connections, and the v4 cookie has
> mssind bits that would bias TX queue distribution if used as txhash.
> IPv4 connections retain net_tx_rndhash().
> 
> cookie_init_sequence() is split from the former version that also
> called tcp_synq_overflow() and incremented SYNCOOKIESSENT; those
> side effects are now in cookie_record_sent(), called after
> route_req() succeeds so they are not bumped when route_req() fails.
> cookie_record_sent() is guarded by CONFIG_SYN_COOKIES to
> match the guard on tcp_synq_overflow().  route_req() receives 0 as
> tw_isn for the syncookie path so that tcp_v6_init_req() still saves
> ireq->pktopts for REPFLOW flowlabel reflection and IPv6 cmsg
> options.  The ecn_ok clear for syncookies without timestamps stays
> after tcp_ecn_create_request() so it takes precedence.
> 
> Signed-off-by: Neil Spring <ntspring@meta.com>

This looks good to me, with a minor commit below.

> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index df479277fb80..cc71d84df42b 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -280,9 +280,18 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
>  	treq->snt_synack = 0;
>  	treq->snt_tsval_first = 0;
>  	treq->tfo_listener = false;
> -	treq->txhash = net_tx_rndhash();
>  	treq->rcv_isn = ntohl(th->seq) - 1;
>  	treq->snt_isn = ntohl(th->ack_seq) - 1;
> +	if (skb->protocol == htons(ETH_P_IPV6)) {
> +		/* Use the cookie as txhash so the ECMP path matches
> +		 * the SYN-ACK, where txhash was also set to the
> +		 * cookie.  The original request socket (and its
> +		 * txhash) was freed after sending the SYN-ACK.
> +		 */
> +		treq->txhash = treq->snt_isn;
> +	} else {
> +		treq->txhash = net_tx_rndhash();

I'm wondering if it would make sense always using snt_isn for txhash in
the syn cookie case, regardless of the IP protocol. Beyond reducing the
differences between ipv4 and ipv6 it will make the code a little simpler.

Not a blocker in any case.

Still I think this could deserve an explicit ack from Eric.

/P


