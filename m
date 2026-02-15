Return-Path: <netdev+bounces-258800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KscAAA5kmmksAEAu9opvQ
	(envelope-from <netdev+bounces-258800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:22:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06C913FC07
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 22:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEA77300575F
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266982417DE;
	Sun, 15 Feb 2026 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH0ie8xF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003681A9B58;
	Sun, 15 Feb 2026 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771190499; cv=none; b=Y7zWiCEv2euq8ZPL88mTa7hQLtvjwQQ749yw6VU0jA4uaFKr0Ywi2Vz3NVWA0Mz139YdhTDrxNfJ6SrfCEUCWlEuqduS3Pw9qnJ/T8jP7hHwwDP/pdWQj/IoeWjtOgJ3Il8UKCE8UTwAU/dImN8IRAr8Xr0UP+bJJ3xJm/jp9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771190499; c=relaxed/simple;
	bh=EmwHoAZpw5p2D3NrQqqpXCs9FWdPkuuUw4WAr+dS/vo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=p3w2F+nKFMcPWwIN4fN4IPQo/A+V4K+Watc38+8e4pixNiitmD4wVXuOUfszXGgnAM2CyPG8Dqzc35leSvFGFb/+gVsmlq/QGAU31JE2Hin/pjt5YY02enLAH3uwVvJj+PgTaIlLZGuufFE3IqrYKe1FxQeyPElBNipkQHksyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH0ie8xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D22FC4CEF7;
	Sun, 15 Feb 2026 21:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771190498;
	bh=EmwHoAZpw5p2D3NrQqqpXCs9FWdPkuuUw4WAr+dS/vo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uH0ie8xFLlybX36TLR5sEcmEbqTn2uQ9KZcQNKhHVJBK6D3co/HFCWzMCbNYPPDW9
	 6nmV3rv/RLEQ+pWppVT1HonbwZ92glmsy4ZbmA/FCInn2Y2z5PDLBRTtSODsEdBIq6
	 G6QDe8O0RIAHkWfF8Mp5K2T1EFWXxcYGN1SmWxjMAjdMXR1hMiGqkvDC2GVqWsWDY6
	 8mZHreTARMStfQqCclY3FEUa5PgBQMAN4E9WC0u6uZLChZBkAmPMO7wtZkQWkQxs/c
	 lCmkTQ9vEtLS/a1U4IBYzU7DfpEG6EDpEHTNEZDx5p2l0hR/PThcyrEUZfixqXo1UH
	 lbipTinGzcvVA==
Content-Type: multipart/mixed; boundary="===============8774445385632602111=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4fa31330c83ad1ab8e4498d2c92dbd4e7660d90bf162395c19bc7bfa7e38b70c@mail.kernel.org>
In-Reply-To: <20260215204353.3645744-3-kuniyu@google.com>
References: <20260215204353.3645744-3-kuniyu@google.com>
Subject: Re: [PATCH v1 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,john.fastabend@gmail.com,jakub@cloudflare.com
Cc: willemdebruijn.kernel@gmail.com,cong.wang@bytedance.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 15 Feb 2026 21:21:38 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[google.com,gmail.com,cloudflare.com];
	FREEMAIL_CC(0.00)[gmail.com,bytedance.com,google.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-258800-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: E06C913FC07
X-Rspamd-Action: no action

--===============8774445385632602111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/sock.c b/net/core/sock.c
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2690,7 +2690,7 @@ void sock_wfree(struct sk_buff *skb)
>  		 * after sk_write_space() call
>  		 */
>  		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
> -		sk->sk_write_space(sk);
> +		READ_ONCE(sk->sk_write_space)(sk);
>  		len = 1;
>  	}

This annotates the invocation of sk->sk_write_space, but earlier
in the same function there is another plain read used for the
fast-path comparison:

net/core/sock.c:sock_wfree() {
    ...
    if (sock_flag(sk, SOCK_RCU_FREE) &&
        sk->sk_write_space == sock_def_write_space) {
    ...
}

Should this comparison also use READ_ONCE()?  It reads the same
field that this commit identifies as locklessly accessed, and a
plain read here would still be flagged by KCSAN when racing with
the WRITE_ONCE() added to sk_psock_start_verdict().

Additionally, udp_bpf_update_proto() restores sk->sk_write_space
on the teardown path without WRITE_ONCE():

net/ipv4/udp_bpf.c:udp_bpf_update_proto() {
    if (restore) {
        sk->sk_write_space = psock->saved_write_space;
        ...
    }
}

This write can race with sock_wfree() reading sk->sk_write_space
for a UDP socket, since sock_wfree() does not hold
sk->sk_callback_lock.  Should this also use WRITE_ONCE() to
pair with the READ_ONCE() added here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22042899757

AI-authorship-score: low
AI-authorship-explanation: The commit is a small, focused data race annotation fix consistent with the author's established kernel networking contributions and standard kernel style.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Incomplete data race annotations leave additional plain accesses to sk->sk_write_space unannotated, which can still trigger KCSAN warnings but are unlikely to cause user-visible failures.

--===============8774445385632602111==--

