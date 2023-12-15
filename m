Return-Path: <netdev+bounces-57707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C4813F81
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6F31F22A99
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C27EA;
	Fri, 15 Dec 2023 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsNNDleI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AF7E4
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 01:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1EBC433C8;
	Fri, 15 Dec 2023 01:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702605458;
	bh=h18XnpfXXs8AzjbHI2Fxy48FRT3PeaOl1k5UlNezkq0=;
	h=From:To:Cc:Subject:Date:From;
	b=RsNNDleIiAl2sJ3eiAbVs6pDRJBuRKMUujfrdMOiCytyDMxUK6YkJ2u//QYc0NdCS
	 dTzeXGqO/ne3LYeSQPUTEqUzLPdBUjhNu9uAF+8WafVd5h2pVzA3U6MS0WiEGteYu9
	 +Gi9oj8SoFF7O3h73rSyxH4j73hOkYMOF0R/5aLamQts21TOwBtyLEbnvnl/Sl6ZBu
	 CB+T48E365qSsNS3GbNrb10sSZ3P3kqcyz+ChAcQzvBEX2c3EdHOPcllBjw6P4P5Ts
	 zlY6tFTSEg9tfv2HNfIkZkIJKaAi0qDJhjJNUp3RC5H27fwlQxiQWbkZzb/brhPtb3
	 nfdcqfVauBmMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] netlink: specs: prep legacy specs for C code gen
Date: Thu, 14 Dec 2023 17:57:32 -0800
Message-ID: <20231215015735.3419974-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor adjustments to some specs to make them ready for C code gen.

v2:
 - fix MAINATINERS and subject of patch 3

Jakub Kicinski (3):
  netlink: specs: ovs: remove fixed header fields from attrs
  netlink: specs: ovs: correct enum names in specs
  netlink: specs: mptcp: rename the MPTCP path management spec

 Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} | 0
 Documentation/netlink/specs/ovs_datapath.yaml             | 3 +--
 Documentation/netlink/specs/ovs_flow.yaml                 | 7 ++++---
 Documentation/netlink/specs/ovs_vport.yaml                | 4 ----
 MAINTAINERS                                               | 2 +-
 include/uapi/linux/mptcp_pm.h                             | 2 +-
 net/mptcp/mptcp_pm_gen.c                                  | 2 +-
 net/mptcp/mptcp_pm_gen.h                                  | 2 +-
 8 files changed, 9 insertions(+), 13 deletions(-)
 rename Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} (100%)

-- 
2.43.0


