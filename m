Return-Path: <netdev+bounces-271424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPF3C1GNw2nJrQQAu9opvQ
	(envelope-from <netdev+bounces-271424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85894320A2C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ECCB300D6B3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0934EF02;
	Wed, 25 Mar 2026 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="suqmKmSK"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376130BB8A
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423165; cv=none; b=LPcOIiEw4g3X7tNzLFfU4js1iKvqf9ATnwSBUWY+Msdzh+mZY3xnZ+urbbH6N7HwE2pxheBkZdhowqLzRvNEx7UMUH1Az6Rz8qYo8nQBFLJbzzwk73lmi9NczJePPBFKt8p3EZFRUWXqnREAtCTxQV+KYz/goA0ZYgtl2KiAwHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423165; c=relaxed/simple;
	bh=lZmuEirQv3QRfdQe+UqC35+d83f2KXAp+wQkwFd+TbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F47OCdWoan2vVw+7aLBuIkgkf6+ijw6rdzOvF2dpWmVnXUOd8mg+yi51r2cQDLHVqzQAmbUOMY8d4ez3nYWCwg6n3LMYrmT3zjjluQFY3RGgiRNqEfwyO2E4Y/c/CavxByPXowOFFl8pJI6CNE6bRjvppSt/iU1bW7+nNArYV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=suqmKmSK; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774423159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BjO3QnN3llyMhOH1FHY0b9R3ld9Lnpdx375Y3nuaGOs=;
	b=suqmKmSKhLbit9lnXJ3s23T00w11HL7gp3LtCkteH8J9YDI/j8xowhwK90DRneWK9TNDJO
	RLlUkogdeE/FWLbWzF2N4MRklo8HR7b7nxBeJzSpl2S/iCb2MTTU9jPgr7lHFcoiOsmHNY
	2kmtj7Ng05G4LApGqVoU7ydBRSx2Zbo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	kernel test robot <lkp@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] tcp: Fix inconsistent indenting warning
Date: Wed, 25 Mar 2026 15:18:54 +0800
Message-ID: <20260325071854.805-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271424-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 85894320A2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Suppress such warning reported by test robot:
    include/net/tcp.h:1449 tcp_ca_event() warn: inconsistent indenting

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603251430.gQ3VuiKV-lkp@intel.com/
Fixes: d1e59a469737 ("tcp: add cwnd_event_tx_start to tcp_congestion_ops")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 39ff4cf3c810..565943c34b7e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1444,7 +1444,7 @@ static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (event == CA_EVENT_TX_START) {
-	    if (icsk->icsk_ca_ops->cwnd_event_tx_start)
+		if (icsk->icsk_ca_ops->cwnd_event_tx_start)
 			icsk->icsk_ca_ops->cwnd_event_tx_start(sk);
 		return;
 	}
-- 
2.43.0


