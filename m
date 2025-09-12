Return-Path: <netdev+bounces-222604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F132AB54F63
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0906A037CA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09631197E;
	Fri, 12 Sep 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFye8UUH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503930DEA5;
	Fri, 12 Sep 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683397; cv=none; b=XtucQ92zZ3zqxZ95PH2oAd3KHydANn0YDAgyRI7uixH/xiXkyQ4PQAE+JUispLJ8PSSCASUmJx8ivwL9Y2uMBnrrB4I9BDwNkXvGUDlfNc08roK6tqWQii+QcXwoX47IqCJZze2UeR+kjSndKrmAIHKhVF3rFhAwOTf2nUD7FOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683397; c=relaxed/simple;
	bh=ftwtHBbPiIFu+p2K8tQlh54LqqJoLrhmdCnkvFFd9Ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNj6ZlJzCkFemX2pIBt2Sh/3wxjBPLxyIREL4XBpNeQMKBGGoi1Vbv1z0VrN9mLJPKS6UiSkw/kdcY96FZd2xgeBJ5odc4bBxmSngOv+/CKYX3dS0ozaQB6guoho1PSOCizr79OUfgw6IbFVLghTrjR/qA1DkeTg82IhEeFfxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFye8UUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F7C4CEF7;
	Fri, 12 Sep 2025 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757683397;
	bh=ftwtHBbPiIFu+p2K8tQlh54LqqJoLrhmdCnkvFFd9Ns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qFye8UUHMEbQhEVGxz8wE0L8iLRQ9azQ8dgy51Pagfqm387dhsavvXqVrcpLXk4lW
	 7UIHdz3XWM25C9BhVAiJGBU/RMPki3XIqc9vB9eVhFXRKAgVjPjibzhaO78mFHpDe/
	 qSl0Vxp+AFTqcG4B2JmlmkOHGwMbPfBpNz3Jgn4mimbOah3ZJ1rX9KWy5vbOpQqNbH
	 4Oi5smFWHYoCGYrq5H4j1Oj7FbwoYlQwV0u1tZE6eytp8kS8+pmX4S8WL+vxQSpHcL
	 ZfCysQyLL6sO9Y8aX+YJ0eJ5o0+ApbudybHyrzKIFVBZZOtr/PifACRhCrPLNn+aDJ
	 2oGWDDti3sQRA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 15:23:00 +0200
Subject: [PATCH net-next v2 2/3] netlink: specs: team: avoid mangling
 multilines doc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-next-ynl-attr-doc-rst-v2-2-c44d36a99992@kernel.org>
References: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
In-Reply-To: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ftwtHBbPiIFu+p2K8tQlh54LqqJoLrhmdCnkvFFd9Ns=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOyO2OnnAl7XZcpYbbW65iIwH51PJJJrUdt7OLShXv+
 TyNyNPrKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEhrJ8M/hWlZq9OyXy06bu/a
 LC7bF92RfPrapKU9apMSeltK5qmtZWR4L6z0+6qme9zyYq4Gu5Y67lUeC1/w7VOWLlfz5Z+ZVsA
 KAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

By default, strings defined in YAML at the next line are folded:
newlines are replaced by spaces. Here, the newlines are there for a
reason, and should be kept in the output.

This can be fixed by adding the '|' symbol to use the "literal" style.
This issue was introduced by commit 387724cbf415 ("Documentation:
netlink: add a YAML spec for team"), but visible in the doc only since
the parent commit.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/team.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
index cf02d47d12a458aaa7d45875a0a54af0093d80a8..fae40835386c82e934f205219cc5796e284999f1 100644
--- a/Documentation/netlink/specs/team.yaml
+++ b/Documentation/netlink/specs/team.yaml
@@ -25,7 +25,7 @@ definitions:
 attribute-sets:
   -
     name: team
-    doc:
+    doc: |
       The team nested layout of get/set msg looks like
           [TEAM_ATTR_LIST_OPTION]
               [TEAM_ATTR_ITEM_OPTION]

-- 
2.51.0


