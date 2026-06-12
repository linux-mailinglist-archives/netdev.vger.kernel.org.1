Return-Path: <netdev+bounces-298453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WtlBAsaQK2pL/wMAu9opvQ
	(envelope-from <netdev+bounces-298453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:53:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 554AE676AA7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:53:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S7YWVGi2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298453-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298453-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 785803146553
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752C8392C32;
	Fri, 12 Jun 2026 04:52:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC12580F2
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:52:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239958; cv=none; b=qMA0u7i+L0HpnAkx65Mkn2lrOfhPFksHqJCPGR071Q2Irk9tmhljscemKR63Vfh1MYkm7YfjnCX3aBI/jP3DVj3k2yjnfTEoqVEEJEA7OxPE7+w473gfdPbdAJBmgHfgtmcxnBfl0tuJHqIPFbpgI6MdFB93xtc2kbHPgaFA5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239958; c=relaxed/simple;
	bh=Zb0aSc57rTv/0MGimrIJROiJKPq6Dg44hlFx/+0n818=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3FE62XM15mDkuMBJXf+39OD63rR+w8tu9R7VPtxMDd64nNM19zpwuPbP+QoEZ+LeoEpmkEw+H8X+yXdHeYsHBk8m3SFmUjt2DQrCGALebYCkj1SC8bYjdlN2/NCHaJs+hZFIinM335EHrbsapWmz2jH+8ARtUCYF+8+bHvHhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7YWVGi2; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so792151a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239956; x=1781844756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Osr7f8AtrbOqHr8+fTeznPttcaP3WhzGJN6RE+7tY1E=;
        b=S7YWVGi2Kge3DT4VzQgmeMh9d0t5Z3rlXSjTNbzyikRcIuIYbUM7U1xVGJB+U2340q
         ciW/j3IL9EJOnkFJh6bdxq+jRIhDu8gx5DsAcH2FRVxUm++ocK2CR0rgR5FRXwxNNbUw
         yl+51o8nWiu2Mk/HCZrjZznFys0MVvl5I8dToTf2KiJ5yWdXGBhheI3ZQfncNbQcmO3Q
         soVK963ERQkdZa7TdK4vElb3W9VLkqmlOsTmtY9Fb5f39+6lnxyvojWi5XlDVXCCs03C
         JbgwwQOHwc3vlmmqh1c/Oo7lUuMCe9/xrUcMgJ76BjDu+Qy7nLpQ2ONw0kksVes0o2pP
         QOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239956; x=1781844756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Osr7f8AtrbOqHr8+fTeznPttcaP3WhzGJN6RE+7tY1E=;
        b=IpzvWmVjPV+fjjfJySgQvB062lt8ZUEwJZ6YT04cXcpbm2GzTnAn06Gfx1h8Yw3WGd
         vDlt7JkxmNUqf+AURjQZZGmGaG3HcdQF6+BdP12GjXDz8kP9T+HJYNBGAvwwTrbZik2H
         2w2G6i5n4yFDF774NqkU9ejCJcus034rr0iMvZAB7AlJu965F3mPruWEOEeNEuKhYNe0
         G0rTxTGiVSR4DjJnFru4rcs2xOu6GBDwiqHg+azFS8wStgAM+z3UvHHBDcNp+50P8iDj
         tJn+kvNAHLDRNSTG3CECJI4eePvzTy3PnIjupzAhmY+Y3Z5SMFXx8z8+ojI3r8ki15ZQ
         yAtg==
X-Gm-Message-State: AOJu0YxmvhP0Vlem9CVkXkRWId0HqE/32kVxZ60xhjXl+r8gKP0LBW8z
	YOKaL0ToCEQb8PiJsD55OhEzvDlW2vUw5uGD9qAY82eiRBZfft301TNrULdLLLsTHw==
X-Gm-Gg: Acq92OH3kY/7hNTX123nJTJn+4JRwTkoJWTIVS8xPbcPac2k+UUCLCLXVRmqvdxzapX
	fHxDDLvxS6RC3NTrg40BkrUEeuSnZZU/THSX1n/xY0xpWalRZfmKIeDI5thU1t7Wra+ElMfCycA
	NdchaPx2+y4LRtMdnSnEhgdVI/EbPe7bNg5idJJUfU88u/rT9GhVBc5p/9rZdFjCnWbgFf+VbaG
	I3ZNsFAr7cDcDn4qKn7SdaI3kCYnK6P98IeFnTfWr2jmHTNe0sCLAoIkvLffr0QidIj0tPEkl6B
	FLfSsiu+Y5N3gdhZMVFTXESqLe0zBfvwK8HTYZafAD04ZIjdlREBQisR8v1pNzQElwqe0R76Q02
	G9g35M97lpYWzgJlg2S9DH+ZUgDAG+3rH9Bz+2a4vUIxutEccOaZ/IsYLkWF7DSfd9qRTlYMbLN
	i41zCxKTo+zqT+CbL3yNbtvLmqSQEdZVyqO+s76Jkg3trteZ6oEPH96lbRvlJ6T87uCjE=
X-Received: by 2002:a05:6300:218e:b0:3b5:68ae:1ac8 with SMTP id adf61e73a8af0-3b7816add46mr1662547637.34.1781239956504;
        Thu, 11 Jun 2026 21:52:36 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:36 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v3 1/4] vsock: introduce vsock_pending_to_accept() helper
Date: Fri, 12 Jun 2026 04:52:13 +0000
Message-ID: <20260612045216.105796-2-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612045216.105796-1-rafdog35@gmail.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298453-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:rafdog35@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 554AE676AA7

Add vsock_pending_to_accept() to move a socket directly from the
pending list to the accept queue in a single operation, avoiding
the sock_put/sock_hold dance and the sk_acceptq_removed()/
sk_acceptq_added() pair that would otherwise be needed when
calling vsock_remove_pending() followed by vsock_enqueue_accept().

Use it in vmci_transport_recv_connecting_server() where a completed
handshake transitions the socket from pending to accept queue.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 include/net/af_vsock.h         |  1 +
 net/vmw_vsock/af_vsock.c       | 10 ++++++++++
 net/vmw_vsock/vmci_transport.c |  3 +--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 4e40063ada..30046a3c20 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -220,6 +220,7 @@ static inline bool __vsock_in_connected_table(struct vsock_sock *vsk)
 void vsock_add_pending(struct sock *listener, struct sock *pending);
 void vsock_remove_pending(struct sock *listener, struct sock *pending);
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
+void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
 void vsock_insert_connected(struct vsock_sock *vsk);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2ce1063d4a..1f94f0d44c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -496,6 +496,16 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_pending);
 
+void vsock_pending_to_accept(struct sock *listener, struct sock *pending)
+{
+	struct vsock_sock *vpending = vsock_sk(pending);
+	struct vsock_sock *vlistener = vsock_sk(listener);
+
+	list_del_init(&vpending->pending_links);
+	list_add_tail(&vpending->accept_queue, &vlistener->accept_queue);
+}
+EXPORT_SYMBOL_GPL(vsock_pending_to_accept);
+
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 {
 	struct vsock_sock *vlistener;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 91516488a7..635ebf9da4 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1258,8 +1258,7 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 	 * listener's pending list to the accept queue so callers of accept()
 	 * can find it.
 	 */
-	vsock_remove_pending(listener, pending);
-	vsock_enqueue_accept(listener, pending);
+	vsock_pending_to_accept(listener, pending);
 
 	/* Callers of accept() will be waiting on the listening socket, not
 	 * the pending socket.
-- 
2.54.0


