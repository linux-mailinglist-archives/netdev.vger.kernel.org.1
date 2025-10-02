Return-Path: <netdev+bounces-227526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03FBB21E4
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 02:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9965F17953E
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 00:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4EB175A5;
	Thu,  2 Oct 2025 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCdhGS+X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0118EB0;
	Thu,  2 Oct 2025 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364233; cv=none; b=ihrX4n6c+Tssm0z7WT76qXLzX59d6M/4Yr8oPy3rqzHKpup17YtoB4Gyr6C4cEYPEnvrwx206oVfmabTHlYIVTWsfOtYDVQ/KR1Dkc+COF46rMlrvrPBO/2O/gGHhW+A2Wj3XxRiBVBW6grFlvfQuEMlWyqx9gr+NEuFQjybkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364233; c=relaxed/simple;
	bh=q67n5Zwaho4Z7A/Cl/8uxnRlyaF6Utj/bLkk5El6bIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0dUmZYUFubrfOnJcxHMzsDZagwIhKluo3M0Sr3WaU8knjgAVb3vVBWTO9WSmYecH6Fu/SggGjSNHT3Gy/JBTrgiCiaJMJ1oI9BOkK5bSkRo7vRI6BVH92YVsJBWOuk9stYvNHoh2p5Sjld3oCvp5Pl9mv1HXGFyRQ35p53uALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCdhGS+X; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759364232; x=1790900232;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=q67n5Zwaho4Z7A/Cl/8uxnRlyaF6Utj/bLkk5El6bIw=;
  b=lCdhGS+X52iIQDdNbhpdsikBcvu7Bi7eO53lYeyauyzSj5Fk9Q2Fh3ZQ
   VGvpitNAorwXVk9wmdiPyeGG71I1iPk0B59VedxQ1aPMBpd1BpR/rmngX
   cr5xgJ+w0ZnxuBz3RvVT1DtS7RkUrCHAwZloTvQ+4yqUDUYn9TsVbbOse
   X34E3myPaxbPvLjcZqzXi+vwCa2lJv+30Q1STgQ/J8hMgfbREGG/0xoSq
   l17mvwmg8PCbcRQPGAo4d5povcCkWPfrAuasmgk+xHJKKWFGE/3015MLW
   cStCheZQi48qnj54vhqh8x5FoPGoMY2Q29/FlbfbdkS1paWIHRlftagbH
   g==;
X-CSE-ConnectionGUID: dgiZDwGTSYyQh45C3OP2Gg==
X-CSE-MsgGUID: fHFTV+dMQAONOJfRJVrcFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61561597"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="61561597"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:10 -0700
X-CSE-ConnectionGUID: xAY0m7TGSRmh0kBHdNxZQw==
X-CSE-MsgGUID: 7hP7sq0MTN68IkmhPFx6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="184105714"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 01 Oct 2025 17:14:11 -0700
Subject: [PATCH net 1/8] idpf: cleanup remaining SKBs in PTP flows
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-jk-iwl-net-2025-10-01-v1-1-49fa99e86600@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
In-Reply-To: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=QiBjP7wgTvVDf3z8UCLMkSpJlxAjS1K1e6zODg8PUkQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy7R5pbl1VseukrvSxo4vKr6f95zh246SV452Q7Z8Pzj
 /8PHD3F2FHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBEFhcw/NMqbbizMPJvQLXK
 Ct/FZ694+C+Jyl7tupHLyeSEPAdDxm9GhgnnWfZLVBncm/e6oiB8gZq4t2jxSmlZ9Zi/Xpt/al1
 /yw8A
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Milena Olech <milena.olech@intel.com>

When the driver requests Tx timestamp value, one of the first steps is
to clone SKB using skb_get. It increases the reference counter for that
SKB to prevent unexpected freeing by another component.
However, there may be a case where the index is requested, SKB is
assigned and never consumed by PTP flows - for example due to reset during
running PTP apps.

Add a check in release timestamping function to verify if the SKB
assigned to Tx timestamp latch was freed, and release remaining SKBs.

Fixes: 4901e83a94ef ("idpf: add Tx timestamp capabilities negotiation")
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c          | 3 +++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index ee21f2ff0cad..63a41e688733 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -855,6 +855,9 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 	head = &vport->tx_tstamp_caps->latches_in_use;
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
 		list_del(&ptp_tx_tstamp->list_member);
+		if (ptp_tx_tstamp->skb)
+			consume_skb(ptp_tx_tstamp->skb);
+
 		kfree(ptp_tx_tstamp);
 	}
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 4f1fb0cefe51..688a6f4e0acc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -517,6 +517,7 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
 	shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 	skb_tstamp_tx(ptp_tx_tstamp->skb, &shhwtstamps);
 	consume_skb(ptp_tx_tstamp->skb);
+	ptp_tx_tstamp->skb = NULL;
 
 	list_add(&ptp_tx_tstamp->list_member,
 		 &tx_tstamp_caps->latches_free);

-- 
2.51.0.rc1.197.g6d975e95c9d7


