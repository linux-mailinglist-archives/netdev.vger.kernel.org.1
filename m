Return-Path: <netdev+bounces-199024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEB4ADEAB9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEAC189F0FB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677162E763E;
	Wed, 18 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+ZRYobj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DD2DE1F8;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=kic5xGMlcl+mFkDL65IcMOHs3DkYFWVAuY2yM1pNiOyFdD01USHTy4cRZKi+0v7EeFj55YtA9V1QqQlCzFvB3Zl4KYBBi4dH/43GYH/QgXJTc41qhXf1lH5eEV97lnF7IdpGcbueqJsDccoHHk+cnEEu9tPKkUg6vBvpN4NvO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=EpBDvvCEgkXYhfewwIef0GKxoO/B4wVDI6b8/pzv1js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShOOFP/IbVcw9McHjAQGA2nH4C/RUyzOMWWFctFR1AcV9m2jgM7PNJgOXFxilFArs+f1vbkyCSwioMLMdlCz8lakE40SoVy6OqoDaWDMKjghYdEms5+VdRbZ3U3bDdThfAK06JWw3IuTgUeG399zB9cnlXGazIUVTdzJwe+c4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+ZRYobj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792B3C4CEF7;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=EpBDvvCEgkXYhfewwIef0GKxoO/B4wVDI6b8/pzv1js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+ZRYobjcLWK0vU17Ws2hevZE0iFBwszhyTYartunBQDEzBnb0bCCXQvtclt7D+3B
	 HVb8Kw/SvOJrc6Frsu2epI4VEzFhYYwkzuMtek/M+XRiU1tq2xwH4zhWDmHs93sVCw
	 d9snjHFdwZr860yuHcxS039luOTnkK2rHxOkcpEOl2S4jV2n4SoTjveEUTv6au9xQ+
	 SdEs2bbd6a7LHA52uT+H+1XhwNh6Z3KnAr9OYe2/RKlSIgWMbLMyglBSw1Ttrx4aEp
	 JbYCgN+UfW70DIxwBK0gCnsNgYGH29pBOOGDTOjR9SafThcSXmQbP0wdVEteFd+mkd
	 tn/6UdQvq0qIA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036Ut-2w6u;
	Wed, 18 Jun 2025 13:46:49 +0200
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
Subject: [PATCH v6 10/15] tools: ynl_gen_rst.py: drop support for generating index files
Date: Wed, 18 Jun 2025 13:46:37 +0200
Message-ID: <f0cac4c299684395f68081fe6cb98aa7689550f5.1750246291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246291.git.mchehab+huawei@kernel.org>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we're now using an index file with a glob, there's no need
to generate index files anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/net/ynl/pyynl/lib/doc_generator.py | 26 ------------------------
 tools/net/ynl/pyynl/ynl_gen_rst.py       | 26 ------------------------
 2 files changed, 52 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index f71360f0ceb7..866551726723 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -358,29 +358,3 @@ class YnlDocGenerator:
             content = self.parse_yaml(yaml_data)
 
         return content
-
-    def generate_main_index_rst(self, output: str, index_dir: str) -> None:
-        """Generate the `networking_spec/index` content and write to the file"""
-        lines = []
-
-        lines.append(self.fmt.rst_header())
-        lines.append(self.fmt.rst_label("specs"))
-        lines.append(self.fmt.rst_title("Netlink Family Specifications"))
-        lines.append(self.fmt.rst_toctree(1))
-
-        index_fname = os.path.basename(output)
-        base, ext = os.path.splitext(index_fname)
-
-        if not index_dir:
-            index_dir = os.path.dirname(output)
-
-        logging.debug(f"Looking for {ext} files in %s", index_dir)
-        for filename in sorted(os.listdir(index_dir)):
-            if not filename.endswith(ext) or filename == index_fname:
-                continue
-            base, ext = os.path.splitext(filename)
-            lines.append(f"   {base}\n")
-
-        logging.debug("Writing an index file at %s", output)
-
-        return "".join(lines)
diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index b5a665eeaa5a..90ae19aac89d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -31,9 +31,6 @@ def parse_arguments() -> argparse.Namespace:
 
     # Index and input are mutually exclusive
     group = parser.add_mutually_exclusive_group()
-    group.add_argument(
-        "-x", "--index", action="store_true", help="Generate the index page"
-    )
     group.add_argument("-i", "--input", help="YAML file name")
 
     args = parser.parse_args()
@@ -63,25 +60,6 @@ def write_to_rstfile(content: str, filename: str) -> None:
         rst_file.write(content)
 
 
-def generate_main_index_rst(output: str) -> None:
-    """Generate the `networking_spec/index` content and write to the file"""
-
-    lines.append(rst_header())
-    lines.append(rst_label("specs"))
-    lines.append(rst_title("Netlink Family Specifications"))
-    lines.append(rst_toctree(1))
-
-    index_dir = os.path.dirname(output)
-    logging.debug("Looking for .rst files in %s", index_dir)
-    for filename in sorted(os.listdir(index_dir)):
-        if not filename.endswith(".rst") or filename == "index.rst":
-            continue
-        lines.append(f"   {filename.replace('.rst', '')}\n")
-
-    logging.debug("Writing an index file at %s", output)
-    write_to_rstfile(msg, output)
-
-
 def main() -> None:
     """Main function that reads the YAML files and generates the RST files"""
 
@@ -100,10 +78,6 @@ def main() -> None:
 
         write_to_rstfile(content, args.output)
 
-    if args.index:
-        # Generate the index RST file
-        generate_main_index_rst(args.output)
-
 
 if __name__ == "__main__":
     main()
-- 
2.49.0


