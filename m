Return-Path: <netdev+bounces-182904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA7A8A55C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC01F7A3FC6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5DB2192E4;
	Tue, 15 Apr 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSRin+XI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F252DFA41;
	Tue, 15 Apr 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738017; cv=none; b=R9oni7BHCF2UGKXE7NrujRdIvA04uP0d7yZalnaXYA835y7efXj9LZt3uSHiKX9svLzxGqsAkMTBcR3DLKByRHa2b/DVy2Ilp7gxSwzuoRYWDnUNO+OsaZF77tgdksH25Xit/8uIRNLDmKdCXXkuXTrTVN5NTPwZfeF7Gj8PqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738017; c=relaxed/simple;
	bh=sb+Sz6Yxyiucz4F0XzTl26j21GxS7DGgFLIILu0YX/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFpzkFbyhoDl/iwCadG6iSKN2vj67XPyA/z+YnkKkKPcCDnVJfsaaS+W8mUSD3NbkMyCB1ZM8nJ2hSkmLnjAllcV7ek79Y8ZW1qzkMnupfpXDJcwq7MDirS2iqnxDYyVCtKxoGWZdE72kCl0fyVmgkAsCJfG9OjQOFMkE3uXv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSRin+XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF892C4CEE9;
	Tue, 15 Apr 2025 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744738017;
	bh=sb+Sz6Yxyiucz4F0XzTl26j21GxS7DGgFLIILu0YX/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=SSRin+XI8xsMmGrsf+7o0V/ku1xzrBVIqkMrto9QeRZMpjRFMtE2l/gUdBbd78iwE
	 LJx3p47m2zD12w+kg0VAa05+JGWJhSlXC9Dk79MaJNQgafBEeWy2nG/H9MLh8urNXp
	 edGSy49xDfJ7SohKpcP/JM7EtZMqtBa/zoHKM80HKNcVoePyqN3wkUuuvUNvpjsybx
	 7g8rif5T0zPs/wOmfbFIJ63zTR+zsfWmFTSF5wNWz65k1e3TeXIv1vM1twYFSlxwnc
	 j5U4ApC162wLCiQGrgDQDjuHHV5UR7kHv7jFN0twlCEn0rp/z0eJdr9PfcWZAhiT5K
	 koan6/vfRqdzw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] docs: networking: clarify intended audience of netdevices.rst
Date: Tue, 15 Apr 2025 10:26:53 -0700
Message-ID: <20250415172653.811147-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netdevices doc is dangerously broad. At least make it clear
that it's intended for developers, not for users.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdevices.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index eab601ab2db0..abfd584f1874 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -8,7 +8,7 @@ Network Devices, the Kernel, and You!
 Introduction
 ============
 The following is a random collection of documentation regarding
-network devices.
+network devices. It is intended for driver developers.
 
 struct net_device lifetime rules
 ================================
-- 
2.49.0


