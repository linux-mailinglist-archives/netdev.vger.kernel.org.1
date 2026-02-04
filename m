Return-Path: <netdev+bounces-256736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fd9Hqxmg2nQmQMAu9opvQ
	(envelope-from <netdev+bounces-256736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:33:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19680E8D69
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2E2230829A6
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF3425CDD;
	Wed,  4 Feb 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MonT7iid"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3A425CD7
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218412; cv=none; b=gmeNshVxBkhmoR1uyJJRGL8eoazOnWfucEBTM6DiONvgfeF8oD5q9cIdAst9F66QhNxDpSj+7AraXXOp7Kv8t8Osb+WpCF1rdq3Ee4JFnlUQ8phuLYBQYrfH2Aii/jI7AY0/T4b/wbwloufcL40NDjbySjLDeAVqauZPV5BWu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218412; c=relaxed/simple;
	bh=IXDSeUC5+cRE+OVG0Hf9hg9EzYy+I7cAflVjxV9P+y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUlGBKxsr8HnE5eJRygK0qjki3janfAtO5V2g3uQSxKM+TcvHnPQdJO0knhkJXGQxg1/oqRiupV4JJIOT/5wgZmM0LcKuU7I+LofI4rpYP0cdNq65v/4HAlbemYXltq6/HdZkt7TMhzoqmuFAOD99xKXHgpIF1/hEePw+/yVGyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MonT7iid; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-649df393c04so669244d50.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218412; x=1770823212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS1GcH9E1CFOhJ9v6nYx4QtLIVjiKCkp4B8BLqgjvqE=;
        b=MonT7iidHBkKtkUYBxSbkZgl5HBkdQDtweR3E45Ss8HN4z53NWJH04WV/MNoOAJNwu
         eqt0ju6RpaHPY15eR9KhHvQ2eSKLsyzqWa77iny+rLgqeZ4SnwTu/0cNWPQjYXbQJlPe
         68Lb4Pl++dGGzF2E84Eyf3wdDQ6Nid9x5q3ntU7DI/T56HGhcbtdNpi2RquuGWiCuilR
         wFDuqKKVXVVXi8fKelIjaaBu8aKIXYK2rE4yE7vpJrqF/3XNvdx22eXFZ9YC2BFG+2p0
         Qv3Vs9EIRg/QTRi9oK4ovYy9KFYi5V6RAB1BDL4bRwhK4b3SW7Vvmem64yc7p6zUKXT6
         P1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218412; x=1770823212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AS1GcH9E1CFOhJ9v6nYx4QtLIVjiKCkp4B8BLqgjvqE=;
        b=YswKVVkAQ41Uxg8CxKWkOwj2b3TqYKgq1h6Se1qi+uo4SP7nldtp1i1Fc/KiDH3xlX
         3mIujdCY4jsVb9wm/15kLW+6eAMRS7CF1tZ0MBZJIrNbZP8QUDxGAk645T39BFCdjFuD
         6AhK1FS46QJSOAGVymK131snjEgfZ8ruFGpqQnl2y+zQrw4ILigjBtOAyq5xho6JVelz
         BnNpOaSJAAHVWju5kGHYvN3D2SU29OkTdRHQnCPbPg7sM/mJwI0itUTDaNwXZ5njaSw0
         LF8ewAK0fCuevQftLonT6BSA1vxQmBTeyVe1GPe9SmNzwNLKlckOGyJ+1ufihVGrDRhO
         jH+g==
X-Gm-Message-State: AOJu0Yw4ZZt+BfQG7jh0tEcphBlVx4PsHintAeYmDGvJCz2rIGNsdyRa
	H0JAhNpNgtsgJtZqqYmDOjtgySBS7HGy02oiUo0UbdkalTYJuxirCzHr
X-Gm-Gg: AZuq6aIS56RKTyQNh8aEac6oHbLdx77VRGnYVBk5Ytl8YVMqqwncqpDlGosHXV9gGVv
	ws18q9HE+uzRdtrIwszTntN+DKC7EfnkNVBDP4ZP2wi6nB3WPCzAUuAa91G5wYfWmiBO9oQwmBp
	LZIpbH8W2EKmKMzLzEjptl9hgjiggA3177LHBWS5bL9INWbshmNYehc3iu8XmcjBttiZwHhrfci
	r3vfp+QBuLn4DCoq9w+3zXQP3VHL7XrTCa0+SEJcg8wxbt1USRGNB0/pi86ejiqWFmt3PKwZaKu
	Ya51fx4Syb4u+c0Q4Kw2Z/V2CQqj2LZMBcrGxKbdd9yEhhxVw7JaSIOMGHnSqx9sUysLJ6R/SSF
	/eXS77KdoGdrCqBy0pnqKT7P4E3xggks3lswAq7zbSgnIr0pIotZywmjmWaxMYifBxOKkM1zwlc
	wps3gNyKa8
X-Received: by 2002:a05:690e:408d:b0:644:71e8:cd02 with SMTP id 956f58d0204a3-649db32ce54mr2737934d50.4.1770218411558;
        Wed, 04 Feb 2026 07:20:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc5ad347sm2601094d50.16.2026.02.04.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:11 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:07 -0800
Subject: [PATCH net-next 3/9] psp: support tx rekey operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-3-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256736-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19680E8D69
X-Rspamd-Action: no action

The tx rekey operation creates a new psp_assoc with the same rx state,
but with new tx state. The new psp_assoc will reference the current
assocs 'prev' assoc as its own. The assoc referenced by
'sk->psp_assoc' will have its reference dropped and be freed.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/psp/psp_sock.c | 51 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 9b0ecce8350f..f429b8b2d8f2 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -215,6 +215,47 @@ psp_pas_set_tx_key(struct psp_dev *psd, struct psp_assoc *pas,
 	return rc;
 }
 
+static int
+psp_sock_tx_rekey(struct sock *sk, struct psp_dev *psd, struct psp_assoc *pas,
+		  struct psp_key_parsed *key, struct netlink_ext_ack *extack)
+{
+	struct psp_assoc *new;
+	size_t pas_sz;
+	int err;
+
+	pas_sz = struct_size(new, drv_data, psd->caps->assoc_drv_spc);
+	new = kzalloc(pas_sz, GFP_KERNEL_ACCOUNT);
+	if (!new)
+		return -ENOMEM;
+
+	/* don't increase refcounts until we know we won't fail */
+	new->psd         = pas->psd;
+	new->dev_id      = pas->dev_id;
+	new->generation  = pas->generation;
+	new->version     = pas->version;
+	new->peer_tx     = pas->peer_tx;
+	new->upgrade_seq = pas->upgrade_seq;
+	new->prev        = pas->prev;
+	refcount_set(&new->refcnt, 1);
+	memcpy(&new->rx, &pas->rx, sizeof(new->rx));
+
+	err = psp_pas_set_tx_key(psd, new, key, extack);
+	if (err) {
+		kfree(new);
+		return err;
+	}
+
+	psp_dev_get(new->psd);
+	if (new->prev)
+		refcount_inc(&new->prev->refcnt);
+	list_add_tail(&new->assocs_list, &psd->active_assocs);
+
+	rcu_assign_pointer(sk->psp_assoc, new);
+	psp_assoc_put(pas);
+
+	return 0;
+}
+
 static int
 psp_sock_set_tx_key(struct sock *sk, struct psp_dev *psd, struct psp_assoc *pas,
 		    struct psp_key_parsed *key, struct netlink_ext_ack *extack)
@@ -269,13 +310,11 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 		err = -EINVAL;
 		goto exit_unlock;
 	}
-	if (pas->tx.spi) {
-		NL_SET_ERR_MSG(extack, "Tx key already set");
-		err = -EBUSY;
-		goto exit_unlock;
-	}
+	if (pas->tx.spi)
+		err = psp_sock_tx_rekey(sk, psd, pas, key, extack);
+	else
+		err = psp_sock_set_tx_key(sk, psd, pas, key, extack);
 
-	err = psp_sock_set_tx_key(sk, psd, pas, key, extack);
 exit_unlock:
 	release_sock(sk);
 	return err;

-- 
2.47.3


