Return-Path: <netdev+bounces-256931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGh2OOkEhGmHwwMAu9opvQ
	(envelope-from <netdev+bounces-256931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:48:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE8EE1A7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C87123011C59
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308A279324;
	Thu,  5 Feb 2026 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKsBstF/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1671CDFD5
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259655; cv=none; b=GC3P8V7UXiRzFMUpnOImBYaxcrMynm3J9nXYmemb9pzF4wdirjwd4dlMlqfVVvl0CMDr8eA496AnUX6acH23wd9DmlWyfVawcEW01BQtzZXqHlCM1p47m0jX1jggXeqBGt1dnoiq1H5sbh1mKbZrlKMJXROOQ7EoLUbqdzZ2e1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259655; c=relaxed/simple;
	bh=LM4w3ayI+D3t0rJOATqyc1N6jV2xUEBJsXzJpchcBWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5vM4VGyaLHjw3hbeCtAaLwsJYCF1verovB2vOEbdzzVz8myUBanhnHFNdlM/gilMJJlb5HURQuPVH/yp9T+hFJI2+SY+0m6uuS1/E/eqafMicysmwO9g6fDTvOjqpg+Ne586KUPAY/Syhnh6m/gQp9pQqraVvuEgheR6q+hSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKsBstF/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8946a794e4fso5412746d6.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 18:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770259654; x=1770864454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jkp+zpklLnwgbsWysYnnsbXefJfZs3Z+JpdRtUJO3sk=;
        b=hKsBstF/L8BXDDz7BXf5XGoxAdWlfYDHFefekPj+avmMF9Qt/rTjbw1fU4jDXNESrm
         4H3YsMVQBLrlDiwORpkyGyL4s8lsr6ff6Su0330f4RXpjtsDzlqHf+PhB8Npc8+Ui+zd
         2N9wbWwuLZb9hdeq79uIpbCmvLJiPo6SJfKNlfyZ+1bUPTBo34D2Igjc7IU9McUSHSH9
         PJ2iopPgaEhRazL7ieS4Ia8KZ905NPZrLuSpUBzDag1VSQ9jstl3bN3EGbNTH9B8MLmL
         CD1HOa/yzvxBUQqZHlH4k9x0vx/6arIPTWNkGtmnqKw878Wc9pee46cT3EI3c5d4759w
         XiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259654; x=1770864454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jkp+zpklLnwgbsWysYnnsbXefJfZs3Z+JpdRtUJO3sk=;
        b=wUsgVh8qELoNE86pyA7Zg9ubqiR+IxvgHtzKlmuObBGlVpWmWKQRWOcW8fEv64e8Ou
         n03jco1NNDEKJvUEZmhUe9FN7aYrYVmGESAsrImlo07hPNfPn8HeQUK6R8v146sZ+JCY
         lbsfRd61dv+2w1MQzPMPl6JiA9ehQblzMG8CdGfPvU2bQ0edyfLfajdO2Wj09y1yXQF5
         icOYBZ1WFZPaeTuU/4f2suNzLsqtozOOJf67hIfeN+pPKbLUwDzFUUbczjYzYOtrPXmP
         5woyN5bMSzXOzYJhBi2yn3YbfcLoag3QDFG6OaA/JmAcF+bsxNRpp1cMo7eouleMAlmV
         hJ4Q==
X-Gm-Message-State: AOJu0Ywfg1Ol85nPA9gIKREpTH6hUY8roo7HUcEhdHX7CXOT9C4YMk2p
	kgd9MlKnO+8uHTCZSFFzGJfoGSLFSBqWGPBzQ+BHNn5DBtWZMVO9PFhN
X-Gm-Gg: AZuq6aIa7yGLpS05E9DUosaBWp9fFIZ/QZEOtFa2jocf/KqUXQemLQ2q2tzzlF2j+Oa
	UCsDqVUIuCNramlnChP69iUhdpeY+kPEpBrfp1jfB8LhkEDEboSnvwm+dO+/eQtc+sK0RERYOSM
	FnZ7qTYWUUHMLYvmSIZMbfvLks2K05LEQ+GxaeWNS3TSCMfvvRO5FMsyWlgYL5Xh9olwYXJTpnJ
	yMdbpaWIU26GndakR+hIAOWNs3FP9OJHmIWQlgUgO/IUA04rTfwNx19jbZftfKCW8DpvIL229Pq
	thin7c5sXqvcJfQn5SMm1zJ66C3pXS/SG8W5KWgsY+SzgnI8H8XuNRqhoLk0Ixt8fFJggMBrsqZ
	6a0/gIpuj4vQj/L0es516p4tEEJ+u2be7jVkmSSs21fo91oV975WuMIYKkTx+gcxYapbjBS3BM7
	EuPRnPARLAe9siYV7Fl0E2
X-Received: by 2002:ad4:596f:0:b0:894:70f6:1694 with SMTP id 6a1803df08f44-895220fe1d7mr68191666d6.11.1770259654001;
        Wed, 04 Feb 2026 18:47:34 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2b5e3sm308193085a.25.2026.02.04.18.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:47:33 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 05 Feb 2026 10:47:03 +0800
Subject: [PATCH net 2/2] net: cpsw_new: Fix potential unregister of netdev
 that has not been registered yet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
In-Reply-To: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
To: netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
 Murali Karicheri <m-karicheri2@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, 
 stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256931-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com,nvidia.com,gmail.com,6wind.com,linaro.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47CE8EE1A7
X-Rspamd-Action: no action

If an error occurs during register_netdev() for the first MAC in
cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
cpsw->slaves[1].ndev would remain unchanged. This could later cause
cpsw_unregister_ports() to attempt unregistering the second MAC.
To address this, add a check for ndev->reg_state before calling
unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
to NULL becomes unnecessary and can be removed accordingly.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/ti/cpsw_new.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index b9fc31eb06134dae33427eaba06341c39eb4b41c..7f42f58a4b031fab4c93680c153383e8eeb8f7f8 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1472,7 +1472,7 @@ static void cpsw_unregister_ports(struct cpsw_common *cpsw)
 
 	for (i = 0; i < cpsw->data.slaves; i++) {
 		ndev = cpsw->slaves[i].ndev;
-		if (!ndev)
+		if (!ndev || ndev->reg_state != NETREG_REGISTERED)
 			continue;
 
 		priv = netdev_priv(ndev);
@@ -1494,7 +1494,6 @@ static int cpsw_register_ports(struct cpsw_common *cpsw)
 		if (ret) {
 			dev_err(cpsw->dev,
 				"cpsw: err registering net device%d\n", i);
-			cpsw->slaves[i].ndev = NULL;
 			break;
 		}
 	}

-- 
2.52.0


