Return-Path: <netdev+bounces-255323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAv9NSJnfWknSAIAu9opvQ
	(envelope-from <netdev+bounces-255323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:21:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4153BC0438
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2875B301BCCF
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7532DB7AD;
	Sat, 31 Jan 2026 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaZlFqll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB246A33B
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825960; cv=none; b=KravxEa3t/OTWhYRM6QgIgal4+TIIRAnx/eEF4qc3thJP2fEj9AJRwUA0POaCbEuAAnSLsk5mKVT7YioZOfJyabUsj40Sc1J65QcC8VwdvCsnW/b+Y1Oia0tkQcwJGbHBjVtGTtJVWvpBBX9uzp3u5uOSpYkrnsHBpZ7g/gMQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825960; c=relaxed/simple;
	bh=DfgWrEGffh9/+P3GtbIsWglSO7Wu0dHRozZJpQB4z7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZwsvMrIeaGUKt8ypeYK8qaIGoQ2nNUOm3LE/+CdpQeTa6Noh283fsPLhn+YwP0KCj/6IV2aAZ1YxG/pO7cpGEqIUfaU7oyMJBbvaJKuUEEmJTL4tHF6xp9N7KKFwuWWeyf2XwYfTfKSodmQCGEBBgM0A4uYbJ/dxBSX1Bdb7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaZlFqll; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0c09bb78cso22461485ad.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769825958; x=1770430758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/I+oT8E/nunUvWBaGvhrVbfUpyTt006WYcjriTKPhY=;
        b=GaZlFqllJoTTlgmMhdPLg7G/3OIMq/tuR++QDZ9wZ0rq165Ti5/cp6FvfS5BJH33d5
         Ya+B+zQRjz1UKF3HS3koMfQh8oV9MAuLswB/6rxC8CdAXFdkQZN2l8vcisBVZSmmSPIF
         Zpbz+qO4gMiJjMfauixObjogBIgSlxe9r3DOpXdhaHzkWMN5TPIyCDGHtuY+uA12uxTD
         k84QApkw9L/uWiLzhpR1nIJepbFpUOTrrk1iQTuoGOpmO0d6K6t5iD1aLE0DlKKN8/UA
         Gh0k1En0ohbxBgP7FLGhQnxhgDQXikrp49EKLecsyCYxBJc5BGNnwl22T96wFDLEcql0
         aOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825958; x=1770430758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/I+oT8E/nunUvWBaGvhrVbfUpyTt006WYcjriTKPhY=;
        b=YqRpUzSebTCaVeWoZpWNqpDJuLZ5TrtKguhFdAAoOBwiFtOYpQ7rHuGpBStIqfXPrk
         x/bevp9gwC5G6VHunJoL9EJpN59sVAN+4uOrXBLNcrvq4anZR9SyPe3s9Xax9OkJ/Ktu
         CV2Ot8ist8xPlwNzXGGFvUPBuIBdLYXqpN/pDtw9N66eCyoXFf0qxuEgM7Mn8bAbTyUd
         IJThK47I6DxPNhHel2VW2o4kdRQP9OrCaUwe9EUj3JiSqRja5ydbmJZStZ9x8e8tOuqG
         wrqkCPODKQ8n7iTQ2Z7/uHlu/z15pVAs1LtjPZ3VBwINVe2G4Zj5yC3AMjAnQQmDOF99
         3I0w==
X-Gm-Message-State: AOJu0Yz1UWtEVw39+13+CxTKexclrUYUdP1TyA9yNLxahf+VCIvXdywS
	YFEeujIy9ZyYntvFkAPlIZz5rCvxpjwY/m0hXGOHqgHNLvwvR95PgPesWfwknQ==
X-Gm-Gg: AZuq6aIB2AxWJ8f59JARS1XhMLwdqVCkFAufoTAEy37VKDpH+XnrIDE2aJ825WDjV/K
	P8HC5us62ZDL2Pfj78tiMgEkJTQW7RrrvtniH035tvh0fIE+4QrsXk/bkw5ZVv4643CfyKMwztj
	dx4c29yZkmzFgDViWjRRFCHbnmunHwxkq51w1PecptfQSiFE36di/COzbMKxGCVK+4UnIpu5o8n
	QRWdRuKWI3zBe4XY8ulWsUEP11V9d1V9fgbrbrDgzRCuc373T0BT338ojh6V76O7h/mBG+dv+JS
	1DLg1i/ZAccjiQmDZoVqg7vcVOq2TDml0NnNJcQudeqH04sovQF65P2w1zO+alrYOQepq/RBiJS
	TuKSdp3yyquVFKO5uulQ20KLplwTNLmz/kHhks001cRGZnW30KGoWrLOPWCEfZfqPLbqQqeZxkJ
	tidKBpaG3v0GJpmvBbg0KuZ+cTw7seupVObbc=
X-Received: by 2002:a17:903:198e:b0:2a0:d0ae:454d with SMTP id d9443c01a7336-2a8bd4f11a7mr78003725ad.22.1769825958448;
        Fri, 30 Jan 2026 18:19:18 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eeebcsm83427365ad.10.2026.01.30.18.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:19:18 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 3/5] net: dsa: yt921x: Refactor VLAN awareness setting
Date: Sat, 31 Jan 2026 10:18:49 +0800
Message-ID: <20260131021854.3405036-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131021854.3405036-1-mmyangfl@gmail.com>
References: <20260131021854.3405036-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255323-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4153BC0438
X-Rspamd-Action: no action

Create a helper function to centralize the logic for enabling and
disabling VLAN awareness on a port.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index d82608154c4f..c2998b6ae535 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1769,6 +1769,18 @@ yt921x_dsa_port_mdb_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_vlan_aware_set(struct yt921x_priv *priv, int port, bool vlan_aware)
+{
+	u32 ctrl;
+
+	if (!vlan_aware)
+		ctrl = 0;
+	else
+		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
+	return yt921x_reg_write(priv, YT921X_PORTn_IGR_TPID(port), ctrl);
+}
+
 static int
 yt921x_port_set_pvid(struct yt921x_priv *priv, int port, u16 vid)
 {
@@ -1818,14 +1830,7 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
 	if (res)
 		return res;
 
-	/* Turn on / off VLAN awareness */
-	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
-	if (!vlan_filtering)
-		ctrl = 0;
-	else
-		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
-	res = yt921x_reg_update_bits(priv, YT921X_PORTn_IGR_TPID(port),
-				     mask, ctrl);
+	res = yt921x_vlan_aware_set(priv, port, vlan_filtering);
 	if (res)
 		return res;
 
@@ -2022,8 +2027,7 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 		return res;
 
 	/* Turn off VLAN awareness */
-	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
-	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_IGR_TPID(port), mask);
+	res = yt921x_vlan_aware_set(priv, port, false);
 	if (res)
 		return res;
 
-- 
2.51.0


