Return-Path: <netdev+bounces-209654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C990DB102DD
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678003AD2AB
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C87A2701D0;
	Thu, 24 Jul 2025 08:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240212153F1
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344459; cv=none; b=Lz59V6DHYDHACR9mfa6wWbi6gabbg/7sYyeMoFmZwibq9zEO4zPmJ752dNQj83qDU+jG3AgtiDUwH2JV0P03O2puR1t4rQv5/nmUR9sUmKYYJp9JzQdar7swx4A7xQW/edMOR2SFS9mbqozIRhjQYhA7qpBd8AL16S4HuZysXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344459; c=relaxed/simple;
	bh=b85+MT0VpueYTU432vWsD0a1Uxz5qdu5A2QqTs4dTDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NCqdk9v5G2xlOVFq4zgsGGX6iCFgBPg4XsojbX0lKMoxxNnOtj8qKl+6rFhvqKbiNQUqLYM6fs/Kv+n6aJ1wFeyvONCR5zaRO2aJ4D7xJQQNHRmSlVkNcsYcvYliAQvdju8yfF0tKwLc++TTZ2v5bq9exOWqBj5YHQclXlI9IB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1753344383t48347be6
X-QQ-Originating-IP: uMWD3Ztj9IRJtnDrrKN8NY1xlg8S2ZSuZTHxcBwHMVg=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.23.165])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Jul 2025 16:06:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5323068037830587620
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 1/3] net: wangxun: change the default ITR setting
Date: Thu, 24 Jul 2025 16:05:46 +0800
Message-Id: <20250724080548.23912-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250724080548.23912-1-jiawenwu@trustnetic.com>
References: <20250724080548.23912-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OAOHw7tUGLQOPPB7THTqqAnE2ACL2p3XRfEZ8GpWog4E0EOmko+RjQd9
	DAypqOSStEEPVMmBJ3NCMinz80dwSDfTWz1wbzolPsuzPOHTwPBiJRHj4i6AIawyrjOLpeo
	NdHWgxFzIloS4AH1qHRYYbpIv4N6gHv0pMdGLwceeu5/e4XtNOYABaSNQL6rFUv8arXjHN4
	u4y1xOlzK1ALw6UOsfgy2jUXQx+myDA/KvHfmhVPXvR3UHWZlOiWlCp9mc0VKL9UaBbEKuP
	5gFl0qyvw9o3BJOegNLWKepfQLdLzV2gT4wo/UB/g+N+eK/9I6yV1U0dSucOTDxfX/k/jA5
	NWWfadqDyxC2OEQ0jlHjZftAFaVyaNeXQbBjReQTPOzcSDjd5JYmLk9yCcdVLsEEIoJ6wiW
	YAyXyTIA9sIcqeXWke+h0rwJoqwFbDvdaJxCNId14p30ZC6uryjNspPI0j65B+KmEAEmsl5
	o/Zd4ChZZZIIWQ0sUhYziAYxHrZBx5V0+YAb7d7Kg3sYS/YIFAd+Bs6QCT5fDp5xDFa0tEc
	Q2BK6lA4ScA8rOymEc98ibAb1lVfNOLMweHXKDiIHCcp7wv98UKA84bpvoSv8GtCPE1CisN
	KYC2Oh+K0OxxkpjLNaed7Cv55ffDqPVYdx6P7FuzWLQ2hscOXiE6KYHtTBmjir4L/Qi7the
	X5pCjt+7dWDBqE/YDYHDbINuMZLV/2WiJorZcqoao22VgdcLUeDQEp7rGUmw497F/D0F4TE
	NcqD+lhKbS45OrdaihEkcK+xZbKdyM7iLiY0VdMu7i/7/2RKJ5iH5AQYFKLQ7uW0Dv0+g7I
	MiGT5x+64Sze65VBQXMsvMm5oPBppXhXXgnk3/zDhLlosm57UmPMaMDqB95+9zwsmXnynrK
	Sn/ajn12lduD+u5jf7VRrX/SYFDD6Q1ny2kZBHa4dl3N1g90OG8y5MLLObDur2RftYHg/ou
	+pftppjK7xic+tU+JbRuWXidlnmeVCycXuSkO+0jqTz+eLZMLgaD3VF8oP9FznYGY/F0ucz
	tObeVviezHzkRC1dQRpozypRXNkjpSH/Q1bylNfg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Change the default RX/TX ITR for wx_mac_em devices from 20K to 7K, which
is an experience value from out-of-tree ngbe driver, to get higher
performance on various platforms.

And cleanup the code for the next patches.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 24 +++++++------------
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  5 ++--
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index c12a4cb951f6..85fb23b238d1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -340,13 +340,19 @@ int wx_set_coalesce(struct net_device *netdev,
 	switch (wx->mac.type) {
 	case wx_mac_sp:
 		max_eitr = WX_SP_MAX_EITR;
+		rx_itr_param = WX_20K_ITR;
+		tx_itr_param = WX_12K_ITR;
 		break;
 	case wx_mac_aml:
 	case wx_mac_aml40:
 		max_eitr = WX_AML_MAX_EITR;
+		rx_itr_param = WX_20K_ITR;
+		tx_itr_param = WX_12K_ITR;
 		break;
 	default:
 		max_eitr = WX_EM_MAX_EITR;
+		rx_itr_param = WX_7K_ITR;
+		tx_itr_param = WX_7K_ITR;
 		break;
 	}
 
@@ -359,9 +365,7 @@ int wx_set_coalesce(struct net_device *netdev,
 	else
 		wx->rx_itr_setting = ec->rx_coalesce_usecs;
 
-	if (wx->rx_itr_setting == 1)
-		rx_itr_param = WX_20K_ITR;
-	else
+	if (wx->rx_itr_setting != 1)
 		rx_itr_param = wx->rx_itr_setting;
 
 	if (ec->tx_coalesce_usecs > 1)
@@ -369,20 +373,8 @@ int wx_set_coalesce(struct net_device *netdev,
 	else
 		wx->tx_itr_setting = ec->tx_coalesce_usecs;
 
-	if (wx->tx_itr_setting == 1) {
-		switch (wx->mac.type) {
-		case wx_mac_sp:
-		case wx_mac_aml:
-		case wx_mac_aml40:
-			tx_itr_param = WX_12K_ITR;
-			break;
-		default:
-			tx_itr_param = WX_20K_ITR;
-			break;
-		}
-	} else {
+	if (wx->tx_itr_setting != 1)
 		tx_itr_param = wx->tx_itr_setting;
-	}
 
 	/* mixed Rx/Tx */
 	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e0fc897b0a58..3fff73ae44af 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -119,9 +119,8 @@ static int ngbe_sw_init(struct wx *wx)
 						   num_online_cpus());
 	wx->rss_enabled = true;
 
-	/* enable itr by default in dynamic mode */
-	wx->rx_itr_setting = 1;
-	wx->tx_itr_setting = 1;
+	wx->rx_itr_setting = WX_7K_ITR;
+	wx->tx_itr_setting = WX_7K_ITR;
 
 	/* set default ring sizes */
 	wx->tx_ring_count = NGBE_DEFAULT_TXD;
-- 
2.48.1


