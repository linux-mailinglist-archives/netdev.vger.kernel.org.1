Return-Path: <netdev+bounces-161956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9583EA24C73
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615AC3A43A7
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 01:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8548B676;
	Sun,  2 Feb 2025 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvkjWcNr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384EA936
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738460852; cv=none; b=HD0xpo+jlW9VaTeUgLE9QNbervCZbopXhdwLibzszr662815OktSHeFhLxRqFNIR7QX+3EXvAbysXPAZiPRCDy8ZHfBUaSWt2jODBj6pMOZ0L5ymIf/IV0CruBz8Z+5H8pJb8jKGqlCnEqwuYo6mgXSUkfbULfuoRvhOgZPaMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738460852; c=relaxed/simple;
	bh=hO8Mz3yNXPfxHejm6ra+uyCBvi993Ph/Aev2CiuKCMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SobCBrtM+NMKQvUzzG66xddc5BNx+Pf2H56+jxqO+V+DaB6sGfNZ4NNQHMBptd8sBYFmNz4Xqtmd5/em6rqUSxD1yfTqde1V+xqe9fLw3ZiJiMUNYt00tw4foATJxD60mL/bb8TlSXifwh4RfNfN36OSQ/WoXGDJbletHSo+3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvkjWcNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C57BC4CEE2;
	Sun,  2 Feb 2025 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738460852;
	bh=hO8Mz3yNXPfxHejm6ra+uyCBvi993Ph/Aev2CiuKCMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvkjWcNrb71Mb9QMgkLpztVH+REjwcaq8iQjXUnflGYWus8eCVgPaXK/XPboxNzMa
	 6PTLYRn+UgKaqoqqVVL+uwFcWdGnWd7WyWx4WfLMcU3e0mQkWiEWJrr6bdK0BROz6B
	 i+rZX/rHoYz16uURkFcEt0fp/ETzlGrcVtJ3Gq0jRi/wv1PDPC6J0Nl3ZWvFc+p9ib
	 +MziRtxaLl345wse8q9UPIpNUP6I5KV94aLeStCGlg0LKF/89E1fAXRqzcurikAUZV
	 5H4QAhoTRxo0MKecDAx1om+48bzf9ehkcswXxWuGOgtfDQrYtPWZi/+o75eAymZTUX
	 OMi3eRDt7yQAg==
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
Subject: [PATCH net 1/3] MAINTAINERS: add Kuniyuki Iwashima to TCP reviewers
Date: Sat,  1 Feb 2025 17:47:26 -0800
Message-ID: <20250202014728.1005003-2-kuba@kernel.org>
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

List Kuniyuki as an official TCP reviewer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efefb04de7fa..dd5c59ec5126 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16619,6 +16619,7 @@ F:	tools/testing/selftests/net/mptcp/
 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet@google.com>
 M:	Neal Cardwell <ncardwell@google.com>
+R:	Kuniyuki Iwashima <kuniyu@amazon.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/net_cachelines/tcp_sock.rst
-- 
2.48.1


