Return-Path: <netdev+bounces-227528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC98BB21F3
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 02:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2620619C2067
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 00:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C11386B4;
	Thu,  2 Oct 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcyfPdvk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB22BAF7;
	Thu,  2 Oct 2025 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364235; cv=none; b=jytd1v8r3IPlqa1UDQtIISdKoJK9JuBQ/a/qw8xQxUkxj/YJi2qmT8fokH6rYhSTt1Y6XwUw6J3IMjags4fRruAvK2JLarhnvNUcfMuq9LNyGFmNFtwqDo5twVlDhmOSJqCHncjLLSD37Hyd1rN6a6ZjTfFL1rhA+M3Ve6kUe/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364235; c=relaxed/simple;
	bh=mrk+bmwi7LPgJPE0ULLvHy99M74CsCQxlnqThYujMhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjc+e/wAtnnr8bdOEC88jF6NQxtTXfgZGrFWPCUZng5Fryzdqmwiq7x1i27G8ZzS5H8/7auR0Lu8SagIssn1NNMcf6XeK0/FTXMCaV47evMVULlKybZ//kFUR7zQ9G9E/m/rIPZMjRUQ9y5DO555WQ0U36P1lr7INssNxcDB/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcyfPdvk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759364234; x=1790900234;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mrk+bmwi7LPgJPE0ULLvHy99M74CsCQxlnqThYujMhA=;
  b=dcyfPdvkYOPeV8sOscDTtI1EvyqtNyyF8Mx1JA25Vg56x8TFmRtP3iab
   zaglVaLqYsW4vYyPr7gT+eFXidu7yT64vb1Z7O8v3nRv5yXFHZZXqTO+W
   CbdBDFArJl8c+lZ3WefsqyC6kcN/6fdXRWdPiHlgo3ZkUGUdyVKwGc6tg
   6Nizpvq4WuxNs8/OJhgF88rB3PyDSxstQAarjJ3VChFYQu+zG7Jrxwm8u
   weFshvC9CpDzB1j81KY0xLSilKOY0IoxTLGwyv98F9vXig7Tu9Yz/9ed2
   zJjuS0NS4Q1KEjS0dff54lIXd52ExwXrAjy14/8rf+ks59QZrljpGUiWG
   w==;
X-CSE-ConnectionGUID: KA6ZEjf8R8e5KSEUfSlE7g==
X-CSE-MsgGUID: C/KyNU99TkGKBMtrzgdolg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61561613"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="61561613"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:11 -0700
X-CSE-ConnectionGUID: f6N93n9lRhGqA1eWla6Q+w==
X-CSE-MsgGUID: p4dpVkOISdyLjVmExRS/ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="184105720"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:17:09 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 01 Oct 2025 17:14:13 -0700
Subject: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
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
 Joshua Hay <joshua.a.hay@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Chittim Madhu <madhu.chittim@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=28VraJ6P+LEhvNo0GXQfdA6iTBGNYSFzyEqMdf/z9Gk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy7R5qPxTM4nD3LN83RQX1D/MsXdx95/Ym0EnnTq7aqb
 eXh3xl6HaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzkkjgjw3P7gpVca5dd/pXx
 46L8fdUTEw72Nh7wPRJnHvXL/ssfE1eGv3I5F05lLbr/IN6Ib5bD1a8Ot3IElYueHrpUzpqTl6z
 fyAwA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Emil Tantilov <emil.s.tantilov@intel.com>

Make sure to clear the IDPF_VPORT_UP bit on entry. The idpf_vport_stop()
function is void and once called, the vport teardown is guaranteed to
happen. Previously the bit was cleared at the end of the function, which
opened it up to possible races with all instances in the driver where
operations were conditional on this bit being set. For example, on rmmod
callbacks in the middle of idpf_vport_stop() end up attempting to remove
MAC address filter already removed by the function:
idpf 0000:83:00.0: Received invalid MAC filter payload (op 536) (len 0)

Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 89d30c395533..01ab42fa23f9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -888,7 +888,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
-	if (!test_bit(IDPF_VPORT_UP, np->state))
+	if (!test_and_clear_bit(IDPF_VPORT_UP, np->state))
 		return;
 
 	netif_carrier_off(vport->netdev);
@@ -911,7 +911,6 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	idpf_vport_intr_deinit(vport);
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
-	clear_bit(IDPF_VPORT_UP, np->state);
 }
 
 /**

-- 
2.51.0.rc1.197.g6d975e95c9d7


