Return-Path: <netdev+bounces-289062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJHwIYARC2pN/gQAu9opvQ
	(envelope-from <netdev+bounces-289062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:17:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA456D79A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 727953060DEB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EBA48035F;
	Mon, 18 May 2026 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCkNx4CO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023245107A;
	Mon, 18 May 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109291; cv=none; b=W+0d6HhsFaOSAdA00ySI1BUsWKNlZp9eNuTyH+o9ycqtseiqDfXpWHOXw1czkWY4DgYfyCqZKjvBxtqVi7ODhIkpAQ7OpAVKLESGKtVUgWPNb1G1TLmRpkDFROmZD3L7LQHXe8lAvzLv+iFeu0p13GmSpWRX5ufMrfPj6F18BNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109291; c=relaxed/simple;
	bh=hojHRr+PheKoQ7m5OKEUeo0v+iLPsIfkBZlaT1Myalg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQwFOZUhGGXkaDVwEdlNd97JopeBadvFFeNBtK7UosozmUWAfrQmxA2SaX290/06JIOiM2N04oLbgUpHOl9IB+VRF55F7kHwAh3jmMqO/NH4Gw2TtqIx0KAp06vxVVnMg9pN8YjccY5Ss0WcXVhKuy0HkNsAUR1COfS3ggRMAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCkNx4CO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36914C2BCB7;
	Mon, 18 May 2026 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109290;
	bh=hojHRr+PheKoQ7m5OKEUeo0v+iLPsIfkBZlaT1Myalg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iCkNx4COB7SMaKeftGoydd9hWGfaLWmMcABqSc/aDRmNTLoszje2E78szvbBWyGOF
	 fY0oHcTNfwEHadVc2//53yGKZ+4JLrOVIEqxyHhbFYyolq/T+Wcnm8Z1TBz3OUEO0f
	 4JwIS+dtdmoOcxLge3kMaDgrGq3Y1IwNS4nAG+6GMZr6gvcfzmVqNPFhYjnrLJgl5B
	 eikuxuVBGsHT7MECuGfR1ri0vU8DY6RS6/1WQ3eGaQobkRjyA+ijYvSnTn01IOQ2eq
	 CoV1OInrdeR8/8erKc8ose8yipMm+grip2W5tohSMzhwkzx7qsTgvkYfqynMGZ7z8l
	 W3hEgd3Oz2wgg==
Message-ID: <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
Date: Mon, 18 May 2026 15:01:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 Simon Sundberg <Simon.Sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hy?=
 =?UTF-8?Q?gensen?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260518082344.96647-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8BEA456D79A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289062-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,kau.se,toke.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 18/05/2026 10.23, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add two if statements to accurately isolate bpf timestamping and so
> timestamping. They can work respectively.
> 
> As to so_timestamping, only add a loose condition via report flags
> to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> and performance impact. If the loose condition is hit,
> tcp_recv_timestamp() is able to handle the exact case and doesn't
> hamper the existing timestamping feature.
> 
> Make it work in TCP protocol.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   net/ipv4/tcp.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 21ece4c71612..64c69bb3578a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
>   	release_sock(sk);
>   
>   	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
> -		if (cmsg_flags & TCP_CMSG_TS)
> -			tcp_recv_timestamp(msg, sk, &tss);
> +		if (cmsg_flags & TCP_CMSG_TS) {
> +			u32 tsflags = READ_ONCE(sk->sk_tsflags);
> +
> +			if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +			    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> +				bpf_skops_rx_timestamping(sk, &tss,
> +							  BPF_SOCK_OPS_TSTAMP_RCV_CB);

Does this mean I can enable timestamp reading per cgroup?

In Simon's netstacklat[1] tool we are forced process all RX timestamp
(hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[2] on
the cgroup IDs that we are interested in (which is a significant
overhead, as this is deployed at Cloudflare production scale).


[1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat

[2] 
https://github.com/xdp-project/bpf-examples/blob/main/netstacklat/netstacklat.bpf.c#L484-L488


> +			if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> +			    tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> +			    tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> +				tcp_recv_timestamp(msg, sk, &tss);
> +		}
>   		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
>   			msg->msg_inq = tcp_inq_hint(sk);
>   			if (cmsg_flags & TCP_CMSG_INQ)


