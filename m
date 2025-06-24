Return-Path: <netdev+bounces-200838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C5CAE714F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C1617B8E1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF2D2571A5;
	Tue, 24 Jun 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOjjy9qi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6752566E9
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799407; cv=none; b=qEF7RVQNBPlAeFQ+igsqmglRhERl4GMAQNWJNLUf/EAb9PJfoX+lVr8DIc54KIvH8Xl5zp/kgBNg/rgFfhhzRbi8zb1N20YYfp6+lIMkFYn+5AS3fcwLmGfNN7jYTaRvog9nZB0Xr5imB/qc4kTswNYMU+BmWSkG8tpqg9BOR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799407; c=relaxed/simple;
	bh=f7GoD7ZSlUC5mZAPAdXHA6lB7e3dh5yBnV/pV8l/jDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=or00EnO8kApaziLuMf4FzajkdqGvdwiCvj5mXxKJeG0OG/w5wdspDXx4V/qzj7ogRLCD1mbgt73TYsNqv4F+IeFblhdHShPc3A0a84yJwY47iD+Zhp+OxMZDkcvnHtUSQe2OKIH+9Sv0IAIBIGg8uOLaQ0dodC+cRadnvVjQUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOjjy9qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95157C4CEE3;
	Tue, 24 Jun 2025 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799407;
	bh=f7GoD7ZSlUC5mZAPAdXHA6lB7e3dh5yBnV/pV8l/jDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOjjy9qib9ZhWewVeHNPA5NkWm0YcvR0SLwoc1KCpaC+IcmiJ53SmTVbmvsJDjBQn
	 0p+7scbpn/HM4NH6/f/dQZgOtA3ORDmf2epK0ZtOLGNLjZd5ItawsQsECQOnOCIurf
	 I6itr3XExlmkGyTvPE+gJSxW7IXpjQRI6J7zCVGThv01xOH+/PvD9wTMksWhkzBvPL
	 aUieXFKs8mrg5zEIENaBVqvHUlKQWLfclqEPO+CRMdeIBrRkrLCinDmXM9wS7Gf0W/
	 Kf59RTYEkAC6b0sUsTQm8y6fgJDx9KJfRlf+fDfU6Ju5PhmvtYehrzVjrvllFClyR8
	 fjgQ6/ksWareA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	lorenzo@kernel.org
Subject: [PATCH net 01/10] netlink: specs: nfsd: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:09:53 -0700
Message-ID: <20250624211002.3475021-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're trying to add a strict regexp for the name format in the spec.
Underscores will not be allowed, dashes should be used instead.
This makes no difference to C (codegen, if used, replaces special
chars in names) but it gives more uniform naming in Python.

Fixes: 13727f85b49b ("NFSD: introduce netlink stubs")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: chuck.lever@oracle.com
CC: jlayton@kernel.org
CC: lorenzo@kernel.org
---
 Documentation/netlink/specs/nfsd.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index c87658114852..8d1a3c01708f 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -27,7 +27,7 @@ doc: NFSD configuration over generic netlink.
         name: proc
         type: u32
       -
-        name: service_time
+        name: service-time
         type: s64
       -
         name: pad
@@ -139,7 +139,7 @@ doc: NFSD configuration over generic netlink.
             - prog
             - version
             - proc
-            - service_time
+            - service-time
             - saddr4
             - daddr4
             - saddr6
-- 
2.49.0


