Return-Path: <netdev+bounces-267186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H87A3wUs2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:31:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C7F277FBB
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C8632B727C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA537C933;
	Thu, 12 Mar 2026 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eSaHjqQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423A32D441
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343155; cv=none; b=I8Q7cMe6Glrvxto3e2Jy2TRIJlE8CaAKIq4ZrUOLk3vnzHlu98T0fBak2oybcnoGRztUhoW8PoPPRG3MLgN8XXaAAzSnLw+sLZ+CF6t3Vk6uvhD5q2DvcqsXyEVtW638sForlYMV1PJXZN6Ees/yteQjuxxzl9J8EsDB0g6p0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343155; c=relaxed/simple;
	bh=2xfM7jnhDY9KAwp/GaPrzlkh8TdqszEvTWgmspjt1h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fhjddMMnjE7Y/k3pKIZBAlonTHFvcLHduBAhYY2XKPJI2tguik4IuworOh7slGm98KMRZ1rPms+22AliybKkcnLJN8yQWqT+e3aDpX58aSCiYSsuv+sqx7cuM7FsnHb79G/dk2BT3/cqKLjHQlf8vj61LOUT9tAjo17NDDhz5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eSaHjqQ9; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ae4d919f9bso9489825ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773343153; x=1773947953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uNxdikJ8tWonFr0cU2+MqW311h46aK8dNu84Z/yYXo=;
        b=aQv7E73rKQjOSKfNe2czReeEZVm++7iW73P4xwn8l+OLnAm54zUIt6EgcYjFx+s3In
         tHUU/PLLQtowDEUsIZmOt+nR+0hMVQdtobaBhz+iXypkG+8VrXWMZN6z38g8DIxVwH2h
         TkAx2MHeNJCgTBS2GnmkcmgcM8ruY1t7YiPTnlHb8wiQJBvP86Rj1r9n6QPdMOoJJm8m
         tnhmh5yLYP7yacsz5TbdFYI7z5EhkVu24y48eM644/6izNDn+uc0rQFqiSc3esZ7fCQc
         PpRu9oBLlhXjmqSeW1cs57FtZWz39hC0CFgME/wPewOpsaKt1Si+Eaa4HCm0ltsmXmio
         Y/fw==
X-Gm-Message-State: AOJu0YyV5QO11zdfMkkz2FlWkzWYUQmZubeaNvZ9zzF0XkTgVbMhffk4
	KHy24povNrQlOX3RvDPPMeona6ILf/zbI+l55YdJT8Yr+S/jiiygPzDufjFduoQFH8neDaSfjH6
	2jE3V9Qlt3BJYsriIjEi4cXCo4LYtpFfWvDh9utr3+8F8enebHfLMQfyYsHdXiAyF0yGX3AunIf
	0cl9/obJXU2RMLsOFYpya2lNHI9vrR8eudzQJdKg+7FETlCsJgtgDYkisPorWSTMI4o5M7aMefg
	KTwsJFWEA==
X-Gm-Gg: ATEYQzy62QjrBwqmv3ZIreGue5E17fSX7ctfma2PqXEQZRvSM8aTZs+5CjUc+eqofPG
	wfZIM7RxgT8342jVaNU2NaY/aBbaFGrH0NbvAbIOmmLYAdHaz6rcwcVTTyyltInh7Pw0fF7ypGB
	YBol3d1YRYIo9zc8idVfB4BUwhup+333gE2Ud69+a1Ens0aSOfLYxjKTBTJ1gFVMpsZ5peS+7bG
	nV4kyeMZMEn01TK446TNqoAFupsUzATRYkUTt6+VkvgoTGumjCCYGuY0umDtFokZ7QaydutPjxf
	IJK9u5RgOlhVOtOGj5eokj1MrEaeg9t4tc8mdCunwy/murTiYzOxYwn+EVWxlNcHwHbe2guWIn8
	e6XRaCOgwG93pswkcT3O/bktgAqlAQtBFjbg9pnjjBdjsVPvdzFwplmOl61qWQaGLTzVpCl2OcK
	sRZCX04YKy87c8kAfKk3fTQyrLb3DAmfGtiSTMOxssiTjGcCcjwDmtEj06yw==
X-Received: by 2002:a17:902:dac8:b0:2ae:4dce:7e99 with SMTP id d9443c01a7336-2aeca9a41bdmr5105975ad.20.1773343153139;
        Thu, 12 Mar 2026 12:19:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2aeae312823sm7933835ad.33.2026.03.12.12.19.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 12:19:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-128d0b690feso21975459c88.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773343151; x=1773947951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uNxdikJ8tWonFr0cU2+MqW311h46aK8dNu84Z/yYXo=;
        b=eSaHjqQ9nVZoxUu7HR6YCTxf2Qu1msLCVCXLt53cTTbP7diY5VfK5YuG36lFbAx/WS
         tW6xyTaS5//JKoZmkBR3N5MuNgjhKAobeuS2YyN4+n7LNm1PCT58xr4/FPuuXO5zCFcT
         qJ7rIpJq1jmzbTxg/55yJPDqJCjhMWmWhjjdo=
X-Received: by 2002:a05:7022:6b8b:b0:128:d51a:5143 with SMTP id a92af1059eb24-128f3e125e9mr342863c88.31.1773343151128;
        Thu, 12 Mar 2026 12:19:11 -0700 (PDT)
X-Received: by 2002:a05:7022:6b8b:b0:128:d51a:5143 with SMTP id a92af1059eb24-128f3e125e9mr342843c88.31.1773343150503;
        Thu, 12 Mar 2026 12:19:10 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7cb558fsm9962551c88.10.2026.03.12.12.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:19:09 -0700 (PDT)
From: justin.chen@broadcom.com
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net] net: bcmgenet: increase WoL poll timeout
Date: Thu, 12 Mar 2026 12:18:52 -0700
Message-Id: <20260312191852.3904571-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-267186-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 83C7F277FBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

Some systems require more than 5ms to get into WoL mode. Increase the
timeout value to 50ms.

Fixes: c51de7f3976b ("net: bcmgenet: add Wake-on-LAN support code")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 8fb551288298..96d5d4f7f51f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -123,7 +123,7 @@ static int bcmgenet_poll_wol_status(struct bcmgenet_priv *priv)
 	while (!(bcmgenet_rbuf_readl(priv, RBUF_STATUS)
 		& RBUF_STATUS_WOL)) {
 		retries++;
-		if (retries > 5) {
+		if (retries > 50) {
 			netdev_crit(dev, "polling wol mode timeout\n");
 			return -ETIMEDOUT;
 		}
-- 
2.34.1


