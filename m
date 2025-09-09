Return-Path: <netdev+bounces-221424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF84B507B2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55552188AE7C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DFB258EFE;
	Tue,  9 Sep 2025 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToQFk8Ko"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE98258CE5;
	Tue,  9 Sep 2025 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452093; cv=none; b=H9GZV8/gqMJAWOAvGKfvbK85GxqfIo5eDHQm+Rcd2Y8vlagvmiOmRFDFJj335NpdHve9FvqpNVDZrUxjWvuDNxzGIoO3tX1JaYpdDKIKqLBUVO1yeBKF6tWdLxy4sY3p5HZLlDL/2Y7987D/N+rUQrodlOe/T/WTV6Vb/SXkXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452093; c=relaxed/simple;
	bh=pxzpuyqnlW4OnsRKv8aNxFfdEU8dvfaFVpoBzcAkfXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kNRDu/9bhriZUEex0do97JbWIGuMYc0SlS+Hf/0J3bqaGGuEBDSGF2cU0ZHN/4dY+seRARNzLCeO4+761QJLAIWtPcfb0cl7YemVzDgsqxV4Z24+FHtmcGmdCmJFNuA+4KJKTJeT+xEurfxx33dPCWcMFAaYVhzCNnLz68ONcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToQFk8Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B36C4CEF7;
	Tue,  9 Sep 2025 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452093;
	bh=pxzpuyqnlW4OnsRKv8aNxFfdEU8dvfaFVpoBzcAkfXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ToQFk8KoJ/uTHwTEdfRzBHXauI2eG89U1hG7B2G9deKlxv6ZT/rQPfmTPaMqpDEGt
	 OSlbcmqUqLDIcbSsqvusAgvDfOtkI4QOP2hmoRPyYeIy6B1ArEJdhZz6Ygdn4JLTWB
	 jeXWGD0v3zVWtUmLYiH81f2hPil5KBFD/OOfti1tXXQLfOz/jFxsADa5kZqLYAiCH6
	 CGytdHYsgr3/gXgR4e/5gUFlvWWsbE8ioGmD8G18Ydiw7HGBDNq598w3ENUGOYxy7u
	 8ST6RyAas4RDGNAPJDW2MG2U0QC2LDs5ECgFngYyEhOMtAtDzWaga1kRsG9RLhROnU
	 CPqDkCJyqQFVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 23:07:49 +0200
Subject: [PATCH net-next 3/8] tools: ynl: remove assigned but never used
 variable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-ynl-ruff-v1-3-238c2bccdd99@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pxzpuyqnlW4OnsRKv8aNxFfdEU8dvfaFVpoBzcAkfXE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOTDe4u3SpcPycadxXnT/bPfx8d9GVp/l7GC4cEWSaE
 db9VWJnT0cpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEul8wMnSc2NkZdTVi+qw/
 X22XCO2caXVmyg/jnJ0J8x70zfsmnyXC8D9s5i1fRtkt+rO0bP/lbV/7b9o1IekICauHgRu+C5p
 rzGYHAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These variables are assigned but never used according to Ruff. They can
then be safely removed.

This is linked to Ruff error F841 [1]:

  A variable that is defined but not used is likely a mistake, and
  should be removed to avoid confusion.

Link: https://docs.astral.sh/ruff/rules/unused-variable/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/net/ynl/pyynl/ethtool.py   | 1 -
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index 44440beab62f52f240e10f0678a6564f449d26d4..ef2cbad41f9bdd4e22c1be956326417c9ee23109 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -156,7 +156,6 @@ def main():
     global args
     args = parser.parse_args()
 
-    script_abs_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
     spec = os.path.join(spec_dir(), 'ethtool.yaml')
     schema = os.path.join(schema_dir(), 'genetlink-legacy.yaml')
 
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index fb7e03805a1130115ccf70d1e3fbdd6ac485374a..957fae8e27ede6fcd51fb2a98d356a6d67d0352e 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2803,8 +2803,6 @@ def print_kernel_policy_sparse_enum_validates(family, cw):
                 cw.p('/* Sparse enums validation callbacks */')
                 first = False
 
-            sign = '' if attr.type[0] == 'u' else '_signed'
-            suffix = 'ULL' if attr.type[0] == 'u' else 'LL'
             cw.write_func_prot('static int', f'{c_lower(attr.enum_name)}_validate',
                                ['const struct nlattr *attr', 'struct netlink_ext_ack *extack'])
             cw.block_start()

-- 
2.51.0


