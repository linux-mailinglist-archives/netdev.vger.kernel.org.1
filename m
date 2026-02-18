Return-Path: <netdev+bounces-259288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOXRHeGUlWk1SgIAu9opvQ
	(envelope-from <netdev+bounces-259288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:30:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA30D155794
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 573D430C3858
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25195356A13;
	Wed, 18 Feb 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCXs+vDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C03563E7;
	Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409614; cv=none; b=THfdkkx4PMSbhSGt7JJnP2d81U2pa+hxdUBMFdLxpCvB06Zz2KhDOYqah5LC/u0QUbSOJJ+EukmtLunegajNYv8Y/1CHmT+NCdUOhPiCLCe2qJ6VOdmuabBJc5aafiT+2l8BoN5LSKdK8YWkasYifKWmB3n59J9iVXQviaI+Xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409614; c=relaxed/simple;
	bh=fvMjJpvYeiR5dsEmac23+IArGmOBOLOmIiyyzQVBvqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMKFitAWbedQ47DRgKVNmdw8nOm6dWzURkyazwC1jE2Cm9G7R4V8EA5Ieo/jqR+Ywd1cH4zox5cLAAWzR5QGy23RgMC+fw+Uy3Xm8AMJ7W6Olv7dQzfarHN9bGXr9nUOlfFPo6s24X7dXCwtFveQXn1VDf5barUmU+VPxaHXEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCXs+vDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D708EC2BC9E;
	Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409613;
	bh=fvMjJpvYeiR5dsEmac23+IArGmOBOLOmIiyyzQVBvqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCXs+vDn55NbKpqXTFsPi7CJOEdjC9jxLinK6EHOS/f1g9uf/z3PDR5iM8HgJvv2N
	 mw6006xk6eMPrrhZWZ3gUeQXlVDshIklV6mSZyA2lgJ13YDwgHo2gn2K8nzXG/bpJP
	 n39uFySI2zwLYiZOkjEYdwgNtOW2LtrKhR7rgIWrEZRbzr7rC8K23c/KG2zdDUwpV5
	 UOBj0eJUJmFgIO08ARmNG+Siz2Z6OmI5KuPjSBDbx9dowDPlrvTK01Sir9ICF4Ut/c
	 aEvWGuUJcbwKyygGrOWVxR2JEgz6iA8qCHMFu5BmbAekRIl1Bf2Y2UDdWBfrOFHzN+
	 45IuDdYQRZx+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYm-00000000M4p-0GPz;
	Wed, 18 Feb 2026 11:13:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 38/38] docs: kdoc_output: pick a better default for modulename
Date: Wed, 18 Feb 2026 11:13:08 +0100
Message-ID: <45159d8100d22567a592a90769a71a5335f0a085.1771408406.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259288-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[self.date:url,self.data:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA30D155794
X-Rspamd-Action: no action

Instead of placing the same data for modulename for all generated
man pages, use the directory from the filename used to produce
kernel docs as basis.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/kernel-doc                |  1 -
 tools/lib/python/kdoc/kdoc_output.py | 41 +++++++++++++++++-----------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/docs/kernel-doc b/tools/docs/kernel-doc
index aed09f9a54dd..3a932f95bdf5 100755
--- a/tools/docs/kernel-doc
+++ b/tools/docs/kernel-doc
@@ -210,7 +210,6 @@ def main():
                         help="Enable debug messages")
 
     parser.add_argument("-M", "-modulename", "--modulename",
-                        default="Kernel API",
                         help="Allow setting a module name at the output.")
 
     parser.add_argument("-l", "-enable-lineno", "--enable_lineno",
diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index 1e3dc47bc696..44e40a6e8ca6 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -589,7 +589,8 @@ class ManFormat(OutputFormat):
     ``modulename``
         Defines the module name to be used at the troff ``.TH`` output.
 
-        This argument is mandatory.
+        This argument is optional. If not specified, it will be filled
+        with the directory which contains the documented file.
 
     ``section``
         Usually a numeric value from 0 to 9, but man pages also accept
@@ -634,14 +635,21 @@ class ManFormat(OutputFormat):
         "%m %d %Y",
     ]
 
-    def emit_th(self, name):
+    def emit_th(self, name, args):
         """Emit a title header line."""
-        name = name.strip()
+        title = name.strip()
+        module = self.modulename(args)
 
-        self.data += f'.TH "{name}" {self.section} "{self.date}" '
-        self.data += f' "{self.modulename}" "{self.manual}"\n'
+        self.data += f'.TH "{title}" {self.section} "{self.date}" '
+        self.data += f' "{module}" "{self.manual}"\n'
 
-    def __init__(self, modulename, section="9", manual="Kernel API Manual"):
+    def modulename(self, args):
+        if self._modulename:
+            return self._modulename
+
+        return os.path.dirname(args.fname)
+
+    def __init__(self, modulename=None, section="9", manual="Kernel API Manual"):
         """
         Creates class variables.
 
@@ -651,7 +659,7 @@ class ManFormat(OutputFormat):
 
         super().__init__()
 
-        self.modulename = modulename
+        self._modulename = modulename
         self.section = section
         self.manual = manual
 
@@ -685,7 +693,8 @@ class ManFormat(OutputFormat):
         dtype = args.type
 
         if dtype == "doc":
-            return self.modulename
+            return name
+#            return os.path.basename(self.modulename(args))
 
         if dtype in ["function", "typedef"]:
             return name
@@ -762,7 +771,7 @@ class ManFormat(OutputFormat):
 
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section}"' + "\n"
@@ -772,7 +781,7 @@ class ManFormat(OutputFormat):
 
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -818,7 +827,7 @@ class ManFormat(OutputFormat):
     def out_enum(self, fname, name, args):
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"enum {name} \\- {args['purpose']}\n"
@@ -851,7 +860,7 @@ class ManFormat(OutputFormat):
         out_name = self.arg_name(args, name)
         full_proto = args.other_stuff["full_proto"]
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -868,11 +877,11 @@ class ManFormat(OutputFormat):
             self.output_highlight(text)
 
     def out_typedef(self, fname, name, args):
-        module = self.modulename
+        module = self.modulename(args)
         purpose = args.get('purpose')
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"typedef {name} \\- {purpose}\n"
@@ -882,12 +891,12 @@ class ManFormat(OutputFormat):
             self.output_highlight(text)
 
     def out_struct(self, fname, name, args):
-        module = self.modulename
+        module = self.modulename(args)
         purpose = args.get('purpose')
         definition = args.get('definition')
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"{args.type} {name} \\- {purpose}\n"
-- 
2.52.0


