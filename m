Return-Path: <netdev+bounces-270017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCp8KKiPvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:19:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B62DF4B9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17CE83275706
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FE3E2751;
	Fri, 20 Mar 2026 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukjksohu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874073E63B2
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030259; cv=none; b=t/a1l3P6TmmJwodpmQArRIj5PCy68aQLPN7VbNmlsW6waT1L5tKFj7bxFxNEye9kKrRS/mbV9/shW21CTHCeocaJdLFCORqehPSx+hiWJbYtPdrLuK6eVB07+wCPcDQ4A0KR3RN1hSQjJZ8Igi0iQBGhyiJmPmBjLuDzl+S2yYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030259; c=relaxed/simple;
	bh=26UQrZbU/JLBJCqLwaX88rDbciQrWYFpkBrK87bA5aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TP3ElqBMHPgz9jIr5iXCOhDZSbNjjwd+DF/RCrfugzOcEk2ImS8dgWRJZevDwFTsS6Jy/doSL0pXcnXpCibElssh5tbrtuJvYGq3s3/c9Twby+0TM80o0Gnbz/GbshE08UPJaTct6kDiPD+EIXYC/Jvav2D7PiJDPJllnuY0ltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukjksohu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35b98def50bso1503666a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030255; x=1774635055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs59ZYsmevHDwekpgOW1Jo5Q8vTfXRm0+cDIBjhCcOE=;
        b=UkjksohuJRYV5krQr4lw6YbTM+VwHFPMavoxqbeht8miFHq0+Lv9iyzkDcQUh8s0+r
         Mw+Rws3X3e66QkhywIn62m3bxVEcWB41nbn92CwOMy5NLFL2p7aRUrbX8Rqi+NZRMq1r
         RVPpmii67atOMA0F1ctiuFl0vH0ImsdOwevJPvm8K0TqYWounQjCR2GEYl2B/8sMxylX
         Tnww8bxFJ7EnWzwMnjcfyVledFObeHpY7WOD2eu6bNV03sw+nAulD9KxJzzUiso4OikN
         Btj7rq1b3KhetrGEx/F8cva4uAUg5cLPYkUM5KlNohMhR5r/TAnsZE6PVHNscX6lkMFm
         ERBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030255; x=1774635055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rs59ZYsmevHDwekpgOW1Jo5Q8vTfXRm0+cDIBjhCcOE=;
        b=Sprr1Esns5ebWukWKIVj3+A1zGyCe5s8Okvlp3KkNKQgk39MGRg4yhiLAd4/UErfxk
         bIbxLn4M8uWE82Uy2QDN3gIWWdGdpcdjHH95A4l4NI+VQ1k02wOaTZB6aHcKxkpJJz+p
         7FTdQl2eOMi8WfXZpFb0jGX1bAL1jD9SJwROpOs6qhoheNggX3WU8KcR8yoRg/DKD7U+
         8S0iRyI901Gq3WQUSd+aBdaOnkDYtFRhuerS0pPFvI8Bp/oXDXcQEUOAXEnwuvLy24g1
         LHlsarC4UOdbB1vzvdUmFSOpZee1QIPXfsO35HBF8BRz8RgK4EcZVOMNKAoiWzmP9BUe
         qWVQ==
X-Gm-Message-State: AOJu0YzCCNwtJxCoGFCNj0AVSpcNaHpmoQCr3kCiIih+Gdnf2unoUMXs
	TaNDjiTU0B7PrEo0NU5P1V1YkUdnFrXuXjEl0Oo1zD2ZK1qqui0x46j4
X-Gm-Gg: ATEYQzzlEfAd3FRn0FAGBm2U4zSfh+Hv6u3zzRng9E7WuCcMGB2OXlWmnC3h06D5Fvs
	v3UtkEGKoQhflbj4rfLrYVar22r6vSfFEDFuVEbOO51iKeFrMi5EMBDnETy4Tjokx7sFNHLfEb4
	Rf5nWwQqBEJ2jmsV1+yOqogSQgmzHRbjcGyV4GBC6/XhWYLJ5GybmG/k3bx3ZzkjQxEp7+F01tk
	9sy/ib9wiNCnpWcDRDlZq9Un6p1OgC3xtUYFgQu5DlPNf2o914/7UGAsgkQ7EnHAUVq+0K4dHKc
	rEVGn8x2NuSsIinv+8YfQuk3eCin+qbEUM9KyUxVmMa1EdAXhKJtMPZA7KZg7MnGtxgZ/5WF+VV
	T/tqg2RCpbw8ZRrHKc3RIFfVon+QVxhWyoIMfjzX3VH8lmSHYEivsqKFPaj8QFI9S6XjNbOgjDx
	IRCooJLg6oY3vzCiIXIjxYTrKyI6X3/tzeK7kpgSDm6xJHNs3ZVIvTCDqGZD+9N5qNjt1UGHE=
X-Received: by 2002:a17:90a:d605:b0:359:406c:49f3 with SMTP id 98e67ed59e1d1-35bd2d1f873mr3078727a91.27.1774030255511;
        Fri, 20 Mar 2026 11:10:55 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:55 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v4 5/5] nfsd: remove obsolete __maybe_unused from variables
Date: Sat, 21 Mar 2026 02:09:55 +0800
Message-Id: <20260320180955.150696-6-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320180955.150696-1-seanwascoding@gmail.com>
References: <20260320180955.150696-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270017-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.875];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 267B62DF4B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that dprintk() has been refactored to use no_printk(), variables
used only for debugging are properly referenced by the compiler even
when CONFIG_SUNRPC_DEBUG is disabled.

Therefore, the __maybe_unused attributes added in commit ebae102897e7
("nfsd: Mark variable __maybe_unused to avoid W=1 build break") are
no longer necessary. This patch removes them to clean up the code.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfsd/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 8fdbba7cad96..8116e5bcbe00 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1025,7 +1025,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 {
 	struct svc_export	*exp;
 	struct path		path;
-	struct inode		*inode __maybe_unused;
+	struct inode		*inode;
 	struct svc_fh		fh;
 	int			err;
 	struct nfsd_net		*nn = net_generic(net, nfsd_net_id);
-- 
2.34.1


