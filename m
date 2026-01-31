Return-Path: <netdev+bounces-255408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA7KAO0QfmkqVQIAu9opvQ
	(envelope-from <netdev+bounces-255408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:25:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F30C24CA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7A203015D2B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EDD3587A7;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmO+GkNQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1357356A00;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869521; cv=none; b=t7c3MLiknzwlBCpxQ1IcKqgz7NfDIK9ZhWCJ89xqBoA/qhO3Gtks+8oNQkAVQhUysxNyqpRxnG8rEG/P2S3RQUgExqcEN/FtQ1ptj2SPNm+OeWbXFZZ4I12dZfjf+jskHH2NvFb5nQjUGkXvcvr06lrCGlNrqDQXvoWd+y2/aUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869521; c=relaxed/simple;
	bh=R+lEuWZm4gs2UH9ywluoEBP8XgG1POTA/3QmMS82aUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ii3zGKKSDzv46Kv9mphMFrwadHaNP72DhNOOzFG3rSnRxqzjcI6URUeDQGfYDnBkcSX6YrSDXo4xZZvbBnABUwp1gcVkh9M0Z5dtJM85l9U9O5dFojo5KvTbnHyNRX2chy464Dj4EbjF7daAYJxhiGNWvU9orPkn3nexRtsVKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmO+GkNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69352C2BC86;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=R+lEuWZm4gs2UH9ywluoEBP8XgG1POTA/3QmMS82aUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmO+GkNQzROY8UXEsWbQLH8djRLsR2ixEWp38CBXq2MQh2bZrGNnJz+AbNxiccXgJ
	 3JfJ1SeiGr75ZTTyy+kxsaiMfLzTs+zwT/ThdvgrReLNY2jblj+Fl0XkAA6v+2iJZs
	 St6cPOotJLMvFoqYo59i27hTqbomG48wsJti7IHB25erya+EIzAhxKW3BgeG/QdKo1
	 du6tXS0i/ewyyRFzVScbPugMkbgAM+zcPdAvUCXTDLMz7RLT8A7JdpL38FjT2Mv6N4
	 U75omrjw3QdTrXTPq/8R6RF42rVmMv4/7QDEB2bNI+1Xw1nCJA1ly+UWAJn7+88XOz
	 wXG7LY2MbV5FQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVkC-25QF;
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
Subject: [PATCH v4 07/41] docs: kdoc_parser: fix variable regexes to work with size_t
Date: Sat, 31 Jan 2026 15:24:41 +0100
Message-ID: <58131226492f1a0f369fa8e4143535b972d77aa6.1769867953.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255408-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5F30C24CA
X-Rspamd-Action: no action

The regular expressions meant to pick variable types are too
naive: they forgot that the type word may contain underlines.

Co-developed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 64165d8df84e..201c4f7298d7 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1027,14 +1027,14 @@ class KernelDoc:
 
         default_val = None
 
-        r= KernRe(OPTIONAL_VAR_ATTR + r"\w.*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             if not declaration_name:
                 declaration_name = r.group(1)
 
             default_val = r.group(2)
         else:
-            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:\w.*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             default_val = r.group(1)
 
-- 
2.52.0


