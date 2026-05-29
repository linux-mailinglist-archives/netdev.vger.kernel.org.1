Return-Path: <netdev+bounces-293119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OZPI6GRGWrVxggAu9opvQ
	(envelope-from <netdev+bounces-293119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:16:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06875602C1C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F9E5302BFCD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E893932ED27;
	Fri, 29 May 2026 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpTBGtiv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DAE32ED29
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060535; cv=none; b=Flq/Hzpegji7PIgJ3UKG/ZfXpvPFTBoYocCJeO46P40HOFSIOEafSXPJQFkma2vfdhWSxPmyXULFdOqFmAK6gml9w6VbJGIo5L4LZhmdBmWxnYmlSf3994cB78ghsxXg/osridtiqDQwOQyr6G4JiYU6U9/regy27uVn1gyWqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060535; c=relaxed/simple;
	bh=T8zML60x/WQFS05OCSI9D268p+fmn0DGrZ40YL0GmeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtXjVTvxEDa/86fVQVU538jjGhhXBLrYPcc7bb3ubKyqcHPNknHAVoqRj/W1BToOTEjqYsueDPeLhh+xk5JXcZsbtxsY3GhOtKHTpl3EGgrFOh1qCAPjWutf8FGbSRn+Uu20KO3CR9r1n+fdKD3o+i+pYN/XeycTMa36AKFCAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpTBGtiv; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e615efd7d7so5669238a34.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780060532; x=1780665332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gpuXxi7i/5t+I/g5icZzBea2HRtsO6XMTgF5cBNBQg=;
        b=XpTBGtivyqgqGydVRr+AXX6zZLJyTFOd5h6QmkcgPBBT3T/Otfrktb7ljjGMi3JYPG
         mHlAOkFJay6BZ0aldOZUdoCShEeWFyOYQNYvtLXYNGWqoriohKalRazqKZVpl/xpaW7O
         OazbHJueNwdj5aVSK5xT2hOpLmJnvIP9qVxzzsGOpChqYPu96h4wvGm0ZBi3GN5RqiPU
         CJOjSdb+ThsJRYewEcR65LYrim+BaEzTQjIoXWbNjV0yaNGHgzvxrV73QAzPT76VEMik
         3jbW/gTbMhw8LuglDhFZPZrej8rNySHV6mUgRF/ZAMqPyZI8d0y8IJsxm/fBKE8W/hZQ
         mAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780060532; x=1780665332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gpuXxi7i/5t+I/g5icZzBea2HRtsO6XMTgF5cBNBQg=;
        b=d9hp4Po19c62QlcBrFjvfXajX+ils5YpQMjxE59dbcubwcGKdyM0DO8oT/r90AL2aW
         R81SMWt4tzfSVlkr1rJ0SUGUB5k5dbWqVQnhy/IavxSHnweG5nrMhZTwqs5UlglH3/yR
         5MLNwJ85JIsRE8BmJUBKkM9Z4Nf6/Oehk0WjHC9OQ04JNOmTJwFH//gxxKiO9Zsk2POT
         IGDS+UP0WG/zOwCjGp+NLPydKHa6z2znQSZ0pPI6TZQWftQCoe96lj7PNIsJ0L6s3hxH
         jH/Oz2lyaJoSgjt58bTfIoXm5FgRm4foYz6WeAiltBEp0x9GoF6VvDI85tTK3UAIfUuj
         bWsA==
X-Gm-Message-State: AOJu0YxlWVmHmEfdEysRgWxJebqUcRAWE49SgbHiLPkh3huAX/d2+/Ke
	SCi4cQt63V3XpgPZCsnYAFbyosWL7Nzg+hqZB2Wg6N5eLnLeXDPmUNzt
X-Gm-Gg: Acq92OEedJe+pjXdopv8WBLo/hJhzeyimTrxvytiDSwM0o2qKLTxdeNNiAn2ivbr5vU
	Kg8eLQS+tdGtw3cRwpc+q8Cy/N2HS5BLPXdezvnbzlO3zWXvAHUZ9oAsz9TBy3YWh+IsqiTB6iI
	vvvZWfX5U6sUDNXFOH5AWRTRjgSLy8EK3rlSzR63SraPnI1iB3xnPpUlbq9CeRYt8vuaFAFk4WW
	OzD5JJajiSiMrUIbC0EOwQsUxAY79+EOnNsUC9dKTDvNATOmzikf6EmCdy38Ye07OhE1a1gjQsW
	0YCZKqNg25dz3nGObg5hjH1RywuV+3QCrCf6IvOH0qpDNQcraGoLEUXRbfa6a1jigcnxFN1lqaa
	JByKJXexMrjhbdCMdUJhpbgWYRY/7Z/qlAKiIWbN7+ORX0p1vwfOfAlymOuJH8t84/YeCJXa3BX
	W2pk40PLcZVhj79TTKdPhQCQJ+Qx3Isz8=
X-Received: by 2002:a05:6830:6081:b0:7dd:9b19:a87b with SMTP id 46e09a7af769-7e694c20e6dmr1950613a34.4.1780060532432;
        Fri, 29 May 2026 06:15:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d918cfsm1427015a34.26.2026.05.29.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:15:32 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 29 May 2026 06:15:28 -0700
Subject: [PATCH net v2 2/2] netdevsim: psp: use atomic64 for psp stats
 counters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-fix-psp-stats-v2-2-3a194eacf18e@gmail.com>
References: <20260529-fix-psp-stats-v2-0-3a194eacf18e@gmail.com>
In-Reply-To: <20260529-fix-psp-stats-v2-0-3a194eacf18e@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293119-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 06875602C1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing u64_stats_t-based psp counters had two preexisting api
usage bugs: u64_stats_init() was never called on the syncp object, and
the writer side of the u64_stats_update_begin()/end() api was not
serialized. Switch the counters to atomic64_t instead. Atomics need
no initialization and are inherently safe against concurrent writers,
eliminating both bugs at once.

Use atomic64_t rather than atomic_long_t so byte counters don't wrap
at 4 GiB on 32-bit builds.

Fixes: 178f0763c5f3 ("netdevsim: implement psp device stats")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h | 10 ++++------
 drivers/net/netdevsim/psp.c       | 24 ++++++++----------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d909c4160ea1..4c9cc96dcec3 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -22,7 +22,6 @@
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/ptp_mock.h>
-#include <linux/u64_stats_sync.h>
 #include <net/devlink.h>
 #include <net/udp_tunnel.h>
 #include <net/xdp.h>
@@ -115,11 +114,10 @@ struct netdevsim {
 	int rq_reset_mode;
 
 	struct {
-		u64_stats_t rx_packets;
-		u64_stats_t rx_bytes;
-		u64_stats_t tx_packets;
-		u64_stats_t tx_bytes;
-		struct u64_stats_sync syncp;
+		atomic64_t rx_packets;
+		atomic64_t rx_bytes;
+		atomic64_t tx_packets;
+		atomic64_t tx_bytes;
 		struct psp_dev __rcu *dev;
 		struct dentry *rereg;
 		struct mutex rereg_lock;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index afe58b21041a..1c415b3d6f1a 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -50,10 +50,8 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	}
 
 	psp_len = skb->len - skb_inner_transport_offset(skb);
-	u64_stats_update_begin(&ns->psp.syncp);
-	u64_stats_inc(&ns->psp.tx_packets);
-	u64_stats_add(&ns->psp.tx_bytes, psp_len);
-	u64_stats_update_end(&ns->psp.syncp);
+	atomic64_inc(&ns->psp.tx_packets);
+	atomic64_add(psp_len, &ns->psp.tx_bytes);
 
 	/* Now pretend we just received this frame */
 	peer_psd = rcu_dereference(peer_ns->psp.dev);
@@ -79,10 +77,8 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		refcount_inc(&(*psp_ext)->refcnt);
 		skb->decrypted = 1;
 
-		u64_stats_update_begin(&peer_ns->psp.syncp);
-		u64_stats_inc(&peer_ns->psp.rx_packets);
-		u64_stats_add(&peer_ns->psp.rx_bytes, psp_len);
-		u64_stats_update_end(&peer_ns->psp.syncp);
+		atomic64_inc(&peer_ns->psp.rx_packets);
+		atomic64_add(psp_len, &peer_ns->psp.rx_bytes);
 	} else {
 		struct ipv6hdr *ip6h __maybe_unused;
 		struct iphdr *iph;
@@ -180,20 +176,16 @@ static void nsim_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
 {
 	struct netdevsim *ns = psd->drv_priv;
-	unsigned int start;
 
 	/* WARNING: do *not* blindly zero stats in real drivers!
 	 * All required stats must be reported by the device!
 	 */
 	memset(stats, 0, sizeof(struct psp_dev_stats));
 
-	do {
-		start = u64_stats_fetch_begin(&ns->psp.syncp);
-		stats->rx_bytes = u64_stats_read(&ns->psp.rx_bytes);
-		stats->rx_packets = u64_stats_read(&ns->psp.rx_packets);
-		stats->tx_bytes = u64_stats_read(&ns->psp.tx_bytes);
-		stats->tx_packets = u64_stats_read(&ns->psp.tx_packets);
-	} while (u64_stats_fetch_retry(&ns->psp.syncp, start));
+	stats->rx_bytes = atomic64_read(&ns->psp.rx_bytes);
+	stats->rx_packets = atomic64_read(&ns->psp.rx_packets);
+	stats->tx_bytes = atomic64_read(&ns->psp.tx_bytes);
+	stats->tx_packets = atomic64_read(&ns->psp.tx_packets);
 }
 
 static struct psp_dev_ops nsim_psp_ops = {

-- 
2.52.0


