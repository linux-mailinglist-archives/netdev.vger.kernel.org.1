Return-Path: <netdev+bounces-210585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A29B13F7E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A84B7A15FB
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D07276031;
	Mon, 28 Jul 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/LjokCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557A27465B;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718543; cv=none; b=BchIJpoA/G0m9B8vuNI8e82tlhckkJAm94+L5ExK8SRRY2yM+4JP/VlW0UvqH8x4xB2W52vi75ORA+9FL/Nb/C5Xs9r/NraXYyD99USu0Wnobk11ut9srV9yImns0XWMuSL0HZhmjqMtJXRjCJng+W5LHCflHEaMlgk/JJBN/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718543; c=relaxed/simple;
	bh=jowhmr+KipOArxfk6mh3f69ZIZNViQ4HOjhtbsGep+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHA9ZPtSWcM4XhuN1n0RaKLLWm+EZVy9M++R1yYorbcWEKv7US4XBypaTodqovVQlNVSVMFSJhkAXLDDM0XY6Z266CCi5yOn0ASi+lHdXh19vY/bSj6MNDl51zHqsjm2Zd2x/5o2OUv3thpItM/by0AtfJdLTcKhAOQ7Vb20htM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/LjokCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A807C4CEFC;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=jowhmr+KipOArxfk6mh3f69ZIZNViQ4HOjhtbsGep+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/LjokCZoaE0bTjy1GzZOIxDi/El7KW7GD1BZOOPvLVTmquFM7ghBX82fm9UxsSHB
	 WxNo7Ub4lyC19v5QrUkDqtAOAO9DWFPSpLkCLOrYIGKsxdpzUfvWFjVr0r3bp6J5vR
	 MulQfzHyc2/aVUdkLRPkHpICanVh0MylAiPo8srsmeYq04nCV+OfRw4BomQL7GNIyN
	 jtuR3HcFkMYrf+sSWH3o1KBUw5wQ4mXbVcf6B9dHVH8xv8n1qiyGS7wes9a/DptaWH
	 GBDTNHA3Hdls71vTXs29fHFd6XCPxM7MtCsm/gu2xptvrGegaC4brgjtvTaZp4ATsO
	 Eq5A+9zV61XLA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000Gd2-1l9X;
	Mon, 28 Jul 2025 18:02:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Marco Elver" <elver@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Simon Horman" <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v10 08/14] tools: ynl_gen_rst.py: drop support for generating index files
Date: Mon, 28 Jul 2025 18:02:01 +0200
Message-ID: <051ddbdd5b0c77126bc391c97014ae6b18bc4b82.1753718185.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753718185.git.mchehab+huawei@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

As we're now using an index file with a glob, there's no need
to generate index files anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_rst.py | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 010315fad498..90ae19aac89d 100755
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
@@ -63,27 +60,6 @@ def write_to_rstfile(content: str, filename: str) -> None:
         rst_file.write(content)
 
 
-def generate_main_index_rst(parser: YnlDocGenerator, output: str) -> None:
-    """Generate the `networking_spec/index` content and write to the file"""
-    lines = []
-
-    lines.append(parser.fmt.rst_header())
-    lines.append(parser.fmt.rst_label("specs"))
-    lines.append(parser.fmt.rst_title("Netlink Family Specifications"))
-    lines.append(parser.fmt.rst_toctree(1))
-
-    index_dir = os.path.dirname(output)
-    logging.debug("Looking for .rst files in %s", index_dir)
-    for filename in sorted(os.listdir(index_dir)):
-        base, ext = os.path.splitext(filename)
-        if filename == "index.rst" or ext not in [".rst", ".yaml"]:
-            continue
-        lines.append(f"   {base}\n")
-
-    logging.debug("Writing an index file at %s", output)
-    write_to_rstfile("".join(lines), output)
-
-
 def main() -> None:
     """Main function that reads the YAML files and generates the RST files"""
 
@@ -102,10 +78,6 @@ def main() -> None:
 
         write_to_rstfile(content, args.output)
 
-    if args.index:
-        # Generate the index RST file
-        generate_main_index_rst(parser, args.output)
-
 
 if __name__ == "__main__":
     main()
-- 
2.49.0


