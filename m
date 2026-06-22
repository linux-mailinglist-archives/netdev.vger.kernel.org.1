Return-Path: <netdev+bounces-301009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NttsDAf9OGoUlAcAu9opvQ
	(envelope-from <netdev+bounces-301009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:14:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3526AE1A4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:14:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=L16aFXZS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301009-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301009-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97424305685C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319C368D5E;
	Mon, 22 Jun 2026 09:07:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F939AD3B;
	Mon, 22 Jun 2026 09:06:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119220; cv=none; b=Mvm8SkZuTUyNd2bFLr14Cporwl0yCEYM5LCQOfUUQzXsJoHrDPzLp8LmFp/rl3ii0QmHxcWr3g87fe6kYYOCdoFPqlJNwCESZd/Zwe3wjQvNEyr0Y+WluKDF/GCDnXTKFEB0G+3r/wgqKi+faBRvA+No2RuE4Ln4AZKtcfic4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119220; c=relaxed/simple;
	bh=5UnOM3smXX450FqdC6aUVos9Kh6GKDIEMHO+1QQVwtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFx9KEeFDXSnF1Htf+MwJwF0ciCO1dXsz0wNhga/1TXUSyUyCZbviDCSrfQzs2pZ0oEafG4DD4LdhahN/Jlw6o5+DMqthMlS9kz7lEVFuV2oqWpqr0F2TfhqgGqbrYKNPncpvxzX+oGodlMnnfevRfmiOklwC0UDIazZImlqTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=L16aFXZS; arc=none smtp.client-ip=54.243.244.52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782119144;
	bh=pwUGxXIMPqYWyVyXYf7y44GxNFxuIdo7lkLoCfU3S/Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=L16aFXZSeYRXYYUKuonKi6E0ECXVZFwhEKvs4dKwV5gT+cyBD6Ml8ytl4+asgCq8t
	 RuVFhNpgXRGLyAG6aXLB4ChokUMbgLylrrnMzzh5u6tnefFmJkANJt93xG67XB/S+U
	 b3vSMV627qMMMtjOyrt5ImlYScpBrRN+Oi17KRic=
X-QQ-mid: zesmtpgz3t1782119126te605c9e3
X-QQ-Originating-IP: WAZlGoezA6r/ZBjWtoe6c1qjhdxAizivWH0ENM+m7Vo=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 17:05:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16604666416164311421
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev,
	zhaojinming@uniontech.com
Subject: [PATCH v2 2/2] net: fman: use devm_kzalloc() for fman and rely on devres
Date: Mon, 22 Jun 2026 17:05:05 +0800
Message-Id: <20260622090505.2418478-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260622090505.2418478-1-zhaojinming@uniontech.com>
References: <20260619121328.922138-3-horms@kernel.org>
 <20260622090505.2418478-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MvyKdZyVtFx37Tb3zg3YsTs5tgV+0jhBgNWgcUh8PGdN6r4D+DcsGrw3
	V5cYj6PXbi73sXr+c/I3IvobSkbpMuVjNgFwv1+MrJXMViK+J31c75ULhFmD86LcoNPbFh5
	xGMUG38mi/hHpfJUPg0tddEXFl94tEB0iEuCbT5GRUvGHeSzbAisljuRM/oyh2kRhO8qnP0
	9LJGiohQqkn9PB0PNUyUAwQxNs+7AS3mrDEN07axMVHuUMjdx/MVymiSqNeDx3PWcfHbLrV
	8Qmk3ftPILLHOfOZXTBTfXkcVao42zLAmft0HlIb473qYEvwYLU8vEoYpBvfFFNll+1EOWP
	bvdeYaVs43ahWJbxyPhfpYw88xCiT94ZQd66saqAj3YIHt1TQZt5+XfFWb+3sQfgga4Y9Zq
	zGJ6f4gLXUDBsFx8V9Gw6thZ+p1DW+S50g/sMpTIzO9aTEC6Adk8iR0U2E3WrQmucAO53tt
	4tYX9rBfwsmFds3z1W+yjqT02UW6kc5Lm8v/wWZMIAgT8Z7Xi+hb64iVV2B2j9s0XDfUYsf
	+sS0LORbiSj6XZfh2SLlQfOM8BNqvmuhouNjI61jQxelur+Y5WJRaUq7CguOcVtb04n8lCe
	bRkJNwyo/lFLZXqGHHfHk9uTyeaidz43QYflgVBwIXE5ZQbymzfbNRUnbOb4dLpyZ1UQl4L
	NytQZkryhhsoubbvilVGnemqxKDRt0tjZ9Du80ZlEKwMgFUTCNBCgxrTYQc114Fp9q5wWLJ
	QrUM/y42qMhLEq9CemjFvn1CwGeT12/X/IDvi2cqksydr+frMEmyigH1zsZYoqU3N40lKG9
	IOZ5oX3icz4O4QWrpUTxtiamZ9yXsYledHK0nau/8prY/oR8yUsorKAmmS7StBLiAksYL8X
	qDzAwFfD8B2sVqR5cqun1csLH0BDYVXjFNEMXdiRIqN7UiF8dBpHBTcgmQN3WG0Zl1hhtrD
	dmmhR4+1RBD2EmO2VDgAMUfLwl6UHEDWXkdNwcgIY/r3D2WltPa3ji0lG19MQnxmYXLVkAO
	xGS7dXAi4No/pWy+0xAFw0hprbltgzohx9YwzVY0IdPeFkw6Gi
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,m:zhaojinming@uniontech.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301009-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F3526AE1A4

The driver now allocates the top-level struct fman with devm_kzalloc()
so that its lifetime is bound to the device and resources are released
automatically by the driver core on probe failure or device removal.

Remove the explicit kfree(fman) from the error paths in fman_config()
and read_dts_node() to avoid double-free/use-after-free and to follow
the devm_ allocation convention.

After of_find_matching_node() consumes fm_node's reference via
of_node_put(from), the post-muram error paths no longer need to clean
up fm_node, so replace goto fman_free with direct return ERR_PTR(err).

This change complements the existing use of devm_* resources (irq,
ioremap, etc.) and simplifies the error handling paths.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 31b0081bdf91..23b938afe17a 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -1793,8 +1793,6 @@ static int fman_config(struct fman *fman)
 	kfree(fman->cfg);
 err_fm_drv:
 	kfree(fman->state);
-err_fm_state:
-	kfree(fman);
 	return -EINVAL;
 }
 
@@ -2697,7 +2695,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	struct clk *clk;
 	u32 clk_rate;
 
-	fman = kzalloc_obj(*fman);
+	fman = devm_kzalloc(&of_dev->dev, sizeof(*fman), GFP_KERNEL);
 	if (!fman)
 		return ERR_PTR(-ENOMEM);
 
@@ -2759,7 +2757,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		err = -EINVAL;
 		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
 			__func__);
-		goto fman_free;
+		return ERR_PTR(err);
 	}
 
 	err = of_address_to_resource(muram_node, 0,
@@ -2768,7 +2766,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_node_put(muram_node);
 		dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",
 			__func__, err);
-		goto fman_free;
+		return ERR_PTR(err);
 	}
 
 	of_node_put(muram_node);
@@ -2778,7 +2776,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err < 0) {
 		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, irq, err);
-		goto fman_free;
+		return ERR_PTR(err);
 	}
 
 	if (fman->dts_params.err_irq != 0) {
@@ -2788,7 +2786,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		if (err < 0) {
 			dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 				__func__, fman->dts_params.err_irq, err);
-			goto fman_free;
+			return ERR_PTR(err);
 		}
 	}
 
@@ -2796,7 +2794,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (IS_ERR(base_addr)) {
 		err = PTR_ERR(base_addr);
 		dev_err(&of_dev->dev, "%s: devm_ioremap() failed\n", __func__);
-		goto fman_free;
+		return ERR_PTR(err);
 	}
 
 	fman->dts_params.base_addr = base_addr;
@@ -2808,7 +2806,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err) {
 		dev_err(&of_dev->dev, "%s: of_platform_populate() failed\n",
 			__func__);
-		goto fman_free;
+		return ERR_PTR(err);
 	}
 
 #ifdef CONFIG_DPAA_ERRATUM_A050385
@@ -2822,8 +2820,6 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	of_node_put(fm_node);
 clk_put:
 	clk_put(clk);
-fman_free:
-	kfree(fman);
 	return ERR_PTR(err);
 }
 
-- 
2.20.1


