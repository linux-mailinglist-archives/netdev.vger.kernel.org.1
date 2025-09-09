Return-Path: <netdev+bounces-221427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EB7B507B9
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54261889927
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F47262FE7;
	Tue,  9 Sep 2025 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrpOcJ4a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08EE262FD3;
	Tue,  9 Sep 2025 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452099; cv=none; b=Oj+P6hGQmbHnt2bPOM/39yQelXs+NlKtxqyjhrPqIGMG53Ig5peZfiuJDjC9RiI2drHAyo0QXmNZu4DfJuEtgJjEhj2QyAU8uV4tGUkjvmkNWu7E5BG4KHfZ2VxfYTM2PkG9fJoSCChnAPI4MVpacqHRd4n0zBk0/CKkaMxlafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452099; c=relaxed/simple;
	bh=2Vs5XxdtdWnMR7InzqV/N/e/gSsw7PO7A03we7TMIEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5jd/+5jrcn87UrMqVMLXdszmf+TSla3F/Nzv3L/LzT5O2wMS3s2vUnOeSXi6HFspjSZfYOSJ3T5kvJ2o1hKnv+WR9xJSTXCpCUqCu1xFZePxWkTN9l8/N4JhtxaBvlGtoXD03AqZjE5GwpMO3uyIhKJU4Z8Egficyfvriauam0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrpOcJ4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E326C4CEF4;
	Tue,  9 Sep 2025 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757452099;
	bh=2Vs5XxdtdWnMR7InzqV/N/e/gSsw7PO7A03we7TMIEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hrpOcJ4aBfT7rVMZrZmf0MSoqsAOK0TGkGtD+F/6xR4jo5iM7MolO8URPhwoqSc65
	 q2977Le6sRv18v5VkSjkDcOYqLsshsWnkUU1lXbkpSNxSC5JY7nHASslGCzXwtcSrb
	 bxfBvUw9JbH5s7udr73Q3Vz3RqNr/8VRioAXeqZB6saXgxim7QT5jLnKlIkTLiQsrf
	 Hkk5Xw4JnIvkmC40UTh9WxsVTYXfZ3lmZjtXVW3YLTI4uXP+HNXZqaDAR9mfEAewAT
	 PI+J3IWjrKYphAoP2aRzHVXN18YLUC+ZXz+sQh6XqEtTsN7qGobaS37LnSmdWJoM1E
	 PoA1JQQhuxAxQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 23:07:52 +0200
Subject: [PATCH net-next 6/8] tools: ynl: remove unnecessary semicolons
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-net-next-ynl-ruff-v1-6-238c2bccdd99@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2Vs5XxdtdWnMR7InzqV/N/e/gSsw7PO7A03we7TMIEw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOTDde9vNbaMXlBwtOJuds9gkS/CyX5MQVlZSpuDjo2
 9LS7P5dHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZxsTIcLnm99viVPMXl/b9
 UvB8fPPJv3ThfU9T7ogde6y0QfafnzQjw5u2HV4Np3f/qJ2o5/l1366JBklsnz5zH5112r/Kd+9
 jL34A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These semicolons are not required according to Ruff. Simply remove them.

This is linked to Ruff error E703 [1]:

  A trailing semicolon is unnecessary and should be removed.

Link: https://docs.astral.sh/ruff/rules/useless-semicolon/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/net/ynl/pyynl/lib/nlspec.py | 2 +-
 tools/net/ynl/pyynl/lib/ynl.py    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index 314ec80074964ecfa34a226de5700b42d4dbfad4..85c17fe01e35aa4b4f5d6cc2bc687621def90575 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -501,7 +501,7 @@ class SpecFamily(SpecElement):
         return SpecStruct(self, elem)
 
     def new_sub_message(self, elem):
-        return SpecSubMessage(self, elem);
+        return SpecSubMessage(self, elem)
 
     def new_operation(self, elem, req_val, rsp_val):
         return SpecOperation(self, elem, req_val, rsp_val)
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index da307fd1e9b0f5c54f39412d6b572557e83dbf86..1e06f79beb573d2c3ccbcf137438ae2f208f56ec 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -738,7 +738,7 @@ class YnlFamily(SpecFamily):
         decoded = {}
         offset = 0
         if msg_format.fixed_header:
-            decoded.update(self._decode_struct(attr.raw, msg_format.fixed_header));
+            decoded.update(self._decode_struct(attr.raw, msg_format.fixed_header))
             offset = self._struct_size(msg_format.fixed_header)
         if msg_format.attr_set:
             if msg_format.attr_set in self.attr_sets:

-- 
2.51.0


