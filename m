Return-Path: <netdev+bounces-288260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICpTCKzyBmohpQIAu9opvQ
	(envelope-from <netdev+bounces-288260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:17:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1DA54D287
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05233313BC7B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15443E4AE;
	Fri, 15 May 2026 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="eEHFQ+lQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="PZldruDQ"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf121.lhr1.oracleemaildelivery.com (acj35aaf121.lhr1.oracleemaildelivery.com [130.35.116.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024D43E489
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838821; cv=none; b=OJndmdN+l2y1QGlZi0PCX6dQzJhEjYBWyYtwT3hOUpUD4AJIrAJ4bY7UbZW3aspQfYzDYQeO5UFpr+IHcKnieG2qZqJQ6746iEYJl8u5FC5IXX2LuenOTxRpEyD5DEk6iwDNbHcomkOnMt8SVizd02E1Kue3D752WRo7x7XKt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838821; c=relaxed/simple;
	bh=QLygpKb2dZMhs/Db+eZZHoi1JZ9i/aczi6DYmubhJMI=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version:Content-type; b=enweL8++n7RkGdKxTfoRlBkipMdswKOD5ZR3fxppuiZrmnt/OJ6/njrfeWug1+/99wSEhKAOUoN3NjKK+s9yjfgp6pOuJWzzfu6LDBwRhCI1nn2JXJ75Myy48NBCEMOSToXxTwLsPb5JNBzdbq+aVBeSiXzLeL83j91kQ06RWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=eEHFQ+lQ; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=PZldruDQ; arc=none smtp.client-ip=130.35.116.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=KhYQsRh4VyQqcPigw9u1q21Z8nnaa7Jt0zu3uVsvbqU=;
 b=eEHFQ+lQtgzYDWG8r7Ox3KeCHeTZJRFTTkU4rhRSQxkHMtQfdmdi1K840ID64unyn9upGGXLnfmc
   GdComVYel98cJLiYJoPHKmUC8rIak7Dmww2oKSmFhg0W6pv7q0YQ8jY7HOHlJkrnDwLzM7k8M4xH
   3CQDKrZzt9zOCfUVipWFIaDTYZKGS/Y5/2pb2Fz1VktyviZJINbRUpoHEjgM2eIfsH7AAeegaWrw
   uRSxbqlpzrbAq0htKye62gQ4266BaO8xJIYpz7EcilTst8nuAZ8eUdt5USkRb3fDoKJKQezlAL3c
   ozSB0AemT4abLUiKYy6jrM7MSZjfhr0bjzf+2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=KhYQsRh4VyQqcPigw9u1q21Z8nnaa7Jt0zu3uVsvbqU=;
 b=PZldruDQRgVfWNWZsMNeBC0hR03cy1qBJomvzcpJc23w+bQTjJss+wWyBCHyIKoucea5Oi1oDN9m
   rDqLoy2DPutCPzZdJYU9q527Xg3nmmG2rQHxReSPnViYDomzNuksJ5RA54UTzEP6lFG1muywq2g8
   E+Zlril4T6XAeMMtzWxOnPIfC9wpz7hIJSEfQU7plTdkyZXM7WtnND1SS8jQXormGPySpqOK8aFW
   m9aQGamQBE1zPNAr9LEJRojqamb8AAUVc0KhQM7FnmvBspE5q/ja264GRguSOEB6AmgZkbEuTY0A
   s+YAD9N45HtD2M/EJlzd8cncikrSsrKOjA6y8A==
Received: by omta-ad2-fd2-1401-uk-london-1.omtaad2.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TF218O4DOTCD560@omta-ad2-fd2-1401-uk-london-1.omtaad2.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Fri, 15 May 2026 09:53:36 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH net-next] net: macb: fix build of TX stall watchdog by
 replacing undefined netdev_warn_ratelimited
Date: Fri, 15 May 2026 10:53:36 +0100
Message-id: <20260515095336.92237-1-lukasz@raczylo.com>
X-Mailer: git-send-email 2.54.0
In-reply-to: <20260514215459.36109-4-lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
 <20260514215459.36109-1-lukasz@raczylo.com>
 <20260514215459.36109-4-lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGGMLVl544WMl84tN2V29poZax5nOlse0gFMRELc/TH6YxsiNZHF6OLG0TWO1Bd
 uRwGSxavSrmdgKx8Xt/6+S5+RT3Vo97Xt8jXUmE8dofHwyXZGJHnX8UpIb/ZZ8dI
 yV+tDuwG6TNP9wokhjh5VdUF9+UwquEJcbQBKNGtvWOj2aDBUUjHN9YoHv2Lal9h
 xa2oBHqIwiCWgHUClMGJDQmuaxh/LuM0Vpr7/7KF4P/HjzO1C4Rfam+ul0mTg88Y
 4O1EhUzgO3h1gcMk9qjy3ZEYLUqrYRGZr15xr1uuyIZzEKbwoPe+TRZ9nlhn4do7
 fqGeVcW6UDk6OOlybQJGhGKMpWMn2EtxK25riAqaC8vLQaUfxG0O6538kBKxQd/T
 SOSLygKjOXthfLxOvPsDgbzdv1QZ5PsHlH8xT4b67npmWQlFjTtPaKz8Vl/rfA==
X-Rspamd-Queue-Id: 7A1DA54D287
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288260-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.853];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

netdev_warn_ratelimited() does not exist in this kernel -- neither
mainline net-next nor raspberrypi/linux rpi-6.18.y define a
netdev_*_ratelimited() family.  I confused it with the existing
net_warn_ratelimited() / pr_warn_ratelimited() macros when
authoring v2 patch 3 of the macb silent TX stall series, and the
result fails to build with implicit-function-declaration.

Replace with the standard `if (printk_ratelimit()) netdev_warn(...)`
pattern.  Same semantics intended by v2 patch 3 (bounded log noise,
retains the netdev prefix in the message); works in every kernel
version.

Fixes the build of patch 3/3 of:

  https://lore.kernel.org/netdev/20260514215459.36109-1-lukasz@raczylo.com/T/

Caught by an independent build test on the Talos Linux Pi 5 build
(John Laur / johnlaur on GitHub), reported at:

  https://github.com/siderolabs/sbc-raspberrypi/issues/91#issuecomment-4456874307

Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2057,10 +2057,11 @@ static void macb_tx_stall_watchdog(struct work_struct *work)
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);

 	if (stalled) {
-		netdev_warn_ratelimited(bp->dev,
-					"TX stall detected on queue %u (tail=%u head=%u); re-kicking TSTART\n",
-					(unsigned int)(queue - bp->queues),
-					cur_tail, cur_head);
+		if (printk_ratelimit())
+			netdev_warn(bp->dev,
+				    "TX stall detected on queue %u (tail=%u head=%u); re-kicking TSTART\n",
+				    (unsigned int)(queue - bp->queues),
+				    cur_tail, cur_head);
 		macb_tx_restart(queue);
 	}

--
2.54.0

