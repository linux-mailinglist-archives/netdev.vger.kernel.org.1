Return-Path: <netdev+bounces-273775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A/nE6NSzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:02:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DACC372927
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C1A3013682
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E6E421EED;
	Tue, 31 Mar 2026 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYMVcQjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9D2FD7D3
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998025; cv=none; b=lodjG1LwuMqXgvZ47kIbiORmsyUXoN/zRVBG+doSFE6mjYaP8GoJdj3RTLEv8PWCLvIoGNFOnHjgG9dz0adKxtYmdYjaq1U7Tlf6X9/mVZRBUmIx4M+S5B09UfnaY/mhp/CEIbu39DmNtJq2GOex5SUz+7+GOYJooYeG5uPY+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998025; c=relaxed/simple;
	bh=jpPmDvg4WiegEQM0IYSX0CZC2jP6oj/2V+56GqkivfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVOTnDdc3PStWqAUTWlT56VWVKW3LObNySkJlYZ05ULaLm868FHI0EHFqWjbRFQsOmOn5GFbpjtQtmOAnckvCTtbsnBEy6Uvh0qhGqCULV2aryfzbKQ7YPisMuloCGHHw+E12d4WCdl8BFEvy5/abvvqBGMIZ2Phh5YO175qwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYMVcQjJ; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56d357797acso4439995e0c.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998023; x=1775602823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiThgiHUNvzIUgWjS4Gk6rzIcaAngyxuVqiXsTkuGBA=;
        b=NYMVcQjJHVojMEkbzkZ0G7vfDXtyOBSS5JshHwUc0YFt131V9cKB7TY/qrfpVXckfg
         4VJrh5YnPzHNTXQXq7xRhYuFP+taslUje9hRuCfANRgbputhR+PK1E6Qx+s5cNO3Ehfa
         JivpgZBYI3iTB4ryAaMyIuTQ+wuU5IQdaMTOPQsqBywfTQsT/J7dERykOzqVAd4H/JpL
         G0PlaGekkIp312lvrowpr7vuG9XdiLmHFjCbve5GUwu/XLX+/VTmXM9OBcIr40SrWnPy
         4FTO0PyYLmgsmcXyaneFd/E0ImF+whDhKhb8CQMvaWDIFb4PTVpX2Tnou/3icJtIyLMO
         bhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998023; x=1775602823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MiThgiHUNvzIUgWjS4Gk6rzIcaAngyxuVqiXsTkuGBA=;
        b=ssaj9bgCzkXYXGPerojpSy63bkMPqYmfeFy9tcxpHRfUIgquc7fmnpSG3i4x4KTlVa
         7UyS2Jx2HR1i7dVmL7zeU20bgp/hBNjzsqxLrdnJ87Kb81qfnHY7FMsRb5YQCIQsoUm6
         JGeoWTJb4QvTLH2c+64gN98KUQHfuqgEnAlk5Wh53vnjKU0BihpqkPI+n0xHYsfZzj/B
         zT5E/sl3DGZXAi0xGXS+nzSVPjBjjHClRjwmLnxO+H5MUKj54j1NENwvAMPqk858dEKG
         2+My/F6lJ2H3GUVo6dgjm0WN0bgGTSA0brDV+z/0CGOuParYMSK1vdJO4eT1pcD/tfKl
         QOXg==
X-Gm-Message-State: AOJu0YwxYvoZ4AXOel2IogYKHM7dzaZC7a+syn/7Tpp+nPI3k776NzGf
	WDe+pD9g315iOvUYtLO7qYTf7tyRxM+VMil4ODs/enfBR2H/41qMics2
X-Gm-Gg: ATEYQzwaNYSQlVjwx33SZ6U70In31o6NfoPt2VU0Bz3mvObsO8/IhKUVytN9p01DGA5
	C3s3+2YkUgr5oSFHzXjvqvCZ6rgUIbOhRcXbu1U8Por6lBo3YadpnT/PaQkkFmYVPyseDznoWR7
	qpKXq67TZKG5Dasez3UlUpGp6GaY4jgikPNDtdrZ/mByhU8RBm230DJnGYp6PQBLeNRyuQvhhX8
	M0JtlFHte/dGd7E/2BLkNbn9jGrlM2vavNOlQmV+feR2LDzPJ9t6pCoYtERN7WHxZTK+au0W/6Z
	235eFDXiEpxOqxk9hR4ymu5Dn1ZPimIC5hMKKZOy/TtFebs9rqZX9btGSkcFMzaXTsG5Fex+gBV
	qZmgFv2qaMOMk04scJBafjLh2uPy5/akJeORUK7wmVZPhwxp66Jjez3RGq2lU7z4VkEEjIcLaXZ
	qqHQfZDhLwD4kQvkJsNs2HsRIcy0Mkec7MnYRnFISrT7sMbgSA
X-Received: by 2002:a05:6122:4588:b0:56b:9b7b:83e7 with SMTP id 71dfb90a1353d-56d8a89484cmr792432e0c.7.1774998022785;
        Tue, 31 Mar 2026 16:00:22 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:00:22 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:02 -0300
Subject: [net-next PATCH 02/10] net: dsa: realtek: rtl8365mb: set STP state
 to disabled early
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-realtek_forward-v1-2-44fb63033b7e@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273775-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 9DACC372927
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Since we are going around and manipulating a number of port settings
during setup, it's safer to assume that the port is disabled to begin
with. This is purely defensive.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 31fa94dac627..530ff5503543 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1989,6 +1989,12 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		if (dsa_is_unused_port(ds, i))
 			continue;
 
+		/* Set the initial STP state of all ports to DISABLED, otherwise
+		 * ports will still forward frames to the CPU despite being
+		 * administratively down by default.
+		 */
+		rtl8365mb_port_stp_state_set(ds, i, BR_STATE_DISABLED);
+
 		/* Forward only to the CPU */
 		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
 		if (ret)
@@ -1999,12 +2005,6 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		if (ret)
 			goto out_teardown_irq;
 
-		/* Set the initial STP state of all ports to DISABLED, otherwise
-		 * ports will still forward frames to the CPU despite being
-		 * administratively down by default.
-		 */
-		rtl8365mb_port_stp_state_set(ds, i, BR_STATE_DISABLED);
-
 		/* Set up per-port private data */
 		p->priv = priv;
 		p->index = i;

-- 
2.53.0


