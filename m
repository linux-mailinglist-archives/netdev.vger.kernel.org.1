Return-Path: <netdev+bounces-226193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB2AB9DD0E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F364A18899C1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60F2E8E04;
	Thu, 25 Sep 2025 07:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32E26FA5B;
	Thu, 25 Sep 2025 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784201; cv=none; b=sXnWZ69e1zjWg+vN8IkZyTGmuigC164Bkj6jPr5PCqLUsW/lRtXt3fH7Erj5P9j5Yie0Y6UCdnxNl0IERWVQmDv/shakG7S27o8ad1ni3HA+qvvzKBw6iACkzloPCHjBtdYn7ujtkjS+QVB7YYwgKw9vLLS6hGmvVmTEleH+kxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784201; c=relaxed/simple;
	bh=SCJEWtZEiSlZn+8gx3kqeO1jWEXxVTA2Eq65cO3lrOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0qg1sgtb0yTClBAlWhc5SDhHLR9Up77I4E1vgZuSKuVYuHzqmTd5YVZFOGQsOak91d3E19VymjDF5Z+YunhVqpL4zjQIzP5pSDtSCvLLu9m4XssImrQKFBIxp8b/YvaVf3V4Fb4SK/r+71It0FzozZ+AHnd+AZ6cTK/IhmYYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB67C4CEF0;
	Thu, 25 Sep 2025 07:09:59 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] psp: Expand PSP acronym in INET_PSP help description
Date: Thu, 25 Sep 2025 09:09:50 +0200
Message-ID: <ae13c3ed7f80e604b8ae1561437a67b73549e599.1758784164.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People not very intimate with PSP may not know the meaning of this
recursive acronym.  Hence replace the half-explanatory "PSP protocol" in
the help description by the full expansion, like is done in the linked
PSP Architecture Specification document.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 net/psp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/psp/Kconfig b/net/psp/Kconfig
index a7d24691a7e1d26e..371e8771f3bd38d1 100644
--- a/net/psp/Kconfig
+++ b/net/psp/Kconfig
@@ -8,7 +8,7 @@ config INET_PSP
 	select SKB_DECRYPTED
 	select SOCK_VALIDATE_XMIT
 	help
-	Enable kernel support for the PSP protocol.
+	Enable kernel support for the PSP Security Protocol (PSP).
 	For more information see:
 	  https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
 
-- 
2.43.0


