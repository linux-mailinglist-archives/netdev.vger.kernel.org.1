Return-Path: <netdev+bounces-200844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9833AE7156
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B471B1BC34FB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1C125A626;
	Tue, 24 Jun 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/ovR9+j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E025A624;
	Tue, 24 Jun 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799411; cv=none; b=S1hXzdziwYw3tdc6Q5JqKsO71NA16sOUAsQm2A8oTlQM8lAvg6vrvdgxmZ9KHz/Rz7CCDcyfkfq7SBtfJXPPmnkLghck/5Bow5WsY5t2KomLIsHvPZgLKwsWmqjMh149NP24lAijyulABC8i1Dc3ifD6sEonS59SqjnD/xUT5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799411; c=relaxed/simple;
	bh=WW3n5z8BKkttYwZrK2VL1cVP754ZJdoyiAbJs4kgSeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lx93FunCkpHIn1clUWXy/Pi6+p7ktM4IalUBw9TOyr7K/1C50OocWTGw0w1livA4JTbQCmyjdT8m0grA2cu8W7oii9C9X0NQD3Mu/8+SOSwsbS6pDwAqILI+cRM42vD5Cc1yzLF12doP5tuaCqRigK3jS0ZcGHjgOfrqKSYyswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/ovR9+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B01C4CEEF;
	Tue, 24 Jun 2025 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799411;
	bh=WW3n5z8BKkttYwZrK2VL1cVP754ZJdoyiAbJs4kgSeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/ovR9+jyu1CIyKOfi9YMNOL7zXHDik5MGw1NGq8AVkq5xXvVqVY+XcJm+g8RMfB5
	 8C3/X5rSNRFMfNlgalEmz0omngnkbiLGr5JqdmIqAVuwnAYeOsxuSbmAVXD2i9b3di
	 rRjit5CgoPGBhERqOGEmSALCoGfqrFn9EErLWM0PRQa5vZApjKtIX90MIAPc/X3CiO
	 A8ag7uVR1Uv8PHoFxV3u9YZC5qaoVHkXFU+72H0/oWkqF2xxySfaGqz8FQXE1L1QL5
	 lFXbWK5LSZMVBPbZtvp4oPPuDi3TAneejVkECJ8NKSKZrYhyl92YOk1OhYfUgjewL8
	 db7DgXEyNO55w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	dcaratti@redhat.com,
	mptcp@lists.linux.dev
Subject: [PATCH net 07/10] netlink: specs: mptcp: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:09:59 -0700
Message-ID: <20250624211002.3475021-8-kuba@kernel.org>
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

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: matttbe@kernel.org
CC: martineau@kernel.org
CC: geliang@kernel.org
CC: donald.hunter@gmail.com
CC: dcaratti@redhat.com
CC: mptcp@lists.linux.dev
---
 Documentation/netlink/specs/mptcp_pm.yaml | 8 ++++----
 include/uapi/linux/mptcp_pm.h             | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index dfd017780d2f..fb57860fe778 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -57,21 +57,21 @@ cmd-cnt-name: --mptcp-pm-cmd-after-last
       doc: >-
         A new subflow has been established. 'error' should not be set.
         Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: sub-closed
       doc: >-
         A subflow has been closed. An error (copy of sk_err) could be set if an
         error has been detected for this subflow.
         Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: sub-priority
       value: 13
       doc: >-
         The priority of a subflow has changed. 'error' should not be set.
         Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: listener-created
       value: 15
@@ -255,7 +255,7 @@ cmd-cnt-name: --mptcp-pm-cmd-after-last
         name: timeout
         type: u32
       -
-        name: if_idx
+        name: if-idx
         type: u32
       -
         name: reset-reason
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 84fa8a21dfd0..6ac84b2f636c 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -27,14 +27,14 @@
  *   token, rem_id.
  * @MPTCP_EVENT_SUB_ESTABLISHED: A new subflow has been established. 'error'
  *   should not be set. Attributes: token, family, loc_id, rem_id, saddr4 |
- *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if-idx [, error].
  * @MPTCP_EVENT_SUB_CLOSED: A subflow has been closed. An error (copy of
  *   sk_err) could be set if an error has been detected for this subflow.
  *   Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
- *   daddr6, sport, dport, backup, if_idx [, error].
+ *   daddr6, sport, dport, backup, if-idx [, error].
  * @MPTCP_EVENT_SUB_PRIORITY: The priority of a subflow has changed. 'error'
  *   should not be set. Attributes: token, family, loc_id, rem_id, saddr4 |
- *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if-idx [, error].
  * @MPTCP_EVENT_LISTENER_CREATED: A new PM listener is created. Attributes:
  *   family, sport, saddr4 | saddr6.
  * @MPTCP_EVENT_LISTENER_CLOSED: A PM listener is closed. Attributes: family,
-- 
2.49.0


