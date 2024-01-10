Return-Path: <netdev+bounces-62956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A0B82A2E3
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 21:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D43428B4BF
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10884E1C6;
	Wed, 10 Jan 2024 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3ItBvh3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49F4F1E8
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e67e37661so5829954e87.0
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 12:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704919976; x=1705524776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nITTlE7A9UjgJNNUZEEKSN0fn+N4oz6Vu5qzwHQ2CS4=;
        b=m3ItBvh3BDEy3qGaBR0fMjUn0jEhiilK/CjBoRnsZDzofFAaYFXOWDnF+vkNVP+rRL
         xuUSScXfXZbY2OEr0GOhx5VkpTNgtUJs71v5OqK53y0Gm35I9G/dXd5NIK9Nw86PGSYr
         3+n9PDwtrpS9I9p1mKrpJQQKdJd4FFOz1mRcEZwPcOEgxRSOud2/48rJQvdEmRGIKeEw
         VJc9auoId7nbQ2rr3dTBrANZDvdeS4OrpNtxb+HFZQAMT8FBovOOmrtxHabFu3zeHYli
         /8UVE/m29B8z6r3h3nSlBPlwfV8D30+38WxCy492VmPI7z2Jd/XFZ3CLBzNqP3sWE2br
         /Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704919976; x=1705524776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nITTlE7A9UjgJNNUZEEKSN0fn+N4oz6Vu5qzwHQ2CS4=;
        b=kpogLUdonWgvOp+03gnXQDqZD+Qcj7HqultYeUiWimEfThjf7P3pOLUm4QjK+2jzAu
         Hh4eRYX2nnPTyP8VV9ug3fbQwUmW7KUaMwFBLUgtRT1i31ImOA/mjwWpwma9yD3S8kfF
         pSNYXmA4NGf5TWhB6d9e7C5kL4jVo4h9wePktlT6bDP0v/7EviJmzneMW5q6qRQ5B7kF
         L95g8cmOU8pHSbT49AhMMClcR8vuHBRmclRnx05Bcr4G7SA7Gnp4T+5+gMfeTqpk9xvS
         iMMKVh8RPWC6d/gtDNMshrSa3QU3lUGPNVkgRHPdbQM+ynqjAlWeUElRSi7YsP2Ganz5
         uW0w==
X-Gm-Message-State: AOJu0YxsvUbHwuheuF7T4ITSkG9tQGegG8J2qUi609BAJrLv00P6HtPQ
	C6w0J/yb4gEocgWgrreiG94=
X-Google-Smtp-Source: AGHT+IEwAEWD9Ip22/Cnk/ZBO9owb8aWVOip9lyvoALN3o6+ZnSI1HYmYoqB94vBmYegXLC3cb9+oQ==
X-Received: by 2002:ac2:5221:0:b0:50e:2551:c8ce with SMTP id i1-20020ac25221000000b0050e2551c8cemr9523lfl.119.1704919975679;
        Wed, 10 Jan 2024 12:52:55 -0800 (PST)
Received: from dev.. (89-109-48-156.dynamic.mts-nn.ru. [89.109.48.156])
        by smtp.gmail.com with ESMTPSA id r19-20020ac24d13000000b0050e9a8057f6sm757449lfi.259.2024.01.10.12.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:52:55 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] ifstat: Add NULL pointer check for argument of strdup()
Date: Wed, 10 Jan 2024 23:52:52 +0300
Message-Id: <20240110205252.20870-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling a strdup() function its argument do not being checked
for NULL pointer.
Added NULL pointer checks in body of get_nlmsg_extended(), get_nlmsg() and
load_raw_data() functions.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 misc/ifstat.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index f6f9ba50..ee301799 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -129,7 +129,12 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
 		abort();
 
 	n->ifindex = ifsm->ifindex;
-	n->name = strdup(ll_index_to_name(ifsm->ifindex));
+	const char *name = ll_index_to_name(ifsm->ifindex);
+
+	if (name == NULL)
+		return -1;
+
+	n->name = strdup(name);
 
 	if (sub_type == NO_SUB_TYPE) {
 		memcpy(&n->val, RTA_DATA(tb[filter_type]), sizeof(n->val));
@@ -175,7 +180,12 @@ static int get_nlmsg(struct nlmsghdr *m, void *arg)
 	if (!n)
 		abort();
 	n->ifindex = ifi->ifi_index;
-	n->name = strdup(RTA_DATA(tb[IFLA_IFNAME]));
+	const char *name = RTA_DATA(tb[IFLA_IFNAME]);
+
+	if (name == NULL)
+		return -1;
+
+	n->name = strdup(name);
 	memcpy(&n->ival, RTA_DATA(tb[IFLA_STATS]), sizeof(n->ival));
 	memset(&n->rate, 0, sizeof(n->rate));
 	for (i = 0; i < MAXS; i++)
@@ -263,6 +273,9 @@ static void load_raw_table(FILE *fp)
 			abort();
 		*next++ = 0;
 
+		if (p == NULL)
+			abort();
+
 		n->name = strdup(p);
 		p = next;
 
-- 
2.34.1


