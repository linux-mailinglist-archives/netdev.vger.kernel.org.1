Return-Path: <netdev+bounces-258851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPTmBSTpkmlSzwEAu9opvQ
	(envelope-from <netdev+bounces-258851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:53:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B861421E6
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EF3D303AB4A
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B82F260E;
	Mon, 16 Feb 2026 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLcmOhQc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01832F0C76
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235516; cv=none; b=WMLhr9GShpkdCFrmZrMm13uO1jgA4RMoGck6y8ww1OcDYk3ydkcLf3rPNTjFPxRueU2OYPQw3wv3xri67zNvNrVcAAoNa9Z58o/cMPSztzAdLBodu7u6ja+BKcJ4SnTeso8yBJpq0O/pRAuTNYWdQuN1+J9zk+VuNTFPV1dBdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235516; c=relaxed/simple;
	bh=c1tONeWLndexREHnhvNJE8lcdbJdgra9xE477TBB+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I5IJ56bBu4taqnz3G0YZGgAsJMxX/bNA7cWPxTCIx3UjQ+N9aUjLYHeHChHNEz2Otw8McbU0sHgfqWL42/VMrRTVQ0uDfysPrA2Jas8kYLGPZweqdvZ7RlSgEIRncaz+SKPSa9sSmo5+Y32uh0sUR3ixMdfLzXO73PKQuZxECNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLcmOhQc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso2038517a91.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771235514; x=1771840314; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GafzzW88JeRD1FqpxjH3p2Ng1n+SZGzfP5Etdtebed0=;
        b=lLcmOhQcYsj20yCYP9KId2+HrhTnHGC+aLFAwnUnNTBojPuC6W2AM4mc5ZmyNxXTB3
         9T7iiqKp9RjACZnLyZkJfL4Ve+9J9UW13GhUCRuuGMVu8mG7bB/1+PFswzX3sHC2OynZ
         qj2/aCCeCA2evBsumY8Nv+hT0kviWT7c0G56R/6hjsEIxrOUpGTC8x1hFFqEXMxZYJe6
         wacLvXKkF+Z0V++WoIHE80CNegGj+N4G+jRlXIrMx6TS+kp+PbPxrwsDEVBP+nKtelYD
         Ghu6HXF+8Ei9eL/9gZS24x/pRBt7BBroicQ23ahh1QesH0joGfIjWjzdwSpGowa8x4pc
         J5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771235514; x=1771840314;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GafzzW88JeRD1FqpxjH3p2Ng1n+SZGzfP5Etdtebed0=;
        b=utRwIDZgl1CUih63dAR2IcNgiHL3YT74EL/yvXXvqvLTZXibJqCksdkhUn3AftRyN4
         GgDuf3pPVyMpXpULuaYav5t//vGQ3/pwdhrR/moYGEcBpQ94Ng1Qfa8DBgfL3I6aoj0F
         0DWhFCwLumYLFIjKyjVkqVZJ/wbN3wjlzIY+KjhaiMvC8ww02DtykAPDTmYXbS4eNjVW
         V2hmAOhcz/5nn/hI+OPGbNMpfAC1cyI49/5xsX/bP4mN53EQsCSCs/Z3ZaBFb8KUw53g
         YWNM+aPzAOoBq+EphDN8vlMVNco25Q/RVVoYtbf5mh8lPvkBk3yzJHlnKoDjXTr1jF1M
         toGg==
X-Forwarded-Encrypted: i=1; AJvYcCUew76/Pjd0S/OhFFHSp7egpdDxeMGNpajL9hEgZ6ZA20+YvY0Jvb3n083jK3ARP0TfGxBMiQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmi4KxfWUOkVcP4OpPdB5R/7YOH1w/TgFW0zxUemghLrJnmcF4
	XHe1iBYg06IJnQDyskvOqKaTUD8lIhESsJzJygrQJEMTrIG2RfwcVd4QN9RtwA==
X-Gm-Gg: AZuq6aJJKWFGsWdS2jIh5CS4sseCDMpwmV16bzJnKGck7YAFlg3uN/7ovBZhgqa7d2v
	FZZpBX9rkDYvqwnzFFi64EcDZ4e1F8WyVrmjVxQRLh+66bkp51FkzTWtJJyCKEu4WPes6Kd4i6Q
	MPDK9iYOU5MgL7cnREVAyEQ3OsPhGfiGGNwVIdKVv4CIQS2b8r0A+Pegl/T/bniLfjnbD/vkOnU
	2ATx3mdZ+YCQmbtYEBvM5qhLMEjDB9mB6EphV5EyYm6z4G0UOqluHge4yzpJKmdmEGgl5JMd2pM
	csMuwFdIoXDEI4F73Zat1DbUMyY7ajr45Srzi1HbinsMpLb5tZaCUop7CxYdzTokDv1LFdpq4Ky
	xjlmtYdSAdGSbO8+02Nsvtp7B/Pp/VKLupcB3EqLltLs3NxcxpqysydGIGbZMRp0X7XVEayZy6c
	DGbfH0WIK/ApOBiBDksPGhod8S+mumlDbyiDHr8l1tnA==
X-Received: by 2002:a17:90b:4cc4:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-35844f95e58mr7960191a91.19.1771235514130;
        Mon, 16 Feb 2026 01:51:54 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567ebc3af1sm15130598a91.15.2026.02.16.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 01:51:53 -0800 (PST)
Date: Mon, 16 Feb 2026 18:51:50 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] net: tls: Use disable_delayed_work_sync() instead of
 cancel_delayed_work_sync() in tls_sw_cancel_work_tx()
Message-ID: <aZLotq3aZY0b-dI8@v4bel>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258851-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52B861421E6
X-Rspamd-Action: no action

After cancel_delayed_work_sync() is called from tls_sk_proto_close(), 
tx_work_handler() can still be scheduled from paths such as the 
Delayed ACK handler or ksoftirqd.
As a result, the tx_work_handler() worker may dereference a freed 
TLS object.

To prevent this race condition, cancel_delayed_work_sync() is 
replaced with disable_delayed_work_sync().

Fixes: f87e62d45e51 ("net/tls: remove close callback sock unlock/lock around TX work flush")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
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
---

Dear,

The following is a simplified scenario illustrating how each race can occur. Since tls_sw_cancel_work_tx() does not hold lock_sock(), it can race with tls_write_space().
```
          cpu0                                             cpu1

tls_sk_proto_close()
  tls_sw_cancel_work_tx()
                                                    tls_write_space()
                                                      tls_sw_write_space()
                                                      if (!test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
    set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
    cancel_delayed_work_sync(&ctx->tx_work.work);
                                                      schedule_delayed_work(&tx_ctx->tx_work.work, 0);
```

Best regards,
Hyunwoo Kim

