Return-Path: <netdev+bounces-281642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGxMNT1F8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB047D8EF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECB2306966A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0ED324B31;
	Tue, 28 Apr 2026 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b="CAKoDJv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86B2F39C2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353819; cv=pass; b=G3JjZIozy47F3m2xCWnDWwOeyjFezqNHh2RSCUfJeOMfxBwCAH9pX7e9N/oFl5XX1ppAIeeHQuipW9xBgwY9JQHP3uT+ct7a+RSx/a/Xzm7ah2B8vHqrC0Cthgo83yC8fnB7B2ooJvhYMgiSpRs1st5VWJx4XjLVRJmChuIerHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353819; c=relaxed/simple;
	bh=uajCEi49W2h0HvEuTqtnXBGCBBSENxiSGia3jyoNuCg=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=dpUusL9xG9FMbPPwgJWcrfuWEjUXwr6sdgRbG2V9oeGKIyeym9BPKchWkg6G31SLshWlgJ8Ba8x+Ls0Njvh9UHRYWAGCGclH9+3XmKYxlK/3W3L7PSM9wWonPfHl0uFVD7Ry07IzaZnNf964Mc90oAt9qm5iQZ4EX3No1DUJQPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b=CAKoDJv+; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56f72d27e7eso10074942e0c.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777353815; cv=none;
        d=google.com; s=arc-20240605;
        b=LKr0tV15izuVlbR1PWkvhMLgb9qXjc/kSvb8piEOqk9ODq9RJfJAm8mI12GWwH7Ido
         DcvCshEdJQMkVpbxz1uPxZ7ddt8mO+/8JCKWZRhztkl51VoUgL4Uz8p+OqJsbQMNAvfH
         T2OhZcvpwRB2VS9BkfBKVSYo/V14KUACjqSaACeNcKpYv0wjovkecY/HiRzSBpTe57CF
         TYaDn0Pn8SrPhLTxV++vuG+nB/3LmIbrNebbKJ/oa3DH7KciV2fE1OUJ2acWO23+m33u
         0BUQTWRKt6lF72Z4TqwG8VHUqfa+L56gqs35qPPlSHNRVJa7FEPwLCssyT+PzQN06s9T
         zERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=qv9GGMzP087RibmUlugnFmVc/vUOGPhG1CWzpjoEmjk=;
        fh=n5o73Ao9bYK01CZd698aS12kaMs4gS0V2lVzY7Ebm6A=;
        b=ZyEl6v3ZtZGKl6y/yhAKqc4LjpsbwOgJ9rA6soa0GAmvH5TafZvKriGgcjbHtqyOv0
         WvFh+na8hP+574Z4XN9fMjR8fCokWcAYT4QrZllu/zbqUZCLeKOMGsZddMI4mpK9PXi7
         z2y4Dyr9QMR53Huj6edxyuITj3zti4Bte6oJIFVWpZXBSzu9TOyYzPulndywD2rGnnL2
         b7u3VCyAREMis2J3+Z20jdsDCtsJb2/R2F1xY2b7GJu43XogwsZq/J28J0wvK6HwU2Zj
         wqgvTsZjnKg3g1Nf5iGBh5LWszakYZHN4Tac1yZZp4t+kjLnujc3qgsJzz1TvJ8mxt8/
         33tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20251104.gappssmtp.com; s=20251104; t=1777353815; x=1777958615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qv9GGMzP087RibmUlugnFmVc/vUOGPhG1CWzpjoEmjk=;
        b=CAKoDJv+lczM/xjMp9ntPyTsPnytxGD9ds4/OjcEyZkx0k3BdAqgybK7bmlGpOX2Uo
         otqF7NyG7KWR+pUYwnq+WPkf99IsFQV0F4c3GOkFnSxIRMgE5+TUsdYyPXDwux39BUjI
         RFskbh/54Ba+oxGtmE+lD1UFetHPd4e0rkCDYHXyuSIO0B6Luu8Cs07rQqHtemm1J3MU
         ku+B/CrOwbk8yLEOvtFtaMmrep/uYzVAXY1IiZCBIiG6b03zzDNsZf9cUZTYlsNVNcZa
         5eIiw8H89kCa7UlhNWXsstp6DVigvriKnENYuKoDrF907uvyCgInQEojUjMCKhmb0HAB
         bN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777353815; x=1777958615;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qv9GGMzP087RibmUlugnFmVc/vUOGPhG1CWzpjoEmjk=;
        b=JJfAw06+DejOMWmTrU6/li+uE8Xdf6Au+DKOD4+t1fXDFbcaE7wsMOp2S4/KOuvDrK
         Mm9hz1mTTNa1SwJVPb9JnMsTRn3wsjdcc+iWIoFndW5htkx5y01AbreUOjvJPowesvPv
         5FMO4yW+MLc1yCydT1j1s+zL/rR6M0rNXw+ArkknijjbT524NXYk00eL7n/yCkff3+/K
         7WR6B5udNpJRuShmpC2oKaUMEjYi6tlGnxA1q2EecqDFr/mgK+nJu2aO3R2mxIvULb3s
         ycK3Iq42j67nSoZmajgegu3IP35HTxW2iCGpPhMWtH3GUgZ/NzM+0E7xgDD6k709Vwqg
         MM1w==
X-Gm-Message-State: AOJu0YzHYeinzSO06cpu91h3n0UyyaiF8x31ZnT+ElomIwUFN5lNG1dG
	7N1e47JigoiLLfe22i/RA6zJ3ctHX8z9JFVJncuxYA8wgjeOUq5v79GSYzQBSMCX6I2KKn2RiuN
	vfTE2f+WYP4+fkXjI0HN5xYnFhQIIeKH0AU7bF5Ao5uVFUexFi0Q=
X-Gm-Gg: AeBDiev8gBuW0+HbTLdsMzZw6kXdIL4h/8WlNIW9mFz+T64COgmF+B8nSuw8KW6Qd01
	Sehvb6azLBotv5zjty6zHLYQt+KtlxDWLe0nf66etfMgY/3vrUFYL8uuUauyaMc3fKS3wFZbMaB
	z83CI+vM5z0p/QDteV7PqBs3lSUVyRfBnWQKEnAXBtGnRIinE+RIxsH1CY1+/+CY2xjL5dT1vno
	NlTrPm4/2ZOaOLxBrEmH603F8YWb0D71bMIUpeBXQFs/ksRxANFdhpY9wsXXgwfYTjO/s72p69Z
	2cOWBFxmuzwuhxLbGw==
X-Received: by 2002:a05:6102:f83:b0:5fd:eacf:27df with SMTP id
 ada2fe7eead31-6280720b3f6mr501659137.10.1777353815543; Mon, 27 Apr 2026
 22:23:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 22:23:33 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 22:23:33 -0700
From: Petr Malat <oss@malat.biz>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Apr 2026 22:23:33 -0700
X-Gm-Features: AVHnY4JN5qqSjHJColGZxCF2Ql4mCiCtCmhkouhZmiKr2RG1FWucysWVZaWZoe4
Message-ID: <CANMuvJn15HHBrq8EEbhSfCk-Sn33WEEovRa-yVWF5huTKfoOYA@mail.gmail.com>
Subject: [PATCH] net: datagram: Drain queue before reporting EOF or ENOTCONN
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, ebiggers@google.com, 
	Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7FAB047D8EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[malat-biz.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[malat.biz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,malat-biz.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@malat.biz,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281642-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[malat-biz.20251104.gappssmtp.com:+]

If a packet is queued and RCV_SHUTDOWN flag is set after the function
__skb_wait_for_more_packets() checked the queue, the function returns
EOF, which is then propagated by __unix_dgram_recvmsg() and the user
reads EOF although there is a message or messages still pending.

The function should check if the queue is empty before returning EOF.
As the same is true for disconnect and it's also reasonable for a pending
signal, check in a common place before returning from the function.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 net/core/datagram.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465923..5952950f7233 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -98,40 +98,44 @@ int __skb_wait_for_more_packets(struct sock *sk,
struct sk_buff_head *queue,
 	/* Socket errors? */
 	error = sock_error(sk);
 	if (error)
-		goto out_err;
+		goto out;

 	if (READ_ONCE(queue->prev) != skb)
 		goto out;

 	/* Socket shut down? */
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
-		goto out_noerr;
+	if (sk->sk_shutdown & RCV_SHUTDOWN) {
+		error = 1;
+		goto check_queue;
+	}

 	/* Sequenced packets can come disconnected.
 	 * If so we report the problem
 	 */
-	error = -ENOTCONN;
 	if (connection_based(sk) &&
-	    !(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_LISTEN))
-		goto out_err;
+	    !(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_LISTEN)) {
+		error = -ENOTCONN;
+		goto check_queue;
+	}

 	/* handle signals */
-	if (signal_pending(current))
-		goto interrupted;
+	if (signal_pending(current)) {
+		error = sock_intr_errno(*timeo_p);
+		goto check_queue;
+	}

-	error = 0;
 	*timeo_p = schedule_timeout(*timeo_p);
 out:
+	*err = error < 0 ? error : 0;
 	finish_wait(sk_sleep(sk), &wait);
 	return error;
-interrupted:
-	error = sock_intr_errno(*timeo_p);
-out_err:
-	*err = error;
-	goto out;
-out_noerr:
-	*err = 0;
-	error = 1;
+check_queue:
+	/* A packet may have arrived between the initial queue check and any
+	 * of the early-exit conditions above.  Return 0 to let the caller
+	 * drain the queue before acting on the shutdown / disconnect / signal.
+	 */
+	if (READ_ONCE(queue->prev) != skb)
+		error = 0;
 	goto out;
 }
 EXPORT_SYMBOL(__skb_wait_for_more_packets);
-- 
2.47.3

