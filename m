Return-Path: <netdev+bounces-278149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGQTKt0l3WlcaQkAu9opvQ
	(envelope-from <netdev+bounces-278149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:20:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196763F1345
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C694D3072060
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9334D901;
	Mon, 13 Apr 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNTjAyDz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3A34C989
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100306; cv=none; b=IwL1VUP/UzM3g6MeEEbS3JepqJRjWxmjUNHP/i9YhHYjp54EgyiihbHnPKRWP6q3emUQVrSdyp3WL/rSAfBzmhgFwwwnzbzHklJmtjkX7/64o9aXh8rLE9H1QGkaUTIAZP+pQcBgTCNClntoTitwSLIElT+rCksMVuhgsUnBkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100306; c=relaxed/simple;
	bh=Ew0xXpehQz7Go7vQ6dIvOdiSol/5CKHYJVj2Y82Gw5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaq37wC4Pt0k9nTeoHgN06wzNSAs7+Rg0GjQ9Jktd1Mc4RRJvIliUr50EqJAfni+EITSXQROL5cgthcAMJZ5g924kFcRSulludJN+CGxRDS327cVAJlrMCZZ2uoRRx6l67ODm+OE62GExdTxVTju1fr2aXwNWrD8BUNShnfwT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNTjAyDz; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d7fdb922a5so3740244a34.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100304; x=1776705104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcG/sXIQptFMlSqk7ATax3dU8Pu1lA/HCdBKrg9gnPg=;
        b=BNTjAyDzaxeAeRVICl769ABzvIUonsqI8NAH+UOuufTekVplosBsKzRNunqYsmEc57
         yr2JXv56V70/NE+tNh/pk3/L+vI32P09TkD73uRam6zgHughzlBZv/MdR528xAu8a4Mz
         zPYHniZEM8tdBesqXjqfUrNaAJe57Ur+iE6DFeIqu5G/z6Si82r97VADffTtgGXF1q7Y
         RMDcwmjqGyqgsxpqHXX9bqMGC/Yjdh/Axm2tE3W6hAtzu8kP4dzWeYXaF0ecj11cT9fh
         nZvOddRXCqsycGgbh2ntY0Ogp+IldpP56qgoUODag4j4VJJD+HwKRCuLO2PflpPIymnr
         tnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100304; x=1776705104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcG/sXIQptFMlSqk7ATax3dU8Pu1lA/HCdBKrg9gnPg=;
        b=i2445UnfoiBRRUQOSt1azsKNKuWbWzE39a4s96V/RBg6CMJxhTHhhuk2WH43lPJ12A
         Z0CBNMCxPqo8EcJ6ojrGmAeGOhfBSOURrlfaZ7JzfPUYrvWxkhwn2rola+UznYKsAB23
         4ZY+Jy0xnywEIplaxwP+RZ2Am8jA0Zg2lTjEuU7DbyuU8JEgqaPDeNO8tVAQ5S+qNUey
         SVcau5AZl3NdhQVePu04rsYm/NsmnyYGA4fkzyLd8qEEhbpuedIXlu8MLPpHnt6N6K+H
         oDJxkwbpQgE8MWAOhYKHC29mcP/gX6B+fgbevMkr35j4dO8yzZJ7EsdwGynzrMDAswZI
         qjhA==
X-Gm-Message-State: AOJu0YyDVZxLH5LgMCpZG7F+/4MRduMt3nkQGO6juBsReuxqTkpnzZUO
	+cGZQayk89c9/oE11Q+JrMX49jj4SYfbvKWD89wj8MreQdYaHWSjYN+EKXqvJUxx
X-Gm-Gg: AeBDieuHtLCnyAlQ1m0SKJGbYVmuYsooUX0xs9JcAwNIaJ5ZHEzhNmsPI3oHxbH+rIo
	JnlGf24Ab6mUonieVQo6SiQMc2/dnJ7aCx50VbYi4bkQAA+vIPVW1HehO31EEwUQoORVmbtSwD6
	omB1BzgmzLpdQ/llJnOCta8JktlG7XrB/jioP3hZdnoi55zFF82YIOlZ3ZrbXjVH85AHruLoREf
	WKme6g6D8+diKgXWsO2PO8VcTof+4CX+4ObPtQ1scO8gi5/yuI5pk+2zQ1JcaaqNQqzhuHfJFZ3
	+jL3gimv7bhQWXgxy3dCzvAuWe5Xq3XiGJxEA4doiR/qpVdr1yPN+RpqwAvRxkL4qVVG7yMgW9q
	CIu0McmNHYEyYpbVKvnPyU3JeOkQEzJ+nJXL59bM5nNg1dA2dNw/m8NlnyZX7pzis+EDa99W2bq
	uSGGB4KTv17CX/8iYO/A==
X-Received: by 2002:a05:6830:6d10:b0:7d7:fada:89ca with SMTP id 46e09a7af769-7dc27dcff1fmr8586555a34.15.1776100303950;
        Mon, 13 Apr 2026 10:11:43 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc269fd1b3sm8798603a34.27.2026.04.13.10.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:43 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v7 11/15] dummy: convert to ndo_set_rx_mode_async
Date: Mon, 13 Apr 2026 10:11:27 -0700
Message-ID: <20260413171131.550126-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278149-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 196763F1345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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
2.52.0


