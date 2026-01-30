Return-Path: <netdev+bounces-255040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJF3BcNcfGkYMAIAu9opvQ
	(envelope-from <netdev+bounces-255040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:24:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E2AB7E3B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5C2B300405F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3492620E5;
	Fri, 30 Jan 2026 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unha1+yh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BE2E40B;
	Fri, 30 Jan 2026 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757886; cv=none; b=L6ZlttmAQafetOMhB9V9gRlWaeN10w0L+IzWoCqbPKkkZxnQhiCqG+54VwHIZVsM3PW8CVCQqnElkDwsbyWl5gBF4otfgtAQwXofKF8pB9jm6p+WtBNyveW+lrjVmTM0QGtSborGrOhjl7xv6f2QV+kfrldYxZZbmk+uRWtxoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757886; c=relaxed/simple;
	bh=RbhFroj7QvFytoXKlKRjIPa9axlhRKn1uHD6xwFo1BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFlLikMpfLT+7uSSOSntN3FQr9JyG/snUFVuak9T/C1+ryTYCz2BczsJ2b75MCV+WyZYQ6Pg9Lwbuxg5K4YCsusAt5g2/fz9QNGYgCut9rZq3QwWHq/QIgke05G/O67KJWdz5vu+K32ai/1Aj9oWIzaFKKe8QHST+ML5xJff+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unha1+yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FEEC16AAE;
	Fri, 30 Jan 2026 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769757886;
	bh=RbhFroj7QvFytoXKlKRjIPa9axlhRKn1uHD6xwFo1BY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=unha1+yh66kWGGnn5Gcx+HVndwjjObB/bZL9TFAhLbNCy8YPFtVqltsAru70YrcMM
	 vApnGxs+LWIMSXhwPAszLQHnbBp4xFWkCV8ltQWyJDmV9a3ppbigxDwRHf83s7Do+C
	 kfXx5UcbQ3NakElgMs+bo0rRxat0A9iCRdoG/l8afgltxbDs/chALlUH1RRzdwu/Hj
	 Lgb34v/4KyWAxQeJsaCoHPV8M9RcggG9QsxFfVq4Kp/DPeQ/XihDyPkPv4wfi7SlaL
	 dgRPtePYrOmNmqaf2WEfwkWlg6FRTChCHwoBPuCmflQ8+lU+oQtvsHYR4maZpHFBW/
	 BLiphRJDJdgRw==
Message-ID: <0f074dd6-6a37-4f7e-bdd3-528f201fc8f1@kernel.org>
Date: Fri, 30 Jan 2026 08:24:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] mptcp: implement .splice_read
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
 <20260129-net-next-mptcp-splice-v1-4-994cac40daa0@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260129-net-next-mptcp-splice-v1-4-994cac40daa0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255040-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31E2AB7E3B
X-Rspamd-Action: no action

Hello,

On 29/01/2026 20:23, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch implements .splice_read interface of mptcp struct proto_ops
> as mptcp_splice_read() with reference to tcp_splice_read().
> 
> Corresponding to __tcp_splice_read(), __mptcp_splice_read() is defined,
> invoking mptcp_read_sock() instead of tcp_read_sock().
> 
> mptcp_splice_read() is almost the same as tcp_splice_read(), except for
> sock_rps_record_flow().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c58e306ec3ef..3aee29f70954 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4396,6 +4396,118 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	return __mptcp_read_sock(sk, desc, recv_actor, false);
>  }
>  
> +static int __mptcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
> +{
> +	/* Store TCP splice context information in read_descriptor_t. */
> +	read_descriptor_t rd_desc = {
> +		.arg.data = tss,
> +		.count	  = tss->len,
> +	};
> +
> +	return mptcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
> +}
> +
> +/**
> + *  mptcp_splice_read - splice data from MPTCP socket to a pipe
> + * @sock:	socket to splice from
> + * @ppos:	position (not valid)
> + * @pipe:	pipe to splice to
> + * @len:	number of bytes to splice
> + * @flags:	splice modifier flags
> + *
> + * Description:
> + *    Will read pages from given socket and fill them into a pipe.

This comment is a copy of tcp_splice_read() where only the first line
has been adapted, but this seems to cause a new kdoc warning:

  net/mptcp/protocol.c:4424 No description found for return value of
'mptcp_splice_read'


I guess something like that should be added in a v2:

  Return:
     Amount of bytes that have been spliced.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


