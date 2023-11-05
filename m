Return-Path: <netdev+bounces-46106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3207E1623
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E68EB209EB
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6B18053;
	Sun,  5 Nov 2023 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c08CcNAb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521C1642B
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 19:56:05 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615BDD
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 11:56:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso4380756276.2
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 11:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699214163; x=1699818963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUArnjSIsgXrx7xFAxQVER0QA0qRV6AYyhVWnbMzG4g=;
        b=c08CcNAbZ4pdFhebIO69rhezM3/YJmSlSR4tGE7uLaV+BqGl/3L7zcIbhkbb6Rzn53
         S+wpclAvdGp+ha5ffB+RGFzDbFP6UHY7Mr1GpZq61YCJaQNdJ+iIaUzVe32mR6eXC0n3
         HGylq5QV6PZEOEJDsWb6mZgCg7w1cpzuLge6r5JCoQLL1O1mIb6zwe+kspI35fJF757B
         8v5t7qq82WpCzoAitb0AUQCGdYvvhycy4zoHuh9rgBYfiBgNChgtF9zASAke1oEtngNE
         FKwaRZH5eBuju/HXtClcH8r+foRir1Sk/7X64ywU5IY45k7UnBgk/HmOs+9oSMwDhyJd
         WwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699214163; x=1699818963;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUArnjSIsgXrx7xFAxQVER0QA0qRV6AYyhVWnbMzG4g=;
        b=nf3XysQD26YpwN7XffiOANK5y2HxFm7MjS5wLQCryUBtiYpq0QWTFEXefuB1/EJvrv
         3kfxp0zCS6jheJHLCIHPuWkcPynVTOBV5cW8xqBeC7+O9dE5mIDVorFbRe8SkZHo7Zxp
         wJE7V+PB3ELJresu4p0ZEBrMOmy4sm0XAAQM5UR1gPGaU83xhhLRHqBrKG0N7fxtBd76
         OMsXh+7EW46aVmDa3dHw63Z4Ag/3K4rx+Ltl1OEycIy3/xXfpl1+2pid4oenk8p7vXom
         dzz3XMi+75A/tcZ9nYv/xeCx86ZSYjQrmvZdvXEqskzj1R+piAlvAMvPVz4jweGdPi3/
         UcKw==
X-Gm-Message-State: AOJu0YxKx4VoVjMvVxYZ7MPXLPV3V4D1Ec2bSTGiBb7W0jEWJgxSaAWY
	Njqur97chh7qZirxqtpXE9QFo9Hd
X-Google-Smtp-Source: AGHT+IFwPAe+YxrftLkpjJj6/uUQsA+ztDwXxVSaYNAZQh9aXwwqjfQlklUxAnhkE+1HsBMjtAcoLzXM
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:8452:1b9c:f000:45a5])
 (user=maze job=sendgmr) by 2002:a25:8806:0:b0:da0:ca6a:bdad with SMTP id
 c6-20020a258806000000b00da0ca6abdadmr558919ybl.10.1699214163628; Sun, 05 Nov
 2023 11:56:03 -0800 (PST)
Date: Sun,  5 Nov 2023 11:56:00 -0800
Message-Id: <20231105195600.522779-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH net v2] netfilter: xt_recent: fix (increase) ipv6 literal
 buffer length
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Patrick McHardy <kaber@trash.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Maciej =C5=BBenczykowski <zenczykowski@gmail.com>

in6_pton() supports 'low-32-bit dot-decimal representation'
(this is useful with DNS64/NAT64 networks for example):

  # echo +aaaa:bbbb:cccc:dddd:eeee:ffff:1.2.3.4 > /proc/self/net/xt_recent/=
DEFAULT
  # cat /proc/self/net/xt_recent/DEFAULT
  src=3Daaaa:bbbb:cccc:dddd:eeee:ffff:0102:0304 ttl: 0 last_seen: 973384882=
9 oldest_pkt: 1 9733848829

but the provided buffer is too short:

  # echo +aaaa:bbbb:cccc:dddd:eeee:ffff:255.255.255.255 > /proc/self/net/xt=
_recent/DEFAULT
  -bash: echo: write error: Invalid argument

Cc: Jan Engelhardt <jengelh@inai.de>
Cc: Patrick McHardy <kaber@trash.net>
Fixes: 079aa88fe717 ("netfilter: xt_recent: IPv6 support")
Signed-off-by: Maciej =C5=BBenczykowski <zenczykowski@gmail.com>
---
 net/netfilter/xt_recent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 7ddb9a78e3fc..ef93e0d3bee0 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -561,7 +561,7 @@ recent_mt_proc_write(struct file *file, const char __us=
er *input,
 {
 	struct recent_table *t =3D pde_data(file_inode(file));
 	struct recent_entry *e;
-	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:5afe:c0de")];
+	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:255.255.255.255")];
 	const char *c =3D buf;
 	union nf_inet_addr addr =3D {};
 	u_int16_t family;
--=20
2.42.0.869.gea05f2083d-goog


