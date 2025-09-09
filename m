Return-Path: <netdev+bounces-221428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA10B507BD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80778462BE3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B626658A;
	Tue,  9 Sep 2025 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO8bf5ym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CAA255F3F;
	Tue,  9 Sep 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452102; cv=none; b=k4RNhh8gm135hQDWESuKBRNBl9EetUxv8Vucq93f9d6cgMBIQNmd/ENpBSFYEjYf5nmF3zQWci0gMAc2rchRngdvc1MMDr6FbcZh8Fu0FOlj8cFFz0Ijq3OyECejDXRzw/hWEx+uPhOFH7PdErXGC8LaQcjsyK9Dp5aelBp0oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452102; c=relaxed/simple;
	bh=z57LfTaJGDPpioooEKgwgM5UMk8JeKI+exkwjuNDgCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVID47b4KZfmxX+oZlEB2rbax9HhRLiHOTtq85CbIp7UmC7SjHXjaBzNlOgkj8w0f5t28n5S9+LteHTv7o1/+4RJ1Nf5xbShMg/A7rZwjuQtXWUeb+o5OFtaux43cj9+9GG3yhG72nx88hGSxwLnOEOkVQC/wVl4QBNOGg93sSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO8bf5ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24776C4CEFB;
	Tue,  9 Sep 2025 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452101;
	bh=z57LfTaJGDPpioooEKgwgM5UMk8JeKI+exkwjuNDgCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JO8bf5ymXKpRtG3CWjSEaf1jhQqlIGcYoMVM7hMkYRDtYO115m+jA23V7fWUrgxuq
	 pjWtlcllWsQpy3LyGHMZKkffYyhWItD67KPzwltXOKA6JXoDya34X/M9kJ0f+N/5cY
	 Nb4y4Z1TdYDHd4128Kf2/G7lI4srrzZvdQWmzPNx9kGb8CeItzKblb8vQmfCR1PMd0
	 ze8VcchJqtFwzRN01jbw4cOoE4jOLcJeQFBsKo6Z8Pn5Nj1yRnxSF7B+UcY+SQlcz9
	 OCrvqv9CiJNdi1FnRY+RDgOJBV5wkCH/q/LFZeBaGDt7tHcZE8cy8/RKe3LtlrKYFH
	 aB6xhdIEF68Ag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 23:07:53 +0200
Subject: [PATCH net-next 7/8] tools: ynl: use 'cond is None'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-ynl-ruff-v1-7-238c2bccdd99@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=z57LfTaJGDPpioooEKgwgM5UMk8JeKI+exkwjuNDgCI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOTDeZ/fKg1M4fvst+z/ZmOX86NO/UwpLcOTN1A8s6q
 xWPVLWmdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExEy4eR4acar5ZK+Z3CG3fv
 8WjvCj5bNfXBNu5gMftPy6ILTr7PU2NkuLRFtUPpywyxh797meou12k+u3FbfxrDlOLF1bMDZyc
 lcQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is better to use the 'is' keyword instead of comparing to None
according to Ruff.

This is linked to Ruff error E711 [1]:

  According to PEP 8, "Comparisons to singletons like None should always
  be done with is or is not, never the equality operators."

Link: https://docs.astral.sh/ruff/rules/none-comparison/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py   | 2 +-
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 1e06f79beb573d2c3ccbcf137438ae2f208f56ec..50805e05020aa65edf86fa6ac5156f1c87244a08 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -705,7 +705,7 @@ class YnlFamily(SpecFamily):
             return attr.as_bin()
 
     def _rsp_add(self, rsp, name, is_multi, decoded):
-        if is_multi == None:
+        if is_multi is None:
             if name in rsp and type(rsp[name]) is not list:
                 rsp[name] = [rsp[name]]
                 is_multi = True
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 5113cf1787f608125e23fa9033d9db81caf51f49..c7fb8abfd65e5d7bdd0ee705aed65f9262431880 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -397,7 +397,7 @@ class TypeScalar(Type):
         if 'enum' in self.attr:
             enum = self.family.consts[self.attr['enum']]
             low, high = enum.value_range()
-            if low == None and high == None:
+            if low is None and high is None:
                 self.checks['sparse'] = True
             else:
                 if 'min' not in self.checks:

-- 
2.51.0


