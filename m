Return-Path: <netdev+bounces-143933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28189C4C9B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523ACB27C0A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E0C205E22;
	Tue, 12 Nov 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="pXJXmMZO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODauS2q7"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5DF50F;
	Tue, 12 Nov 2024 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378301; cv=none; b=j8Oj3EPSgxN5zPVRYoLGfxD8uYJmOhOvTNVfMf17EeRQ4LAN5MA2SaCzlzQw+z1XPNeIw4nmwWYCbgyCNYwdAY4q2HOeVG/NsWsK6Bg67xRIBpr1PY4av80dR9DeXg8RqyhEQLxBdY69GeSfvKhDg0QS2zLxVy9cwhGuQx8wFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378301; c=relaxed/simple;
	bh=Ijbk3Pr2g1cV1stuaPcO0SMWb4AI2/oyYbU/HhQZie4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcx0FzM79hb1fuKCPBKvixuyyY/PHdNydK71JSQqn8LXgOoemJ2v/pLTaxGfgyd55rO9Vu7mwY+M5ZIlwfvHsvneW2Vg9yAvHCH40pyYHPCYTM6d08/bM+b9jqrRQpgPO593QBDgK9l35eu1FtGIMvyE5QyyZj9U6VyixEkVsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=pXJXmMZO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODauS2q7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3BA2114011B;
	Mon, 11 Nov 2024 21:24:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 21:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731378298; x=
	1731464698; bh=VxZnqmS/y+9L9W/ar0XabTk2ezV5wTswTuwNGTb+0Lk=; b=p
	XJXmMZO4EcJ9M3g7QsYsl99o4fsO9iWVm21OPlQrQadq2/BqXapdtD1Ed4VlpQ8N
	yCz0wGCxv/+FgtR6/5vxNfhyqNt/YzzZYg4qgzJjxH2N3/gHTbo4aqnm2VsSKUWL
	mSDSUHwjegw3CGyxIunvKUPijOj4AR7nUukqbLZ51C9wTu0Fp1x6dRHSUsygwy4y
	rpAMFAyhDyQTaQglS491Rwg7BGAHSevH9zZsL+k5St0wBErY57K4G13S4yyxhbH3
	RkzKb1J9I6bxGU7eGKoIXKybQY9ujO+Us7xa8xao82hHvCZLUPgUZddig7cfNNlT
	QUF78SbR4vOGFaYQZZJ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731378298; x=1731464698; bh=V
	xZnqmS/y+9L9W/ar0XabTk2ezV5wTswTuwNGTb+0Lk=; b=ODauS2q7rCuQD63mR
	xFfsWxo1sqRVQHLBTfez7LMHIoqfPmuk5SXe50s5piP8PkslmeYdSnZt2OoMAkGV
	713cxFdstqnegKCGGKr41iXaSW/uqR+8abbb9Djvh6VE2VK6hwqbiO0aHjhYO7B+
	SGo+Duk73Z976C97D7EBvFhLpkRVSWzEGI9DumSOBr74XnFn7M3HgHVshKPfNIDR
	cWXZZ/D8hq3Uus7bzX3MpmqmX+ueyediaqdLOaoxylmaXk4MKZCQ+czXf/YkU0jx
	QTBb2dJzxOBewyfXAyajQVJb6AdqK7dtpgLsiJzuuhhZdOLdxhya+p8AATTf8QQ3
	mK8/g==
X-ME-Sender: <xms:erwyZ2R3SNxFuQ5X6ZU8RHut6cc2XyG2_PcGmxnLww7SQSm8V0-HWg>
    <xme:erwyZ7zJRPbDloFC1lOAUvsP9QoXSTBpjsOwsLFAnO7P8XO1oAB7-UAcd-zSco6G-
    CE9Gbrk-h4gHC_mkA>
X-ME-Received: <xmr:erwyZz0lOaFkznIIBAYWNZP6nOBPojEecOGEVs2MJCdgyLy5p-FZ9fMx5gNQDZ5CTLVQe1WHZlg_xBbYDdiVNvmNfQ4vx3l4H3DRLz2acf-5GceUjE3f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrghlvg
    hshhdqrghnrghkkhhurhdrphhurhgrhihilhessghrohgruggtohhmrdgtohhmpdhrtghp
    thhtohepmhhitghhrggvlhdrtghhrghnsegsrhhorggutghomhdrtghomhdprhgtphhtth
    hopehprghvrghnrdgthhgvsggsihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:erwyZyAV6XsuYMjx3qxZ0ailR9zDY0nu-4l-Be5Gd1yfXhvH_VQIBQ>
    <xmx:erwyZ_iC_KCukGdhwfBgsB41N0_s1C9xYyFDJoi-oivu2YtcRCFNhA>
    <xmx:erwyZ-ovtbb9IbUEPX0QZyfGPTfGcO9Aky8gqdAR7K4qlikuDyVttw>
    <xmx:erwyZyg0hx6LYKUNViqdWZ4ikeKYc4BW9Wpw7D-l1FlISAbvwnEueA>
    <xmx:erwyZ4aOiBeGCsnBxOc5pgvZLnUqnKwmBIUzx1yF9xz7kQUJMOF-xcNh>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 21:24:57 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: pabeni@redhat.com,
	kalesh-anakkur.purayil@broadcom.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	martin.lau@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net v2 1/2] bnxt_en: ethtool: Supply ntuple rss context action
Date: Mon, 11 Nov 2024 19:23:30 -0700
Message-ID: <fad94e00f0db1c0d03824b51bc4e7db547f1c4e8.1731377399.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1731377399.git.dxu@dxuuu.xyz>
References: <cover.1731377399.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2f4f9fe5bf5f ("bnxt_en: Support adding ntuple rules on RSS
contexts") added support for redirecting to an RSS context as an ntuple
rule action. However, it forgot to update the ETHTOOL_GRXCLSRULE
codepath. This caused `ethtool -n` to always report the action as
"Action: Direct to queue 0" which is wrong.

Fix by teaching bnxt driver to report the RSS context when applicable.

Fixes: 2f4f9fe5bf5f ("bnxt_en: Support adding ntuple rules on RSS contexts")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index cfd2c65b1c90..a218802befa8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1187,10 +1187,14 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		}
 	}
 
-	if (fltr->base.flags & BNXT_ACT_DROP)
+	if (fltr->base.flags & BNXT_ACT_DROP) {
 		fs->ring_cookie = RX_CLS_FLOW_DISC;
-	else
+	} else if (fltr->base.flags & BNXT_ACT_RSS_CTX) {
+		fs->flow_type |= FLOW_RSS;
+		cmd->rss_context = fltr->base.fw_vnic_id;
+	} else {
 		fs->ring_cookie = fltr->base.rxq;
+	}
 	rc = 0;
 
 fltr_err:
-- 
2.46.0


