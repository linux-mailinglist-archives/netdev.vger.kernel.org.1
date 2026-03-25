Return-Path: <netdev+bounces-271412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHvnH8KDw2kPrQQAu9opvQ
	(envelope-from <netdev+bounces-271412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:42:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94D320446
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334D73033A8E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FC535B644;
	Wed, 25 Mar 2026 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCbQr+//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD535AC11
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420737; cv=none; b=paPbwUzrVsUi/sZiaiodqgzT9vNd6LFnBb5vnsH2DdOhqwqSgAvZNuwHzTUD5C21Cvv9vHcAED9gkziSlAjagT9CxfSnH0NpTKUU45uOr5kC4qL93J0L51iqSpu7hOUXs7WSjeoJ6QKBWttEFPvQm0CiKtmKLIb6HgCeu1Ul+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420737; c=relaxed/simple;
	bh=VIlhogVXZhEGBZnMLXlhILBNvpfmY3ha555h72D4CQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cKgh5aDqcZK61ST4hT2bu19F8nPsvRqfK+1KGvQIOnLlRbztcVZ8/vXzhGW8sa6za9m0oWLGuXtiz7sA12vFydS2Fmw/Pzn+2n8Kbh0jBl5TTQqLb6xFSmdLXMnRfXqnRqJ9F8stYvDJ7sMPpEPzGX8LdTkNGW/GI/0dsfNy9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCbQr+//; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3594620fe97so42514391a91.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 23:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420735; x=1775025535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nL4L22a9Ck1NAZ8TRhufw+BZmJs95X+mOcKWTHsxd3s=;
        b=NCbQr+//g4mcMUrsM8FwMmygQU3i69ieX1PZ/I6gf1WqGcXPiGm3t4mAgtlyMssanL
         VD3uN91avA9rIwEHezwZ2JS9h7WV8WnAQcAD45ERSsX9i3k08se9dvAuZimp4j5rgzSh
         5+DpGgoGBFIeLJiuykySOaZ+5rINVzqzwBH3D3OlJB5zJZpIEs/YCJDxSN+6k5sMRFqa
         KW/0itWrIZHQkrSegvDNYOvqjDOInKhSjMzmgQ0Gx11/APdaU+whDuGeUC2E+B4vbCqj
         ni4UL82OXavrwXiMLEyi+YOk0Vz6BktEaoceMtycJDzuwYzY94bCm4k3HI/XZZbjEfHP
         OiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420735; x=1775025535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nL4L22a9Ck1NAZ8TRhufw+BZmJs95X+mOcKWTHsxd3s=;
        b=eOQJTR2uAidCOchSeoHiwCkdCEReGoxIabvvQo10GESAquQNPL1sYi2iV7GZR/kYih
         agRT2WeV+qY/4NKBWKJuJQ7U9srPPWVVU6zRj3r94JOuYTnM12hAo2usoiuDRd/rfkxo
         54/EYyqMrcc+wfpCLvtcTK56u1ACthqeo4192BMyODYb1w4ZmChybzkzLitFgk6zIfXm
         SV7cEgc9xHv65d9i/Q3oThOvsX8OBQRIn48PAJpe5a82x9Yx3zMbyMrMUZ2IJmQIQ3bx
         i/Z9oJo/ZmWHRnuGU+5OYZUUkRFW2N0aF5AfeMrfnFQ/HV0qJyDX+NFto7LtlmgZ4g2t
         X9WA==
X-Forwarded-Encrypted: i=1; AJvYcCXLqyEe4r1WleLtpIYtlULhdAjRlkUmgFuIJHyBFMJkquNesqea8QZ8rqWKpJlaV7nO0vpBPLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcxbJ4+M7QjT7hzCbl/0xbnCMXMMKMt53I5L3LC0zynCLrYAo
	srrfOzfT1QTi5v1Xo29O7yhIm+xdM4/veZ0V1pKA7aK7fwVCQmkaiFsvrIPNf00Snzrg1s6VuRO
	ZiOFo4g==
X-Received: from pglu12.prod.google.com ([2002:a63:140c:0:b0:c76:3cb2:929c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:958e:b0:39c:1f90:2867
 with SMTP id adf61e73a8af0-39c4ae9f50bmr2735620637.59.1774420735355; Tue, 24
 Mar 2026 23:38:55 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:23 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-3-kuniyu@google.com>
Subject: [PATCH 2/5] nbd: Reject unconnected sockets in nbd_get_socket().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271412-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,other.debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB94D320446
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NBD requires a handshake, so passing unconnected or half-closed
sockets to NBD does not make sense.

Let's accept TCP_ESTABLISHED sockets only.

Note that AF_UNIX sockets remain in TCP_ESTABLISHED once connect()ed
regardless of shutdown(), but this is a prep patch for TCP, allowing
a subsequent patch to call tcp_sendmsg_locked() directly without extra
setup (e.g. inet_send_prepare()).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/block/nbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fc714cba1f23..1877554d362e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1228,6 +1228,13 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 		return NULL;
 	}
 
+	if (READ_ONCE(sock->sk->sk_state) != TCP_ESTABLISHED) {
+		dev_err(disk_to_dev(nbd->disk), "Socket does not have bi-directional stream.\n");
+		*err = -EPIPE;
+		sockfd_put(sock);
+		return NULL;
+	}
+
 	return sock;
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog


