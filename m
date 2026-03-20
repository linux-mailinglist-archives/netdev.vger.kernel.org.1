Return-Path: <netdev+bounces-269748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM9VK+mjvGkI1wIAu9opvQ
	(envelope-from <netdev+bounces-269748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:33:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70D2D4CD1
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F71931141F2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA995317145;
	Fri, 20 Mar 2026 01:25:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715330C621
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969920; cv=none; b=FbPqHUj9OtrH8fTXuF/Ulvo1p38mDlIQl6rIEt0CVdH9XQN5zyClvwpKvplUk8kgswAapJa7hiXe4cD88KSRdGWIGxEFcjHAbY6dTQiFlDYhoCPGJRdO0y0778954y5mZ3Jx2QEbvthQke6pAYuSyhgIXvBqUy4sXuST/J72u4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969920; c=relaxed/simple;
	bh=5NcsxaHVIQ2NmCj9OLQh+nSLlXz0JVUjSv0mBYVb1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcC7xkPubcYfRFnzqpCInGQoXsPy/YET1bO+XVWyrCBAfM9q9qH+ZQY/GBfZe0aeIU6qF3mGfdfbtI5efKdusmHAzXx9MzWQDpChGtiK3htFa0Uwwsa2ei+At2yLME8huavH/J01JGx3CtjrQTFhB2aVf5kxra46BD12cIng8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1786602eec.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969917; x=1774574717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
        b=bXSe4Zc6tf8M8wTV1ZLJzXP9/ePk1+mgfQMJQDnEQq0zcRcJlhp+0gRBQWoorwYOE0
         wXNn/c9KWmYylMswfXOsIpNBnxaGbf22sq3GOZXWvBCZJfLo0LclwVg/5UChmR1RRYc6
         ivpH/H6gg1j3QtfKGL875+91zcaW1M8rvXpfbwRavZKIwLxa188hxjYaH3sZfimc9pVZ
         SI+9dQ139XQOMMAsOpZxYV5EH38wE/IZnzU4j2gqQieJix8WgeTX36Q8ksnd4I9fA3pm
         a03/HT360sXZV+Y4UQg9XgfdAY55zjORQ0shn7StTpRAdBDM6LYmfTcZxekIyf8eElGG
         60Zw==
X-Gm-Message-State: AOJu0YwQ5o31lcJcis8k0QtbNIG4zWJvQjrtZYvSmWThzyA4/imdPWvJ
	2U64qNtTSmYjb51z3WaxhwwZ08t5Li4nwGb2yCBl6EODL9HZOaNt01FrqjHc
X-Gm-Gg: ATEYQzwg4nn4TK8qN0hswTsAiJmQ8dSV/Uu8goyyHehCZ8lalliwpYFhZq97CvSyLlx
	cE9L9B1TuCf3yZCvRGl8qdpgGcP0PZosaKuYh6iUB+CB+6JpQ+PYjc/jhYbCOwzYBGO2n+b7moJ
	x0en0W+VfqIJxq94vZ08LGHzKcoupauZlRKqjqoyJV/oQ2/sXGIvM6frawtJtprIkDynTAkDS+J
	hXH23oYu92JsXGd2+g/U4ojplmQoIYFT1zz7Rn4t6zKMFFX8oC+dRN484ADnIpqZzE+5W4bBJ/G
	YMizUNS/hHqaFwK5dyaW4D0CxtcenTAhbVNxMEHRyhTQpi5vVlNZvfUiQLOCZxX4YRuzFVuy+lT
	EwUsxzlVeUXZMjEkLZ4LrwJi6/saY6FtDKo/lg2qRipZ4JJLawccVY2fKpc86MVYlOmnwcL0DV6
	jRnV8Amxtl47vd2Xk7XKp25lGD4hDSC4y8Psq9sq1JeyXkMCgh6vmhxHcuYTByXtj25Q6xd8M8N
	JqHwTi4onR6nQK2vg==
X-Received: by 2002:a05:7300:6da5:b0:2c0:eec6:279e with SMTP id 5a478bee46e88-2c10974fb69mr728307eec.22.1773969916878;
        Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29c74bsm1146865eec.17.2026.03.19.18.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 11/13] dummy: convert to ndo_set_rx_mode_async
Date: Thu, 19 Mar 2026 18:24:59 -0700
Message-ID: <20260320012501.2033548-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269748-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.047];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A70D2D4CD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d6bdad4baadd..f8a4eb365c3d 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,7 +47,9 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_set_rx_mode_async	= set_multicast_list,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
-- 
2.53.0


