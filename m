Return-Path: <netdev+bounces-274732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MntK1H0zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:57:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9338EEAF
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D49993068331
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A93D6673;
	Thu,  2 Apr 2026 22:55:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE53D75A0
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170549; cv=none; b=MH63jdK5vKtlQPFp+yP0pe7HmdjpBkShbdnpAkPzLXIbPpfUEpDIJFgtJSWVtwwEYy/nG8iVAI2qlIXMnzr8e/lubfK4jLS4UxlNs4ZqjMjktXDuq/83/ZHMsZvtu2/8AwwIVms43Y/yX1HYNhPJpxUtnBOAojdRYW29iCoxBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170549; c=relaxed/simple;
	bh=7NfL0ac9n0yvxNRNjugIdGbRdSSQgjbJekS8L5PUrko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAu5nhKV+n1KBguTQs8W4FOFOWO2EmLz8mR1UZmU9cLySQM7Z4RG8P26hBLd3psQu02ebJWUvm1O6c6+6/JkNpsJJ44B6UMFjiYzaZWSYuRYN+22IRlWpyKZkrRVfmX4ZZx7q+k8bNn06y0YBeP/kg+OlY/5+n1ncyH4X6mWmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c56aa62931so3099387eec.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170546; x=1775775346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AqZcCsa0DTeuxGn0ZQ/YQdhqykMobJw8M9QZCnqWwJo=;
        b=lbThA3I0dTWgtx50kcF87geXnx9APuwT0BPMK43hohZ4wGLtlpD6CL0aMf6FmnVmi3
         LluYl55EeKM/KEb5UL08f/t8Ee9GzBZhzMwHZC3mFak3lT9Gpngr5VQn0vYlfz6DZDh2
         xFydkd0r1JoZ15zXJjxvr0r53rgqj5RoCcalq6zuXDTS9icuJHRM60yu7cttAbWg85R+
         FINCRsm6xj4lXvfoydLY0yHUiOq7rQ+lGWsptViuOcTGKpxbKE8+WIC6fvDiKP7oEl53
         19/VgRGfzh+rYsD2RpmGItya5vQNJ3qtA4NJbRiU0rjG/zo68Gk09ff+GivVIpwfdiEl
         7G2A==
X-Gm-Message-State: AOJu0YwEI//G9T8l21Hby7cBH1ZzNccig9VmeR+cMmA5olmhgJmKhfLf
	hutz3XtvYOdqPzdnhwCee/qW86DmilbrpD0LVF+nHmUy0az/WWxzIiKFyF86
X-Gm-Gg: AeBDietTpu7TaKx3WasxBa8f4PuS1GabB2BHWKD6Rg6J3qZ5mAJYUflN7sAJcJLOv5U
	sggxk7yP0IUqULdAmwHfrHRI989dNoTYNoUGN50eER3RhbfqEuxXzjPVuZ5ps73qTlh9ACPQ3dy
	fWveRY2gDAKrJLkeS5zZJxDeA0MGLLQEECBI3Ex2BnWVvZTCrn7A/Iz5SqVXV61bRXVxMS3F60h
	y9KwKL2SieJJHq6YMQqELK1yEBdIKozCxZdBv7vbH6JgpAamDsmKlnv27jpzGKfA4fYie5XafPE
	hIXrRIJZoyfE6N8k+BMZyLF5U/FlHUoVdyABAka7UNlNhVF6yX86VK2b8C0ExEber0ESWgWlyVn
	wsG8XkiBieMIikoOM2xqsCxpaR04lSNYiSJd9S174XJV/13n5jwzUCDF5aojLsAPDZjSQ9dWQ4p
	ADKU33SdFTmMks4M5uwrBZroSjl44Gt2WFPjneUD0HzvSm5NMBSnPTB//CY/1JxLLOpaFf+zS19
	Y26zHWXFwcA2cbqLw==
X-Received: by 2002:a05:7300:6d07:b0:2c0:d9e6:7eb0 with SMTP id 5a478bee46e88-2cbfba8eb08mr587090eec.16.1775170545982;
        Thu, 02 Apr 2026 15:55:45 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df5ed3sm3520034eec.6.2026.04.02.15.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:45 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v5 09/14] iavf: convert to ndo_set_rx_mode_async
Date: Thu,  2 Apr 2026 15:55:30 -0700
Message-ID: <20260402225535.4124525-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-1-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274732-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 2FB9338EEAF
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


