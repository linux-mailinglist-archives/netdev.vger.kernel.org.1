Return-Path: <netdev+bounces-254200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMtXGZvqeWkF1AEAu9opvQ
	(envelope-from <netdev+bounces-254200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:53:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B145D9FBA3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89011301E958
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA032FA00;
	Wed, 28 Jan 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nqvYJteQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1A31062C
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597522; cv=none; b=V69yABOdQHWUgTPxHVahdisb+Utn+kFyDY3MzrIMTphZ7AqlQHtSOfzKUGyZO7Kr0QF6VHDMdJwY2rMs6i/jGCqfHDN8FKeQP2WrLSlt2y87Dax8FdtbQnmCNfcfyzcWMxDFUfFz0nMQC08WCdyD77jfvX4I5XyXpGKYVAtVuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597522; c=relaxed/simple;
	bh=c9Eiagdq6U48mRTb9hfve6FYWqdBjsr8AYWZRxD3hag=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=QxyMHfVi7+S7Cc58Whph2GktW096hxZt5rW+NByoZhgoxgDbz+s1nMNHbzdh9VbW1jRL2EQfEMctqJKeEg6XQRb5S0FcEbUxKD3m9UyXG9mkJ0WXkN5H17aNNiDA8YZi3YRPKWRSOzVlif1L00vqYR7/skQbNCOUQYxjJhrXZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nqvYJteQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XtC8yJQgyjPmZTdImoZeQxZHnTGIV1u/ZfImELjtTq4=; b=nqvYJteQoEGSF1YlajDty2HRBs
	Peq9TUComiO7lbywl06o8X61iGWDhLn5XTYKvxlL+he6UY9ByWSJd2vsPx5JN5Rdu7d4GJvLccW86
	FS3vztXNXK4Cm20Y1Bi/wSdFMi/t3gK6rqk8iREoZgeULvynGxlImQOPfhTFUr4THEo4P9jSVLHlR
	Wf0rqOXMXrRIdsLmZh0YzHHw6oUheBA9aJzAUjHl3SN20d6B6BLDAjCUdnWdWndJCGPSVG+dZSXv2
	MA0MYnv991258qcLK7N5ozfxGuHv7NPucTw0ol+0kiOMGJxuzyobECBOqovjPxcFBMzJkchO7Gyzs
	LZmgIWpA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38786 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vl39R-000000007ER-0oWK;
	Wed, 28 Jan 2026 10:51:57 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vl39Q-00000006utm-229h;
	Wed, 28 Jan 2026 10:51:56 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phylink: fix NULL pointer deref in
 phylink_major_config()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vl39Q-00000006utm-229h@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 28 Jan 2026 10:51:56 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254200-lists,netdev=lfdr.de,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B145D9FBA3
X-Rspamd-Action: no action

When a MAC driver returns a PCS for an interface mode, and then we
attempt to switch to a different mode that doesn't require a PCS,
this causes phylink to oops:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
Mem abort info:
  ESR = 0x0000000096000044
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
  CM = 0, WnR = 1, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000137f96000
[0000000000000010] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000044 [#1]  SMP
Modules linked in: --
CPU: 1 UID: 0 PID: 55 Comm: kworker/u33:0 Not tainted 6.19.0-rc5-00581-g73cb8467a63e #1 PREEMPT
Hardware name: Qualcomm Technologies, Inc. Lemans Ride Rev3 (DT)
Workqueue: events_power_efficient phylink_resolve
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS    +BTYPE=--)
pc : phylink_major_config+0x408/0x948
lr : phylink_major_config+0x3fc/0x948
sp : ffff800080353c60
x29: ffff800080353cb0 x28: ffffb305068a8a00 x27: ffffb305068a8000
x26: ffff000080092100 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000001 x22: 0000000000000000 x21: ffffb3050555b3d0
x20: ffff800080353d10 x19: ffff0000b6059400 x18: 00000000ffffffff
x17: 74756f2f79687020 x16: ffffb305045e4f18 x15: 6769666e6f632072
x14: 6f6a616d203a3168 x13: 782d657361623030 x12: ffffb305068c6a98
x11: 0000000000000583 x10: 0000000000000018 x9 : ffffb305068c6a98
x8 : 0000000100006583 x7 : 0000000000000000 x6 : ffff00008083cc40
x5 : ffff00008083cc40 x4 : 0000000000000001 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000b269e5a8
Call trace:
 phylink_major_config+0x408/0x948 (P)
 phylink_resolve+0x294/0x6e4
 process_one_work+0x148/0x28c
 worker_thread+0x2d8/0x3d8
 kthread+0x134/0x208
 ret_from_fork+0x10/0x20
Code: d63f0020 f9400e60 b4000040 f900081f (f9000ad3)
---[ end trace 0000000000000000 ]---

This is caused by "pcs" being NULL when we attempt to execute:

		pcs->phylink = pl;

Make this conditional on pcs being non-null.

Fixes: 486dc391ef43 ("net: phylink: allow mac_select_pcs() to remove a PCS")
Reported-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Even though this is marked with a Fixes tag, and has been noticed by
Mohd while testing my other PCS patches, I would like it merged into
net-next rather than net so Mohd doesn't have to apply this in
addition to my series when testing. This isn't a bug that will be
seen by others.

 drivers/net/phy/phylink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 7641f1f41e39..e1f01d7fc4da 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1293,7 +1293,8 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		if (pl->pcs)
 			pl->pcs->phylink = NULL;
 
-		pcs->phylink = pl;
+		if (pcs)
+			pcs->phylink = pl;
 
 		pl->pcs = pcs;
 	}
-- 
2.47.3


