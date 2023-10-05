Return-Path: <netdev+bounces-38203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C6F7B9C39
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 11:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 50A791C2085B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D7107B7;
	Thu,  5 Oct 2023 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMdCxTyN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092C7F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26A4C116D5;
	Thu,  5 Oct 2023 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696498706;
	bh=d5XE/MSf7FUNkmuxaAGhzKlGv4qni/ds0rW0I4rggWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GMdCxTyN/ZXrU2gvITOIWvT+zTvUviqiUiLbxFT9RdyUd4ushHr1L68d01WdLV9OF
	 1PKmuA9cssRgDX0t3RRC17nDVHzzwJZ2MwDvfjPxW+6l4O5ebLix71VXpvWtxxOoHR
	 rH5RfEKdSxN+wMxsugRNdog+8NMTDBt21/ckCiJnXsO7mbwajkMnWRqgylgCEVtYRH
	 9EX26F+pE/MoDUaiXJWUdtDU8WV3fTM82dCIIIfBOlQVy8agJlm2CHcof4wRyfHmga
	 GdUWVZZuhu1HoB/9Xbb+Rgh+uIlTwVsDGTAuHS8ISYevNs2RE90YDjC1HlIUh2nYxw
	 hTH2/DQTwblJQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	jlayton@kernel.org,
	neilb@suse.de,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	kuba@kernel.org
Subject: [PATCH] NFSD: remove NLM_F_MULTI flag in nfsd_genl_rpc_status_compose_msg
Date: Thu,  5 Oct 2023 11:38:17 +0200
Message-ID: <3dd8abe7304ed6649e581bcaaaf61fc1278cb3e2.1696498541.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of unnecessary NLM_F_MULTI flag in nfsd_genl_rpc_status_compose_msg
routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfsctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b71744e355a8..739ed5bf71cd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1527,8 +1527,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	u32 i;
 
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			  &nfsd_nl_family, NLM_F_MULTI,
-			  NFSD_CMD_RPC_STATUS_GET);
+			  &nfsd_nl_family, 0, NFSD_CMD_RPC_STATUS_GET);
 	if (!hdr)
 		return -ENOBUFS;
 
-- 
2.41.0


