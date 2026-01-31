Return-Path: <netdev+bounces-255440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ/cGFATfml6VQIAu9opvQ
	(envelope-from <netdev+bounces-255440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:36:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA72C279F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1570D30AF60A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E160536C0A0;
	Sat, 31 Jan 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJrxdO8o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E14235A92E;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=ebpiml8y0/ltUxmzZOQ0jcs0cXAoM4NVT4RhPkHGngicZbH8wD4uJHGIDzzRbFh4GHeKtqRGDo0lvKsSFH/GYk67ZKy/+/3Rng+uhJYgyuThwpbuRO0NJca83fXOnW/tFPcXv0VzjDG26Q6psoSDXSQKg4mVhJIwB1fSfzs5r/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=CwHsRCLR3wmM4G7G9vnHWInI3q03RKTr8dBQN45i3sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6cOn+UEkxD4vj2E0T0ml65BUizI/HyZx++4wLU9QXZ4IX7l+gq3NKK6sOxF9ChPy6StTRAWIk37FPU7CS2235Socrkqi9QuGvr4dgLF6Y1K3aQJVOp1+Jh/TsVCc7dMNGv2cMxvROWbkmIFs16E0ilAbQF3uo5lL5pKbwzxZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJrxdO8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D87C4AF62;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=CwHsRCLR3wmM4G7G9vnHWInI3q03RKTr8dBQN45i3sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJrxdO8oCa5P9y9iP18SyDLyWn9DYbKIpv1VOzITG4adEF/ptMevl3UgwnAE//lVc
	 Q8bDOHbZSJyfxxuIpJd4pLvsc6yB+sxECrSZ3gyjdmTWTC6vmTWZg3Ax892X2Ir8Gu
	 5i7vP/mlwUp3Bud8QXeQWUJ3f4DpX+bUDlCRmneYEPossKeZ5Lupi0jhwm1ikBYojH
	 vu1wxcD4wUdrVPjMLv0J/EZ5/pkbP9WO2inGFsaxQmckbr+wEQQtuPM0qkw0qWBaf5
	 Vo93bnPrZDKSymLfiGB+RJpjeTc6/MRfayCi0IxPq0TjP85UD5eE32IlyrSBe4mFA0
	 +mygCXG+hGKQw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVm3-18Hs;
	Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 35/41] docs: kdoc_output: add optional args to ManOutput class
Date: Sat, 31 Jan 2026 15:25:09 +0100
Message-ID: <fc6723d13b96db014eaf0f14354d8821ea2085b8.1769867954.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-255440-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[self.date:url,self.data:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCA72C279F
X-Rspamd-Action: no action

The current logic hardcodes several values that are placed
inside troff's title header (.TH). Place them as parameters
to make the class more flexible.

While here, remove the extra unused "LINUX" parameter at the
end of the .TH header.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_output.py | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index 4210b91dde5f..fe3fc0dfd02b 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -607,7 +607,14 @@ class ManFormat(OutputFormat):
         "%m %d %Y",
     ]
 
-    def __init__(self, modulename):
+    def emit_th(self, name):
+        """Emit a title header line."""
+        name = name.strip()
+
+        self.data += f'.TH "{self.modulename}" {self.section} "{name}" '
+        self.data += f' "{self.date}" "{self.manual}"\n'
+
+    def __init__(self, modulename, section="9", manual="Kernel API Manual"):
         """
         Creates class variables.
 
@@ -616,7 +623,11 @@ class ManFormat(OutputFormat):
         """
 
         super().__init__()
+
         self.modulename = modulename
+        self.section = section
+        self.manual = manual
+
         self.symbols = []
 
         dt = None
@@ -632,7 +643,7 @@ class ManFormat(OutputFormat):
         if not dt:
             dt = datetime.now()
 
-        self.man_date = dt.strftime("%B %Y")
+        self.date = dt.strftime("%B %Y")
 
     def arg_name(self, args, name):
         """
@@ -724,7 +735,7 @@ class ManFormat(OutputFormat):
 
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section}"' + "\n"
@@ -734,7 +745,7 @@ class ManFormat(OutputFormat):
 
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{name}" 9 "{out_name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -780,7 +791,7 @@ class ManFormat(OutputFormat):
     def out_enum(self, fname, name, args):
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"enum {name} \\- {args['purpose']}\n"
@@ -813,7 +824,7 @@ class ManFormat(OutputFormat):
         out_name = self.arg_name(args, name)
         full_proto = args.other_stuff["full_proto"]
 
-        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -834,7 +845,7 @@ class ManFormat(OutputFormat):
         purpose = args.get('purpose')
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"typedef {name} \\- {purpose}\n"
@@ -849,7 +860,7 @@ class ManFormat(OutputFormat):
         definition = args.get('definition')
         out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.emit_th(out_name)
 
         self.data += ".SH NAME\n"
         self.data += f"{args.type} {name} \\- {purpose}\n"
-- 
2.52.0


