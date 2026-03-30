Return-Path: <netdev+bounces-273104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEoONTw8ymnD6gUAu9opvQ
	(envelope-from <netdev+bounces-273104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:02:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC07F357AF4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 311FC3020A79
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FD3AEF3E;
	Mon, 30 Mar 2026 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHMUigPl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601737F749;
	Mon, 30 Mar 2026 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861241; cv=none; b=nkzJajWy+Uxe5CZbXKv0LXMML86Z7xzTyu4zYD2mTkGPbIrvl6ML1JRRPlZWhrw+d8cmi2p94xN+JUySzYu2nqAGmK1YFnG40M3E6xKs69IyqhYFSi+U9MD/VWYzQwv39+2MqhOEON4yYwPgi+ns+cqhxiNf69i2d+ym843zLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861241; c=relaxed/simple;
	bh=vuKopLxiQ6DJEOs3R1LaTxwbfB5g3ZLWVX3uJgUva1E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QYg1S3Cx1Udr0pVjsBosAvjxGHa1VRFroq8ELY2UUYky0bYeXekRHOKCx8ZvxaNEJlKfVIuvGkZKiMMc7PJpArYFi3UYLGkIVmo1/NjLlVW+HUG6ijGnItNEsQecrn6q1FB50n6dKsNNk++GRjOTKscO/vtBZy65ZQJQmyOko6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHMUigPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2207CC2BC9E;
	Mon, 30 Mar 2026 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774861240;
	bh=vuKopLxiQ6DJEOs3R1LaTxwbfB5g3ZLWVX3uJgUva1E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VHMUigPlUFNhup3Q8tTS1MS7lj7/20UFqlyXIfptK98y5aziKtJyz/uHsaQEsNCGu
	 IUkhSpQUvwuHqMfpPIp0MCDF+0BhpVCX9TTIvZQzqJJJjlvivKlGujy2nzDBVTA4PH
	 YgJS9/uWKYdhk4b22jC2z1v+U4DQHSy7wP0zc6LBgHCWnzMNMPgyr5ckfTwOxozg0Z
	 AssDLPyaNqK5Vqe6NCPcn+HWIVs60cNK/gy9VTF3uWEkl3PzOysR5iaI79XgpTnM1r
	 mmFeqKXAEErXq9BE16lc1h2Hf1UhKIlLFVVYDFQOpLP2bqh9TWQ4XySdyQBobZ2JBt
	 9GYyECWECxYVg==
Content-Type: multipart/mixed; boundary="===============6759854404622828131=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
In-Reply-To: <20260330080746.319680-2-jiayuan.chen@linux.dev>
References: <20260330080746.319680-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,kuniyu@google.com,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 30 Mar 2026 09:00:40 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,google.com,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,redhat.com,vger.kernel.org,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273104-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_NONE(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC07F357AF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6759854404622828131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..fb975bcce804 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12248,11 +12248,17 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
>
>  	switch (skb->protocol) {

[ ... ]

> #if IS_BUILTIN(CONFIG_IPV6)
>  	case htons(ETH_P_IPV6):
> +		if (ipv6_hdr(skb)->nexthdr != IPPROTO_TCP)
> +			return -EINVAL;
> +
>  		ops = &tcp6_request_sock_ops;

For IPv6, ipv6_hdr(skb)->nexthdr gives the type of the header
immediately following the base IPv6 header. If extension headers
are present (hop-by-hop options, routing, etc.), nexthdr would be
the extension header type rather than IPPROTO_TCP, even when the
packet is a valid TCP segment.

Would it be worth using ipv6_find_hdr() here, similar to
bpf_update_srh_state() in the same file, to walk past any extension
headers? The IPv4 check above is fine since ip_hdr(skb)->protocol
always identifies the transport protocol directly.

In practice this is very unlikely to matter since TCP SYN packets
with IPv6 extension headers are essentially non-existent, but the
check as written would reject them.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23735111188
--===============6759854404622828131==--

