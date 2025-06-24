Return-Path: <netdev+bounces-200841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE896AE7153
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DA15A183C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87123259CBB;
	Tue, 24 Jun 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS9Vz3Bn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C0259CB1
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799409; cv=none; b=TDCS46vVinSTB0wuHFkB2CdVTT/uxgqIDNjVvvbbOnFeteEON3Wj9LQqw8ZNbVXYdwkwCS7hEVrDdOsqo8F9wikPKind5zGNIA86tdNvVhNUYqsTsg/gqfM/keEnh6jl2oMT4d7bZGJvJNjr2Jsp5RR7tHTjoGBLxJEP0z/KZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799409; c=relaxed/simple;
	bh=+l+q1YPN3J1N++7jWp6jFm8v9Eunv8qr/6B2rrtMfv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJR0YqT2MszoIAEA1wVK6QtCLgwIyDoUUCGhfMrAgwR4Gsi9UDcv7LHmaf+tC5FKpzTEagDikmLry9f3TliZVpFWcg6Q4/gO4IxosunQEkRYxArKBl0BYn1dWCk/x1+42Y6fzmpuzZlcRsgrUL6BX+0TZh6XoB3ct+ChbZwr2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS9Vz3Bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE76BC4CEE3;
	Tue, 24 Jun 2025 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799409;
	bh=+l+q1YPN3J1N++7jWp6jFm8v9Eunv8qr/6B2rrtMfv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fS9Vz3Bn9j/Flngc6GlO/sRlax8nqbV56M082Z8MoQ3uWJhKMeuR5rvFBEjlkXcmn
	 tiGPIj8bjOxIha3TRhWFVtaF54lvbt6NqiyxmpwxE3xB3hloyWs9ZnUaiIKMZwnA+6
	 q4cOaTBt9ZAKbJYL3cRrL4mtxdqDf2bo1zXAuHH/bhCiIVdW2G0ruR6GlIGlMb3Icz
	 EV/14P4gRHWRoSSiqiwICPvgr4eC7klUo1CUWI0T8JeqwRNlKfHbbjdIk+qe2NA8DN
	 zz3kbtoMKYJy01FI7QXLyu3RJ5XVOIMb4Jus0Hvs40+D91ZwJ8FRbpB4qkht9lydCm
	 8Zrb+OuMd7Xzw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	aleksandr.loktionov@intel.com,
	michal.michalik@intel.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net 04/10] netlink: specs: dpll: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:09:56 -0700
Message-ID: <20250624211002.3475021-5-kuba@kernel.org>
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

Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
CC: arkadiusz.kubalewski@intel.com
CC: aleksandr.loktionov@intel.com
CC: michal.michalik@intel.com
CC: vadim.fedorenko@linux.dev
---
 Documentation/netlink/specs/dpll.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8feefeae5376..f434140b538e 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -188,7 +188,7 @@ doc: DPLL subsystem.
     value: 10000
   -
     type: const
-    name: pin-frequency-77_5-khz
+    name: pin-frequency-77-5-khz
     value: 77500
   -
     type: const
-- 
2.49.0


