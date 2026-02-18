Return-Path: <netdev+bounces-259262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDutKtiRlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:18:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495515543B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B6D0309D420
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B099342C93;
	Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj254GgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CF33D6EA;
	Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409601; cv=none; b=OW7/I88qoMvf5348TjwO7wBn8XK5J8zn+aIM5UyHRgf53IJDBR6rCWD9VCzteQEup+jao2yGVPV0a/EbB7G9/Da4R/B5DhhyAiYtwlQrVdwbgTG/NX9papQGT/R+q223tBZVX63GNGbS/KHqwVbm3+8QWM14ge7rCoS75O1dgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409601; c=relaxed/simple;
	bh=JTYFcIXcwV7BhIZmDYUhOQPoY48Bf1qGF/RzTiHfnbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzbhRAa8leCC1FRmSVFLjIivztZswwZONgqZbvOYpezwLHdsrX3FUh2PC+2D7+y0oWu8XFbWvbZZwqVnsM2cWj6v7QsDsN7CmD8kwLq1192x/sKoSHuF5Ezr3KqQ3gYXkw1urc0xpMHW8OnrTD0Cju9x5gmUqrIllgL+hkBdwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj254GgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8EFC19423;
	Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409601;
	bh=JTYFcIXcwV7BhIZmDYUhOQPoY48Bf1qGF/RzTiHfnbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sj254GgIyuBcb5XoikRrAgXbHGdZGs3odN22SIFqNLjd/14wf0z+iI7mVYs8rxoDs
	 +cU85qUL3oHalhO35vgqdhYAgstD9Ptn+OhFqzui/HZcAhInoCK+UnjcdYx64Z6x/M
	 TjWdCWjcTbAkhRyyFxoALGSHORs/7zdYIz2mFB+WNWDewvr6OZ5Ymbi7nL4bJfdlYo
	 mK8oL/oDwlOxAomY+ZTtYqUwRg0Vm7lk5NUeFmlICVcvaGvjdlAtf/MJNrDAD1pHhL
	 xjOmNqBFf7wNzhZHtEHT4oQb/0rXTu5OF6jmpdVNY4GyGxaAzJMPLl0q0BRadB+2yO
	 TMZlNX8QAyjiQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYZ-00000000LUY-1NFu;
	Wed, 18 Feb 2026 11:13:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 09/38] docs: kdoc_parser: add some debug for variable parsing
Date: Wed, 18 Feb 2026 11:12:39 +0100
Message-ID: <4d6cac070e812ba030474b2b814d31b3cdffa0da.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259262-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 5495515543B
X-Rspamd-Action: no action

This is a new parser that we're still fine-tuning. Add some
extra debug messages to help addressing issues over there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index abfa693051cb..9559cbfd5e4c 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1034,11 +1034,19 @@ class KernelDoc:
                 declaration_name = r.group(1)
 
             default_val = r.group(2)
+
+            self.config.log.debug("Variable proto parser: %s from '%s'",
+                                  r.groups(), proto)
+
         else:
             r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
+
+        if default_val:
+            self.config.log.debug("default: '%s'", default_val)
+
         if not declaration_name:
            self.emit_msg(ln,f"{proto}: can't parse variable")
            return
@@ -1046,6 +1054,9 @@ class KernelDoc:
         if default_val:
             default_val = default_val.lstrip("=").strip()
 
+        self.config.log.debug("'%s' variable prototype: '%s', default: %s",
+                              declaration_name, proto, default_val)
+
         self.output_declaration("var", declaration_name,
                                 full_proto=full_proto,
                                 default_val=default_val,
-- 
2.52.0


