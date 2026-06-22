Return-Path: <netdev+bounces-301010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P3lXLHD9OGovlAcAu9opvQ
	(envelope-from <netdev+bounces-301010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:16:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B96AE1CD
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:16:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=VNgSpSOG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301010-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301010-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E43A5304043B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB0D36A369;
	Mon, 22 Jun 2026 09:07:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CF363C6C;
	Mon, 22 Jun 2026 09:07:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119232; cv=none; b=okQHhb5uBJezVvjIZfEI0OccNXp+drfU9S5JnQnwDctsSZ9RJ4ZDXICNkEWI5SgBfZ7A9pPf0sTOsrM9pgEsWbs0lqKbyrTOH4eG2xAY41zgSbc68PUqzsBZyI4HBWnPxjV3IqAQtSBBMkQFVCiWj3b4pTCRHUWC6QjrhfhztoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119232; c=relaxed/simple;
	bh=nJVXmVDY6fj8Jkz5rX/Bvm7WthGIyIkfF9MTEk0djKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nwe/FCvR2X4OClTlHGm3qteBRBxFRePlIIMfTdaUOFzROaWt/ctuHnlKvQmSsnOjSipLW6tKbwzyY91DACTRf2/UnitnssTEQjd8nvT86Tj6n63dULRWD9V4TOKGkPGAMQj4Ec1KRb7GbgXlAvsCBAsxVhvbfUSaN3ZQpRDD/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VNgSpSOG; arc=none smtp.client-ip=54.207.22.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782119135;
	bh=YwanOJOBZw3lKW2p5b1/Xyem8AZOuZaSgWGJ17KuRDE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VNgSpSOGBvIl5vFZBTbMVjjmgKSOI/rPtl8KQ/Xa74cz/0cjl7m+q7h5TOcsn3jYq
	 4vjMEVv6R8FUAdhFovyyaCq+w0SORiSY8R0g6mJd+emCRFF9u1VXaVOtL36CHqSQUE
	 bUD/JJVfK1HZ8KrOJr3eo/tUygeW/Mgv8MpUqurE=
X-QQ-mid: zesmtpgz3t1782119117t68845b0b
X-QQ-Originating-IP: 6N5dvQhryBuoB0IdUROh7OrmUPKSJc2P8o5IdwaXUP0=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 17:05:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11900996019285188267
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
Subject: [PATCH v2 1/2] net: fman: fix clk reference leak in read_dts_node()
Date: Mon, 22 Jun 2026 17:05:04 +0800
Message-Id: <20260622090505.2418478-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260619121328.922138-3-horms@kernel.org>
References: <20260619121328.922138-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NwZEY09ZZGEZjAXbO0mUYUsB+Qoke/k3aUXQYWKkeAS4UWnxo771zOKH
	deyb0DzyYIkt5nD+GI1/0DeEIjqla8VErYxpsAIl3XzXSpiBIRQ9m5HHN7qjEP2UX4sx2y8
	NwfwK+haczfbYitXcIc+7Sk0UIwUp64dbtGK9M5h5ISCCZKB89Uhbc2k/K1jPRiQawh7mjG
	amxTg40+wVUMmNLTya9LZx440q/I7Cd/nNdN9EpW/bUGSx8Sn1e6tSaPEStdXWdIqsMS5Oq
	2kTJ/TjGG2nTdcBtiQ+1iMcpvM/0qyOeXr8TaZV9FzdTlF8Lb63psbAdKmgMUCmyd5p7csO
	FlerG1fmwPGdka9ukczMMiX9/dBkKSB6peHKLApnNWkHmi1ASK24hiNtoBzfxGPVngorh5j
	0wKDXGFuCnjiMYTPePHehkcc9n9UNpESGZPM9wIvx1Lvg0nW/ZPPY53/8XNbjhp9Pcmxa7y
	NvpUJmr5n5FHWbpmR0sJLuFrUupynxvPCL60SXH9Ifo0ZUqbMSa9e2ekqcOSTtWWap753T0
	BIxSg/lsGqYMgqRVIxfaMj6Ehf+sw2VAVDPSLKx/Gmz64BStCSG3b73MFF5ZaWO+KYDqF9m
	VghuVG8t7L4GWqI3ujvAkoL0cw2dlqsbPb1LMy9oF+fPW26Zs9CXLPij1oUFfTiCfTZp+cC
	U204MPBu2Hg4CaUTRBVpFwlyiYJmx6kFzrmU1Xs9eRqCHVY5qea4CR65lIO4McWTxnfGV1z
	6TOKIPzdEAFouKa3G6bP5zNUJ/cuvt2o4UdF09XTMixNzMrf5wBINe741trlYN01g1GhKex
	A0WEJPGU/VLRO+JdV7AWid8m6OLTbcwWk537Q3g8jaRet7LfnJpLYntyuABcCTRETqVP7x8
	DNgyvwNpn/tEmgelO6iGCWDr7VcdM5621c5Co2GVSoNpmubwn8xtGiuYGnh5ef9haM/Q7Sz
	mt5S23xZ2/l8PUr0oC0Gox44R8artxPTYQy0b6XcXuIeQ8kH3S1vyeN08BV1n6lvi6mPryb
	JrzCDL1w5cwmlVuQXp3PQIgQKZk5TQtJPPTpCxikNT18UWrLtI9dOuarehyR4M/Wu0UDk06
	w==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,m:zhaojinming@uniontech.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301010-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 359B96AE1CD

of_clk_get() returns a reference that must be released with clk_put()
when the clock is no longer needed. The current code never calls
clk_put(clk), leaking the reference on both the success path and the
clk_rate == 0 error path.

Add clk_put(clk) after the clock rate is consumed on the success path,
and jump to a new clk_put label on the error path to properly release
the clock reference.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..31b0081bdf91 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2736,11 +2736,13 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		err = -EINVAL;
 		dev_err(&of_dev->dev, "%s: Failed to determine FM%d clock rate\n",
 			__func__, fman->dts_params.id);
-		goto fman_node_put;
+		goto clk_put;
 	}
 	/* Rounding to MHz */
 	fman->dts_params.clk_freq = DIV_ROUND_UP(clk_rate, 1000000);
 
+	clk_put(clk);
+
 	err = of_property_read_u32_array(fm_node, "fsl,qman-channel-range",
 					 &range[0], 2);
 	if (err) {
@@ -2818,6 +2820,8 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 
 fman_node_put:
 	of_node_put(fm_node);
+clk_put:
+	clk_put(clk);
 fman_free:
 	kfree(fman);
 	return ERR_PTR(err);
-- 
2.20.1


