Return-Path: <netdev+bounces-182482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC892A88DAB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EE1179A04
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726951F4174;
	Mon, 14 Apr 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTbwksFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9791F416A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665603; cv=none; b=g8Pd9+4ZWYeLEf7jm5HOU+biejOvfvkzIxx2qmnpZDinvXRVeMqT0XgMzYVM/FJWYrLIr0A7+SDHrBshTMIB2ygJxCqMg1ONlSCChzrmghSWqPbsd+csBSJSDfyPWeHorRX1ptCLArtANocHr7Pv7yH6EZ3tb12Qg71Fz5BpsE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665603; c=relaxed/simple;
	bh=Do2eAU0Nk/Tazu2Fq6kH6a4QRLTwyAw65utB51JufXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDttizb+ZlrrZDCc6vaxw9npyKVRtmoNnjhWd7Mm7NUD+4z7YZVtPJNxJXkFj531FdYmKdrZqOQ53XZZOLrHXmx7+482o7wDsbllitz7j/ugYjJKBsyPOmuryxvD2v/jrBAE9ij3JoZPw7ckSnrzD3D5nzHy7jRNFImGe/1AFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTbwksFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7185CC4CEEB;
	Mon, 14 Apr 2025 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665602;
	bh=Do2eAU0Nk/Tazu2Fq6kH6a4QRLTwyAw65utB51JufXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTbwksFDMxe+sP5h/IoYrN7AF4r9CPsawCiU4WzCuGqlXnbqmu9MZRDZirUVarqbQ
	 8AUVc+L5VWAmNvEq/p9JmyFHaAjUvXAU/wxYALttBHbh0mw4TSlggYlCGkI0OsMMfs
	 3QrnLbQ0UVwZx7iFABQIqyCrDV2TD6QvI4OAWRQdFIeSQeHBoY+RhCAFao2frt65vI
	 jdG1i9ZZH3pNAhwUmHHy1DOtSCGtcZIItQS0HCLZk2/a/SMyEQDvzdXgn4uRgjxMTX
	 OtocrqvD1SYyTqQme/6f3BgLQHfbulz3Gp80gYQ6o8CqgUzEij1J7FLpnGmn5DB64i
	 JlU/eKWysa8dw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 7/8] netlink: specs: rt-link: adjust mctp attribute naming
Date: Mon, 14 Apr 2025 14:18:50 -0700
Message-ID: <20250414211851.602096-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
References: <20250414211851.602096-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MCTP attribute naming is inconsistent. In C we have:
    IFLA_MCTP_NET,
    IFLA_MCTP_PHYS_BINDING,
         ^^^^

but in YAML:
    - mctp-net
    - phys-binding
      ^
       no "mctp"

It's unclear whether the "mctp" part of the name is supposed
to be a prefix or part of attribute name. Make it a prefix,
seems cleaner, even tho technically phys-binding was added later.

Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt_link.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 03323d7f58dc..6b9d5ee87d93 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -2185,9 +2185,10 @@ protonum: 0
         type: u32
   -
     name: mctp-attrs
+    name-prefix: ifla-mctp-
     attributes:
       -
-        name: mctp-net
+        name: net
         type: u32
       -
         name: phys-binding
-- 
2.49.0


