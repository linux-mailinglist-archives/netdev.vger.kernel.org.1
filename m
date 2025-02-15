Return-Path: <netdev+bounces-166690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E3A36F77
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493CF3A7C95
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665601DE2C7;
	Sat, 15 Feb 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGFZhPFK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218FD529
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636815; cv=none; b=kb88oTv+f/tUVR+c3XykJ68EgLZD4K9DtQmeqGQbYNdHZh3ZED43gQwB4oiT22R9lD6yXo8rBCx1dh+qpZwv0wLjUpsJX00n5fIZYdYpfO36oAEGfR/2fJkrvcu8h7mMSRdWUZawpZsKFqmGpRwphLEyJBCI9EVDLzFz88zE5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636815; c=relaxed/simple;
	bh=7DnbGMz6w8BpDjH+L2rTaGtk5gGBNylaz0S1Cv/X40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQFkEE6DmwvnNBjrZgvcyazDq34qQ7RW2u74XtnOUaREC6Rtfua8p/29NKe9WAOA/z0IOJsbh30ioDowwmHM4Dwcc0it42l0HXjUYCe+oTigRPSulHpYMvz6USf/kxWsRLlzolJq6Gw1Fl9QRhq8DgtE9/ksNGfJZURO8veLIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGFZhPFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48753C4CEDF;
	Sat, 15 Feb 2025 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739636814;
	bh=7DnbGMz6w8BpDjH+L2rTaGtk5gGBNylaz0S1Cv/X40Y=;
	h=From:To:Cc:Subject:Date:From;
	b=nGFZhPFKlPTrKBtfMNoGD0eAj0dcR6rVDHE+4kcyonaZmK8rwhqcpbx4WExiaSSl/
	 sRDaakvr10OTtcGNFGG0mLupWqzleYQ724ZkIWtmG52bmiWaMSb9RxhbI2YEZIboc2
	 HAy7lJzNB3TjCGoZf8uMZnUWsszfQ76o4Poapp9DQpZ2fUOxA/mLdJ8h0RfIBWXeTl
	 rnoAZqB2HaCFuH80L5eRUtQcfEMLhnk5T7C20Qm8B8p1vlKCW5ScPoCAbY5W/TFWQV
	 mZg1/vOHbc1US3+jHh6sSNRZYec2gpXL704xpSbhkSXrbBrFOM3Qs1pTDReg834k+q
	 5eRL6fMHDalNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jeroendb@google.com,
	hramamurthy@google.com,
	joshwash@google.com,
	willemb@google.com
Subject: [PATCH net] MAINTAINERS: trim the GVE entry
Date: Sat, 15 Feb 2025 08:26:46 -0800
Message-ID: <20250215162646.2446559-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We requested in the past that GVE patches coming out of Google should
be submitted only by GVE maintainers. There were too many patches
posted which didn't follow the subsystem guidance.

Recently Joshua was added to maintainers, but even tho he was asked
to follow the netdev "FAQ" in the past [1] he still does not follow
the trivial rules. It is not reasonable for a person who hasn't read
the maintainer entry for the subsystem to be a driver maintainer.

Link: https://lore.kernel.org/20240610172720.073d5912@kernel.org # [1]
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jeroendb@google.com
CC: hramamurthy@google.com
CC: joshwash@google.com
CC: willemb@google.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 988b0ff94fda..f4a2951c4d90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9834,7 +9834,6 @@ F:	drivers/input/touchscreen/goodix*
 
 GOOGLE ETHERNET DRIVERS
 M:	Jeroen de Borst <jeroendb@google.com>
-M:	Joshua Washington <joshwash@google.com>
 M:	Harshitha Ramamurthy <hramamurthy@google.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.48.1


