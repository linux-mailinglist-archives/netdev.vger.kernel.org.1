Return-Path: <netdev+bounces-258651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FWCFMVYj2lqQQEAu9opvQ
	(envelope-from <netdev+bounces-258651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:00:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5CB13872A
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9CD93011C70
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465E3644AF;
	Fri, 13 Feb 2026 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fk94WmVj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0F364054
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001936; cv=none; b=XJOe8nxfvEHmAyxpcIht64hcnxgVqAf59/I7iH9VW2te9Hd54Yjzk9PGYRxB8pbh8vQoSeaq3KxklSQps/ExtnPQ0FQ8H1JHezpNOwZLJEPP3CGl6q27kWom8dg5PP//q0yt3eD+7gjYqAJb7+zfQkTaVnc8RUvlM9BUmZLdphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001936; c=relaxed/simple;
	bh=bazbAb/mDntPtfEDp3Dea7UxKGYZirgt8bOJfbpxSpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+CZ2kqRllcJ4llmAlTPT17+Aw/aH1LAlFRLKDYbB85anj8jFAJXZzqGQJM0jUmTo4erisYw7AbBMtAQUHn94kk/6Df1zhd9jTvA7s/DQSAf88V1+07LdUyI+l99nJaCuFZzM8TUflxQkDBRrrN/27gbfF8/f2DUBqyQ3U01jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fk94WmVj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0384FC1D706;
	Fri, 13 Feb 2026 16:59:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 39CFF606D1;
	Fri, 13 Feb 2026 16:58:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6027E10368EF5;
	Fri, 13 Feb 2026 17:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771001923; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4YJzMxeTKdT9Nn40+qxjCuuux+hgT+ZKElmk48vFsHI=;
	b=fk94WmVjfm4rESqp/+yNjYyZoPWeHYgGhoYPOpTz7xyrV98fNToK5oBX+Zg5CVQf+NANLA
	HPrDAHDtaogIhqnJBKeFYhZlKQOEd6TpX2vPZQ3JDHSwFwgx6J0x66I0fAjK6aJC7WUMvE
	Eky5JF9bSxAJM+dQzFWmFVXDZ59nT8KlNn5Nw4kmbL4xZCyLsxpCuyPPl7fc4ZhyBwGlAQ
	HW2/7tT79uT7fEQ56LOqyBoJdb28QsO3rC1SDUavs/PaNF7XjXr+sZH71YBgEzrIcI0MTZ
	QT7vns9QF+2QLqbArqr3HnaPvJ3ArkRL+Wf9qhz5cflnV6UEj+5ZlOvg1HGuTA==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	kuba@kernel.org,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	pvalerio@redhat.com,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 5/6] net: macb: improve Rx refill error message
Date: Fri, 13 Feb 2026 17:57:58 +0100
Message-ID: <20260213165759.225449-5-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213165759.225449-1-theo.lebrun@bootlin.com>
References: <DG4MBFXG7GGG.3GFLWBUKH087T@bootlin.com>
 <20260213165759.225449-1-theo.lebrun@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258651-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13]
X-Rspamd-Queue-Id: 9C5CB13872A
X-Rspamd-Action: no action

Message is "Unable to allocate page" in case of alloc failure.
 - It does not mention the buffer direction (Rx/Tx).
 - We allocate page fragments, not pages.

Fix by replacing with "Unable to allocate rx buffer".

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 01b4299dc34b..2c7644f2215a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1319,7 +1319,7 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 						    gfp_alloc | __GFP_NOWARN);
 			if (!page) {
 				netdev_err(bp->dev,
-					   "Unable to allocate page\n");
+					   "Unable to allocate rx buffer\n");
 				err = -ENOMEM;
 				break;
 			}
-- 
2.53.0


