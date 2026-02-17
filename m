Return-Path: <netdev+bounces-258986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICNhM5EplGlTAQIAu9opvQ
	(envelope-from <netdev+bounces-258986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:40:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 377BC14A0D8
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D40300B47B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD12E88BB;
	Tue, 17 Feb 2026 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI+738tP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0552D97AA;
	Tue, 17 Feb 2026 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317619; cv=none; b=jsCyPp1pE5YbybvCf4Y0bsnKsUELq+NT7QHwIQ5UyOp38yejLhgf8cfDX4g7lMQbB8Ki5KdyZ8MSMDzHLJz70dSouSicPkzcdlip8zN8MYX0z5Mh+zMIBwSwXFAZgNi88tG1BLMjHwmL7HEO0lED74YIuKRJECNQoi8/eI+J0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317619; c=relaxed/simple;
	bh=wW6DjHm2f+Hdvl7DyexzQGIW6OUSx5LEnomEww1z/v0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UUzOaI4m6C1n9P8SkJi5KmGX8QBT9+qpu6BkaYwU65kb5sh3U/nhJvkqZUnT8ZCeHWLS5xe0K8LlOUmBy/KPxyQPTV3XYxCElIN19kxt/On9nk0/WXvN8UTDZVACTmXRuaTzocZ3nK1Z4diz5iNGT68NU2oyDI0Bb3dI5FNTOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI+738tP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B123C4CEF7;
	Tue, 17 Feb 2026 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771317619;
	bh=wW6DjHm2f+Hdvl7DyexzQGIW6OUSx5LEnomEww1z/v0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rI+738tPw5YpR/1Ev/CQfeyE7fbulUFRB4aNL94GaiQwx4D2np4ayc31ihQsbW3mC
	 yppdCHrMFyyKA0Gqz513NkJf6EHqqDO/xnOIC9jnuVgelhU3VPV3U/guNE7GgixlNh
	 F84lk3z4qQdDTTN/LjzXfgWxxMZ3MSklNeHMLA2z4f/bP8bZqeDEvmANogzKt4VZ84
	 q+aL/K9atz58ksNrXNeO3YShJK8A3NWK7PpnB3eo6lWGEEo9KfMFco5jgHz1JpBDTM
	 1VJwp/b4F/WOgDTYsXC6KsZsYxg4hjiyuAm4Zx6h3zzWoWDD7yr8qzXYBhBIZ5/m4v
	 OvVKAdnfIG8/A==
Content-Type: multipart/mixed; boundary="===============7328391430163487292=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1fe4a48f5e77f265dcd03fb56ccfca4851f0c1910667b894193713969034b1f2@mail.kernel.org>
In-Reply-To: <20260217080326.50564-1-mahdifrmz@gmail.com>
References: <20260217080326.50564-1-mahdifrmz@gmail.com>
Subject: Re: [PATCH bpf] bpf: fix selftest/xsk single test selection
From: bot+bpf-ci@kernel.org
To: mahdifrmx@gmail.com,bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,sdf@fomichev.me,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,mahdifrmx@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Feb 2026 08:40:19 +0000 (UTC)
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
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,fomichev.me,kernel.org,gmail.com,iogearbox.net,linux.dev,google.com,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-258986-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 377BC14A0D8
X-Rspamd-Action: no action

--===============7328391430163487292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Signd-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>

Should this be "Signed-off-by"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22090844124

AI-authorship-score: low
AI-authorship-explanation: Natural writing style with human uncertainty markers and specific manpage citation suggest human authorship; the Signed-off-by typo is consistent with human error.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Misspelled Signed-off-by tag (Signd-off-by) breaks the Developer Certificate of Origin chain and automated tooling recognition.

--===============7328391430163487292==--

