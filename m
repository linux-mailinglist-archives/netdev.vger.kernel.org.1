Return-Path: <netdev+bounces-281328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPEkBGJk72mHAwEAu9opvQ
	(envelope-from <netdev+bounces-281328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:28:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A94735F6
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19E9E3010777
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917993C942B;
	Mon, 27 Apr 2026 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rez/yuzY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D33B961E;
	Mon, 27 Apr 2026 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296371; cv=none; b=Qk4oin3PGMmdA+ZKV++BgpSZcjXShfUYEw0qcDzjQqMcQuyHu9YL6sKSYf0j2vX7OY5RVwVvUBiQw1O8DG1RVHSJRc/7d13Ll6qXTija3wK0Oct9XoIbBxXCRQWCQx/M5lNFG/ahEQUBcOwWbpz9CCPDKAD9CFcAHdH82fRhf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296371; c=relaxed/simple;
	bh=PNFp6YrNI1bQfBLs81TTKtIKSQgAWu5W7GiOidP85qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rd2yiKmv0xAvEBU+rWlGeqet2dReI6tcoK4oPKAwHovbtx1fRJ6H/lSod/i8hqBEGgLnp1wCP5TW+0SejlyEakG2W8fJZ8lULHGBuiqipk80IWmOVM9IFmKDj3G6QJgiDd2rsOpEipdf4NuS4qwpCwRnB+qntze9DzEEgc50lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rez/yuzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0845C19425;
	Mon, 27 Apr 2026 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296371;
	bh=PNFp6YrNI1bQfBLs81TTKtIKSQgAWu5W7GiOidP85qw=;
	h=From:To:Cc:Subject:Date:From;
	b=rez/yuzYCaamcFyGsmogoa6J95EmfW2+T55Lxy3vwhxg7KD9z3YBmdeYFh08gdvFR
	 nTjenbwfV4Bclg7mo3VnEqsgTHxMotx8m18EoWkiFoEjPzoUMgvXg9frwzVqw/UnJX
	 Rvhsx83tx9mItHft7vbRGymyQb2eOnuwQyRfyQe9SzIupqQ+i80iTQvcwNrk7IOvXS
	 YBnZO61GoUvh0gr6NRLhg4JSmshAHRXw+J9xOkovTzeNcAKOjcR8WnL/BuotwgKB9F
	 aXQamG7tBWBmipZEvzeQ94nYd7D8lgo9VeoGEEqsFjo0BQNXrovI9NWoqaBEjqbxkd
	 XjkpbvrI7cq1w==
From: Thierry Reding <thierry.reding@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: linux-next: build failure after merge of the bpf-next tree
Date: Mon, 27 Apr 2026 15:26:01 +0200
Message-ID: <20260427132604.3754048-1-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D1A94735F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281328-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]

Hi all,

After merging the bpf-next tree, today's linux-next build (x86_64_perf)
failed like this:

      CC      builtin-trace.o
    builtin-trace.c: In function ‘syscall_arg__strtoul_btf_enum’:
    builtin-trace.c:972:27: error: comparison of integer expressions of different signedness: ‘int’ and ‘__u32’ {aka ‘unsigned int’} [-Werror=sign-compare]
      972 |         for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
          |                           ^
      CC      util/btf.o
    util/btf.c: In function ‘__btf_type__find_member_by_name’:
    util/btf.c:19:43: error: comparison of integer expressions of different signedness: ‘int’ and ‘__u32’ {aka ‘unsigned int’} [-Werror=sign-compare]
       19 |         for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
          |                                           ^

Caused by commit

    f7a6b9eaff3e ("bpf: Extend BTF UAPI vlen, kinds to use unused bits")

I've fixed it up like below, but please fix this in your tree as well.

Thanks,
Thierry

--- >8 ---
From 4689669414ed7de19a69803714bc04e96fd82618 Mon Sep 17 00:00:00 2001
From: Thierry Reding <treding@nvidia.com>
Date: Mon, 27 Apr 2026 12:32:06 +0200
Subject: [PATCH] perf: Fixup for btf_vlan() API change

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 tools/perf/builtin-trace.c | 2 +-
 tools/perf/util/btf.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e58c49d047a2..d22e20a57b70 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -969,7 +969,7 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_
 	struct btf *btf = arg->trace->btf;
 	struct btf_enum *be = btf_enum(bt);
 
-	for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
+	for (u32 i = 0; i < btf_vlen(bt); ++i, ++be) {
 		const char *name = btf__name_by_offset(btf, be->name_off);
 		int max_len = max(size, strlen(name));
 
diff --git a/tools/perf/util/btf.c b/tools/perf/util/btf.c
index bb163fe87767..50d98f3e83bf 100644
--- a/tools/perf/util/btf.c
+++ b/tools/perf/util/btf.c
@@ -14,7 +14,7 @@ const struct btf_member *__btf_type__find_member_by_name(struct btf *btf,
 {
 	const struct btf_type *t = btf__type_by_id(btf, type_id);
 	const struct btf_member *m;
-	int i;
+	u32 i;
 
 	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
 		const char *current_member_name = btf__name_by_offset(btf, m->name_off);
-- 
2.52.0
--- >8 ---

