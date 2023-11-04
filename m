Return-Path: <netdev+bounces-46070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D07E110C
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 22:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E151C208BA
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 21:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D271250EF;
	Sat,  4 Nov 2023 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0eVTXul"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C424A15
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 21:01:02 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE2FC4
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 14:00:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bbe0a453so39205047b3.0
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699131658; x=1699736458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DmhC1X9OAQjJSlRCqONzFt0aXmHxKRvFg2VPovcxo4=;
        b=J0eVTXulSu4Xa0vAzbhW7/KriqeZBP75Vo2ypGXMPQUBihQZ+F2mUI3OCFBOQscfjC
         G9HFrbthec8965RvaQ22q5Ovgupa599DDr47Nh9y+5BMCxGMUWMIN+l1Hw/Jt5nCuX4F
         Zca7eA5lu0/8nPPQBoldV163WpYjwxujFEMqqyuPYbJPpZmFVhGCJ5Vf9aZo3WdcuV9k
         0HHdCgfBBItibESVF8h4RXO7+QSYrIbzRO1Y7rg3AgImQCN7YlX67G/HEnRzButAoma4
         ZA1JTx1zbavDP5x6JWKousol/deq+HJb+yK55qgvE2BgTtrhMi/yfCnLdBYxpLcqJJ9T
         yaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699131658; x=1699736458;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DmhC1X9OAQjJSlRCqONzFt0aXmHxKRvFg2VPovcxo4=;
        b=pNhbsqs9zmBAv8/EEmN6PVlXU7zFi1sSjpZ5BgSRW1cC5i8HTVo0dqTkYntbeYnWjW
         gPnQbcfMeo1Kqjlvh38Wu1zfzTTRNWZTfloI2sJRBMftMIQ5qwj96AUN+a24AoErkQ9b
         Jm7vLJFmj4ozjp4mXUY2OxqFsp4J3MlWAyf4tH51QNtHaLrwAVE1hKqGkterES0sU/52
         ZD8NVKSXHIcjgTWOLgLGXsjO65hdGqYuNsIxmLyZQCDNinJLaMB2Wc78ZPeNsmkysm+X
         q4DHXoAkWR6huTHj6aeVpFhKu2ak2YjkZ8Oll7bqbrGrvNz8WJYncpLY00caNf+ygn8G
         1JUg==
X-Gm-Message-State: AOJu0YwodEn7jUVuT72e6YrY2jAQ4HIijGi+sSSWL8LcO8t+ijqMxtTi
	gvmBZeppgFIaEKyM7zVWzq1xAoCN
X-Google-Smtp-Source: AGHT+IGIDtqtmA/oVN0QNcBMr7oWGUtMmz2Vav0nvFAmRnKyjHoSrAdF6TfPHq/oNfosQzv6u6SZ/Jym
X-Received: from athina.mtv.corp.google.com ([2620:15c:211:200:f00a:d6b3:feb2:6f0c])
 (user=maze job=sendgmr) by 2002:a0d:dbcc:0:b0:5a1:d4a5:7dff with SMTP id
 d195-20020a0ddbcc000000b005a1d4a57dffmr128329ywe.6.1699131657967; Sat, 04 Nov
 2023 14:00:57 -0700 (PDT)
Date: Sat,  4 Nov 2023 14:00:53 -0700
Message-Id: <20231104210053.343149-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH net] net: xt_recent: fix (increase) ipv6 literal buffer length
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>, Jan Engelhardt <jengelh@medozas.de>, 
	Patrick McHardy <kaber@trash.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Maciej =C5=BBenczykowski <zenczykowski@gmail.com>

IPv4 in IPv6 is supported by in6_pton
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

Cc: Jan Engelhardt <jengelh@medozas.de>
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


