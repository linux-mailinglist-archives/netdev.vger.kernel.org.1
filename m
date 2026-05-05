Return-Path: <netdev+bounces-284337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Kw8MZnL+Wn3EAMAu9opvQ
	(envelope-from <netdev+bounces-284337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:51:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E12A4CBDA4
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A71793100E65
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 10:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433841C2FF;
	Tue,  5 May 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/QJZ+18"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D063410D1F
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977752; cv=none; b=bJ0S9obcIqIQiCfU6wODNRecimE5p1+QCAotkS46/YmEofWjoYWvDSepqAYMMdfPFxN60yAnSlKJe4dPkMyJWxbjOxiRrWJwlmWLouCJvIzLj1f0G3wg5p4BgoZaFZfm4EQcYIo6bjl6GtNEa8crm4Q4Ono+keY8PoeUIQhYhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977752; c=relaxed/simple;
	bh=2yxca9KdGpxlKDUxXsYOrQhJn56phQUvzHUfWjqzioE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQysJKkKqCQ8FcJCNorHxJjm4iI+x4ombf3N5e84xpAOMhhvbTQdWKAvVFUbkEXKG3Li0UA35l86o6MA7Y4VC/uLZ8kxvCY6rGaYqbwIT+5fTgTaaWtNMpXacZjoP08m9Sin0PyrB/MPnOqX9YhbEoF/H1/XmKzgBve9NJrHkqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/QJZ+18; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40ede943bf0so3624630fac.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777977750; x=1778582550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWd8Hd1knCnGyBHNHqboksALRLBY693aSCfFmusPC8U=;
        b=m/QJZ+18KYgcyAatjejG1jXrUVV0DDDt2XVv3mMtROnRbeZZUqa7RdV6pw8BHcMrE2
         szO48wTq86ajP0COSy/Y2ey5Bjj6eBbZD8v0D0/0chmWqUeDTyoStzIX3DYUEN9C0Bvf
         m1NCjrYnG/2d+bMPGr1uuV9RegTo13zmaTcM9BscFNIOMP8r4WWT4OX/dW7zqklETkdf
         BwS3tEY392EmoH04s8ff9wM6SeCC2WkA7bc+n8+BXrRyYOhz39BqzIhD54VS57wYaJH6
         Sqr/+UFGl1zUj8JQCR5qpbqETcc1XPNt85TcCI1JIxtLpEZJuuHOksvTSJsfdsjYZK+I
         IaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977750; x=1778582550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zWd8Hd1knCnGyBHNHqboksALRLBY693aSCfFmusPC8U=;
        b=bdxpqNGv//Gh2/hUPg7XjIZ6Y+6Jowya2X3X31Ho5ZWB0y55KEZ/qofR6jdQcVpgpH
         UvYJO5XA7Ri3FA/CD0Mawf3qu436gemJtf1boJfReccPM/MJxsd3UE7VCTPtnNPzeU/+
         2VI/nSTeWNwj6GgNncl9jEg2sXnVJKFtqhbak4lRocJYTgtkqYp8rYkDhOtB+FrtMrNb
         U90kQlOdGpMA0GAEpehSOzx90OTpyhyeqG2QSHdvcdQdpD91UHeTdN9lg810QeneZIFy
         70QehDKNpYSAbTSQaSefYS2EYMHDLv+RVDPssU7UuO4HjR0yVq21jXkqtOb2IClo6Wm0
         EfpA==
X-Gm-Message-State: AOJu0Yw3nQBmLcYNX/N3tr1geEnSLGg7IDm6uGYEoe94RXqn40Jrg7o4
	eRY0QZZBTfywJp3lLa/+sH1CMoSqYiirepfK4bTeAz2OR+65tOEbdwLsXnMXPw==
X-Gm-Gg: AeBDieubMcMJcH7LIn84facRvcQ9lbrJS8UmPQK5Dd57/XAhOY4OW8R8jMC7MOiuV70
	jhVVUNyw90MHWvukoZb9rn8wmkEQGiiwqVdqDDOi3q7PiHio+WlCPw/zwwfGF1CY0IXYuMfsWs2
	Tu3gkz5hCp3GmLYpCP/rRgKcCPvi3m0FHjNEFSbFpi1vpMsWe74Xsn3aNvFiX1KJE9AZGXjLiL7
	a4qPTyjN6HAq1rmrwf/0rJ85vHs/xGEwcG2LTTLSPlE062vLkdG9SOg77gAeZYm6SIY19hwKLf9
	4qSkynrHHZexdW7L0KkZgEFQiInNnSAghp+bUbqpGRijhzcZWu0jYRtj+sGS8SAu5I7e4ZMuK6w
	R8E5cpfkxd0KBMfjAbagYfzZ4YZifGy7KDQpiFZlyypz3Q0U7raR2VODeRYgCpkif98xGY+4luH
	geOtx7+elKRM7vQ77Xif4atYKbrHYFPWeiXX/9z5PqVfJqlke8T6j52FBHaDsKUg==
X-Received: by 2002:a05:6870:31cb:b0:42c:2042:1652 with SMTP id 586e51a60fabf-434d4168e24mr1321010fac.24.1777977750153;
        Tue, 05 May 2026 03:42:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454cbd8dbsm13463281fac.11.2026.05.05.03.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:42:29 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 05 May 2026 03:42:24 -0700
Subject: [PATCH net 2/3] netdevsim: psp: serialize calls to
 nsim_psp_uninit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-psd-rcu-v1-2-a8f69ec1ab96@gmail.com>
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
In-Reply-To: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 4E12A4CBDA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The debugfs write handler, nsim_psp_rereg_write(), can race against
nsim_destroy() and against itself, causing nsim_psp_uninit() to run
more than once concurrently. Two complementary changes serialize all
callers:

1. Delete the psp_rereg debugfs file from nsim_psp_uninit() before
   doing the actual teardown. debugfs_remove() drains any in-flight
   writers and prevents new ones from starting.

2. Add a mutex around the body of nsim_psp_rereg_write() so that two
   concurrent userspace writers cannot both enter the teardown path
   at once.

The teardown work itself is moved into a new __nsim_psp_uninit() that
the rereg handler calls under the mutex, while the public
nsim_psp_uninit() wraps it with the debugfs_remove()/mutex_destroy()
pair so nsim_destroy() doesn't have to know about the psp internals.

Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h |  2 ++
 drivers/net/netdevsim/psp.c       | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 7e129dddbbe7..e373ffc26b0c 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -121,6 +121,8 @@ struct netdevsim {
 		u64_stats_t tx_bytes;
 		struct u64_stats_sync syncp;
 		struct psp_dev *dev;
+		struct dentry *rereg;
+		struct mutex rereg_lock;
 		u32 spi;
 		u32 assoc_cnt;
 	} psp;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 0b4d717253b0..86d84b7e566b 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -209,13 +209,20 @@ static struct psp_dev_caps nsim_psp_caps = {
 	.assoc_drv_spc = sizeof(void *),
 };
 
-void nsim_psp_uninit(struct netdevsim *ns)
+static void __nsim_psp_uninit(struct netdevsim *ns)
 {
 	if (!IS_ERR(ns->psp.dev))
 		psp_dev_unregister(ns->psp.dev);
 	WARN_ON(ns->psp.assoc_cnt);
 }
 
+void nsim_psp_uninit(struct netdevsim *ns)
+{
+	debugfs_remove(ns->psp.rereg);
+	mutex_destroy(&ns->psp.rereg_lock);
+	__nsim_psp_uninit(ns);
+}
+
 static ssize_t
 nsim_psp_rereg_write(struct file *file, const char __user *data, size_t count,
 		     loff_t *ppos)
@@ -223,11 +230,13 @@ nsim_psp_rereg_write(struct file *file, const char __user *data, size_t count,
 	struct netdevsim *ns = file->private_data;
 	int err;
 
-	nsim_psp_uninit(ns);
+	mutex_lock(&ns->psp.rereg_lock);
+	__nsim_psp_uninit(ns);
 
 	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
 				     &nsim_psp_caps, ns);
 	err = PTR_ERR_OR_ZERO(ns->psp.dev);
+	mutex_unlock(&ns->psp.rereg_lock);
 	return err ?: count;
 }
 
@@ -249,6 +258,8 @@ int nsim_psp_init(struct netdevsim *ns)
 	if (err)
 		return err;
 
-	debugfs_create_file("psp_rereg", 0200, ddir, ns, &nsim_psp_rereg_fops);
+	mutex_init(&ns->psp.rereg_lock);
+	ns->psp.rereg = debugfs_create_file("psp_rereg", 0200, ddir, ns,
+					    &nsim_psp_rereg_fops);
 	return 0;
 }

-- 
2.52.0


