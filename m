Return-Path: <netdev+bounces-273816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGBNDnVzzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8ED37374F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A78530C753C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D172C21D8;
	Wed,  1 Apr 2026 01:19:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095522C0298
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006367; cv=none; b=ZHDgKzo2uF18yIO4NtKOp7aKj5SMNlzmsH2wQEaeasTyr6sek2BkjFGtrMco/XttqPwenXeIYIevPTiUsUGRFEM6NDMOZaCOs6vSJ6Q7dWkgfYR2wg5mLVO/sMF7JP8hpCqugMTaiYyOvG0AGfDbbNW7sJBpe6bHNmJmgTN6X+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006367; c=relaxed/simple;
	bh=7NfL0ac9n0yvxNRNjugIdGbRdSSQgjbJekS8L5PUrko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmrvRWn9CC9D+XGva90zKk+2MAW4x3bzzQKIyuU53+r5+kjJLIfZZ6auZBNNxAugXKIcc+HJu80GRqF1wbFqVizcsM5M1lC/uIiD/O7SmmXm1IquBdWxmQmxZRoXWU434jy+m2C5U56FLWR1R53GjwM6rhjm1WSWeTLPiLaJS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128ebee22caso934960c88.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006365; x=1775611165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AqZcCsa0DTeuxGn0ZQ/YQdhqykMobJw8M9QZCnqWwJo=;
        b=Ciu9W3MgXKStnc/InBQ9a8upzyvKkCq9NLAV+6MS1RPueS49nb3CwnxdEcaiLVb2k5
         TJexHcoFNJQpHENbMR5SB8sHKRPKc0qWTQqS9kNgKeBFPp2YzO0DK4MaM5ZPzlpmhRAq
         a4yPzdQd4KGWpCLqLU30Wi/cpKinLd4YmpM7oWWqx3g2sVoTL00XnDtkKWKJTgOlGoej
         2mYjtVwzY801NYtUc46DSAP5kA3FIoTK6cqPz+QhE0T+alYfPdu3oSqPc6otUI+slHNP
         sbLNRBc1s1XAqgoUAL+WxX3THnxIT5jzo/nmF+Ibp3EMkuJz0kiH6VSuDY/1bbswPCo2
         yL4g==
X-Gm-Message-State: AOJu0YxNNChDF4yu3P5zncF98Gubo6Me/KuzVkdHodC689vSWxwxB8GX
	grNIYAZ6wMiJE9/72AntPUEFFoue+24xO0xNwi8rzlGADCQe59lUojkV581w
X-Gm-Gg: ATEYQzwDxa7rA68w9MjPRWdLzkkjjEF25DTtYb4ECOYh6XMunrAknW2EC1cb/VxPQWl
	PvPs25rGiNJJLp4WzFPl+NrzdcbXEqCDm9iognMwz+5aajDbdOxIFk4K6ELKN6gZ0uT10ym77Fn
	cvAhnMqr8efh8AxQeYwf6n8VLRfy+PQeUbIh8uRrMYcGmmbS9jpBfPmjnilBIyt5fho7/Wr7a2Y
	viHOKO9wxsFPB4S/dQBYmTecwFah/jZGkyaFV0Q2/zL6PGL2tPgqP82cS58jjJYDuqdeifXWFLZ
	YK2fJr6esP1U/XJy2tWgk2qXpNG2FugdeY90BKUjymVMSXAXUSGKDblW7kV2ntv2fzEOaeJ/iDr
	Blmt4hHUIuW2qbh0qtxCyvSDpIZCykEPQdeY7W1Wytd3+EtrwnfuEAqZf5jAYMwNV/VAeoXW2sW
	ebu78sYDKmxHpStDIXBAdX1DvFIlqDQaLKRznjUWlAB83F2GRn8j/A4sAe2bp3cxLAX3orupA4s
	GyQ6kwn7BkBTwLlGKrWDvslfLQv
X-Received: by 2002:a05:7022:6991:b0:128:cf5c:5362 with SMTP id a92af1059eb24-12be649e62emr1195231c88.12.1775006365076;
        Tue, 31 Mar 2026 18:19:25 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm17789272c88.4.2026.03.31.18.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:24 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v4 09/14] iavf: convert to ndo_set_rx_mode_async
Date: Tue, 31 Mar 2026 18:19:09 -0700
Message-ID: <20260401011914.1716692-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401011914.1716692-1-sdf@fomichev.me>
References: <20260401011914.1716692-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273816-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB8ED37374F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert iavf from ndo_set_rx_mode to ndo_set_rx_mode_async.
iavf_set_rx_mode now takes explicit uc/mc list parameters and
uses __hw_addr_sync_dev on the snapshots instead of __dev_uc_sync
and __dev_mc_sync.

The iavf_configure internal caller passes the real lists directly.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001abc908..485acf402a47 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1150,14 +1150,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
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
@@ -1210,7 +1214,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	iavf_set_rx_mode(netdev);
+	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
@@ -5153,7 +5157,7 @@ static const struct net_device_ops iavf_netdev_ops = {
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


