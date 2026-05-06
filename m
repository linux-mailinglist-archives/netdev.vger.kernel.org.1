Return-Path: <netdev+bounces-284782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCw8LHkX+2lGWgMAu9opvQ
	(envelope-from <netdev+bounces-284782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:27:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF84D94E0
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA740300E703
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1093F2115;
	Wed,  6 May 2026 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tj1uuxf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D472FFDCB
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063223; cv=pass; b=eMiScwAAIAbERdCeyV3eIHshN05M4Wx3MxDMTC6vtcKWpK2l6YWOAwm6yb1pLquZUwkxF9O1LRhvKk1owe1qgoA+JWMrht7JbUMOIeuzIxXyWocnnoBFOfO/xv5qs1ct0EJiqNlGhF0raorxfsA6S7u2fCIBzHNqEPFEC7WEeXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063223; c=relaxed/simple;
	bh=BUbT17XTF4LpPJHK9/Oas04DkUEoDV1irwxbSDXDlno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDuYL54ao8/7OLHJ88aRcsu15E/6ROLmZKeNgqRUvht0hyu6elrw7795ztjh7wC1mKhOkvaof94jjW0K3PlK+/Cj5f8cnqruRy7qpdhkG97PUbdlwTJAh90XkTIzCb9IY3nQG9/XILOr2EwnfAqr4ieza6iEMGNQNp5zA/q6NdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tj1uuxf8; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fb8e9a4edso74810041cf.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 03:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778063221; cv=none;
        d=google.com; s=arc-20240605;
        b=RRaCM5+PvL5mdOx/6V8sOMevfMxafGA07e9ZowMgqrLeamvFGBV9qhk6lFeTU34lI4
         iAzEbvr7vZO0f7KKl1PJggg9KdYJZvoz6yjdzgyQVxvY2onF4WqapDYj0u490n+iKHoN
         zOfFSJQkw7SWIurnGUNZt1JXk+vvSjk7pfEOcCEGkU49naL7y5KKVWik+NGmjA1gXjW1
         MDPI2swqu5CaTl9OjlsJoDNn7N6TX5eL6wUPltpyYhyWpz9cJHeIWLfPZAtVE0qi9OSr
         +az13yJJj7i2VzPrpu+MBuTBC1gFkG5f16aOQA61U4NB8thBw6BlXp4FKv2+l9E6WHi3
         RTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+LNsuU6CiH2blZgmZ8ZjMHqPo4F0AV+gbi/DnSg3g7c=;
        fh=QwkOJ6+oOLw3lIfOpb2uhSBYRrQkUkjas9ApHHea0c8=;
        b=E/5LL+8kQ6SqZcnVv4xyY7kM0Se7g2RUtx+7vpUShCLEN8uqDhxYUBu19B4n+9UqEY
         aTT7H6bADHp0eJZ7inhuugbL4lc74QK7cNHnIvIQsQNg74NWqLdTl2qFC6lwMqVMpEnt
         U3rJ6PtxK5T1w4qog1qS8gqImIrmX5biG0e11WVMaoiiK1/m5W4745554QLb6QGfwsDP
         JAyzkrqj753gosixqmvYhS0LK9OMTZgHSF3vCH4P6R+tsqXiEQUM4m8i4e86MIApEaQN
         wgNZV8xdu3HXrglWOcLtNhXU6qWdo5o6b2EtmRUkHDH25GffMdUZaqmgdDeEq2/yvDj8
         g5HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778063221; x=1778668021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LNsuU6CiH2blZgmZ8ZjMHqPo4F0AV+gbi/DnSg3g7c=;
        b=tj1uuxf8VqACmWCOiKgy5AUIZXVKRJE2HMG7Lmcz2q8rJ2nYJm26i/wyQGcXEDitRO
         Jb3HtDaBix37PsFrp3V7EKDWLcLcgndsrXRrtAyy+IirstyU2o70C8wWQdgqyTKKAsdj
         93gdKe2hCkKTIoLH+Z3k8kT6GkkR4G+YAI5MUnPB6uLYeg2pvxXwpUAFsxMQ/1f6d8S+
         0AwOo8Gb0oqTvRaMk7HwkHGY+P+V7jgt5OVV+vEm6D+UNV4q56QkuDOmCf9pMiAYiMzr
         wLWxbEYspEhKEpcjFZUF50fxBemHlVHmzrqZJd+gcP9VpL8YThbgdkqG07xi+qrCN+tI
         Y0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778063221; x=1778668021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LNsuU6CiH2blZgmZ8ZjMHqPo4F0AV+gbi/DnSg3g7c=;
        b=Hgrpd/m7MIX69egt9vpMJmBFMRa8MgSBtOi4uSbWewSHx4lCZabWSuxWlGFdjj+cbT
         T6GtnUMBRTf29/JVx48usU8keBh5R3NWeZ7qGcsmLT8i7wBYr0UQ+Ztljmf3nhz54crN
         zV1WI8UQ+BjA9LZtUfrhAbN+Y3o0bZusRNnLKGzj3CTKtjPLj5G4v4GIWFJJh0IKf7m/
         tArwmaOicvUqbj6u+bK0GyZtD+zd+3MmPkef2HvVR32mODH6Ii4Qu0DruS40QPdDX59T
         jlm+a/qp41YnBF0m0C2vKBef0mG8KOJtasrjFVCC1MHLHRaFZymf0+cG4DaisoZ3O1/h
         QOYQ==
X-Gm-Message-State: AOJu0YwDTlj5WIqbyMMfT6kIVreWmWVsNKF5UD8O2dTAaQg+tGvOCZ8N
	Rds5AKi4F9QIxEDP7K3WLavVWHQBjexhknDdPxY1IOapmLIsKlGkkTX9JO+2mg3uR+ntbClbl4+
	pnhJWKAbNghhwPvqZ+amBWZ2Ow+wArND5Vu2lNw67ZBbDWaWdRbmIL1ZJnuA=
X-Gm-Gg: AeBDieudtablidKyRbllvoBj4H12MJnpCs3ri1ghG3gSeYcSFU3T+vrTJeYr8klunnI
	Y5ya9hAy/CZs+5urlSetzkH6a7s5h2JYCZxF/aW0L+rgMea2WnWklcNlQ+5G4wRNnW5jjQ9+Fn2
	SJRa0EniPHYnBXbeaJNH3ZhzbckU8EUA3wEpH2ZbJZfbK8zdoZe9Yjb61e57W7vQ0nT59iCxkZi
	rWqylD91fSqjOVp9MSpiHLX5vXADhphqF6zIarP5/eegoME1RmiMxgLNzyzKzjQZUAhLMwVIyJV
	zx/7ybyAMKj2kzN7p0CLqvgiJ+Gc5oJjjDqlsSBh9PfRkMJsR5OLnlcRQG7r7Ik4xeJUMPQcZCc
	P+FB3ou18WJIk9IvwzkbL1P44uz84Wvc0HTi43G0=
X-Received: by 2002:a05:622a:5a87:b0:50e:57de:40d7 with SMTP id
 d75a77b69052e-51461c25ab7mr42990321cf.19.1778063220396; Wed, 06 May 2026
 03:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505193824.2791642-1-ntspring@meta.com> <20260505193824.2791642-2-ntspring@meta.com>
In-Reply-To: <20260505193824.2791642-2-ntspring@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 May 2026 03:26:48 -0700
X-Gm-Features: AVHnY4KB3FX_UYJ57dg4M3K-0J-h-uHJJxgpTeBRnnuXQsGBSyyO5b_9vDXMv3k
Message-ID: <CANn89iLPxD6ukS7K8NRX0Lox8MXvqWoTTm2P5rQmYhKn7H1n1A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1CFF84D94E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284782-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]

On Tue, May 5, 2026 at 12:38=E2=80=AFPM Neil Spring <ntspring@meta.com> wro=
te:
>
> Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
> and spurious-retransmission events, but the cached route is reused and
> the new hash is not propagated into the ECMP path selection logic.  Two
> changes are needed to make rehash select a different local ECMP path:
>
> 1. Add sk_dst_reset() alongside sk_rethink_txhash() in
>    tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
>    tcp_plb_check_rehash() so the cached dst is invalidated and the
>    next transmit triggers a fresh route lookup.
>
> 2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
>    SYN/ACK retransmits) in inet6_sk_rebuild_header(),
>    inet6_csk_route_req(), and inet6_csk_route_socket() so
>    fib6_select_path() picks a path based on the new hash.
>
>    It is necessary to update mp_hash explicitly because the
>    default ECMP hash derives from fl6->flowlabel via
>    np->flow_label, which is not updated from sk_txhash
>    (REPFLOW is off by default).  ip6_make_flowlabel() cannot
>    help either, as it runs after the route lookup.
>
> Signed-off-by: Neil Spring <ntspring@meta.com>
> ---
>  net/ipv4/tcp_input.c             | 4 +++-
>  net/ipv4/tcp_plb.c               | 1 +
>  net/ipv4/tcp_timer.c             | 1 +
>  net/ipv6/af_inet6.c              | 3 +++
>  net/ipv6/inet6_connection_sock.c | 6 ++++++
>  5 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7995a89bafc9..126dffd675c9 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5020,8 +5020,10 @@ static void tcp_rcv_spurious_retrans(struct sock *=
sk,
>             skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>             (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=3D
>              ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
> -           sk_rethink_txhash(sk))
> +           sk_rethink_txhash(sk)) {
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREH=
ASH);
> +               sk_dst_reset(sk);

I think it would be nice to use __sk_dst_reset() in TCP, to reflect the fac=
t
that we own the socket lock.

