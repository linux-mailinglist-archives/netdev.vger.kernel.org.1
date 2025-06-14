Return-Path: <netdev+bounces-197737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CDAD9B79
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D200B17BCFF
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4E29827C;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN8xx+lC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C81EC014;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=dJx0bPIhCzSSKqVD6iRHjQT0mg5uJhpesRToZ+w+meTp2cK+z+7v+WemthGbcIOykSCozQRAxCN/tnHBkzUBRRg1HQajk9b5J8hjDR8IBmim32U6Bv/zZFpZz8d0ImuuhvZuCxYfH3b/UohifOqroOEXsI+sFfr+M+l2sCzQ0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=zjfj2Tm7h9LKUnhgzAVTuVnT8YUaP6pYYIdRhxmKFAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ5qaE24Q7sWn/t0PU3RvwbKi8wSAoxK8DnbS3/jBqB5t5VueTnYXmOsohw8heAc8Wi5wlGl6RLbUNscU881NvV+Jqy3CmmzlUyjEzPQapYuYkfTHXOU/KmS8mCIzo2moNsdWobLAHJcmSOmYtBAO33wX3acpervgWLCK49eZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN8xx+lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E578EC4CEF1;
	Sat, 14 Jun 2025 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=zjfj2Tm7h9LKUnhgzAVTuVnT8YUaP6pYYIdRhxmKFAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XN8xx+lChxGcgbZ/ztz2429Ca+3Vh91S/41P+iBhSYgUXxOCXNENr5YO36mz5p5Qr
	 5BWkw16tgrbiIUcPp7S13/Gl77VY9kk2ygbQN63bxhZFLidlPN/Oowf0EDBjQvaUvx
	 +DOsNDt2bvoKH9r3H9OC9ng+uu6wNAzKctC2Lxp3xfWKlY27zGLQUUQtoErQSFTb4U
	 Zqh9IQjyxvtwmnkya21jQ4Ic47BZLEiUNVkrVD+MPiRs3LrVclJlIdMLloniEKL7F0
	 i2qTV7k2UGBFK8PYLuWc3kN6SGblRv/qIHNWsRE08Cdqy8W7G/0GNwLlytCSyJkbdI
	 0TQD+6uNa2hOw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064at-0Rls;
	Sat, 14 Jun 2025 10:56:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v4 04/14] tools: ynl_gen_rst.py: make the index parser more generic
Date: Sat, 14 Jun 2025 10:55:58 +0200
Message-ID: <3fb42a4aa79631d69041f6750dc0d55dd3067162.1749891128.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749891128.git.mchehab+huawei@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

It is not a good practice to store build-generated files
inside $(srctree), as one may be using O=<BUILDDIR> and even
have the Kernel on a read-only directory.

Change the YAML generation for netlink files to allow it
to parse data based on the source or on the object tree.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_rst.py | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 7bfb8ceeeefc..b1e5acafb998 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -365,6 +365,7 @@ def parse_arguments() -> argparse.Namespace:
 
     parser.add_argument("-v", "--verbose", action="store_true")
     parser.add_argument("-o", "--output", help="Output file name")
+    parser.add_argument("-d", "--input_dir", help="YAML input directory")
 
     # Index and input are mutually exclusive
     group = parser.add_mutually_exclusive_group()
@@ -405,11 +406,14 @@ def write_to_rstfile(content: str, filename: str) -> None:
     """Write the generated content into an RST file"""
     logging.debug("Saving RST file to %s", filename)
 
+    dir = os.path.dirname(filename)
+    os.makedirs(dir, exist_ok=True)
+
     with open(filename, "w", encoding="utf-8") as rst_file:
         rst_file.write(content)
 
 
-def generate_main_index_rst(output: str) -> None:
+def generate_main_index_rst(output: str, index_dir: str) -> None:
     """Generate the `networking_spec/index` content and write to the file"""
     lines = []
 
@@ -418,12 +422,18 @@ def generate_main_index_rst(output: str) -> None:
     lines.append(rst_title("Netlink Family Specifications"))
     lines.append(rst_toctree(1))
 
-    index_dir = os.path.dirname(output)
-    logging.debug("Looking for .rst files in %s", index_dir)
+    index_fname = os.path.basename(output)
+    base, ext = os.path.splitext(index_fname)
+
+    if not index_dir:
+        index_dir = os.path.dirname(output)
+
+    logging.debug(f"Looking for {ext} files in %s", index_dir)
     for filename in sorted(os.listdir(index_dir)):
-        if not filename.endswith(".rst") or filename == "index.rst":
+        if not filename.endswith(ext) or filename == index_fname:
             continue
-        lines.append(f"   {filename.replace('.rst', '')}\n")
+        base, ext = os.path.splitext(filename)
+        lines.append(f"   {base}\n")
 
     logging.debug("Writing an index file at %s", output)
     write_to_rstfile("".join(lines), output)
@@ -447,7 +457,7 @@ def main() -> None:
 
     if args.index:
         # Generate the index RST file
-        generate_main_index_rst(args.output)
+        generate_main_index_rst(args.output, args.input_dir)
 
 
 if __name__ == "__main__":
-- 
2.49.0


