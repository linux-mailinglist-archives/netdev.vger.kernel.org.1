Return-Path: <netdev+bounces-255415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECAnEucRfmkbVQIAu9opvQ
	(envelope-from <netdev+bounces-255415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:29:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D50C26A7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDD2C305B582
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678323624BE;
	Sat, 31 Jan 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3JUosEF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152D357A59;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=FkGPDD3DHY87NnLbIJy58fV9Q/mXti1XXDzpPM4HUzjeDpSuMazy+Mo8pMINKc4ODmhH8cRniJsUz1Wf801banMiokXK9jsnBaUCVUbcZhSvHI1zI8nzf0Ycou9jLeQFYX6y4jICcOBjemNhO3xFJjO5eitPY5bbBJuAjm/fLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=E4fJO9wVUnaqUlAi5WmkzEmXnpOij75g8JwiGBZaJ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXX4PDFQXRYrntxhf2QXNS9ZXpQQMNhbfqKCDzb6pwtYV4LfMxoKwtaG5HyRjNLAhF7zbau1sHDGFOCdKbQTn+uE+KadmmLEhOqSGJwSB+qS1eZixY9vN2sYd82axbtiGv0vto4t8Y2E/uTL0Hgl8/RPj7UEi80Qiq4ZvyEDFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3JUosEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEB9C2BCB7;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=E4fJO9wVUnaqUlAi5WmkzEmXnpOij75g8JwiGBZaJ9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3JUosEFJJEjm57nIN5CeAd93uZO4+2EAFKhDcuIbkebO1FR7POhOcbcWgZueyjxz
	 /IXGruDaiYAZz5IDDMkSzYsse7MozmnPNwyYQ8YggFCXDpNaPTh0vTGS/jP152zC7j
	 czzMbvpxWdlmG/CBEtjZDH+Jxejj1xUlPWmhmsAvgpBeAjSfrsEp6at4bEQGHheS0p
	 2Pd6103t7cEK0kCjoXibs2v9jbZ0I009Vab8mMb4bm3yMhx7jMcI1E/PLCPjN2dVXw
	 nj/EAPU4U/6kUE05hcZ18vsYp8a1GBMvr+2v2XPhxvic6Epx9QexnaN5o3IjvqpgNq
	 mqUN574QnMeEA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVka-2msr;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 13/41] docs: kdoc_parser: add support for LIST_HEAD
Date: Sat, 31 Jan 2026 15:24:47 +0100
Message-ID: <b53c8adc52fc0263d73fe85ff0c57b9cbc58bfd1.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255415-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 07D50C26A7
X-Rspamd-Action: no action

Convert LIST_HEAD into struct list_head when handling its
prototype.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 92b550189988..33710c4be145 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -219,6 +219,7 @@ var_xforms = [
     (KernRe(r"__ro_after_init"), ""),
     (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
     (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
+    (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-- 
2.52.0


