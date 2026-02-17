Return-Path: <netdev+bounces-259067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHklAO6ElGlBFQIAu9opvQ
	(envelope-from <netdev+bounces-259067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:10:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BEB14D719
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B95963042D74
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6B36CDEB;
	Tue, 17 Feb 2026 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srypdZja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C49224B15;
	Tue, 17 Feb 2026 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340931; cv=none; b=ob7Elia/XjJ/5P3T6jJzdGAjs9UaPT3hTacTg0iuaUeTG3f5gXuPQuFw3Oo/OXvDQBqvxYghXgLIK1EK0lrjyx1xXjNMLSM39346eLzTq3BNWHPQsjfIln76wgl7C9BYmV8jwbAe7FAmgvbVyRU5I3TUB64TXI9jn39UATs4qQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340931; c=relaxed/simple;
	bh=qUqviPhC+lO0du3PPdFxNHa7+5RLBocFe9qTDdmhvrg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CeOjFkJTyLgLCP8lrPsy7jt8tlF0ontXwRPM+A3OpSKqVhEsP2O6OrsxIo+jxSBAPSMZOJhXIHvs/zqmvLnPVgLo4s5kK6CqWbTfnnQ4E6sIxLfI7mmkSyhox0becnfcKbDuV0jDWr5lu3qGM/51eIzGG3Z+juE7l+77DXQBv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srypdZja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74216C4CEF7;
	Tue, 17 Feb 2026 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771340930;
	bh=qUqviPhC+lO0du3PPdFxNHa7+5RLBocFe9qTDdmhvrg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=srypdZjaxy6DSK2rmNUiDxEVszJLu1m+IzeNxtokBlVgQqT9LxJkljhSwS38hoHMd
	 rXRkLHc7Fe+ftAPTPfQFZw8gttgus19i+Y8sjueVwOraE+h5Sdo3eYQTd4HnSO7fyi
	 1gMKgN6hYhXNRGX5eyYVabMNqsRo4vSXpyadPsQ4ispmURf2LldGxZXSpHyqdBLVn2
	 JGTBNjhWf0wX6BPdtUeX9l3LnN5uXLjz6CEmV9WLD4SATpa3SPv/wFzPPCQDfq9P4b
	 LWrNNe+mCDE4PehCTWOfHRXizE4ZeROOpSe9u3u/z0p34tJdrpGfAUwkMXse91Olan
	 XZBfCQ98wxX0w==
Content-Type: multipart/mixed; boundary="===============8182911979985705380=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <19800f868f20c395527ee8a9a7af3ef09991109715686acb92c08b20d2dfef04@mail.kernel.org>
In-Reply-To: <a44f6bff92b7f2d0f86c10214c2e861164e52a03.1771338602.git.anandkumarshaw@users.noreply.github.com>
References: <a44f6bff92b7f2d0f86c10214c2e861164e52a03.1771338602.git.anandkumarshaw@users.noreply.github.com>
Subject: Re: [PATCH 2/2] bpf: report queue_index to xdp_rxq_info in cpumap and devmap
From: bot+bpf-ci@kernel.org
To: anandkrshawheritage@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,davem@davemloft.net,kuba@kernel.org,sdf@fomichev.me,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,linux-kernel@vger.kernel.org,anandkrshawheritage@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Feb 2026 15:08:50 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,fomichev.me,google.com,redhat.com,linux.dev,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-259067-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rxq.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 68BEB14D719
X-Rspamd-Action: no action

--===============8182911979985705380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -195,7 +195,7 @@ struct xdp_rxq_info rxq = {};
>
>  		rxq.dev = xdpf->dev_rx;
>  		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index = xdpf->queue_index;

This approach of adding queue_index to struct xdp_frame was previously
submitted by Lorenzo Bianconi and discussed in January 2026 when
saiaunghlyanhtet posted the same change (v1 through v3).

Toke Hoiland-Jorgensen pointed out the earlier submission was rejected
because adding fields to xdp_frame ad-hoc was not the preferred
direction:

https://lore.kernel.org/bpf/87h5so1n49.fsf@toke.dk/

Jesper Dangaard Brouer (XDP maintainer) further noted that queue_index
is not the most interesting metadata to propagate through cpumap, and
pointed to his RX hints series as the proper mechanism for restoring
metadata lost during XDP redirect:

https://lore.kernel.org/bpf/dcad6dc7-b152-4511-becf-9e7721996f6a@kernel.org/

Has the design concern about ad-hoc xdp_frame field additions been
resolved since January, or should this wait for the RX hints
infrastructure?

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22103049906

AI-authorship-score: medium
AI-authorship-explanation: Polished commit messages and cover letter with precise technical details for an apparent first-time contributor resubmitting a recently rejected approach suggest possible AI assistance, though the code itself is too simple to determine.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed design concern from XDP maintainer about ad-hoc xdp_frame field additions; the code itself is correct but the approach was previously rejected.

--===============8182911979985705380==--

