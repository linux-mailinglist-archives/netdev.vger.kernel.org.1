Return-Path: <netdev+bounces-276883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJy5G+Jg12keNQgAu9opvQ
	(envelope-from <netdev+bounces-276883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:18:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C51F13C7A51
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB070309DFE8
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052339FCB3;
	Thu,  9 Apr 2026 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="cutfWxTf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0581D3976A9
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722420; cv=none; b=HzT5UxCpLij+WMlrZuspJU3bM2f2hz4dS4EhkHknW2d6BUlFbqdiq39T/n8NMEjN9qr1oaaMsrGSitvqtSZZQQ6CC8x09nZz0S+7NV0N4jLmi3mc6P3PFP9mkutetf2uo+OGOUDIVXs0yEx6egjjsxOiMW8GM7CsplycDxQZyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722420; c=relaxed/simple;
	bh=wamlg7cG4onOyAvlIExCjVjWIJuPxmnTcceFW3Erxjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LI73ZWx+aNBt2bkNRFS8UPkMivOKqDFTQXaOtYXThU/mCuIzaWyxjQz7hZaV33KKGuEZTaCArViC2UdYD0GIVLT9LW1wWccHwRy1qzpysK8oOb08h9W3i8ofoStf7U6vd/+pEZuMTOCiNnOKdOfT+gEcuSHAC0tzYe1B61XuCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=cutfWxTf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c6680aaf8so99080066b.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775722416; x=1776327216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJTqTg29y4fyyCQIM/Qide/ZIGLKp0SbPQP2kYlNUwo=;
        b=cutfWxTfiQP1lUJE92zdljC1M49hCuOiMfT76lg7gUReZkQ3ZF0h+1T33TeftsJITd
         hVYbWKaFpvB+xD/S5NM1sZyVcHXkFd3B9xVnLxp3lXF0MmojPWjHYo68VidKT8vL2GRu
         0znqA1bgnvaaD5kh9u1+wUA+1PrjFa5Hbwwq668R3uRcLxOgDNq5VGLJfL9RLYWeB/Mi
         awpplN8dqPO/OdByS8E8f8IXSUsW5kD5JET6roJwPshM07iVF8Oe1qY4EpjWK4edH6xU
         nMb3Vij+7ofATzFXOI11EHicMyG2HHBbaFIEEoLD6SJlmbJSshtI6If9laZ/Qx8HtwtT
         1R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722416; x=1776327216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GJTqTg29y4fyyCQIM/Qide/ZIGLKp0SbPQP2kYlNUwo=;
        b=mZRCETB0blrflmYzUqZUooRiIeaPgA864Mxojg7rUjm6vnp0PsWwe1fwUthG8X4j+P
         kDRdyS9rjs8CMJLiRklWBrAcatH1ZOAau+fMdZ+uea/d5MlqazWuaXgBadMJRauxIT9U
         M3aciMxXChqFchsSc0KENVFJd84MkySPCUiI5CDVIwc0wMlngJiqLWCtqxVnuudtlPnv
         v55yv2Qprz2oBS472G2NxA5S04dG4bkO65JK7TRONS818uAh2suMFhcigwTjpdoJAggE
         6mwNfP4kiCN29qDq1WTuFtCOkmKokQ8mv7z5SpQ7ANkO6SZeKWwg5Oa+cXIU7UX+6waS
         4Dqw==
X-Forwarded-Encrypted: i=1; AJvYcCVZPlv0/MwwNn2bBjoJhd2N6Z8mgHsrjugP2NA5ygpGxfpmZQd/gbOwmgHqCLrfgyZkEknpbUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8An9YrcfbfwG62j+/A+jJAmDuMRbjjpygeog+RGOXADUPaogi
	K2h2NrLafZg0rA6Z2As4QQBHbAkXylKstVzU4zQxXJo7MeDigW1DBGvhsdJvzFDb4GK8QEvjyx4
	mntRe1T8=
X-Gm-Gg: AeBDievZ2UvNMoXrkG+XUWUsR7I67ctZ4TJVSpb+Y5/MVIH5nwyBA4iak9M0WVO6D+R
	UA1DGvwgw+OUx5HAN2es4dBFCx4D5Z5XHysP7HfjIjfnm2Cq5ck3/vBnUGX5g8ATl18cGc0O953
	psfW+ULckRG2RvTD+j5Ya8VzUTCNy8KnhVYx1bWy8WKnTXz7Fhq8Q56VE0G6up/bKPOR+1hvAbi
	wSdxAa7WaTnqpYqq06/jWDuIC319oE+p+1tekKUn2IC+uLstTbvqf+ZvrWf+iF6bPny1JTEL4sK
	+0XVVmXBMzvgmZlSj4RalyOwBruljg8fy0GPIIAsvahmnoZinwBpYfEk1IB6eGIOhAAjrO+ty69
	EIVbt8HceJTL3muqd/hbA6djBfzkKD8W+zo9wgWxQ/yhg1FfFlx2fuDWX6016cbwJaV73nSj5X1
	6yqDRyUtYmzeJP2e+nvf5t0a1Y1MnCjLB1o7enXWyBfRRPsbuxAp+zFc9swhu90zHHs8RaiBvlH
	KAA5Q==
X-Received: by 2002:a17:907:3c85:b0:b98:286a:e2c2 with SMTP id a640c23a62f3a-b9d476ac76amr120880466b.38.1775722415821;
        Thu, 09 Apr 2026 01:13:35 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6f20sm709846066b.38.2026.04.09.01.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 01:13:35 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 09 Apr 2026 10:13:31 +0200
Subject: [PATCH net 1/2] net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ipa-fixes-v1-1-a817c30678ac@fairphone.com>
References: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
In-Reply-To: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775722413; l=1436;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=wamlg7cG4onOyAvlIExCjVjWIJuPxmnTcceFW3Erxjk=;
 b=XZUulr8BhdYKcjjF8UzgaLp8pFwenn1sWPeLayNoINHm02FB77AyoV17swCL4CwNvDNSccWeg
 ea0YmdRC+XKDrAalkWmGOiQnYrsAI0HM7+Hk4KsUAtNMY6UyJ6Uq1q6
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276883-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fairphone.com:dkim,fairphone.com:email,fairphone.com:mid]
X-Rspamd-Queue-Id: C51F13C7A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 'val' variable gets overwritten multiple times, discarding previous
values. Looking at the git log shows these should be combined with |=
instead.

Fixes: 9265a4f0f0b4 ("net: ipa: define even more IPA register fields")
Link: https://sashiko.dev/#/patchset/20260403-milos-ipa-v1-0-01e9e4e03d3e%40fairphone.com?part=4
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/ipa_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index edead9c48d1f..216506eeef1f 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -361,7 +361,7 @@ static void ipa_qtime_config(struct ipa *ipa)
 {
 	const struct reg *reg;
 	u32 offset;
-	u32 val;
+	u32 val = 0;
 
 	/* Timer clock divider must be disabled when we change the rate */
 	reg = ipa_reg(ipa, TIMERS_XO_CLK_DIV_CFG);
@@ -374,8 +374,8 @@ static void ipa_qtime_config(struct ipa *ipa)
 		val |= reg_bit(reg, DPL_TIMESTAMP_SEL);
 	}
 	/* Configure tag and NAT Qtime timestamp resolution as well */
-	val = reg_encode(reg, TAG_TIMESTAMP_LSB, TAG_TIMESTAMP_SHIFT);
-	val = reg_encode(reg, NAT_TIMESTAMP_LSB, NAT_TIMESTAMP_SHIFT);
+	val |= reg_encode(reg, TAG_TIMESTAMP_LSB, TAG_TIMESTAMP_SHIFT);
+	val |= reg_encode(reg, NAT_TIMESTAMP_LSB, NAT_TIMESTAMP_SHIFT);
 
 	iowrite32(val, ipa->reg_virt + reg_offset(reg));
 

-- 
2.53.0


