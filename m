Return-Path: <netdev+bounces-278211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB8bOoRp3WnfdwkAu9opvQ
	(envelope-from <netdev+bounces-278211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:09:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 595643F3B69
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E010302BE21
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6923539A7F0;
	Mon, 13 Apr 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Vpj8tidj"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606B399364
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118104; cv=none; b=lyLzy5zaJuaBx9EtHFtR6NXlJhRRrEDwCutltTMDwYI1mthEkaZC3UfD+HYDB//QDDOgEdWoltGPzGfuz8bevFVRvrnKUmYMKnbCX0KmuaOLGHyhOwFxhMnQcjL7EewFy3VUVGns00ZzPgUtaNGN4l5M+3eBmvPEAVB/Vp79fC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118104; c=relaxed/simple;
	bh=WP8RRazo4i8+pHKmdTpyGkzBs5OKglb0K8QfxB/9CtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N2NkGSQ2fEa8GIST9wGAtHIkc9EQcAd8I4e5MQy0ke/Y1aEsX43nsN7kWmBKqpDzVTDwV9xQprk88uJQwpzsQ/hjqBkRoyRd+iWLsaHUJOD+p8PN940re/D8/3AUYo2NsQQhGSlTNiFEk6kA6QAcXNHGxPw7vsC7eLTrPc/l1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Vpj8tidj; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=AaAPAlrvaP4khcmeOKEgY8BTunVCuVMNBsFKS8WMTYg=; b=Vpj8tidjNuugUigfpCn2vB1uDn
	JQe0ZazwZAuyLLbgngYofgIksDgHKKk0nyBmLWp9OHhq2l82NzC4uQZ2jpvpkrO4JMjlDDHQn3wHt
	/vkmnOiWnOA2Zw9RqBn1WZqd9LrR5TM5xgfV7W7zPcDiWGhPcwKfjdFamTMWzBxhz+1fLpjsT9kuP
	6tKP18a/XEXE06MYGeK/1bzsv8XxR4KAo2mfLPr8TxeDPucZQ/5375r2VCk9EOa14nvTUEuACfTyW
	wTccsTfm6MsyFu249nvodJEvyJvIGtamfqAHVziXCubzkc77y288BP9cPvVglbFOH7KOEgDVFphZ9
	Hu0xnbTQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCPRx-000Chq-2q;
	Tue, 14 Apr 2026 00:08:10 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	dw@davidwei.uk,
	pabeni@redhat.com,
	razor@blackwall.org
Subject: [PATCH net-next v2 0/3] Follow-ups to nk_qlease net selftests
Date: Tue, 14 Apr 2026 00:08:03 +0200
Message-ID: <20260413220809.604592-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27970/Mon Apr 13 08:24:33 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278211-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 595643F3B69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a set of follow-ups addressing [0]:

- Split netdevsim tests from HW tests in nk_qlease and move the SW
  tests under selftests/net/
- Remove multiple ksft_run()s to fix the recently enforced hard-fail
- Move all the setup inside the test cases for the ones under
  selftests/net/ (I'll defer the HW ones to David)
- Add more test coverage related to queue leasing behavior and corner
  cases, so now we have 45 tests in nk_qlease.py with netdevsim
  which does not need special HW

  [0] https://lore.kernel.org/netdev/20260409181950.7e099b6c@kernel.org

v1->v2:
 - Fixed ruff ambiguous variable name
 - Fixed https://sashiko.dev/#/patchset/20260413114011.588162-1-daniel%40iogearbox.net
   findings except the one in patch 1 since if something goes wrong
   there, then the test fails and socket gets cleaned up via cyclic
   GC run anyway

Daniel Borkmann (3):
  tools/ynl: Make YnlFamily closeable as a context manager
  selftests/net: Split netdevsim tests from HW tests in nk_qlease
  selftests/net: Add additional test coverage in nk_qlease

 tools/net/ynl/pyynl/lib/ynl.py                |   10 +
 .../selftests/drivers/net/hw/nk_qlease.py     | 1142 ---------
 tools/testing/selftests/net/Makefile          |    1 +
 tools/testing/selftests/net/nk_qlease.py      | 2109 +++++++++++++++++
 4 files changed, 2120 insertions(+), 1142 deletions(-)
 create mode 100755 tools/testing/selftests/net/nk_qlease.py

-- 
2.43.0


