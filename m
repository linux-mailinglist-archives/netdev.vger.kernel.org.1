Return-Path: <netdev+bounces-267492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFI3B+0ntGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:06:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B802858BF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8486231C2D7C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447BA3B19D9;
	Fri, 13 Mar 2026 14:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A23B0AF7
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413484; cv=none; b=AY5/0p4QC89BWnNSnr9Cf4Tea0J1xxQ28NIsVYrXuJEC7gjukPBzRr0bCwKr7Dtf5+vRe3ijDU/Fh8FypJO4mcWFjQW4X5tkMy6bVTnskvqT5vYeCmtddl51vj/Y5O6Kp48EneVT6kmk+i1ul/bDXkpHjOaWcNfWZVJSENzHNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413484; c=relaxed/simple;
	bh=tpq4CPEg4PF7xY4vX/qaHiEsjc2ICDqk3bHyi4H6/ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGL8rZT7IOTfUdbKruAZSy0vkujBnA2Z6uoDn4JMLSMLrfxVqzwAZrnKlAAcmgUIWs52C2/0aYmlc/o3lMAsnBxnu7eRJbrLUnuoKo1a1ZGp0OWAgtdY+mTWSHR3ZJKM72cotH5O6FLdQFNiUEfU089cWFww+/GXKQkYsPcBBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1271195d2a7so571310c88.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413482; x=1774018282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZI1/cLnyDnVOs4qvF1/y00bhWF98dmH7Q3P7jVrTCz8=;
        b=g/vWDQ4MNeG1LFFXiX0lU0Zc4/Pk9csdYFWVR21lbZUfwiAzmrc8NQVcBS//dZbnkV
         NAEHpLL2TWdm0XnNMx6Nzzyo89iPE163COswH5oZonJZz0Ni1gDmhDGZAPbageON1zCu
         6/UwnRMtF9+DZfvNrjVNMkOAhczjO4fsEw0XaJViBmWR80ZqZVRETkFG+8enpMWvsRxT
         sOsi4HgfeMyMFdcQC9X1VF7zRh9A4PImxY3DdXaYCIwjZNhnVhh5A28J3P6I35/r/ju0
         RRAXUCxD+AbHstusDlyXWyKAzGIypQZuXCdQjIIXi9ysEFT+I/GIU+bwBNKB1fkFa1Ci
         MRLA==
X-Gm-Message-State: AOJu0Yz0ts0PE1xWKqRJxd9ukkd2gg3jy4sTwwwhfkUC8TwtYsXri+4+
	9qh/lvLN1RbVPPeObk84QbmSk64ktdoMJODaEprCNul9qv8JkkxCRWi6zDoH
X-Gm-Gg: ATEYQzztpTYwwGti8fLxSAEUgDSxy6HO3tFBOgr8tKBYzE+N7La6r6jRcZYgvWkmKnm
	uYZ+40s68Ac/1pvdXKvhDlnx8ITqqOHVuwCsaBwC0hR1YjB+6tNWIlDqRvdDHiNjbAr7hzObwG9
	Quu8wsuEqwFe9G4mTsd71hUCVtnzUQzK64gnspE10vTYyoagfUf2d52l0k6lEfTANZDFxjnrlIr
	Rif9qonJgChfxxaGN0G5CflRJx/Hghuzw1ysg2EdIwq9lalqfocP9YndDsEkjNXJMRU7YBeFeIv
	gBAikNSJZV9cabkp2SP/ezNnPECTHIcqWQIYocVY6p0N26375nsk1PAObM4sTV+jSBOLChVjIVI
	g+Ro9NJEGWE/b97UqAqpSQjlqCniE51GrOPv2Z8Bgx4x6G9NAn/9MtiQio/fENubb2TmSZVVJEo
	8ejuX7ljzHpFuN7JqolmuPnAyKpHa5RvcHoNMEq68RaP+M+We4xH8CdJu81HlMAKm0QZ4XsxeKc
	X18H0EKTGgtArVs9Q==
X-Received: by 2002:a05:7022:4397:b0:128:d34a:320f with SMTP id a92af1059eb24-128f3d3be43mr1677962c88.12.1773413482159;
        Fri, 13 Mar 2026 07:51:22 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm2761133c88.3.2026.03.13.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:21 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 07/11] iavf: convert to ndo_set_rx_mode_async
Date: Fri, 13 Mar 2026 07:51:09 -0700
Message-ID: <20260313145113.1424442-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267492-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D5B802858BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert iavf from ndo_set_rx_mode to ndo_set_rx_mode_async.
iavf_set_rx_mode now takes explicit uc/mc list parameters and
uses __hw_addr_sync_dev on the snapshots instead of __dev_uc_sync
and __dev_mc_sync.

The iavf_configure internal caller passes the real lists directly.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7925ee152c76..6632d35ad0fe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1147,14 +1147,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
 /**
  * iavf_set_rx_mode - NDO callback to set the netdev filters
  * @netdev: network interface device structure
+ * @uc: snapshot of uc address list
+ * @mc: snapshot of mc address list
  **/
-static void iavf_set_rx_mode(struct net_device *netdev)
+static void iavf_set_rx_mode(struct net_device *netdev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
-	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
-	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(uc, netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(mc, netdev, iavf_addr_sync, iavf_addr_unsync);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
@@ -1207,7 +1211,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	iavf_set_rx_mode(netdev);
+	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
@@ -5150,7 +5154,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_open		= iavf_open,
 	.ndo_stop		= iavf_close,
 	.ndo_start_xmit		= iavf_xmit_frame,
-	.ndo_set_rx_mode	= iavf_set_rx_mode,
+	.ndo_set_rx_mode_async	= iavf_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= iavf_set_mac,
 	.ndo_change_mtu		= iavf_change_mtu,
-- 
2.53.0


