Return-Path: <netdev+bounces-307607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XxalC4e4Vmo9AgEAu9opvQ
	(envelope-from <netdev+bounces-307607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:30:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE67593D4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:30:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=Afh8wwwW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307607-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307607-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9979E301F581
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D623559F2;
	Tue, 14 Jul 2026 22:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F43630B0
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784068227; cv=none; b=DwSGuovo1XfcnoQw4X430SfFwVXpoG2S0/bWWDGP/9ydmlNsAZR3esoTtyvZAhnn4VZWqPcvZH4QX4uXlD97kzSJLB1kQTbT09HrKQDime4MBCdWhYCL8CdrhBsD+oj2MsB5j+RKoBTnQqkvKhcopvMVflxcd3WPy22GTHFuv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784068227; c=relaxed/simple;
	bh=1X8RMcO9u1ZdvJEbTKcsopB9C3caj1GEhxj55HG7QFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjhhEa7AZiGsgDLTQXNFmrhj+LLBbINayyAVQCbBO9l76zfaxrh1qIXkj5xc9S9tysD4GZDyCE2FITIvpD0QuuaIBwwGE9+DVd2xW5lUxJc7nJFTYM9epaZkr4wyMb2j7+ZpdSxjE3C7Gvv6zwLUGRRatgYV1UiwihFlOIh7wQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Afh8wwwW; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c19bad03so43127285e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784068220; x=1784673020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D75JCKhn0rkyk7luV/pIhhCc/sZRji1g64S8PTRRu8o=;
        b=Afh8wwwWw09DUwWuZejgWaypAbrZsjvZSjuEj46p5hCG4XHwCr3OI+OYAacNw1V02J
         13qI32lwKfHoJ7qjKiWxytrttaLAuLr2o+zsPf565gcBzjSadtW5z7LZGbFI1zOMSw3W
         ZoZ1VmYPnitojwTbFkEoM6lQpxhrZ/Y57yUTfNOyRvtZHcx9dpjXyxlQmdvyASx4QNFY
         QERtwPPAQXWM4Wp8dh33zZNSlQ5CWKpwFE8XY4TNStJ0OkCun30BCFAxa8+jdAD6drte
         Y5Qb8B4mF9Ys0exMT6fX4do0NOiSeGpb92jfheX9HXaFoLuwjZmu0S+8JgwhqL7szWz8
         +78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784068220; x=1784673020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D75JCKhn0rkyk7luV/pIhhCc/sZRji1g64S8PTRRu8o=;
        b=XeXF1AoSCB6TeUfLRoylgjta6ewvyf2yI9iVLiRnS1jUCQML9nt91HqnhhRTsPFcwU
         6TPE7ttVzDYQbyOzNK4esCj/QdMwUNaDnIc1ewMLcxdvFpfgOQmgMfd/X6kldNOz0qWi
         RobaraaQH6tSD8QmxhuLqF6VkMUTt2uaaTmxzULkzgcg3maTx5jLPKVLcay4QDLSFwzl
         MF5U96zszA05OkpMBt1kEJcMc0s3ZebXSlZFcPSB5VHjRVgz22cpvwRWMU6dXJ8Iyfps
         zKAXLQM5kvFQL5whNkuALqIsWfQrMoWlNKVQx34KmavyrZENnK57O82uU7hWVsuK5BNU
         /iSA==
X-Gm-Message-State: AOJu0Yxl7vj2JHMxZa3luxYEzy5QNHeomeL+2cjgcfmCc0mM9k5isr59
	YPJTurRVYZZl82MMU4OiyABQIv7M/MB4z9fzlm3ZDr5GEZ6f+btPKIxYbjztI2Yuvh4dYiFuuQ9
	PRzk4h18JgKaOo14w1Oe1zDZ3n0VfsjkiSkkfDVEoyBAI5rYAy/BcyKk+NEbih7HT4zx+Q693Ub
	/K7lw5Ikw7At1kul/PJw9fXjVyAuljNVzFoIXhbQMY+11qAos=
X-Gm-Gg: AfdE7clv26RWEP6BHX3lTOQAdGWWeweqZj0GvaMRq/u/G5zwsv6UDK47kkoNd7hAj59
	u7SW9GaAMinTfuzcqcQKsvgaY2tiZVUKOsSn1bEm6vUDBlQGJgMTk3qUQjTT4c4rmVT3NMiAbi/
	4GL5EtoYYEhznAzYFFBVuL7MvjV5gj8ook0HDmIcZ5rZhm83N4nUejg3fDto5COL0h7b+kCbvhk
	Sol8E1GbD08rNp8ckqu0tzRThuTAYc3K/3qlXAqL/PiEqzj4+tCJcKokU4SqNH1x8CnzeH0xe7p
	hwELHVIZP+wVGzVfBg5g/2T7ekH0voacdpfniGyfXzdf9vS/VVtyESxIZMyKtLPSTvMvc46oXt2
	i57ScWS9FDN/btEOl1yHx5FCznqqh2lf/wZKm65tLlXBK52zGZ6i4zOuMjdNXBEvLJuxMe4YapH
	WXdX04nqx0tHC8HvnMLlpOm5HQJSJfl8wSoFeUCLGyn0IlADMJ8LQD728f22pyT5rVHrOrInpa5
	0gqR6H781NFvc81ARGaNm4bc8J+jEqoN8Z2nkXtvzP1vZD2f/wEXcnozWOxM03UNImkj1DV8HTN
	WFK3wRwZaegbcu90GEJ2gGTQKsvM6G5ZSQk=
X-Received: by 2002:a05:600c:530c:b0:492:3da4:81ef with SMTP id 5b1f17b1804b1-4953c830f66mr3338605e9.18.1784068220049;
        Tue, 14 Jul 2026 15:30:20 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495087366c0sm196536915e9.7.2026.07.14.15.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:30:19 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	nils.juenemann@gmail.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH 1/2] net/mlx5e: kTLS: reject stale RX queue mapping on RX offload setup
Date: Tue, 14 Jul 2026 16:29:14 -0600
Message-Id: <20260714222915.2334949-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260714222915.2334949-1-rjethwani@purestorage.com>
References: <20260714222915.2334949-1-rjethwani@purestorage.com>
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
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307607-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:nils.juenemann@gmail.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,m:nilsjuenemann@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CDE67593D4

mlx5e_ktls_sk_get_rxq() treats only the -1 sentinel from
sk_rx_queue_get() as special and returns all other values unchanged.

After 'ethtool -L <dev> combined N' reduces the number of channels, a
socket can retain an sk_rx_queue_mapping from the previous
configuration that is no longer valid for the current
priv->channels.num. If TLS RX offload is then enabled for that socket,
mlx5e_ktls_add_rx() uses the stale queue index and can access a
channel outside the current array.

Preserve the existing -1 -> 0 fallback for sockets that do not yet
have a recorded RX queue, but reject queue indices that are outside
the current channel range and fail setup with -EINVAL instead. Wire
the failure through the existing err_create_tir unwind so resources
allocated earlier in mlx5e_ktls_add_rx() are released cleanly.

This addresses stale queue mappings during RX offload setup. Existing
offloaded sockets whose channel disappears after reconfiguration are
handled separately in the resync path.

Fixes: 1182f3659357 ("net/mlx5e: kTLS, Add kTLS RX HW offload support")
Link: https://lore.kernel.org/netdev/20260627210635.89769-1-nils.juenemann@gmail.com/
Reported-by: Nils Juenemann <nils.juenemann@gmail.com>
Tested-by: Nils Juenemann <nils.juenemann@gmail.com>
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c  | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index bca45679e201..232e998a8f24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -620,12 +620,15 @@ void mlx5e_ktls_handle_ctx_completion(struct mlx5e_icosq_wqe_info *wi)
 	queue_work(rule->priv->tls->rx_wq, &rule->work);
 }
 
-static int mlx5e_ktls_sk_get_rxq(struct sock *sk)
+static int mlx5e_ktls_sk_get_rxq(struct mlx5e_priv *priv, struct sock *sk)
 {
 	int rxq = sk_rx_queue_get(sk);
 
 	if (unlikely(rxq == -1))
-		rxq = 0;
+		return 0;
+
+	if (unlikely(rxq >= priv->channels.num))
+		return -EINVAL;
 
 	return rxq;
 }
@@ -673,7 +676,11 @@ int mlx5e_ktls_add_rx(struct net_device *netdev, struct sock *sk,
 	INIT_LIST_HEAD(&priv_rx->list);
 	spin_lock_init(&priv_rx->lock);
 
-	rxq = mlx5e_ktls_sk_get_rxq(sk);
+	rxq = mlx5e_ktls_sk_get_rxq(priv, sk);
+	if (unlikely(rxq < 0)) {
+		err = rxq;
+		goto err_create_tir;
+	}
 	priv_rx->rxq = rxq;
 	priv_rx->sk = sk;
 
-- 
2.25.1


