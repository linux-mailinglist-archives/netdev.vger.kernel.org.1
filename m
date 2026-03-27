Return-Path: <netdev+bounces-272547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCKYNn94xmnwKgUAu9opvQ
	(envelope-from <netdev+bounces-272547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:30:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42069344370
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6943230CCF89
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC0396588;
	Fri, 27 Mar 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2VRXNBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B438B121
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614229; cv=none; b=HAbj4d4q08G2D1UysNsJe5MM1u8Zac8o88LMqqnvQ1oPNzgW1oW1YXkJeKErKxrfWne9O4hF1H+rCMeMc/Fu6ZG9OkFLs9Qs3EfEaUn8c69hH94Rgmqy0TWQcJsE651o2sW1odtRCwl1CWBi/A+Bi5LKL6m9g9UEwpr6KwHyouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614229; c=relaxed/simple;
	bh=VWj01YqhzQ8f1hRp9DZw2u/QC8qqsvOVh2wDJFArDY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nk21IKNr28DnKnzYKoT4Sp0DiNLEWMqfHVafFB6FqcbBhFDVCTVOwSwkGR+Pgh76319ptYAnEGPNFK7ua/wtHlgqEH1Cfq0bRdgdMsn5rzA4BLPUF8RbdzZr237BbjWUSkiuo7mioigRhyQzpX9lK9t//643uvNDFtKPDJVZumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2VRXNBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A66BC2BCB2;
	Fri, 27 Mar 2026 12:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774614228;
	bh=VWj01YqhzQ8f1hRp9DZw2u/QC8qqsvOVh2wDJFArDY0=;
	h=From:Date:Subject:To:Cc:From;
	b=B2VRXNBJ9+UKJ/HMervaWNZHzpv5Z9zM0Llo2NKPRiO+HLAZ2tWKs/yjXi93g/2bH
	 FiorLxMDLDxroVkrBw9kiiGMXxojM8L/SAlEyEmqC7DxrrkWyxw+dilDVLBYBZFeXg
	 Xs6tKniWptPF/UPokvbuDHrzXixyqX6xM3uC4HTYjM7pNmMsaebCZcSc2KklOTa9iL
	 krk+bNu2JPtSb4imyDuLOJiFfsemVV4pUHYu+FRoa51zJFhfxWfMyftfK1EXjZBRZT
	 ebUOCt/YKNpycNHAvh9jfn/P/lkVtnnfGhq4FR/dfkCI8SxkJEloVd6o8stAOLePUO
	 Lxy/dXwlR+Geg==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 27 Mar 2026 13:23:45 +0100
Subject: [PATCH net-next] net: dsa: qca8k: Use the right GPIO header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-net-dsa-qca8k-v1-1-94e613a5c369@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G6gtuH1FPESbahCqtiKC+Herx
 4GZuSFyEI7QZjcEPiXK6hMUeQbjTH5iFJsYtNKlMrpCzwfaSLiPVC/oTGUVNW4g4yA1W2An1//
 r4FM9Xwf0z/MCmZf0cWkAAAA=
X-Change-ID: 20260327-net-dsa-qca8k-f37d0a9fba3f
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272547-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42069344370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver header for qca8k includes the legacy GPIO header
<linux/gpio.h> but does not use any symbols from it and actually
wants <linux/gpio/consumer.h> so fix this up.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/qca/qca8k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index d046679265fa..1a00e2f62fef 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -10,7 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/regmap.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/leds.h>
 #include <linux/dsa/tag_qca.h>
 

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260327-net-dsa-qca8k-f37d0a9fba3f

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


