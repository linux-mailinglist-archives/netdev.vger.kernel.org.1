Return-Path: <netdev+bounces-205486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E8AFEE75
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A2B542FC7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937B2EACF9;
	Wed,  9 Jul 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP9xj7xU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074132EA727;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076750; cv=none; b=b58eTg2EPjnGdcyArkVG94psjjOhiqr9ATEGS01Baim9yXV18/iR08DZwJj8GEXKZeLFesvU33d3evfC/A3ezuVe/Z1Z2KK0DEO193rEe5L2kXDreWXSGxIVKU0v0I24ZuIbi0q/qDi9d73DgoWW+K8dpFpiOONYFsa35Hpty5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076750; c=relaxed/simple;
	bh=jowhmr+KipOArxfk6mh3f69ZIZNViQ4HOjhtbsGep+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvbqsYcM2j25g3Bw43CQt5CFb0s4j/hAWRl2IOGD916VluO9e7bLpMVmhNSg0duLyqZRLIZeuipPzZeu2wgMm5UPAFCCpHCsS2qYd6866PTGYhykjMfcCFOH6zNHVcJeAZVMDXQqNq8QsgtyKQylcce6/poBF1b/48TaJoRLoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP9xj7xU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4A3C4CEF6;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076749;
	bh=jowhmr+KipOArxfk6mh3f69ZIZNViQ4HOjhtbsGep+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JP9xj7xUndV4+JgECIqXowYcrK6Uo9upJ459j580bKY/bNDirgl143vcaGCIdOoZ5
	 /fsnzRpkugPhiqgkyIb1evS8FZ3qWGmyw1Kx/h6VuC5a5uYIWlkHESZUafmohdIYSu
	 hj2v6hQADYG1edmpCV1GfHewHyFxKBGpuIazGaLSa8t6nRAkvbc9CxZKp9LvW63sD3
	 gdNUdBGhkiUmr2BHIOQmqtayzvH7eVLCnsKQ4kI1VX9kary6+L6/pB0Fe8QT9BCngM
	 T304wrmngrh+VNqZzoHvNIhWQbvd5F+4mTWkqSWe0/Q98Kpne+tmhs78K7KjlRp82l
	 LGj5J4cmFun+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000IhB-1b54;
	Wed, 09 Jul 2025 17:59:03 +0200
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
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v9 08/13] tools: ynl_gen_rst.py: drop support for generating index files
Date: Wed,  9 Jul 2025 17:58:52 +0200
Message-ID: <fe549c3a16c21d8b5e16aea395033383c5bc2975.1752076293.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752076293.git.mchehab+huawei@kernel.org>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
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


