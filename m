Return-Path: <netdev+bounces-272920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEy+NvU4yWmKwAUAu9opvQ
	(envelope-from <netdev+bounces-272920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:36:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D635270B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F483300C371
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7936EAB8;
	Sun, 29 Mar 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LOkHatM1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ya64C7CR"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D55313552;
	Sun, 29 Mar 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794923; cv=none; b=NUqZM27OEPHYkSg0YEt6XhBxmTypRAYHStC5+w86KWV+frIIzfgKkV3A0b19T306QZFhJlMfS/QCw6DtgWpSOHDWTkxVdfJHncVA3TfWefFVrhTMpqaKOJkNkTJl4MTOL2Wt76Bjs0PIQu4SkXZ0+lNCfqSpoYx1EoqrzidSErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794923; c=relaxed/simple;
	bh=tUxbiSgA/s0Xx7o7+3Y8m8kSwCRGLgBGXbEjRR534JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+07Xf+6h12vSLu8pFMZRZrnUWpMYa4tr8VbdrvFvmBQVykhW2INImAwtMd6JchA8S0g3tS+l70CTKRMYYC94mSjfjpnzKePKrpSIAqLMP7v2Asq242M58753uNY13XWDQE1VNN0S1TwLmZ231R1hPjNyRjqykbfZ8OfoX4tzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LOkHatM1; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ya64C7CR; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fkH3P564jz9ygk;
	Sun, 29 Mar 2026 16:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFxFghpFoPQdi7SGn2QhRMR5os5nzruxLc6IA7icWvc=;
	b=LOkHatM1KR9v6aaNn5QUVUq0sI2M6nJDIYVc+rXcdC5wv7vvbAJpraEKJ/eBUHhkscTgXj
	MmVpkA6dDonpATZ3I2yxu8LUP4MccbgOt4KdGoWl4IzO5U0is6SoEtI4H3DjDqbUt3eYw4
	CH3qqTql0QpYFlD75zU21AZ5qqvkg3H1Eh+9qIpG0842Ias2uLHHXX54DFo/V6LZEba1Ke
	WeaC13edw7Str3haxgyJhn4GJq9tq7X7OIVQccDnRzfpTPUvmEs6qSTPMa/7SaHyDe6lPx
	U0R6i9CNUZ9I5ApkateDDaehrxu4ljiV44DV+2+VqBc39IT7Q4ASSCm5Do/YEg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Ya64C7CR;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFxFghpFoPQdi7SGn2QhRMR5os5nzruxLc6IA7icWvc=;
	b=Ya64C7CRF7d85Keb9V8f3ng9LLTwsJVDKlWcX1gJjKyMeQ/eWDk0oJK5E3qZPD70BB0nbF
	oN96XGVe1vQzwnXTdF2e5zIwp5cEwLoJHIAvGm0gHJVJIs+pUheMwoowCPwqSNOTr6HWTm
	80ryyGxbPMHKsHhrReSJpcdgd0/JvCUxGGpw3q+Ei9IQ5MD4Xp6xu5EMEMAF5gvBPxj52D
	jwb72awDwjrkZoBZrv7GXrkuyHAVqQCytso8iqNpHJkzwJ1UHoAjR5gwRaORl3rI2d2sYr
	NFepI/95ZOOPIzLbjyF3kPqBCCV9Gn017Tl9l/Bg/K+rLomQmaHDIt5bWGKNBg==
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 3/5] hamradio: mkiss: fix spacing around assignment operator
Date: Sun, 29 Mar 2026 22:34:06 +0800
Message-ID: <20260329143408.747197-4-mashiro.chen@mailbox.org>
In-Reply-To: <20260329143408.747197-1-mashiro.chen@mailbox.org>
References: <20260329143408.747197-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b741d444fa07ae12c2e
X-MBO-RS-META: psuwxqrsimaxyt7h1bt8k6ymon7zjdp5
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272920-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 172D635270B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing spaces around the assignment operator to
adhere to the Linux Kernel coding style.

Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/mkiss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 3721572ce..b9160b95f 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -201,7 +201,7 @@ static int kiss_esc_crc(unsigned char *s, unsigned char *d, unsigned short crc,
 	int len)
 {
 	unsigned char *ptr = d;
-	unsigned char c=0;
+	unsigned char c = 0;
 
 	*ptr++ = END;
 	while (len > 0) {
-- 
2.53.0


