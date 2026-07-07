Return-Path: <netdev+bounces-305550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A0BaFxU7TWqHxAEAu9opvQ
	(envelope-from <netdev+bounces-305550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:44:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3D671E5E2
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:44:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=JRJUnV2I;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305550-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305550-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F10AD300ACA0
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388F437863;
	Tue,  7 Jul 2026 17:44:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE1438482
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:44:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446290; cv=none; b=JKNBIzXKjRJuRfRbqqPGJPHx09dbFUP/FG4yItTkohy7ctDgsEzPMou1RmYzMPNBvewUEPEqawUURT8111VlKyye1DwyPTpHxIawRtyDp/saoMjNmuJNg9owehqhtp+TNXZHxSNOvjkHRik1Pp/od/pjohC1U6e/c5VMymrAKJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446290; c=relaxed/simple;
	bh=2Bp5t/KlqZHKTfhPvGmYPg5J37BtkKllx/rG3/y3D94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ngQTDtK2dGp0QilUP/hdf2llmH8YhBXLcCdaYID7Jk8n8660a3//R5fE949x7kJIuTTDj6U4QAKjOqnmX6CvJnO/WbJmsTnMqMNYm8H7RmDh4iDLUfpoKt8F86bpXokKiVSpsZp5jR04pXDd3Tth7+xMh+hEEcajn8v0MsJ5GOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JRJUnV2I; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174441euoutp024b86091b98fdddfac3383556db7336ca~AEvGoT9Vg2061020610euoutp02p
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:44:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260707174441euoutp024b86091b98fdddfac3383556db7336ca~AEvGoT9Vg2061020610euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446281;
	bh=6lgwdnEn24PopOzdpstGeWRcgCfBKK0UG6WHCBzKOg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRJUnV2Ixx+tyiPVvh9zBM9GyPlnmwK4y0hzqJra042KHeaI7QgHpe8dWpcEoUCP6
	 3uaxgKg5NgcJPkMSpIvlHnsZ6tn3PmyACROFuWTqQJNl1qN74WK37SlNuRSbrfUgZF
	 iEUgfV1q8A4uDB6tJO/TKmUSxmJTXnNd4w5ve17w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056~AEvEpANIX0453604536eucas1p1a;
	Tue,  7 Jul 2026 17:44:39 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174438eusmtip2b15724d2727fe1b8344eee30956fb692~AEvDi9bfW1215712157eusmtip2g;
	Tue,  7 Jul 2026 17:44:38 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net 2/2] net/stmmac: Verify provided DTS AXI setup
Date: Tue,  7 Jul 2026 19:44:31 +0200
Message-Id: <20260707174431.1264520-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707174431.1264520-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056
X-EPHeader: CA
X-CMS-RootMailID: 20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056
References: <20260707174431.1264520-1-j.raczynski@samsung.com>
	<CGME20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056@eucas1p1.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:j.raczynski@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA3D671E5E2

During parsing of AXI setup, there are few issues:
- 'axi_blen' array is uninitialized value on stack without zero-init stack
  configured. This can result in random AXI burst length config if
  DTS config provides shorter array than AXI_BLEN.
  Fix this by initializing it to zero, which allows to provide shorter configs,
  which sometimes happens where only one value is used.

- stmmac_axi_blen_to_mask() is executed regardless of return of
  of_property_read_u32_array(). This is not issue after axi_blen is
  initialized to zero, as zero blen values are skipped in
  stmmac_axi_blen_to_mask(), but that would be useless operation.
  Fix it by checking return value of of_property_read_u32_array() and
  parse any legit config.

- In case of failed memory allocation for AXI and error, there is no handling
  of that. Fix it by checking if AXI config is error and return if so,
  as this can only lack of memory. No AXI config, although is probably
  wrong in most cases, is not treated as error, as generic config is mostly
  provided in drivers.

Fixes: afea03656add ("stmmac: rework DMA bus setting and introduce new platform AXI structure")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 9112cd69b9b1..0acc61a98292 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -95,7 +95,7 @@ static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct stmmac_axi *axi;
-	u32 axi_blen[AXI_BLEN];
+	u32 axi_blen[AXI_BLEN] = { 0 };
 
 	np = of_parse_phandle(pdev->dev.of_node, "snps,axi-config", 0);
 	if (!np)
@@ -115,8 +115,8 @@ static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
 		axi->axi_wr_osr_lmt = 1;
 	if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt))
 		axi->axi_rd_osr_lmt = 1;
-	of_property_read_u32_array(np, "snps,blen", axi_blen, AXI_BLEN);
-	stmmac_axi_blen_to_mask(&axi->axi_blen_regval, axi_blen, AXI_BLEN);
+	if (!of_property_read_u32_array(np, "snps,blen", axi_blen, AXI_BLEN))
+		stmmac_axi_blen_to_mask(&axi->axi_blen_regval, axi_blen, AXI_BLEN);
 	of_node_put(np);
 
 	return axi;
@@ -580,6 +580,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
 
 	plat->axi = stmmac_axi_setup(pdev);
+	if (IS_ERR(plat->axi)) {
+		ret = plat->axi;
+		goto error_put_mdio;
+	}
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {
-- 
2.34.1


