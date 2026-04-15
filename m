Return-Path: <netdev+bounces-278848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFdqCKHL32nVYwAAu9opvQ
	(envelope-from <netdev+bounces-278848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:32:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 367AC406D25
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 19:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F15F3006B38
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171043EC2FF;
	Wed, 15 Apr 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hDOnBqER"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBAA3ED10A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274333; cv=none; b=BH7psHk7GaoPIy+h22+S09NxqWK8h8XM2gVL5QYFfDg9kXdGvKzo5s32wb7XiZ1ZnwX4JSGIuWSLEUNBeKhOqNcHHDEEvzGoxTTqNAcPKptXa9ELrj9tGtpqPMtenlow/gX8I+lfkeTEa1QJIb4sW6gwkNwRlv+Dtsit8Vfv5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274333; c=relaxed/simple;
	bh=1I1KmVFUZ5qSJm4NxYrqYBOrSRz2EsAkrxr7eQWclx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNm7o8qR2vHk0JzXvhb/WagF6qo/YUx5rOvnIqCxbiBPnFT+vIU8Rm51ZJFWW2q1oXdm+aHYN36o2sXfDr7UHfuodWQuUKj41Qk5jacDLM+z2MtUorMaqi6AvIoE8DBJ60oW9gvR4prXbfvQ7gJWHQMKlLZilEKOfuU/xtUgYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hDOnBqER; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Apr 2026 10:31:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776274315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1E9SNK8votdUUiELWyxRQ1UqK27dc1Rr/hhOeHUwdoA=;
	b=hDOnBqERvoCMz08Ir2a3RtH+hTMsuZ4BHDTcoUHor1IZRAhPilXWIUhAICj9zqewdfmNRc
	CxDxjRzmrJWSzPAUsBdiRx4ADUm0M9s1W+KRe9Opybqq+1xWD0G5y9tVAifm2xnEKIMSdT
	DqIHDxj21hZEfv2aLmnCLD0AfpZB6Xg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, shuah@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>, 
	Kaiyan Mei <M202472210@hust.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: tcp: Reject TCP_NODELAY from BPF hdr
 opt callbacks
Message-ID: <2026415171036.QLi9.martin.lau@linux.dev>
References: <20260414112310.1285783-1-kafai.wan@linux.dev>
 <20260414112310.1285783-2-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414112310.1285783-2-kafai.wan@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [4.34 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278848-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,vger.kernel.org,std.uestc.edu.cn,hust.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.492];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hust.edu.cn:email]
X-Rspamd-Queue-Id: 367AC406D25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 07:23:09PM +0800, KaFai Wan wrote:
> A BPF_SOCK_OPS program can enable
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG and then call
> bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB.
> 
> That reaches __tcp_sock_set_nodelay(), which may call
> tcp_push_pending_frames(). The transmit path then computes TCP
> options again, re-enters bpf_skops_hdr_opt_len(), and invokes the
> same BPF callback recursively. This can loop until the kernel
> stack overflows.
> 
> TCP_NODELAY is not safe from the header option callback context.
> Reject it with -EOPNOTSUPP when TCP header option callbacks are
> enabled on the socket, so the callback cannot recurse back into
> tcp_push_pending_frames() through do_tcp_setsockopt().
> 
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn/
> Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
>  net/ipv4/tcp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 202a4e57a218..7ac4c98be19d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4004,7 +4004,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
>  
>  	switch (optname) {
>  	case TCP_NODELAY:
> -		__tcp_sock_set_nodelay(sk, val);
> +		if (val && BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))

It will break the syscall setsockopt and also break the existing bpf prog
that calls bpf_setsockopt(TCP_NODELAY) in CB other than the
BPF_SOCK_OPS_HDR_OPT_LEN_CB/BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

Lets brainstorm other options suggested on the list that have smaller
blast radius.

pw-bot: cr

> +			err = -EOPNOTSUPP;
> +		else
> +			__tcp_sock_set_nodelay(sk, val);
>  		break;
>  
>  	case TCP_THIN_LINEAR_TIMEOUTS:
> -- 
> 2.43.0
> 

