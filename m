Return-Path: <netdev+bounces-255407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JgsBuoQfmkbVQIAu9opvQ
	(envelope-from <netdev+bounces-255407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:25:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C246BC24A3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9C7C30143DE
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC1357A5D;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo/3Vt23"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7097354ACF;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869521; cv=none; b=l9v+CoL7HAOtRA5+lzqYxWePQH/C0WivyNW47XAOJycPYejlrkaFdSPZBoImmmCo/hwOJivJ0nJiQG6nMP+wyRipvV806/SMqoPEThVN4j14uuwP1cKmllsQXMNrhlU9JsQL31htbUidwJo6OHIxWkZc1KxpiwMQF92BpqdleHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869521; c=relaxed/simple;
	bh=SI0OuhHT6kvx7zPg3IIsJPCvtLTTLub7sg5GnAeFE/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxslsWczOJDQ5s0KRUQP1a3WEzr8I2CqNsfw/k54gSUPwoggKX0AlnrxtCzNHPFPWhwibTLAY92wnSjIMnaJJaP68e6BlUEviUDaW6d0eyf9LE4NmUMIt4IixqbJ4FmUmkXTwG32RJVGhjCA+H23dH6ckWZvHjGMawNuhP9QjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo/3Vt23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642CEC16AAE;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=SI0OuhHT6kvx7zPg3IIsJPCvtLTTLub7sg5GnAeFE/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo/3Vt23C7chjuZ7k/WMNAMPjI5tDrGE7fZP0881O6poSzzKpdAOGgMXFZkaKBcOi
	 no/HeR0CPK5DIDvj3lJWubQwPmmVIw8DwxCavnGH5IzOrbP8WJUXLGjcB1KfG1NlgA
	 PJ4m93OsS0puDcKLOQnP3XRvIRAPCFGTlprCq+vFHzSoLKdnW9Xj0MP9LtTnWAH7+Q
	 pN7VlDM/8lqPDYESZtNBvPTh0ksLTf73qARHwjoy9LFFEY+K5IB+ztfVpcjxvr0a4n
	 83vHXEwItfBnH8rSEXV+QyUi0wquTHG83DNa5ipLR1fEgeFbb+7emItvvl4KDEaRMF
	 EPMj34EU7ssnw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVk8-1yFJ;
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
Subject: [PATCH v4 06/41] docs: kdoc_parser: use NestedMatch to handle __attribute__ on functions
Date: Sat, 31 Jan 2026 15:24:40 +0100
Message-ID: <7efbd500b098b45d697beb769f07d471c33a7117.1769867953.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-255407-lists,netdev=lfdr.de,huawei];
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
X-Rspamd-Queue-Id: C246BC24A3
X-Rspamd-Action: no action

Some annotations macros may have nested parenthesis, causing normal
regex parsing to fail. The __attribute__ regex is currently very
complex to try to avoid that, but it doesn't catch all cases.

Ensure that the parenthesis will be properly handled by using
the NestedMatch() logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index ae5b2ef80f75..64165d8df84e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -165,6 +165,7 @@ struct_nested_prefixes = [
 # the start delimiter.
 #
 function_nested_prefixes = [
+    (re.compile(r"__attribute__\s*\("), ""),
 ]
 
 #
@@ -195,7 +196,6 @@ function_xforms = [
     (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
     (KernRe(r"__attribute_const__ +"), ""),
-    (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
 ]
 
 #
-- 
2.52.0


