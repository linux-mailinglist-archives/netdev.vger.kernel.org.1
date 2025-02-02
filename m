Return-Path: <netdev+bounces-161958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C121A24C74
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DC618846B1
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 01:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E51BC58;
	Sun,  2 Feb 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZMQZNv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9017BD9
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738460853; cv=none; b=sunl11UBHACYzZ51hNOx/8ksmqlRPl2vJOJ0KcqTTegyoFyF2I6moKA+Xhkykx2wVj3q6J64Q0hKRZR1fw6EB6SIHiSEy9X1c1SQlRZV6mEbGFVLa/SjL6Uak2WzsWRf11aOQEK5dBeafdINbfDzDbep5vS+W1iIYFWLerQ45dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738460853; c=relaxed/simple;
	bh=0h9Gx4ZQjJ/3BvRXsub7+BgKB+0TK8UXH1OpxmEvyxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCsQBoDFMl0z12avlepdtlPr473oS/d+7jTW6N6QlfBi67oXWRaRzJBY433SgHryPy3qGqwMWdKEaHgnTuJ/45mURBZmF5xbQDPsl2oKASyclPZs3hKcyxWI3h08zk8iLuVT5GMtTAIR1dfn1PxubN1YMasxV6cbWAL8AfRtKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZMQZNv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D1EC4CEE5;
	Sun,  2 Feb 2025 01:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738460853;
	bh=0h9Gx4ZQjJ/3BvRXsub7+BgKB+0TK8UXH1OpxmEvyxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZMQZNv2nZCHkL7k5gMcMRh6/Zc6ufR/kmo+Qm8bR8vazSXBYdaIvQO6gk2U7rudR
	 3OqbtQ5+eaLEsrU2VlWYn8olLbwyXzi4QlxZWPgOpaQ51bOV7gYK2M4GQ0jZTgesG+
	 T5vvNC6EmQ4+bbluKNQ4q1bZGCggz+Fo8TIZSFjv/LlPeNIfaafzFfhbC20eDMg1rc
	 HxcT8CyKRmBAKSTd7EiDTxGEC9BgJWIyAUmmgCTQSvTlqX1GL7SXGXcBNWS8KNxJWR
	 wv5xMqlgK2A8+Lv5+xILNsznFQgnTnR0ZBaKxMv7x+bSBKXU23sadxmgjGdRk9UYA0
	 hBL1ip3LIKtKA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuniyu@amazon.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 3/3] MAINTAINERS: add entry for UNIX sockets
Date: Sat,  1 Feb 2025 17:47:28 -0800
Message-ID: <20250202014728.1005003-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250202014728.1005003-1-kuba@kernel.org>
References: <20250202014728.1005003-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for UNIX socket, Kuniyuki has been
the de-facto maintainer of this code for a while.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61a8815fd28..ce92c8a3e3ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16663,6 +16663,15 @@ F:	net/core/*sock*
 F:	net/core/scm.c
 F:	net/socket.c
 
+NETWORKING [UNIX SOCKETS]
+M:	Kuniyuki Iwashima <kuniyu@amazon.com>
+S:	Maintained
+F:	include/net/af_unix.h
+F:	include/net/netns/unix.h
+F:	include/uapi/linux/unix_diag.h
+F:	net/unix/
+F:	tools/testing/selftests/net/af_unix/
+
 NETXEN (1/10) GbE SUPPORT
 M:	Manish Chopra <manishc@marvell.com>
 M:	Rahul Verma <rahulv@marvell.com>
-- 
2.48.1


