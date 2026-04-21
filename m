Return-Path: <netdev+bounces-280190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEnWJ7uk52nX+gEAu9opvQ
	(envelope-from <netdev+bounces-280190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5E43D4EE
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4CB43004D2D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A765363C4C;
	Tue, 21 Apr 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuZ6fx4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379332ED17B;
	Tue, 21 Apr 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788663; cv=none; b=UorwxaVIWASKr5BAWPJ2aqHToun13ZeXq8dQtr8hQq8qU+9VNBTwGAVjpBz0wAxRFgsbwfydq5MBBGizwuRKXRtkQoC9O4GqDWdGtXMCPrhEyozfcRF0NpJRI+KXP8OOn5dlQeLHF9ckEd46FzU3+H4KgvgskMrCE7COxjrRfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788663; c=relaxed/simple;
	bh=6UeoK3+oPAoW5BkB+MhbM0T6YpD6sWSw9Ifvnqy2WLQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=smli7RI/1vOQtvb6+jXoSmH1qsU7jXKzh3EzQO/3qWte9w7G4gpjVR4DZ6Rp0Bhf2cDoTF9MpqPu0KP2jxXJeAhH6ralOM62Jota/qHUgNO+cw/vRGLI/pZupY+7jQQ6K6sP6r9uDkUlewMsEOc57SWz4HVsA1j8bFoRZp6hLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuZ6fx4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B77BC2BCB0;
	Tue, 21 Apr 2026 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776788662;
	bh=6UeoK3+oPAoW5BkB+MhbM0T6YpD6sWSw9Ifvnqy2WLQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iuZ6fx4JVHp/tHoAu2c1IAvBj0EXt9JCd1m0L0LcRg9vaof4ci1VsDG0Jnkr6aw6Z
	 cvajuYSeUDnL62p+JjfiHycnqY+ig39cRb7gSWKdxUEXMOKp3xQ950TZj/g6hmGprG
	 UUswZoC9IBrtYv2K9ls3Plhv06gzM6/ZMsQ2J0pZOgiiO3Q5opb3pwQElojVgouNSD
	 FJJvovRQ3cc8SJ5HfcejtpjOcrnzIUiLRdg5FFRZ56NayBhLyjX7NFGI9wY4cMrrgc
	 PV7OnbzP08f2bNuv5nCIH3DylIJfCCWK5j+8Qy2A7411Etbvg6rAKvNeZpqOVL/euj
	 9pPeQxViY+YMQ==
Content-Type: multipart/mixed; boundary="===============6483710146441311888=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cc500964d83d95307126b05cc7557309b498bafce0c514fa3f1656dd6413ce71@mail.kernel.org>
In-Reply-To: <20260421155024.997077-2-bestswngs@gmail.com>
References: <20260421155024.997077-2-bestswngs@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
From: bot+bpf-ci@kernel.org
To: bestswngs@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com
Cc: horms@kernel.org,martin.lau@kernel.org,ast@kernel.org,ameryhung@gmail.com,leon.hwang@linux.dev,kees@kernel.org,wangfushuai@baidu.com,menglong8.dong@gmail.com,netdev@vger.kernel.org,bpf@vger.kernel.org,xmei5@asu.edu,bestswngs@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 16:24:22 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280190-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.dev,baidu.com,vger.kernel.org,asu.edu,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.30.226.201:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CD5E43D4EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6483710146441311888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 14eb7812bda4..b2cd2b0292cb 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c

[ ... ]

> @@ -596,6 +596,8 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
>  	saved_len = skb->len;
>  	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
>  		smap = rcu_dereference(SDATA(selem)->smap);
> +		if (!smap)
> +			continue;
>  		diag_size += nla_value_size(smap->map.value_size);
>
>  		if (nla_stgs && diag_get(SDATA(selem), skb))

Martin KaFai Lau pointed out in the v1 review that the NULL check for
smap doesn't fully address the race condition. The issue is that
diag_get() will re-dereference sdata->smap independently:

net/core/bpf_sk_storage.c:diag_get() {
    ...
    smap = rcu_dereference(sdata->smap);
    ...
}

Between the NULL check above and the call to diag_get(), smap could
become NULL again, leading to the same race condition.

Martin suggested passing smap as a parameter to diag_get() to avoid
the second dereference. This would ensure diag_get() uses the same
smap pointer that was already checked.

Could the fix be updated to pass smap to diag_get() as Martin
suggested?

Reference: https://lore.kernel.org/bpf/2026420182243.zAiN.martin.lau@linux.dev/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24732581685
--===============6483710146441311888==--

