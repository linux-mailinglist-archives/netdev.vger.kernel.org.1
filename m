Return-Path: <netdev+bounces-295975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pGxvALo2I2r2kgEAu9opvQ
	(envelope-from <netdev+bounces-295975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F064B37D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:51:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VkhEd5pR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295975-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295975-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A974B3028F0F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1D03C3781;
	Fri,  5 Jun 2026 20:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFC3C5827;
	Fri,  5 Jun 2026 20:50:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692633; cv=none; b=sQn152H5W/anYZ8Y43msbXgpbMFwJ3jYuAySGtvlbgn+qmUi/7ueoFNFVyd3wqfkXwDLza21vDvfeRKnXO6/BsEOG69C02bfexqMxtJPDXrIbM8YLBe9PEbTUM4MofCb5VLOahRJ4PyssN1tMtXVC+4sqjYEaI5m+X68Q6Sgd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692633; c=relaxed/simple;
	bh=xbrHq+DGHaD+A8qzioPF9ByfcICvn4tsN4P5u5DLV1U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oWbAgYU9kJuzlQC3XY3vZNgPvebX6gEAI/REU6DRD1IcTOWtwjiF1XEGy+sNKcVRZoBNdiKZxHvD7lFBpRdNOBN5rE/H9lOwXFxqNRp0j36Cfw5s5fvqs/6SD2/M2u9Rik+k40Yl9iB5NsBB7GQBbl5lrOWzvVC+h6I3Vz/T6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkhEd5pR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28341F00893;
	Fri,  5 Jun 2026 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780692632;
	bh=XvEjhU9dpizasLQXA4sOqgWY9q0v/NYUa0Pf10IzTJw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VkhEd5pROhEYGqNYEItmc/Drm3sQWJqfmOwwVgQDlh5FD2fT2Nv4mhLWtRNHW20HS
	 mYsWyGthqWVHM1Z9OG3ijORkLg/R25OIpq6BG4zFxe2ULa2qadIX0vMUGWtswCk2wL
	 6Idb2vxfFclHoRHAZ6s8+ZGE5C29uZd7xRXC2VAdHHtkYokGr4fBoAUHPAla+MLRgc
	 Tu61j88jHkLVFq4wBk1CeC+6i/D3lviu+MW8upOQBHrSYqkKDtxKw1ZDiqOMsnoIqF
	 x8PajMzRwfbvmJ5xIyuXe5SAb29BdVJFWa5x3NLT3VR+kHknSjVYSsCTRulqZPT+8f
	 zguL/8Plpo8Ng==
Content-Type: multipart/mixed; boundary="===============1305281309859444005=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e8611cf339651054f1237f21f7e869431725e6eb4f17ff16331a4af3f7ed921@mail.kernel.org>
In-Reply-To: <20260605202056.1780352-5-ameryhung@gmail.com>
References: <20260605202056.1780352-5-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpf: Remove WARN_ON_ONCE in check_ids()
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 20:50:31 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295975-lists,netdev=lfdr.de,bpf-ci];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 424F064B37D

--===============1305281309859444005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove WARN_ON_ONCE in check_ids()
>
> check_ids() warned when it ran out of idmap slots, assuming this was
> impossible because the slots are bounded by the number of registers and
> stack slots. That assumption no longer holds: referenced dynptrs acquire
> an intermediate reference that lives in refs[] but is not backed by any
> register or stack slot [0], so a program can accumulate more reference
> ids than the idmap can hold and exhaust it.
> Exhaustion is fine for verification correctness. check_ids() already
> returns false, which makes the states compare as not equivalent and
> prevents unsound pruning. The only effect of the WARN_ON_ONCE() is log
> noise, or a panic under panic_on_warn. Drop the warning and keep
> returning false.
> [0] 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

This looks like a bug fix for a warning that can panic under
panic_on_warn, but it does not carry a Fixes: tag. The body attributes
the newly reachable exhaustion to commit 308c7a0ae885, which introduced
referenced dynptrs that acquire an intermediate reference in refs[] not
backed by any register or stack slot.

Should this include:

  Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27038754519
--===============1305281309859444005==--

