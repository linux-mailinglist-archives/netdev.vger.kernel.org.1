Return-Path: <netdev+bounces-283223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFz4IhTN9GkDFAIAu9opvQ
	(envelope-from <netdev+bounces-283223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:56:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B584ADC73
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A01E6301583C
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FBE3D5666;
	Fri,  1 May 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="tNcg/P1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE423D5657
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650878; cv=none; b=dQSE11fNO1Qvju4gin6ZpBcZ2LrNd5G3VagvVOmVBH4gek3l4AvkUG/tof3QetT4wprniWe0BHmCfnpBdAmDfNn+76CqqZomSs8qoGNDADD0HgVnhKPqXZL0czwtZ5qpNRC9iozNY7BICng2vcxhzN5UNGpsnBg3oEXw5egnFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650878; c=relaxed/simple;
	bh=FecQt5wh6wqUypR7GIOTL8vQl1Ce+BG0nyhOWnwbzHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmhLTgyanSTIfPdfOZceZe4tUFlyKukABqOUbyre5SRRqGiXkA/2C2WtduCZt3fI83jDMyRcXEpXuOPUrjZU8T6eLt/OhpuulyDnt6oKfrneJIu68/hPPULkJIc8KHWeCMfR73BVNuBW1Xi6NAsdq/wO+EWdYfAsK3i4dJJCWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=tNcg/P1P; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899d6b7b073so21010146d6.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650875; x=1778255675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HU0BdifEzvMmdb0M7vix3Brd2gKsWcYWwUTy3bx7+E=;
        b=tNcg/P1PC+kwjWrj+0nDkm12iH83g+0LHIXYlZK9eJvfzDn6Fbx2ejBpmXkXWEbJzi
         dx/ij0rAWyHvUW4t3j57Lz9to9iqAvr7Kb/rbWAmZSR604/Wh4NQ14zcJxh0t8PSpdhr
         3TsOZJxn6w1Hy0Vgf6LaQdO8Ce7xKOmPUzRYOHsuj99wMrM2L5S2Q5VhreaIDRppxEG5
         xc0C8J9QL3TlM9akv6ha8pEaXilam+JPmyVG2IZP/Locgn5ZauqbTgbhqbKPDMkbQZye
         qqpYKADzZgQb2uDeCn6UUt3OSuUNzwKqW3z5MrQEo/NxhQdC7jeVuUqna/uqMsmHIqZ2
         mhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650875; x=1778255675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/HU0BdifEzvMmdb0M7vix3Brd2gKsWcYWwUTy3bx7+E=;
        b=ryECmbMkP8r6OgyznRv6+aDFw1YK7QGKUXWp6zGYI4GQOBxW3aHFjMTGkSvh6a8paF
         71XT4qOUJCM7nOI3eyNA9SbaeLDHZ4Kxz67hcJA76rWkoPybqUpJRWYkIdVQQRejuCby
         DJ+J0C6ztMHxmIvQifp2f6lqf0B0KFb3QIBlmDhL1ej/SMs5RHMPI1+njQ5RprZXIpk3
         6fWFUTgb6WwBTggbptnfalbylg3z8ISgk4wacR7Nx30ubgSOrleKzHvGEovTLVcpcwvC
         laUWdxyo+mhERlnJXjMVm9MjMw4kfcUbcViByrsMLu4r20tsgtdbR2ILMPqzQmImL9iW
         IIdw==
X-Forwarded-Encrypted: i=1; AFNElJ/FJqLlsHkjb5ic3nSyQCa1x9XJEfSQlaTYdYiwfZbpyHCNZYgSJOqUyliSNrYG5T4ukN49we0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywugnr7WyjURVq8EyfZ8sFOcFu50c/GRmOs63sXFX4XN1GV3vP4
	EY0kIZRK3QDGLOsiZ6dO8MbiZnaxi4JNLZbK8EOs5Zpg0xLuJfeyUfIk+VUQZwg1SD4=
X-Gm-Gg: AeBDiesOkXrjSyvU7ivOGjf38P7cReVuYB/Zl3xP2Y4zlFoskWY9eLScRBKdnnDj6wz
	++g46pbRT1AUZ5JLtO6r8HNTU6AmflX0yV3LT092tQPmb08wnD7Yz5QgRY67wfdbxnk+pKezs88
	gVSGNl2nHvm4VX8TXNiIcytQ87WXwwLsvQ0RRwfJG+sN4HquHIJWNjzxm75LHMyr3+PUrLGlH/q
	uluThyu7cwrBVLpx+hABM9tQArjk3XwhRl/2s3dxfp9MCyhi2QXlHm1oK0nFEIdvQxCr0tvU4xQ
	bJ/uDWlikDEzllCD1Gzv+LrQ5XAXUt2xTEvd2QTwZTE0Ls9NkQVxxTSRRdZuSnQrJ9OiwZflhpl
	o/TGTqhlpEWTEv5N+4FDhej+jKFVzFqmPH1xwNMipTj/SIuE+fScJ6ZN41oHjXCPeyVcw4WMP57
	F9Kn9GMObxpoAT3LjkbYKTgof/CdOcyrHKMVLduhkMq7EkTxeh0zdQh/vdN9enbCHmD/EFQ6JXK
	zCHOCULLrBoO+bY
X-Received: by 2002:a05:6214:3d9e:b0:8ac:b63e:72eb with SMTP id 6a1803df08f44-8b6660063bbmr1282856d6.12.1777650874598;
        Fri, 01 May 2026 08:54:34 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:34 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	matthew.gerlach@altera.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/12] net: pcs: pcs-xpcs: select operating mode for 10G-baseR capable PCS
Date: Fri,  1 May 2026 10:54:10 -0500
Message-ID: <20260501155421.3329862-3-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D3B584ADC73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283223-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,kernel.org,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_GT_50(0.00)[50];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar.com:mid,riscstar.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Daniel Thompson <daniel@riscstar.com>

Currently the XPCS found on Toshiba TC9564 (a.k.a. Qualcomm QPS615)
is unable to operate at 1000base-X and slower with a PHY connected
using SGMII/2500base-X (in our case a Qualcomm QCA8081).

The problem arises when the XPCS supports 10Gbase-R. That means that
the reset value of SR_XS_PCS_CTRL2:PCS_TYPE_SEL (0) is valid and this
suppresses the modal switching based on bit 13 of SR_PMA_CTRL1 or
SR_XS_PCS_CTRL1.

The reported XPCS dev ID on a TC9564 is exactly the same as every other
XPCS supported by the kernel so we can't use the dev ID to automatically
determine what operating mode to select. However we can use the feature
bits in SR_XS_PCS_STS2 to detect 10Gbase-R support.

Rather than introduce a quirk let's attempt to solve this generically by
setting SR_XS_PCS_CTRL2:PCS_TYPE_SEL to a reserved value when we detect
the right we detect the right combination of phy interface and XPCS
feature support.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/pcs/pcs-xpcs.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8d..b2c84b7e1e113 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -747,6 +747,40 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 	xpcs->need_reset = false;
 }
 
+static int xpcs_config_operating_mode(struct dw_xpcs *xpcs, int an_mode)
+{
+	int mdio_stat2, ret;
+
+	switch (an_mode) {
+	case DW_AN_C37_SGMII:
+	case DW_AN_C37_1000BASEX:
+	case DW_2500BASEX:
+		mdio_stat2 = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
+		if (mdio_stat2 < 0)
+			return mdio_stat2;
+
+		/*
+		 * If this XPCS supports 10Gbase-R then it will be the default
+		 * which prevents 1000base-X and slower from working correctly.
+		 *
+		 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want the modal
+		 * behaviour that comes when we pick a reserved value. XPCS
+		 * allocates extra bits to this field and allocates values from
+		 * 15 down so MDIO_PCS_CTRL2_TYPE + 1 is the value likely to
+		 * be allocated last (and hopefully never).
+		 */
+		if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
+			ret = xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
+					 MDIO_PCS_CTRL2_TYPE + 1);
+			if (ret < 0)
+				return ret;
+		}
+		break;
+	}
+
+	return 0;
+}
+
 static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 				      unsigned int neg_mode)
 {
@@ -919,6 +953,10 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	if (!compat)
 		return -ENODEV;
 
+	ret = xpcs_config_operating_mode(xpcs, compat->an_mode);
+	if (ret < 0)
+		return ret;
+
 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		/* Wangxun devices need backplane CL37 AN enabled for
 		 * SGMII and 1000base-X
-- 
2.51.0


