Return-Path: <netdev+bounces-219705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF56B42BBE
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666F3580943
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF832EAD0B;
	Wed,  3 Sep 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxOuvV+a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EA2EA753
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934458; cv=none; b=GTqqt1MGgFH08gQrtw38a8DiO+ZW/jDB4KFgKUzDh7r3HCYmwffVU8BZ+f99EiQBDHlUgU3wb2af+ZSJGbdCanbjOq1vQKLmzNu7Q9UDMlDYG95q0genDxV/Qani0u1qogpocxHz70/DRkXkHefMTkm7JTdvGa4smuhP3jUljeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934458; c=relaxed/simple;
	bh=Fi2z0kHmbeboOB73NpFmJANa/lBlgNnhWuFvmgwCikM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=px7+NWPaNG7uOQJFyAh1lCCpOL9Cyj9mbOcPB1crkIO4vJfVOtUxMtDKudPWdj3paZdOrbMeU9BKhVhfZR2QhwMYRGtSfWpjVAngKCpgIA9iqTxO68hOWrY2RG/NN4vf+MWNMlRm8vaUxaARJpVkzejVkiUopNKYR+F4onYXvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxOuvV+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24D6C4CEF5;
	Wed,  3 Sep 2025 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756934458;
	bh=Fi2z0kHmbeboOB73NpFmJANa/lBlgNnhWuFvmgwCikM=;
	h=From:To:Cc:Subject:Date:From;
	b=lxOuvV+aeSIUpDga4fEqZDRYd768J4CvuppprwStfYkPoMvX/VM8vn1nX5A7u9W/n
	 lKfzSXGXvoAq9xc6UX495+ECQ9dLXUV93gxSL6A+qeOYHjTVTTefDTomIe/uSEnq0E
	 2u+bJAoTq5ROOC2uOXVq5u9loiCDoiIRwf/HT0IjTtFrltkldfO8YQ2VLc90+Er95z
	 p4Xj1e/SOMxNOFcTeuphdzkhuGhmdMQYmqGZJ01OkR9s7mXpIqmABTE4K0Xwk/0nST
	 KV4jOAcOerhEApFtsyqcUsWwL72GcHbcz115L8aKw12/y0EJttAY/Hw6ouhQTi1yu6
	 cGk3DomYgMT/w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	john.fastabend@gmail.com,
	sd@queasysnail.net
Subject: [PATCH net] MAINTAINERS: add Sabrina to TLS maintainers
Date: Wed,  3 Sep 2025 14:20:54 -0700
Message-ID: <20250903212054.1885058-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sabrina has been very helpful reviewing TLS patches, fixing bugs,
and, I believe, the last one to implement any major feature in
the TLS code base (rekeying). Add her as a maintainer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
cc: john.fastabend@gmail.com
cc: sd@queasysnail.net

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94213c175533..970ca908aa27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17851,6 +17851,7 @@ F:	net/ipv6/tcp*.c
 NETWORKING [TLS]
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Jakub Kicinski <kuba@kernel.org>
+M:	Sabrina Dubroca <sd@queasysnail.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	include/net/tls.h
-- 
2.51.0


