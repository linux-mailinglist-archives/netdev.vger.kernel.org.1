Return-Path: <netdev+bounces-185293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06BA99B30
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1E41B836B5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D61E32D5;
	Wed, 23 Apr 2025 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/0Shikx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77921E1308
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445754; cv=none; b=N7DQL9gYEeS+ACacx571O0JdohH3o5ZYbV+jRqCim50Pzeqy3T8JD0hBJZ5R8T/IspmYtWW0kG2JNTWsiaCks7oTSgeCTN0OifkvTUMGFgunsPbRnROOfQ8c/X9AgvFTtR7Zua0Z0uUnZg0I5ulDGP2Xu9K3loZKbdDF2wSaVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445754; c=relaxed/simple;
	bh=hCJEUkQCCILjWFV2XmdQc1O6wx01bPMTRRLAu6Qjhyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAazglTDBWKFpn7RblSpdLiRHw6pSjqUCQoiqjURIRv687JHfk1W1DgRyn189RAAuY+zKQYC/KwMR5o3jEfGK4b0ONHigUVp3Q0pyYT/gPrhWjJQafc6QN+jdsoqXZP5Ku3v5JvzGQvCqLekkU3S9dwA6uoitD6mMTB+xZRkm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/0Shikx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF07CC4CEE2;
	Wed, 23 Apr 2025 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745445754;
	bh=hCJEUkQCCILjWFV2XmdQc1O6wx01bPMTRRLAu6Qjhyo=;
	h=From:To:Cc:Subject:Date:From;
	b=h/0ShikxIxZOszJF2Y9hW0nZbXVcJzOpn446zjpXVe9P5B3MRpU0urV6zDbDniSxb
	 o5X3J6PFRQymwRopnd85sFS03E6bbi6hSqaAvS5CFUKIcpCysdomM16v7DzGf45DhD
	 oAjwbRCg1w1fXtwr8Kl7R3dZSBe7FLy3frQv5ecit+iNxKGhdKRzU9wfLtsiQYjgMK
	 mkx9dELaQf04fCWjKP4k53QuIVu+nmTG+TmIsRU5vJfw+Cnv9hQoRVzh1Ybwe/lVrg
	 Si1el2/yjMqm3QREUvGeu/qETyNNQKdTTQ8ckIBDxpfWwwAGQgreK2m8YYNjplguC6
	 tc2YIZty+TLRg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	danieller@nvidia.com,
	sdf@fomichev.me
Subject: [PATCH net-next] tools: ynl: fix the header guard name for OVPN
Date: Wed, 23 Apr 2025 15:02:31 -0700
Message-ID: <20250423220231.1035931-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thorsten reports that after upgrading system headers from linux-next
the YNL build breaks. I typo'ed the header guard, _H is missing.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Link: https://lore.kernel.org/59ba7a94-17b9-485f-aa6d-14e4f01a7a39@leemhuis.info
Fixes: 12b196568a3a ("tools: ynl: add missing header deps")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jacob.e.keller@intel.com
CC: danieller@nvidia.com
CC: sdf@fomichev.me
---
 tools/net/ynl/Makefile.deps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 8b7bf673b686..a5e6093903fb 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -27,7 +27,7 @@ CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
 CFLAGS_nl80211:=$(call get_hdr_inc,__LINUX_NL802121_H,nl80211.h)
 CFLAGS_nlctrl:=$(call get_hdr_inc,__LINUX_GENERIC_NETLINK_H,genetlink.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
-CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN,ovpn.h)
+CFLAGS_ovpn:=$(call get_hdr_inc,_LINUX_OVPN_H,ovpn.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
-- 
2.49.0


