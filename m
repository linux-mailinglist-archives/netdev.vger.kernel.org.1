Return-Path: <netdev+bounces-296630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VEF8BgXmJmqVmgIAu9opvQ
	(envelope-from <netdev+bounces-296630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:55:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA66F658657
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:55:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openvpn.net header.s=google header.b=dw4yIfJh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296630-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296630-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=openvpn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D024F30A0B0C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834DE353ED9;
	Mon,  8 Jun 2026 15:07:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D9332610
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:07:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931279; cv=none; b=C0vTBDxxUrUUgj+bNVCjtOQOP9A4GEVtjS5CirV5SlOhSaLelMm1+PXFoJjzYiUdpm0H55GXaOeACn02Kie7LyQmKrHks7KEL0yYLBKXFmsjJJF9WxqhVWYsVmhYL7E3nfUTJ6xPK0B0fwhe+jCFbZsAjoqQ10EfNLMJAbodCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931279; c=relaxed/simple;
	bh=GVeaFmDl3Zv2NMxAhA6o3DrDcWESPgBn6yuhNtSkhDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDUb/Sgm9RgklUb2ny3b7plBydMoh2ShpXALPRb7FCffwTozk8tP+GS6eV8d1ShasrdIHLszZqEp2yNOTe9r/jTeoJi4n0ClnDH1hxikC2vrqoYo9G7bkrRvoxQUSDaEBHwSXunCmuC9Ar4vEVVsj9s9N5jYNvEm1VrOvTUJHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dw4yIfJh; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso50710945e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931276; x=1781536076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJCy09ESTxEx8Ki/esNqRYV/Y8EcyDPn5yaJERV6vkI=;
        b=dw4yIfJhnAfXw5XRCcd5+1zSfTSDJb4oC9IuZWz6PbfiZjVD1XVGxkprEtJD7PbJrD
         fNaWFH/fTF1JdmDNRdcoAXSsNz504eJvXxYSJISRNrv7ME1WmMIlFEii++LrAyKrv12M
         deuyf+SLspdLil90DBmAx0CusP66V8hzg3tP/igegHZ7nWLC9BO7IJZwvAc1Vw1q8YWP
         /YFcxXkyIuLeaNumtxiXeLYVJVSuDYL11dCM5j/FeQNNMUKxfqmgQo91OJ2DZ595bY2V
         zcOuVW30AYK6pJ8XvQpwNVxM+KNgAp9XjFeFY1r0voY7H6CcQoRmByHihFMMQ8MiWvZj
         /S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931276; x=1781536076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJCy09ESTxEx8Ki/esNqRYV/Y8EcyDPn5yaJERV6vkI=;
        b=gDGhVtRHn0Y40rAPH1Id9CIN95kiR0PSZQkReFSDolP8PNe43oW+cGpQnQVKLRr4kT
         oMCRrUZS7zpn6fXGlCUhKzBcSD+zNaJhliz2+Ami8HTQjaK3Y4+vnOMp0yZioNUIVwRu
         pwAfKYdRj/yWJZiEQe4/v2YRAG03E0uZXMfH+TnlFYfkZk5rfv2hUoiA66VXw83ew4xX
         xTPuBxSNzi7b4PUfZ+UbvJMd45PZ2nlFCsoMucwXji2wqMpiZoEgQT4aSrh/Xs+eh4+Z
         7r2OH7hf1iNd5hB9C3e0qpXjHzuJo3R1m5tcQSyAol5dNe6b8qHhpXPC+wq7Nxg1mSsz
         BcqQ==
X-Gm-Message-State: AOJu0YzfacS6QayxavcR9MpCkQq7ddIQkUm0k8CuDlL1hbUzxwNrIE9P
	PrhNbDNNip1ADyQqbkd82hMD/30QwGKt152Fa91ND5l2iZvmmiEHaUxYwrRUWArH0nuE30CIQDG
	yONUdeQ9dHFLw+hukCfdS2gupAZM7pjN+GsAS8vUZTPcmVGU3D+Yeri3vbA6MwLbWzEw=
X-Gm-Gg: Acq92OFl/92BJI+8yYKwQk12RBt90/Ob+UQGsXEdFJhiSLe/+GmN8jzDGbil7Z+0G8s
	14dH7E6qymKIEt4sXuXZIZQpA4L5mHlEGyS8ZtQfia9WPQY58/QSufPVsQUhcsNf6crYDg/qQMP
	Grmm6MkcqLRoQYhn9PKEi8R7dce3V0+qw/Lg557BalAqDfPKBX9LoBTtPUCSOi0djbjXLA9FI38
	vzEbZn5VMibH77NqVhp/kLZJqfkgN1R8sRURtOihpO79OGIt2OTtuEEwHLIxquIIB4dDCGxraIa
	XXXltsq7my3FJKM6eJFnS7DEVgK+DoClkGsLM/S5VAsP/+WyxATlcbsw/+irfMvCQH+YihtsUAx
	TKgmJYeDO0riLQ0nfDFXvvCibT8JsNqSN0jQTHDtz5gDV8jWkF4HUj3RuCM68atrt49cgTNWH72
	SjFfwwxUkUsp0SeWceN8eYgV3v5dgXVZ66LmaWDJGtXQBIOD6yDIIdJ2ziJA==
X-Received: by 2002:a05:600c:3ba4:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-490c2525dacmr289221285e9.0.1780931276284;
        Mon, 08 Jun 2026 08:07:56 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:07:55 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Pavitra Jha <jhapavitra98@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/6] ovpn: fix peer refcount leak in TCP error paths
Date: Mon,  8 Jun 2026 17:07:33 +0200
Message-ID: <20260608150741.3320919-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,mandelbit.com,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org,openvpn.net];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296630-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jhapavitra98@gmail.com,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:stable@vger.kernel.org,m:antonio@openvpn.net,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,openvpn.net:from_mime,queasysnail.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA66F658657

From: Pavitra Jha <jhapavitra98@gmail.com>

When either the TCP RX or TX error path calls ovpn_peer_hold() followed
by schedule_work(&peer->tcp.defer_del_work), and the work item is already
pending from the other path, schedule_work() returns false and the work
runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
exactly once, the extra reference taken by the losing path is never
dropped, leaking the peer object.

The race window:

  CPU0 (strparser/RX error):       CPU1 (tcp_tx_work/TX error):
  ovpn_peer_hold()   <- refcnt+1   ovpn_peer_hold()   <- refcnt+2
  schedule_work()    <- queued      schedule_work()    <- NO-OP
                                    (work already pending)
  ovpn_tcp_peer_del_work runs:
    ovpn_peer_del()
    ovpn_peer_put()  <- refcnt+1
                                   <- peer never freed

Fix by checking the return value of schedule_work() in both paths and
calling ovpn_peer_put() to drop the extra reference if the work was
already pending. ovpn_peer_hold() is kept unconditional in the TX path
as it cannot fail at that point.

Fixes: a6a5e87b3ee4 ("ovpn: avoid sleep in atomic context in TCP RX error path")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 433bd07a4f1b..0af14055c39a 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -151,7 +151,8 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	/* take reference for deferred peer deletion. should never fail */
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
-	schedule_work(&peer->tcp.defer_del_work);
+	if (!schedule_work(&peer->tcp.defer_del_work))
+		ovpn_peer_put(peer);
 	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
@@ -283,7 +284,8 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			 * stream therefore we abort the connection
 			 */
 			ovpn_peer_hold(peer);
-			schedule_work(&peer->tcp.defer_del_work);
+			if (!schedule_work(&peer->tcp.defer_del_work))
+				ovpn_peer_put(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
-- 
2.53.0


