Return-Path: <netdev+bounces-301281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BUSHM/AqOmrL3AcAu9opvQ
	(envelope-from <netdev+bounces-301281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:42:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C96B49D8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:42:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MK1Hap7D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301281-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301281-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453853037177
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64B5331EB5;
	Tue, 23 Jun 2026 06:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA123EA84
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 06:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196941; cv=none; b=i3whuoYJ7npFzTq3Gwj3oti6hqIU/ViV7FeqBeEclFgWBHKz5Qwcfezx9DZSpb0K1WIehda4ZzH71uYpN7xQgi2EmNmZkCtk3klS+XToPpN0sxMDlYqNQRhCbUJfudOuI3V7ynzKLJvti7ilpV/LsWVdvWyKqWZHgljf+tR/PZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196941; c=relaxed/simple;
	bh=uOByGr4vblK9B20Aq+PsLQex9gmyDLYAbOyz1m5A/po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHAlHQpi3F5KTCPSz/8q4oYlWe+zZbiZKrua25zO+ZHw0E65/IOz1qMt1FQGE+ykHtt3Q8wD3FSN1e9W8tDBNwP7eWu/dygnqU3Y2HXLIfGwEpDM19ph8YK00W9V2uAxmgLKFtel6w0rJhqRoKwrYmjqFNaGEvtNcZSGsPQepDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK1Hap7D; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so2608659a91.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 23:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782196940; x=1782801740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbfwy+N51pnPP3dCRs58iA2OlGOjosl6R8dDok6B7Dc=;
        b=MK1Hap7DU/+M4eE4moSm9ezd1aie3JWxQdI+ms2D36DkLVlcM/hcbemz5NlBMS53qp
         veOo3oqI8eqpFDhJ4TsPr8lq07IXzAeXW364BedCVfByjQ6ElzqyBJwIhC4PmYpCzuH+
         byybvL8jlSxBxUVtZR1TM7rAfgSy7QI9pXosmW03ie2+NxzshkEcyJ/FSkD2NSlJUTvM
         +0OWjAIpRcXE9DU8It488rqYmcF4dSOjfpnUE89sItwAB5H+tCFPjGIYSVlcL0T390Qw
         IAh7sa6HQfX1e+MOJOQoLAjGrkWw5KtOEuhiZx4Vd3MpKvMzocurjGMrXNvdV70NWBIk
         3xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196940; x=1782801740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbfwy+N51pnPP3dCRs58iA2OlGOjosl6R8dDok6B7Dc=;
        b=IB1JiZIl9E5plwhzK5uMjjPNUd/uvR4esnTKs65M+RVsrk1XRl2u9Mpg6DBhcMqgCx
         lpEHJ33f//Jj79uXDJK/v7JMhFoXQuI7gncpzA0Lbbgt8fWeUGrCybIUzUy1oao1mj66
         ceExA9bpYwlbNFIotLXHvN8YtaSMD4TxGsPEO9pCIhRU5WOQNpLF0pIVL6ztgcNNy9Sn
         9/T6t/QZ7lyRIPdoUVTmlCVmrG0aSdGyYSmC7vO/+DTt1Jsve/6g3kxIBFNC6lTNohy9
         F80uxaf4UZzW9XtYaDjA6s09LkjJMAj4wii/5Iaz1/lOq2UfzGcLXT2FCcYfyNMX41WN
         vPWg==
X-Forwarded-Encrypted: i=1; AHgh+RpwxVnQw5N1oyLJsz0suHPyqAOsaKUpfXTyQ+aAqnBGZtT1X3QbcZ76u7Mg3JulBRVPvhO7ans=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOkYFWD/wOaU3du5YuETxkyiIeU8FpyFVpLjFavKmy8zK62sy
	8gvbg2tVmNmVRdqDWOLLDFKxPGQA7yagoTDYrCMY5JSGPfZXwjMS3BYY
X-Gm-Gg: AfdE7clFJDdV6aDL/IFr3Gibs16aOzdQtz5lR0eZEUgHSvUFCAzeEc/ovaqTuFTs0kS
	aTKSfWVEYhKgnYQyLB0uThvemTnAUVKCuOpvr1OgJl0kdCiboKcHRq6HwkhaV4O+7bbsm4Y5bWn
	Iz73pt1wsthE/lUIqUHN6km/TbmpKibxQyaLxl/nPiuZl1EjWbbPEkoWAvFW8HCJFG/nwWz+9ti
	pWc2adL6vFrGQC7w4FiJTqzdFeQgMPJKi/llqwJxioT7q0CXMLlUDYyg7x9Uk47MXNAvE1HbONn
	puoHJa8DTGW3MvA0cfh6ogS7KAtcKMKBqarC6Ow7FQMM/j+twX1JHzLuoJh0i72LeDfuSG9b450
	WOAwDZHt49ENWgEhqcR02vQ6sOiuT5jS7wIzV7f/IfB7fyUKyh+MxAqGC56hIi+cIad+yL+rHUM
	wtcheHe8UKnNZT+oSi62FavqGdw9j5i9PVEAhL7aZHFhdwnteT9iA=
X-Received: by 2002:a17:902:c944:b0:2bd:ba44:6c07 with SMTP id d9443c01a7336-2c7c997d7a6mr13438545ad.16.1782196939753;
        Mon, 22 Jun 2026 23:42:19 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af22bsm93689415ad.10.2026.06.22.23.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:42:19 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net v3 1/2] net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
Date: Tue, 23 Jun 2026 12:11:42 +0530
Message-Id: <f3bdd4c91f3e2269b4e256075f9dc70808b1b8e9.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:wellslutw@gmail.com,m:kuba@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301281-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cambiumnetworks.com:mid,cambiumnetworks.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 283C96B49D8

mac->phy_node is acquired via of_parse_phandle() in spl2sw_probe() and
stored in the mac private data, transferring ownership of the
device_node reference to mac. On driver removal, spl2sw_phy_remove()
disconnects the PHY but never drops that reference, so each
probe-then-remove cycle leaks one of_node refcount per port permanently.

Drop the reference after phy_disconnect(). While at it, remove the
redundant inner "if (ndev)" check; comm->ndev[i] was just verified
non-NULL on the line above.

Compile-tested only; no SP7021 hardware available.

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/sunplus/spl2sw_phy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_phy.c b/drivers/net/ethernet/sunplus/spl2sw_phy.c
index 6f899e48f51d..a4889c52e00e 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_phy.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_phy.c
@@ -79,12 +79,14 @@ int spl2sw_phy_connect(struct spl2sw_common *comm)
 void spl2sw_phy_remove(struct spl2sw_common *comm)
 {
 	struct net_device *ndev;
+	struct spl2sw_mac *mac;
 	int i;
 
 	for (i = 0; i < MAX_NETDEV_NUM; i++)
 		if (comm->ndev[i]) {
 			ndev = comm->ndev[i];
-			if (ndev)
-				phy_disconnect(ndev->phydev);
+			mac = netdev_priv(ndev);
+			phy_disconnect(ndev->phydev);
+			of_node_put(mac->phy_node);
 		}
 }
-- 
2.25.1


