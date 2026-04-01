Return-Path: <netdev+bounces-273817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOuvDn9zzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB69373756
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E4FD30CE022
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7602C0298;
	Wed,  1 Apr 2026 01:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1872C15BB
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006368; cv=none; b=BfC5ej3FAbpd7fl/4eh8clBicuJQJikAcpnbO6pmdbf5LEB8CME4Q2hHulZBxCduJYacF0j9r28SKFKUNJlJgo6I0uOiR2Fg1iwKrFuVoDlDu0cpOMKgQjhzV/lVWDKtsK/1wjPPRm5gPclwMoRowS7eVs3Nq+mACTUeRZIuZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006368; c=relaxed/simple;
	bh=Jm9nwGZjhZZeatqCxi8/bWT1kO5c8q5DfJQgvX6wLs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=my+L7CIZO9YB43X1lqqErHgzVWxY8LxbaErBL42qTUzDxLCEL23BZQQaZ9YyfMHYSpToiKWjLtVvtLj5NMdlBtYMKFieVIX0XA66X/YAbTv0tJ36ffnwXXbzt9+XwG5PkKtfVx7SxCbwAVp/A5FN4AhjC13bCe5Q5DaAyTGvEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12776bebe9fso2448644c88.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006366; x=1775611166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjbmQA+UAvJNFroRTtaphpH50vddoyQfB2DIkNU0HGo=;
        b=FUVvFLRj/db/tFO47X2AHbwnZ8FuF/kG7LiTBFVbao4Dr/TGeLCe5JTkTHmAUEI0TO
         EmRvyrhzQzdHYbEOTaJkDMRNjC0qYPDtYSjRvZ5u1UvFlY9mMguz9eIVXaG7yNklb0IX
         6nqtyqEuBMLdyBxk0ijzAUVpNm0YTK8tGRe1HrZ5CDZKUtCRdmrq3TFhiiOYkyuLyatv
         kVDfjbo3UmiVUpg5/hKlPXT0H1zjLbhC0GANQT3tbPNBAGviTEmr7NW6T7A+SyKnocym
         IWR184fl++/HRT9ulBh1oGz81z/vQ2J/ma0+aglpDhwkKXHE6re4RpusLcfNSuQS2cnT
         WTjQ==
X-Gm-Message-State: AOJu0YzInYPQXaFGpeSwLBjO9MeLqNzu7LsQ/u3r7ISHitDWTll7B7pa
	Zx7wRb5UEeYm4aEOYsLCgSVdjlTiNUC7WZAD0gA3zenByFjDd0z/pQFszmI6
X-Gm-Gg: ATEYQzy/NE0ilsqMSMiKxVgk++PvFPcgNcPQAK8n10zWxtGHrvj2fgjo+QBMLJBw88K
	MswKjRj1G8yJUYh3ro+1nmNcNHkQyzXT48/NqyNbve2EAROSRbbPmPEFt3n4F9GnEuhJV0OIwQ1
	QKKNEFdW5GFhW+lSpTT3zNTsDxwtSjMWs2yBI7eeHtAtEC0FXt+UrWEF14iWqReW7fEhablezEo
	5uVaKgwIzfESkL91rWBRTwu32vJD6XIiDLfFLPaviBiTiUiy3/3I7ZK3OQY1vQa/V2PXUMWySka
	qHBAsqsTeO/5m+MMZTakjFhOZTrSHUq6rCXzwI3meg6qaWKrgb+CcCO5kgXfxeuQTJxp9EjnhPV
	TQduLAQ/jxg3EG3tBguw6GsnpP+x7yNotafHy8QuZEbhBLGgDDOjftV3LRV66EgR7UpmqtWwbfr
	MvN/3WDowPElYUn2oMHH+h6ZD3KMLUB6yeyFFAJzjqPmI+XUXopo1XBUFOyra3aZy++g6ewemun
	vE2wpLx76lic0thYA==
X-Received: by 2002:a05:7022:660d:b0:12a:6e97:c1f5 with SMTP id a92af1059eb24-12be6438185mr1178793c88.14.1775006366097;
        Tue, 31 Mar 2026 18:19:26 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97d88c0sm18916553c88.5.2026.03.31.18.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:25 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 10/14] netdevsim: convert to ndo_set_rx_mode_async
Date: Tue, 31 Mar 2026 18:19:10 -0700
Message-ID: <20260401011914.1716692-11-sdf@fomichev.me>
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-273817-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEB69373756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert netdevsim from ndo_set_rx_mode to ndo_set_rx_mode_async.
The callback is a no-op stub so just update the signature and
ops struct wiring.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index c71b8d116f18..73edc4817d62 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -185,7 +185,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void nsim_set_rx_mode(struct net_device *dev)
+static void nsim_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -593,7 +595,7 @@ static const struct net_shaper_ops nsim_shaper_ops = {
 
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
@@ -616,7 +618,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-- 
2.53.0


