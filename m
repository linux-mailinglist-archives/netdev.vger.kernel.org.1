Return-Path: <netdev+bounces-300439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rfmABqDtM2rbIwYAu9opvQ
	(envelope-from <netdev+bounces-300439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:07:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD74A6A053F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:07:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LYFHJOx6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300439-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300439-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 748883002B06
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54E3F7A99;
	Thu, 18 Jun 2026 13:06:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E20330B22
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:06:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788006; cv=pass; b=I8Hh6EFMJF9RGHstiFsBXWwhYZLmFQrV3j3n4at4OXyUqSQK4zJAHIo5kzhsA88WKYoEtDpDXfAtD9Wbht2eA132BFxuzmTDji/mThhR+JCJMBS4T7iGX/0axJfAqSLPZr4p/+d700treYhlCl2jHZVoCo8Gqmykk8chsdiU8wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788006; c=relaxed/simple;
	bh=Ge5iG+jK12/OuNbbizRkpfeFAYQLwGgU1pOomh7zRzA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EihJfjUzSVk6B/1GZ6Kx7/zoXwpt+r92gDnx8u9yG7Yt8ZuWbXs+NPy+Y5PWR/dj17u4wVi/VyltWHzsIXt9gf+vB5VuRY8A8KEdfk9/IWQutLdUh7IR7j7qn4Q8kbmE+/fS1U9Zy2V5j2J49ZbHl8ORBlp+yIGRMpS4oNykLCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYFHJOx6; arc=pass smtp.client-ip=209.85.161.52
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69ec2ebec61so692245eaf.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 06:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781788004; cv=none;
        d=google.com; s=arc-20240605;
        b=eROVQOt+jTGe9zhekHCOyS9g1um/PwxM2CrOxuLa0YqolC9ltWES6iJnOqS6ks2W9n
         XEUdJi2oqv9lUDxnz0oc4kKPxSml3q83amigjIZ3TLUoz52s3v9I2N0opH1segI0+D1e
         Sz+k9qOcR9luU9H/bGhJRPLsgNdwZHZkW+/euRRCRwoVYTz0p0dpGWKOhD6BGR6Tslvi
         +xUfqjj6zKJ86ox+MiemgyzF5TVAc0toSxYWmW3HTzGGVXbhbYtrTSsQhNVIHpQZGpeM
         woMX8FZSd84S3YdioMHi+sqIGVqoOU1FULCCY9JtB8JGMpzi2oU49KFkKK6f7gs4yOhC
         K3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DyX9HJy/ZN1FLchAnFuO89U3CtMYzMlkZMHuvPK9uY0=;
        fh=WhIT+GZNgOUHhq7VnLirQQjZJNIUyXJcs5VgKfOt8T0=;
        b=MfAX2r/wD/HEDYNQUNs6ewlafjWgfPU3Pwuz1YqaP/uZyjMmiSfqdc9nSai+NFW1bp
         BHtw1wWsoK6tuAWJDVmudw3ZpPWA4Nq/+u7VLvIb/m/IFRVER1fdVZHSO8lSN7oOJGOD
         OalDv2CWi0T2la6E6w6OJKcqau+SnrnXwXCVa2xNCOfin9Zv5aNXUGvsdulBlOecsDOH
         EgDEoM4bdjehMf10ECddlO85RQY/n009Sl5+MXS/i9vIevMcqxNgLyXxSsmjPTl+WRHg
         86Za7tG/ftjkx2AHOGHztS95WNQPXYp8rEbj8RsM5cvSHl4+V4V9CH+hnp9dKnp9jcwu
         2aXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781788004; x=1782392804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DyX9HJy/ZN1FLchAnFuO89U3CtMYzMlkZMHuvPK9uY0=;
        b=LYFHJOx64RbaOOF0ZYpt+4XVFwMB2wO98BPmJ4VRyA7NIyAITP1QP56Ujv0DtMWGhR
         SOFUTtjkWwAFUh//zKUcEAIT0eKvFmHwEy9DCtuOug978Anq1MrchMiQrFT3tGzWhrWG
         2mJWp/BU6O49CC4GZDroDmOUv9rjL+ZU8Ngw/MwP9lmKgA40kG9RuEHQjve+Tv3/+480
         gkBPmh4hu3e6898HRYKE5RO2/IP7246Cth+cAGjx/tyyiDsbm6Tmq3tuGR9XfEvIxAML
         ik4JLc0Hsmvl5czOkjf9St7NgGjOVEIn2ImGM+WFEX9+dNAdIqEQu3qxcJDgu0Mt7cyV
         b8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788004; x=1782392804;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyX9HJy/ZN1FLchAnFuO89U3CtMYzMlkZMHuvPK9uY0=;
        b=a4SZlVoT5DmTV/FFWQmUi492NOqM6gH8/F8KMn4tnEIs3RVwIYkDtgcIBs6UUAy56k
         BnAd5bT2Vn7SQLRvgSQdHajb4bH4GVPAEjrnH5ZOx7T536lZGQlU6bXCxVAV7HAFgs/h
         QSqQi67HFLBOFCZcpS7VAnhPG9XSMh90RJakrkVlifOHFcIcBdTDkanemwn4IxLLxptn
         lueV2nFNEc+UpdClxMsGHxnuhP1RK22LG4hatS1vXfUq04hf1bXWgPZj81gpypnBl0od
         mR31X9ditzi4I7i3xa5P9qdP7KUExnOYur7qJgV9XFVYzITtqMcSdNu+E3637gDBI+y+
         iSXg==
X-Gm-Message-State: AOJu0YxqprrrmeRHNcjD1fCHDu/yXREKGbPyLyTLKf75kk9EJeG4Cxo4
	YrXIN+EiOWRbNSlXNHeE82gxSeYQEDJKAcoDH7wcjbpnqK4oG3eKdpTJACN3B3Nzs7D34pvKD28
	qBSBqeAzL4Jzed4uMsvyga4nrZkyauhY=
X-Gm-Gg: Acq92OEEbdGCZvDNC0/2DmVyWtIgb/y1iUMpabI3n2ZnImJa55QD0tGulVKOrwleXJv
	Hwt+Dusox3WwGLHt46CMj9R1CVNmfDCv9ssHgN9+RlTHSVQ9lizH+PdSAJEOk+15jGN8iFmEryB
	XUJTM54Nzc5ILgxfBiE6aBJjssdSJb/FW7xX0W4tDI3IF9oJZlbn1tfNxPj59cyBtdWJOXhBGln
	LcLXent73ryYoNrHITOLFGQ3Yp//GE01Da+R80bZbDDqk3L8Q3Uu4Osn7XbQqLwIUzBoVajiQ==
X-Received: by 2002:a05:6820:1b06:b0:69d:d87c:177 with SMTP id
 006d021491bc7-6a0b5e75df2mr6365880eaf.12.1781788004076; Thu, 18 Jun 2026
 06:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Goltsev <sasha.goltsev777@gmail.com>
Date: Thu, 18 Jun 2026 16:06:31 +0300
X-Gm-Features: AVVi8CeEpoED3jJEwA_q3ex4Jo-aNbgCGVjBq_DjlHKn03yulxq7Uis5Ef00R3M
Message-ID: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
Subject: [PATCH] net: add sock_open() for unified socket creation
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300439-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashagoltsev777@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashagoltsev777@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD74A6A053F

From c3d9f58bd314011fdbf18bfb9ea2e410898a9770 Mon Sep 17 00:00:00 2001
From: 0-x-0-0 <sasha.goltsev777@gmail.com>
Date: Thu, 18 Jun 2026 15:21:32 +0300
Subject: [PATCH] net: add sock_open() for unified socket creation

Signed-off-by: 0-x-0-0 <sasha.goltsev777@gmail.com>
---
 include/linux/net.h | 14 ++++++++++++++
 net/socket.c        | 31 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index f268f395c..18883ea74 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -116,6 +116,18 @@ enum sock_shutdown_cmd {
  SHUT_RDWR,
 };

+/**
+ * enum sock_create_type_t - Socket create types
+ * @SOCK_USER: creates a userspace socket
+ * @SOCK_KERN: creates a kernel socket
+ * @SOCK_LITE: creates a lightweight uninitialized socket
+ */
+enum sock_create_type_t {
+ SOCK_USER,
+ SOCK_KERN,
+ SOCK_LITE,
+};
+
 struct socket_wq {
  /* Note: wait MUST be first field of socket_wq */
  wait_queue_head_t wait;
@@ -273,6 +285,8 @@ int sock_wake_async(struct socket_wq *sk_wq, int
how, int band);
 int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
 bool sock_is_registered(int family);
+int sock_open(int family, int type, int protocol, struct socket **res,
+       enum sock_create_type_t sock_type);
 int __sock_create(struct net *net, int family, int type, int proto,
    struct socket **res, int kern);
 int sock_create(int family, int type, int proto, struct socket **res);
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa..2c79c022a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1562,6 +1562,37 @@ int sock_wake_async(struct socket_wq *wq, int
how, int band)
 }
 EXPORT_SYMBOL(sock_wake_async);

+/**
+ * sock_open - creates a socket (unified interface)
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ * @sock_type: one of SOCK_USER, SOCK_KERN, or SOCK_LITE
+ *
+ * Unified entry point for all socket creation variants.
+ * SOCK_USER creates a userspace socket (via sock_create).
+ * SOCK_KERN creates a kernel socket (via sock_create_kern).
+ * SOCK_LITE creates a lightweight uninitialized socket (via sock_create_lite).
+ *
+ * Return: 0 on success, negative errno on failure. On failure @res is NULL.
+ */
+
+int sock_open(int family, int type, int protocol, struct socket
**res, enum sock_create_type_t sock_type)
+{
+ switch (sock_type) {
+ case SOCK_USER:
+ return sock_create(family, type, protocol, res);
+ case SOCK_KERN:
+ return sock_create_kern(current->nsproxy->net_ns, family, type,
protocol, res);
+ case SOCK_LITE:
+ return sock_create_lite(family, type, protocol, res);
+ default:
+ return -EINVAL;
+ }
+}
+EXPORT_SYMBOL(sock_open);
+
 /**
  * __sock_create - creates a socket
  * @net: net namespace
-- 
2.47.3

