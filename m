Return-Path: <netdev+bounces-300345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eiV2DhalM2p+EgYAu9opvQ
	(envelope-from <netdev+bounces-300345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:58:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E413C69E460
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:58:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="DmRK/I4D";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300345-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300345-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 884583094F2B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE453D7D64;
	Thu, 18 Jun 2026 07:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F32EEE61;
	Thu, 18 Jun 2026 07:55:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769363; cv=none; b=XvlCW2Eym47JZxYN2A0FR8GdUfo0W7PGCl8FvJ/8BHa0FDN6zEkVxjzctB1XLxjhOIDKNhcFZjLu9a6jVyul1SvQ/IL88u1ajd/miiLbree4Is4+JL6WGoe2FvBSvm+Y1jVUm7FgIBwFzTxFZkh6BqBOwkR6rv5TNeRwjMPHOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769363; c=relaxed/simple;
	bh=izr3e8xaE7FSAJNGWP+NVdtsvkPSw/DkyFydIwoKxRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTHanOR65dbY1tzbg/pKcZ0/soPIDfWlyU+i0p2hu1oj5ZitRUkl2P26ZhtY1wcDoxYlnhrnUfhHemBCL6riawousU+vS2RpZ6vz2ZDkZdEVqQVYhqLypOUfFrUiRPgVUfYnvmSghMkPhXPZuEtU8esyYZe/SN9R6Dn3vYBf998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DmRK/I4D; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769294;
	bh=T717HZ9C894Dqy1jhhFqWn/Sw6LU783IrPcrALglV6A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DmRK/I4DJMSIpKJrljAOe48SMPr9+KnRKneP0dGEH4XJdRtyo2bh7p9nEfDGivzr/
	 BvCIZ/Aa0TdoWKj49UMO7WaRHruS1hx86HhmsHtndE5q9JIq2B1cKZp3UyfPTSR1TX
	 +bJ8dMN1DejGrqTxiFv+KiuVhgycJ6yOhkQxGjIo=
X-QQ-mid: esmtpsz16t1781769289t900aa2e9
X-QQ-Originating-IP: tc1D/NFqEptOKYSwYkBpaUPy7wavTZGxAmL57KVP/4U=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:54:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3650313968144136322
EX-QQ-RecipientCnt: 10
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Madalin Bucur <madalin.bucur@nxp.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] net: fman: fix clock and device node leak in probe error paths
Date: Thu, 18 Jun 2026 15:54:35 +0800
Message-Id: <20260618075435.1262533-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OUC5DGN0mB58LQVcoNVdoWumBJy6hy+uuoUIioHx9HNLdtMo6NWb6XSv
	NnnlcDxnatBInMCNgkMmgD1dIROtr4qzJBDu8ylxqrJEgfB3DisXmFnxwcYda3+CerD0TvV
	BJQOBDiPNiuLeyvUBmIPT9IxhOHaBvMqJDvDFCvmYbA17Q1VHnLhqUUsq9Xk4sdOyO2s6zO
	A/FMkG9ZnkZ98cAJeo3D0HwAHWtSZuWzLCVFojl99rJ/nuL2ycWHHsGC0P+lCFjNIY/2AKy
	FHPY18oSdYQQo/2ClOMGSm2zafg53RLgrhUJLEf/ELLsMcFteggcokquepgTK6d4dHBOgl+
	Dkau/A6R/z7fVVPsuvYmnUVMuIMhonQtIhoPXN+KvgaXiIfNcbx3ZxrbA+/9H1YOPfZ5+ZN
	lmu+/BBcvlYpe94pvL1+b7nNO3LNifp+PK5+t8/rID5J7f4JFm4gQ+OLNchfjwhWlqQie07
	mRXvT8uFxdL1goZI2OVODtCk4oAJMwD9aEr5qm/kldzo2jjgY0/uWsQWp0HdnmPjaYVuXuT
	kermYTZXpKuWZru9597ShETLi8sdSxZ2xwVzSwSblm6YAMjXUjJvndNixDIdPoaJojzNH53
	pjBsY536n/Agi4xHXL2Fq3J+G+6Affo5/XHwlp8PQQguZ6cBndL3QifambbD1ZQMQ01tnSa
	jq0EMEMFE43u4YG57p6pWrD815nD8wcmcEWvm9OTpVdEuhD3KV170gbm+idU6p7S8og4zb4
	xd4G4okRpu9wjlVnbWQzm0Al624N0lyZSEZ3kqtfnL8dre6o9nrhcYeo1+NETCE06clCOM/
	qZaK5DCqctwPuEsn0cPcdM6UFoDjRxRkTY6OmslLv5S5AY3yFou3ZLrKdivCglIyhjreY/k
	SnNr6u77XU87Q/+eHvn6M5TLjnFKWWUXVjVSCwH8oBf7fsUjtTAgaz9bvST3OEt07O/Ph4x
	2rWQ2H0l8iYsDIE9MNPkEQinchI1SloKOnjulQDklo0h1qvZ4X5flQYMOyyqvz/FqyjNzpT
	M8LHzW6IbdiyjFIQ9GwmS2nACU2q76o4m6MqURDzqs1sVG0ffU
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300345-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhaojinming@uniontech.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E413C69E460

In read_dts_node(), fm_node is acquired via of_node_get() and clk is
acquired via of_clk_get(). After a successful of_clk_get() call, the
error paths for clk_get_rate failure and of_property_read_u32_array
failure correctly goto fman_node_put (releasing fm_node) but miss
clk_put(clk).

Worse, all error paths from the MURAM node lookup onward goto
fman_free directly, skipping both fman_node_put and clk_put, leaking
both the fm_node and clk references.

of_clk_get() eventually calls __of_clk_get() -> clk_hw_create_clk() ->
alloc_clk() -> kzalloc_obj() to allocate the clk struct, so clk_put()
must be called to release this memory. Without it, the allocated clk
struct is leaked on every probe failure after of_clk_get() succeeds.

Introduce a clk_put label between the success return and fman_node_put
in the unwind chain, and redirect all error paths after of_clk_get()
to this new label. Since no goto target remains for fman_free, fold
it into fman_node_put and remove the now-unused label.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..734cbe8efd7e 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2736,7 +2736,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		err = -EINVAL;
 		dev_err(&of_dev->dev, "%s: Failed to determine FM%d clock rate\n",
 			__func__, fman->dts_params.id);
-		goto fman_node_put;
+		goto clk_put;
 	}
 	/* Rounding to MHz */
 	fman->dts_params.clk_freq = DIV_ROUND_UP(clk_rate, 1000000);
@@ -2746,7 +2746,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err) {
 		dev_err(&of_dev->dev, "%s: failed to read fsl,qman-channel-range for %pOF\n",
 			__func__, fm_node);
-		goto fman_node_put;
+		goto clk_put;
 	}
 	fman->dts_params.qman_channel_base = range[0];
 	fman->dts_params.num_of_qman_channels = range[1];
@@ -2757,7 +2757,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		err = -EINVAL;
 		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
 			__func__);
-		goto fman_free;
+		goto clk_put;
 	}
 
 	err = of_address_to_resource(muram_node, 0,
@@ -2766,7 +2766,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_node_put(muram_node);
 		dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",
 			__func__, err);
-		goto fman_free;
+		goto clk_put;
 	}
 
 	of_node_put(muram_node);
@@ -2776,7 +2776,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err < 0) {
 		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, irq, err);
-		goto fman_free;
+		goto clk_put;
 	}
 
 	if (fman->dts_params.err_irq != 0) {
@@ -2786,7 +2786,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		if (err < 0) {
 			dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
 				__func__, fman->dts_params.err_irq, err);
-			goto fman_free;
+			goto clk_put;
 		}
 	}
 
@@ -2794,7 +2794,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (IS_ERR(base_addr)) {
 		err = PTR_ERR(base_addr);
 		dev_err(&of_dev->dev, "%s: devm_ioremap() failed\n", __func__);
-		goto fman_free;
+		goto clk_put;
 	}
 
 	fman->dts_params.base_addr = base_addr;
@@ -2806,7 +2806,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (err) {
 		dev_err(&of_dev->dev, "%s: of_platform_populate() failed\n",
 			__func__);
-		goto fman_free;
+		goto clk_put;
 	}
 
 #ifdef CONFIG_DPAA_ERRATUM_A050385
@@ -2816,9 +2816,10 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 
 	return fman;
 
+clk_put:
+	clk_put(clk);
 fman_node_put:
 	of_node_put(fm_node);
-fman_free:
 	kfree(fman);
 	return ERR_PTR(err);
 }
-- 
2.20.1


