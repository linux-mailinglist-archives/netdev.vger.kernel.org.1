Return-Path: <netdev+bounces-198457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17219ADC3F3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C2F3B39DA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140028ECCB;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf5PXJHb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D07A8528E;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=VhNbvn3X6Yw2K/I58h+e0LyE7VVBs82w872PvIdB4H9iRdCH2sptpp0W8NNJ5QBGk13BzUH4LPXrBAsS4Act/9+oIluK97NyAlZ7wamWWxegG8+qZNHkBviAkK3sJf9TFvlvcYBR6OzKJFfsKwXWZGuyxIwyy53jIY8/aUAt6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=zjfj2Tm7h9LKUnhgzAVTuVnT8YUaP6pYYIdRhxmKFAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcGYxhPQVcRjb/AX3C2wQeWjHagu927qWb7bYheZNEI45GKboj64FDn5wxz6ULQ2qmqezSjNrnxflpFJ2K6+0cPJa1pMP4QTqVWn+cNog3UG4UqWum2CkbfuNJzH2gu4X7iR57dJ62cIfaaB5HFYTYRVyYaJcCm0T66V0yvU1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf5PXJHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1C8C4CEE3;
	Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147351;
	bh=zjfj2Tm7h9LKUnhgzAVTuVnT8YUaP6pYYIdRhxmKFAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tf5PXJHbyqoDMJUjhFzgNd2QGPUruuk54hW8GfaiY4HU/qL1o+lPlFJ4ixNuynI+I
	 LgDzId9V2N2/TBnov9FlC+ewqG+seIJu21fNhZQalb2Z+c38L5lWALHfK40MHkUrkz
	 rjdD5mtoXusfnPP5ksGOkgtAOH8vtnQ7UX34RX34vdPdBjX4ZQXW+MtlLGjq2iUh94
	 ScnqiaNRn8Kw/zchQ1QNIbu4pnRHYxj6AYirHgpT+InZ9lflxBH1ksL5Xnge+LabWM
	 y0CkkOO+WxmJxLa+mla504XWl2rQtvPJZXMQ7ITvVL3uIEG7xsquNK4YdcDPpqywRV
	 SpN7aT8dbEagg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH4-00000001vd6-01hy;
	Tue, 17 Jun 2025 10:02:30 +0200
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
Subject: [PATCH v5 05/15] tools: ynl_gen_rst.py: make the index parser more generic
Date: Tue, 17 Jun 2025 10:02:02 +0200
Message-ID: <1cd8b28bfe159677b8a8b1228b04ba2919c8aee8.1750146719.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750146719.git.mchehab+huawei@kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
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


