Return-Path: <netdev+bounces-174137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C271A5D947
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27A7173CD5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505C23A98C;
	Wed, 12 Mar 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1d7/Ie4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40EB2222DB
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771338; cv=none; b=Do6MVTi+/3se0dKRwGCs9qFnm5R4SEKdmMmeA1f9hGkgqnvATj1CZqVBsMayWOat/gIRLlp2L/50jjjtkhLkEhvEhTcfyLHdG7FWBPqR7qJICo4SV+rUZ3RIeKzf3GKbNhm1DcQcE+BSUK44YbgmfzPjREj66LhUUfSwEc/v+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771338; c=relaxed/simple;
	bh=/r9PKLYe0+WoOlDJzTRqb1IN3+/nRPCexBrBGKAqtQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AfoqH6J/yFVORluDBx0UVuP/X5zqYOybIqquh0TOzuG0B5CCt6ZeV1C5IfMI71C/cNQohCXaGRrC1KLNjqntjN0xPn4TxUBkz4X3UDSQ/h69HKl1T//eFymN3JS6zJ/zxNU4QfwJDd6ZhYGGyitzyf1ctLcKwdPZU9Z+0gmRF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1d7/Ie4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D9CC4CEE3;
	Wed, 12 Mar 2025 09:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741771338;
	bh=/r9PKLYe0+WoOlDJzTRqb1IN3+/nRPCexBrBGKAqtQw=;
	h=From:To:Cc:Subject:Date:From;
	b=d1d7/Ie4ZVkbppiaTDwyb2S5ne4qEZiuGYhMPfvrJHrkuoo0ylAKalhplKMJgCt+k
	 cRTSG7c71zsUmr6rcjEzDTCbCSPa3WZK11Rz+wGA5flW8CUJVNETSf9aAKj4hFfC90
	 isVSG+M0me0D6Uw0tjZ4hjpCoUVcq/aj8WcUpk39iLYWIJK6KrclRMKOzm9eExm69A
	 p8radKqj4RDdJXjvTLcYlg2dhgpYtO+pRCqtSksrGxATrwT8/GZuuPplwHp+Nvsg/b
	 Ykl0YSsbvKJUsgyTvgMw6kFXGokpHoU9G+eAqpe65Y0a5WwTpRo4yAupgqlBzwlzsO
	 smaQaw6gQ96Og==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v2 net-next] MAINTAINERS: Add Andrea Mayer as a maintainer of SRv6
Date: Wed, 12 Mar 2025 10:22:12 +0100
Message-Id: <20250312092212.46299-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrea has made significant contributions to SRv6 support in Linux.
Acknowledge the work and on-going interest in Srv6 support with a
maintainers entry for these files so hopefully he is included
on patches going forward.

v2
- add non-uapi header files

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffbcd072fb14..e512dab77f1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16649,6 +16649,17 @@ F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
+NETWORKING [SRv6]
+M:	Andrea Mayer <andrea.mayer@uniroma2.it>
+L:	netdev@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
+F:	include/linux/seg6*
+F:	include/net/seg6*
+F:	include/uapi/linux/seg6*
+F:	net/ipv6/seg6*
+F:	tools/testing/selftests/net/srv6*
+
 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet@google.com>
 M:	Neal Cardwell <ncardwell@google.com>
-- 
2.39.5 (Apple Git-154)


