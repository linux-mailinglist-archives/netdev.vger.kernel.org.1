Return-Path: <netdev+bounces-259367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHCmGAc2lmkkcQIAu9opvQ
	(envelope-from <netdev+bounces-259367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:58:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8115A785
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DAC130138E7
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666123346BC;
	Wed, 18 Feb 2026 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LyKRd3QJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B433557B
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451851; cv=none; b=nrag5rUHCm7rUV8ACUOqeRukUFS+wdDXwP8nCt2HexhnAeNObv2tqOsqzr5Gs4tPhKq1Qptf0hAZfKcwOS1NSjjrWm8Z9JNugu2aX+IlLV2zNuf8848K9219uQU4w8KU3/oPRcIOhTjAyaV5hEaCgpPclHj8JLgP6OOjNs+yxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451851; c=relaxed/simple;
	bh=f1lNgefGIC/YcxlXd5e/ZNS93ri6kYhQckVJurlwkG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRr+arCnZhpVXqNifNZxbo+XHLmoYIdRCXRKAbqKI4mzS312zwUSko+mRCqsRiT80BPJI/v8rA7JXgyNy8m224tVzZeB3pFDapHwm4F8r4wQUVCFeWRFTmGyqSavmejvk/Fus0CBY8oyXYCjN11Jh5OWMcZUB54t3TMzVb1JEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LyKRd3QJ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771451838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=45YBMKDdB9CHi80ZhvvMJxTNPQtUdWSacNHeDsJ8hFg=;
	b=LyKRd3QJigcsQqGyCrt3fCAl3dxNeDrlgMXFicMVlCZPkgDgX42aYhRo9qQhPNjRS+w8FH
	ZdlWVqqNuyhwUs4emcqdjtlzwmLXIE9TRAL3a7mu8glFvuMDBXEy5pqEHZ0NFSMBnhvAJB
	jS24rzSBG5mOoMWfohA9S8S28ucPVL8=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/2] libbpf: Remove extern declaration of bpf_stream_vprintk()
Date: Wed, 18 Feb 2026 13:56:49 -0800
Message-ID: <20260218215651.2057673-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259367-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ihor.solodrai@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DBC8115A785
X-Rspamd-Action: no action

The first patch adjusts a selftest that has been using
bpf_stream_printk() macro. The second patch removes the declaration.

Successful BPF CI run: https://github.com/kernel-patches/bpf/actions/runs/22156645808

Ihor Solodrai (2):
  selftests/bpf: Use vmlinux.h in test_xdp_meta
  libbpf: Remove extern declaration of bpf_stream_vprintk()

 tools/lib/bpf/bpf_helpers.h                       |  3 ---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c | 12 ++++++------
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.53.0


