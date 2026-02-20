Return-Path: <netdev+bounces-259692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN8+ER4smGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:40:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57B166568
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7504D3014419
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641B322A0A;
	Fri, 20 Feb 2026 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2rTdOSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C5A3242A4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580442; cv=none; b=PKMGJZ63fBQ00W6a4jpXgHogi1C/XqibN1/kHIXzGeI2y70rDE2XGJHwhUgoj2eIKRDnnqUI5EV6boxMAZ4nWZ5fPUuqwScVUwrmlHTyb/ManHwKMCGVGOhmDffvJbjBMPZmKmOUv6fy1jcR54Y6ZojC1dzWXf0quHoaEM7flm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580442; c=relaxed/simple;
	bh=RcHwi6NMTnEnGhbPhxKfgO4Rhk0dr/HBdje2gy8ECb8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OJP7U+CeITl+KYscslahhMcnpAjYnk8ZYooJwYpeUT/3bgnSHH0TCtyhl2UbX+jw+SVcXBZsAjPzqvQwQEGNURqgwF05DTpjkeAnFg1YRGgvXhaVlR2eJWIvVoWoL6nUiSWAJAeS0KpYfFqTsxLLsI9w6BYBAWjWYXyIi4cNgvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2rTdOSJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7a23f5915so10738245ad.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771580440; x=1772185240; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YMHxvG1SjZtPqMa9iQmMXbxbj1JNPzcKUqfP001EPo=;
        b=k2rTdOSJQN7xl7Y7cHfTvoVs9+s6gE0G7LlQdb50ckYgkpiwfH3yiiCP5lA+qQTGGe
         QRA7W2AWkp7OSGWWJvVkU72jd6mYyARLvY4LornIfg4yTeUHDePQr+hHrc1nuaCCQbSp
         /nH/LUHYbX7X2UbJeydPQu8QziNOV8xp4mKazwQCYSy3jfgfXCqYGV1u8NQM5ftS4UOi
         bnXQIg0AWnrwakli4XzlVn7idqvd04INJf2nMULDKceFEZME2P1+Wmofibj9O/cR6pSp
         b4n7DFu2iEr5GApeYXUo1EOf4HxbOp/NXMwZ4vobaWnxaEx4R31vYR+zCv2+exSUkbs2
         yY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771580440; x=1772185240;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YMHxvG1SjZtPqMa9iQmMXbxbj1JNPzcKUqfP001EPo=;
        b=oHVc6ORRLIkflf3pe431c6ZxoJXqRaj3HiUbMgvfwAmrpQmoTofUM++2Rdxj42n1Y1
         YcILa0TQNTo1FmzaEav5CmnO4SpBMGQvrGTjv7HJ58BnP2h6QmNXmTKcfpA+YhDWbYTR
         tSJLQ2GLwpdMekKshblY1vEAHa5HVPBJ4B1dfuvDGJqbjC1POR1u0dbX6WzZ1CHYN2fE
         jmBkJokvnWag5FgVRjvOAsJeVd2NSQ7nftQ5EjOCsH0vHQmwT5EUlMv12dd/MXQ4Jbpr
         Rv+VMc7Xgcrx7mj9TkIXiQ3qhZbmUOXFmz4DQlpP0e6DzywaxTETDmT8GqdJFcSD7iBC
         xBTw==
X-Gm-Message-State: AOJu0YzOOZkKAadaDqwFkjQLHyLKht11hCrCR14TY+uozkJvLxti+ozp
	X8tVHMFfS93/mmlFOwNSm2NkvhU2Gc89EiCXt0h8zLKkGD4L7Q096iE1
X-Gm-Gg: AZuq6aIkOiof87oCD5zTWREXutrnjfsBpmV3UL9ukieleTfokQIWHxtXijnrS215Yab
	lGx3NShachubOZ0WEZDE0YmKzUpDoKr4CnvaWC3VPA78KSyf9mlYIUMGCAJ5DH1pFP17c+8gRPn
	YhLzF0mUQsi5esViOXlLp6ZQ1OLCTCw1Mmba9rKuI09LG4AoCqNkhtEwheQIAkLw3RXjKwsYMm6
	t1f6x0jOqF5VJmFSd7Y9PU3OZy6qqPFs1PKXsadq53mHuCYKoYw3HER5eSDA3Gl6ekyGdGSTAO8
	e9dQOjHBLrqYePNnQoabbGdH9VRMEsQ1LNN49qoBJknXJMWxtUtDtElTmHOh+dK0NWjRRC5I4bC
	gNxGurl+jO5x4FoSHq6wiGUsGXcm9zKlKWgzosHOkwKfIPP0YLC/8dyJhy+ia8TbmFdYRaM7xem
	z9J8KBoeyC7T3g29lXDOP4ruFV4MLSKB8kQnY4/uoSqA==
X-Received: by 2002:a17:902:ec8b:b0:2aa:f0d6:bf3f with SMTP id d9443c01a7336-2ad5aed41e6mr50588585ad.1.1771580440330;
        Fri, 20 Feb 2026 01:40:40 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6f9df1sm170076585ad.10.2026.02.20.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:40:39 -0800 (PST)
Date: Fri, 20 Feb 2026 18:40:36 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] tls: Fix race condition in tls_sw_cancel_work_tx()
Message-ID: <aZgsFO6nfylfvLE7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259692-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D57B166568
X-Rspamd-Action: no action

This issue was discovered during a code audit.

After cancel_delayed_work_sync() is called from tls_sk_proto_close(), 
tx_work_handler() can still be scheduled from paths such as the 
Delayed ACK handler or ksoftirqd.
As a result, the tx_work_handler() worker may dereference a freed 
TLS object.

The following is a simple race scenario:

          cpu0                         cpu1

tls_sk_proto_close()
  tls_sw_cancel_work_tx()
                                 tls_write_space()
                                   tls_sw_write_space()
                                     if (!test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
    set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
    cancel_delayed_work_sync(&ctx->tx_work.work);
                                     schedule_delayed_work(&tx_ctx->tx_work.work, 0);

To prevent this race condition, cancel_delayed_work_sync() is 
replaced with disable_delayed_work_sync().

Fixes: f87e62d45e51 ("net/tls: remove close callback sock unlock/lock around TX work flush")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Shorten the patch subject
- Target the net tree
- Add the bug discovery background and the race scenario to the commit message
- v1: https://lore.kernel.org/all/aZLotq3aZY0b-dI8@v4bel/
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..b1fa62de9dab 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2533,7 +2533,7 @@ void tls_sw_cancel_work_tx(struct tls_context *tls_ctx)
 
 	set_bit(BIT_TX_CLOSING, &ctx->tx_bitmask);
 	set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
-	cancel_delayed_work_sync(&ctx->tx_work.work);
+	disable_delayed_work_sync(&ctx->tx_work.work);
 }
 
 void tls_sw_release_resources_tx(struct sock *sk)
-- 
2.43.0


