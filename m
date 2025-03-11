Return-Path: <netdev+bounces-173784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450AA5BAC9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033463A597D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD46221554;
	Tue, 11 Mar 2025 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKLCFCqA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78801C6F55
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681579; cv=none; b=EbfFh9YZxOQgpqXOdUUkmFdaLzjHov+UyyubUXqXd1zWJKrDzQ++Foii0kE9uMz437WGMhCm3ZzqICZvgfzCqhRZasKdv8eTVkVrG81wpe0y7VrjZWS2vuy3bwFPtU78ISPckDN9oMWh7W5sMXY3D/8Tufcpz6O6FmHVEqxIpFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681579; c=relaxed/simple;
	bh=PHcX73WEyMo1a+Naqr2mLFe5LCc7ejJ7ZmEs7JVXidU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCuU5oh7pOI0NakNQknnI8c35WprivFLeT7wUWeEZO/4eYw6el+VWNbePhXCeUtvVawaVow5IuZ3GA/hm5ulK+nAzGM3YzL64q5V9MRrlxfrlucpCu7cfJSewszoYMZxK6f3XmNdKT8vuryy22ZEO4ExREnE16urbxZ7bHyQCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKLCFCqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFCAC4CEE9;
	Tue, 11 Mar 2025 08:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741681578;
	bh=PHcX73WEyMo1a+Naqr2mLFe5LCc7ejJ7ZmEs7JVXidU=;
	h=From:To:Cc:Subject:Date:From;
	b=DKLCFCqAAJ5hCcV6PxOLqSeWl/peysYKZUp3qV3igwqzDnpGjjZjtaOAF1w6EgF8B
	 p8T9eq5HPE58y++iKffxZlWQSGEaGoq8p2XdXtncVYiGNO6RFnQXw9VYnylgcRmXXH
	 NC7LKq17zSFQSIfrPCGPou89bN07Y6PC6gLbv0BXAyW6vLcQR1eiL5cb0ojeL9pUF+
	 Pj6s39hhnpce5/gygOa5DwENVI9hL1QwPDe0hlXp/Y1CmQv5iIkkkX36ogSpVNNQ/U
	 6+wce8yjIDtPG42KelN0gQLkKcCJprvtyFFBnTm7Z/+E8U70ZFwWsZj8YJ+Lj1Hf2r
	 rYaRKXxjyciyw==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next] MAINTAINERS: Add Andrea Mayer as a maintainer of SRv6
Date: Tue, 11 Mar 2025 09:26:06 +0100
Message-Id: <20250311082606.43717-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrea has made significant contributions to SRv6 support in Linux.
Add a maintainers entry for these files so hopefully he is included
on patches going forward.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffbcd072fb14..cfac67dc66de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16649,6 +16649,15 @@ F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
+NETWORKING [SRv6]
+M:	Andrea Mayer <andrea.mayer@uniroma2.it>
+L:	netdev@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
+F:	include/uapi/linux/seg6*
+F:	net/ipv6/seg6*
+F:	tools/testing/selftests/net/srv6*
+
 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet@google.com>
 M:	Neal Cardwell <ncardwell@google.com>
-- 
2.39.5 (Apple Git-154)


