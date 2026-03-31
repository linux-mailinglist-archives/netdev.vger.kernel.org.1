Return-Path: <netdev+bounces-273783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM54CSlTzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:05:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EED372988
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 372B130F9DA9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77B466B66;
	Tue, 31 Mar 2026 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg5dNi6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77E1B3925
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998070; cv=none; b=IyJV7ZGc9l/FeDt19PEnWy65nb+GRbBsSg9I8hsfWUDd5v7CbfVCn50s/OC5KA5khSqxhXZtgTTnbsoO44sW/5gr5MRC4Hrd6dflf9LaZCWMl2gDaQpNPXrwX8reLWDUget8eeMENkd6SvPOg8w7Eu2L+z/HTJonID/l6txPlj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998070; c=relaxed/simple;
	bh=0rRRB1pnJMSltJnfuPdC7c14m71gUrKIm3lMrUNlwxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWE3RBBisZLtIGw7JC1wxvMzQ/7Hw/yHUm4i2L+6hnZ82mrF/fF4ooeFLfIdEpBH2Q46wb5N1bNqh3+UEQOMREHUfbIQTbd80ja5yaJGlXiwZLKRP8GsikwR9CvywKU8Q9rTBofZms2H/0W/khRgMVuwMbH7bkY4lVW/acp6ywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg5dNi6T; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5637886c92aso2971734e0c.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998068; x=1775602868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCcRDNWf/MJLY2UxfN+Xcd+3k+QnkQJ/sDWLTVG516k=;
        b=Dg5dNi6Tv/8f+lnqDF13xW5zFdyCc6T20FUlLh4Xy7fP8XbD6f7B57LeMqshSdHidl
         5orKPH5ZpejoAaL4JqqEQ3v27tGY9+uwlGEUE5qYls6vFhwB7fNvALXVb7cdRL0yB3q2
         YYVmDrFQy0NocvAyL18RuEAxWcJxQyp791uHxPBZodIwQezQFy62tmyPoGYEjyJRoMVN
         a8KUZZEsQ6stLxjKTOpI4lEvIaS64F/jjfqKtcj6E4Kr6idAT4YNTx8bY9l0HAhNdjna
         pv1t7087B0X5cuyItabM2eG9KLJ0nfl/vOWKsbtZjGP+r5uwMocbT8Uav4mP7EABoJTJ
         J9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998068; x=1775602868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCcRDNWf/MJLY2UxfN+Xcd+3k+QnkQJ/sDWLTVG516k=;
        b=sCKjUZSo495lC+6sCiYVoEmZUzUyONMRXBkDYNu7QvtkV2AN4xTsMNPAqyFwZ0DBPO
         0cW6WrzQJy70Pvqm5ek+rtWzNLv77obnyGbqa4/UA7c6DCWIOCAv2k06TaOgfLu1+6v6
         +2oj+DLYJZy5XG6eqOys6ea4KujtyYHqvNL2PAvPl7vdKgMVODtuv0mX8utcWE+JoWlz
         VynB7r8nVEBq0H+cX+Dt9D9ozmP1bQsm+jZICN4q801RXBN05MyBuGX/yH110mqZMZR/
         k4dmS+M7wJMRSzZK8/5n1b48UCx3ThrrEiyk+beqAmHCUWRVn2nsdRPOBg+mr8PGKCVZ
         /Tdw==
X-Gm-Message-State: AOJu0YwsUIMKTqsPWPjm3MUrWZHT1NSF5QI9O3CvNH3QCyG99EUwXGn8
	JRHlR8N/r5SmKFE2o+imFXud4rljhWY/HQ0/ivmli1KtB/CAx01nU4nh
X-Gm-Gg: ATEYQzy5TTy9LctW4O0w5mquE1wzlb5ZbVrWjAYoG9Z2QDgdvQezNA2+4L+3i4gPMNO
	t6JrDRLLkJ7by23L849jS4v5CRuG4D0UlOGMqiadAb2U9pGeEnCqg5TVX2LBZ/osNOfd0kNwxHM
	/R9M7CezKA1Dh8F91LsNvGEi2RTC8bc5t9gPOWcDUPMaIZ9CBYFcSYxmpOem8gWdi72m32TBIcg
	qlhNmdY9HZBoZHlKEBEyGZYhLeb/x/Lhdy6uYC0HDB0YzQRmi7Sv7VjVd3DzB5frcAQk3WgvEhM
	KoYsC3IQdeiQo+TGNrEPbMWsHqPfE4VnkhbG3TfvpjyITonytdqK+INI7Lqvs2S6Wc4sfm+MmL9
	hsC66V3g9Zevavvq6JOYh8SnsB0QNO9PsuRRgc20sYnG34smfYNl+pgpi98krBJ5vURN4FUNWcM
	FzXUGmTnWs+odfxpT1ELMzSnFF0rtdYmCevH1mDg==
X-Received: by 2002:a05:6122:469a:b0:56a:f576:cfca with SMTP id 71dfb90a1353d-56d8a8184fbmr695578e0c.2.1774998068199;
        Tue, 31 Mar 2026 16:01:08 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:01:06 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:10 -0300
Subject: [net-next PATCH 10/10] net: dsa: tag_rtl8_4: set KEEP flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-realtek_forward-v1-10-44fb63033b7e@gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 95EED372988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

KEEP=1 is needed because we should respect the format of the packet as
the kernel sends it to us. Unless tx forward offloading is used, the
kernel is giving us the packet exactly as it should leave the specified
port on the wire. Until now this was not needed because the ports were
always functioning in a standalone mode in a VLAN-unaware way, so the
switch would not tag or untag frames anyway. But arguably it should have
been KEEP=1 all along.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 net/dsa/tag_rtl8_4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
index b7ed39c5419f..852c6b88079a 100644
--- a/net/dsa/tag_rtl8_4.c
+++ b/net/dsa/tag_rtl8_4.c
@@ -99,6 +99,7 @@
 #define   RTL8_4_REASON_TRAP		80
 
 #define RTL8_4_LEARN_DIS		BIT(5)
+#define RTL8_4_KEEP			BIT(7)
 
 #define RTL8_4_TX			GENMASK(3, 0)
 #define RTL8_4_RX			GENMASK(10, 0)
@@ -114,8 +115,9 @@ static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
 	/* Set Protocol; zero REASON */
 	tag16[1] = htons(FIELD_PREP(RTL8_4_PROTOCOL, RTL8_4_PROTOCOL_RTL8365MB));
 
-	/* Zero EFID_EN, EFID, PRI_EN, PRI, VSEL, VIDX, KEEP; set LEARN_DIS */
-	tag16[2] = htons(FIELD_PREP(RTL8_4_LEARN_DIS, 1));
+	/* Zero EFID_EN, EFID, PRI_EN, PRI, VSEL, VIDX; set KEEP, LEARN_DIS */
+	tag16[2] = htons(FIELD_PREP(RTL8_4_LEARN_DIS, 1) |
+			 FIELD_PREP(RTL8_4_KEEP, 1));
 
 	/* Zero ALLOW; set RX (CPU->switch) forwarding port mask */
 	tag16[3] = htons(FIELD_PREP(RTL8_4_RX, dsa_xmit_port_mask(skb, dev)));

-- 
2.53.0


