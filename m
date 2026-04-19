Return-Path: <netdev+bounces-279567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPjyLfxa5GlLUQEAu9opvQ
	(envelope-from <netdev+bounces-279567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 06:33:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F0B4231A3
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 06:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB3F301AA6B
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 04:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312FB27FB25;
	Sun, 19 Apr 2026 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoAUslfA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E33BB4A;
	Sun, 19 Apr 2026 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776573176; cv=none; b=gx4Ka0mWTedd0X2EpYTmsP52MWEi+Nvan2VU/Xe88Jzc8BODnxhPgsdpaUfj8T+ake8zrF8Vu3Q386kFITShLPESeBjTB4iiz9d/yWG1nMsz2UzgsSiiIAGyJGETV14qnwJ5cHwfa0O8Gm80bCuCM11UYsnBfaTnGhYYwXN/xIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776573176; c=relaxed/simple;
	bh=L8BeoMR/S1J5cJhw4dhL2I8MvOSmN9iYYujOLMiNCiQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l7e7pKMEZCsjhB7pTG6wbFRy6qLqxtFefVSl8ozt+SoOkVN2OJKzm9847qBgxW0PMPMLBGqveGaf3qoJe9X0l/wdmQ7KD0rt3fyq9tC4gFiVqXjaBtbueoHVtqQnEJItXpgOUrRTsnf2NHH7yHlQ3utGlPEMxEpxnEEXlZFK9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoAUslfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D983C2BCAF;
	Sun, 19 Apr 2026 04:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776573175;
	bh=L8BeoMR/S1J5cJhw4dhL2I8MvOSmN9iYYujOLMiNCiQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qoAUslfA26yZanvgnKMgcjEebz5WRTxortbnChaH4CFl3VgjM6QsIsYg62VCh58ZL
	 Gi5BJJexe/xFvBb5ThEutagyWVVf2LDiDECYiFUq/nWimPhHHABuOiNGVp5/KKvCik
	 WyAUAeEyRfcCwHxa1GfIRCrQkHF9Y36ur+YvLoPZZDyTEzadaBLgVyupMt2VbsOSup
	 8alno2egypdkbaN4TQG33Cg6pA+i8EkdgknGeGK3rdTXRYwsqlnLvmRBa3wkOGyKve
	 pdq+NjwWfw/BJ12GEUDppIH8wsCST8+/mIkhzmGfG92KTgrl25T/AmpAYax5btGIW3
	 bJ20tmlnGK7ng==
Content-Type: multipart/mixed; boundary="===============5059097281938462969=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <557b90e63fb85b646de7ae4792eb2c06d6be251dcd95dabe9ed99435c82b85e0@mail.kernel.org>
In-Reply-To: <20260419040426.9672-1-avinashpal441@gmail.com>
References: <20260419040426.9672-1-avinashpal441@gmail.com>
Subject: Re: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs
From: bot+bpf-ci@kernel.org
To: avinashpal441@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 19 Apr 2026 04:32:55 +0000 (UTC)
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279567-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,gmail.com,linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05F0B4231A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============5059097281938462969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 6c1cde9635b1379ee40c94c5ecc8a7d09507c0c9
Author: Avinash Pal <avinashpal441@gmail.com>

bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs

A NULL pointer dereference occurs in map_kptr_match_type() when a BPF
program attempts to store a scalar value (non-pointer register) into a
map slot annotated as a kptr (kernel pointer).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221372

This commit appears to fix a bug introduced in an earlier commit.
Should this include a Fixes: tag?

The fix guards against NULL reg->btf before calling btf_is_kernel(),
which suggests the vulnerability was introduced when map_kptr_match_type()
started using btf_is_kernel() without checking if reg->btf is NULL first.

Looking at the git history, commit 61df10c7799e ("bpf: Allow storing
unreferenced kptr in map") introduced map_kptr_match_type() and the call
to btf_is_kernel(reg->btf) without a NULL check.

Consider adding:

Fixes: 61df10c7799e ("bpf: Allow storing unreferenced kptr in map")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24620726038
--===============5059097281938462969==--

