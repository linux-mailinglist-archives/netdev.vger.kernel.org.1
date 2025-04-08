Return-Path: <netdev+bounces-180224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AABA80A2F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DE01BA52A6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21C627C86D;
	Tue,  8 Apr 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4VLi7P6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04527C847;
	Tue,  8 Apr 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116531; cv=none; b=M/PZKop20RdybbKOzHuBrd6vEXz8XdPjBGH62vDGtOPfKBgqW/Hr0/88vfJjfiMrem8aHlZCUJHlHZcs7nK4XrCRmK8/BpYhup/RU2jHG0uFtAfDDgD1ROAhpUBE0mB6asqfGY3PWNLbuVdRiVqjcT43LRsLXa+hmXK83gurCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116531; c=relaxed/simple;
	bh=ukAD1uy0xnhxTzbVwWD8YNjayEsfFmhyB7zCf98vyVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmU1ddj9WJROyrFtZNgsXkJ0/bFw0rNIwaBELp29XtbAPBVdqqPLlQiIGQQd2U5cqmSGFueKwGp1/C+BrNWk4tdCWmFfKbRzxXPx4PewIWAnOdxEuC7vszxZl/LvzkcN/oHG73bOTxAgh3sSxC1Zjs9ZUy6cS82N1lbwTxHkg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4VLi7P6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744116530; x=1775652530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ukAD1uy0xnhxTzbVwWD8YNjayEsfFmhyB7zCf98vyVk=;
  b=T4VLi7P6737VtrnTIusfT+91bbu4/m/hjbFAihuu11+y73RBPhY9uIvX
   lLk7WA+e5NuAAdpiwnGM5ozAF7P7nyqXo+dGGw8V90TMSIlDlCWzTR3lV
   Z+gZDqBTbMPa7v3HLd5zxOgypfPDHQ7N3xjBAOncmCqX6h98amPRYovG8
   5lFpPPx/4SYyQwgHbptWw93yeZ7Zd/iRZz1p6h2eskm7Te/rJ2lE1PnUt
   p1fxbKKpwzFonnFL6qITUE0bkYalTzBN2PpGp/4eVP21SRMwRl1FOtQly
   2a51G4QGvQjSUFu5rvZoZ/nArwEifWLeZvpXExY6MKh1C2o4kw7X88M2h
   w==;
X-CSE-ConnectionGUID: yCMpH3tfTGeGTq/fzv1h/A==
X-CSE-MsgGUID: WgLLRIxsTQCvl+IYun31Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56184937"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="56184937"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 05:48:49 -0700
X-CSE-ConnectionGUID: lNE5dLD8Sb2vckzczEXcLA==
X-CSE-MsgGUID: 0VmiTTDqRwCgeV2quaLVww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133130744"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Apr 2025 05:48:43 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9BFB534314;
	Tue,  8 Apr 2025 13:48:40 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wenjun Wu <wenjun1.wu@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-next 10/14] idpf: print a debug message and bail in case of non-event ctlq message
Date: Tue,  8 Apr 2025 14:47:56 +0200
Message-ID: <20250408124816.11584-11-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250408124816.11584-1-larysa.zaremba@intel.com>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike previous internal idpf ctlq implementation, idpf calls the default
message handler for all received messages that do not have a matching xn
transaction, not only for VIRTCHNL2_OP_EVENT. This leads to many error
messages printing garbage, because the parsing expected a valid event
message, but got e.g. a delayed response for a timed-out transaction.

The information about timed-out transactions and otherwise unhandleable
messages can still be valuable for developers, so print the information
with dynamic debug and exit the function, so the following functions can
parse valid events in peace.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 6ff7d5ba3844..d3b4612c3205 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -84,6 +84,13 @@ void idpf_recv_event_msg(struct libeth_ctlq_ctx *ctx,
 	u32 event;
 
 	adapter = container_of(ctx, struct idpf_adapter, ctlq_ctx);
+	if (ctlq_msg->chnl_opcode != VIRTCHNL2_OP_EVENT) {
+		dev_dbg(&adapter->pdev->dev,
+			"Unhandled message with opcode %u from CP\n",
+			ctlq_msg->chnl_opcode);
+		goto free_rx_buf;
+	}
+
 	if (payload_size < sizeof(*v2e)) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
 				    ctlq_msg->chnl_opcode,
-- 
2.47.0


