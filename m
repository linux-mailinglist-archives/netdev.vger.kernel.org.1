Return-Path: <netdev+bounces-19921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C074B75CD27
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A731C21745
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3B21F93B;
	Fri, 21 Jul 2023 16:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E469200A0
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:08:05 +0000 (UTC)
Received: from sonic311-24.consmr.mail.gq1.yahoo.com (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7821E60
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689955683; bh=nfLzFkl205ozVQfoC93TDv6rb+g8tAZfzEbMKwzdw9Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kFWq1DO/Sy46FcKsm+/HrAppAtEtT2f0idG4TdOOnneFNImzFZok+n+CjxFMp2HV1WwSjUy1XHLNhB7sSYYxMMAlQBMOjInfwhC5jlarjI1LH7HyoNKG4649PePC538uPPAcsf5YMiVeL/sfQAns1pNZkhx6NgoaN+0Dq+Tc0t15mEKyrQnvnlC55UyHhpBREy28rGlNNYm7EaoEdNGy7rmVl2Aa6+jViRUTzakgxeGY1YE0WyWTfewNOfSfobQ7m2EdkFphL7YEuITely5ETue1l+ccLe9sQmzSIlvOUzBEVJ9HQ2+8RJ2t/YKDPuXRvdTYPN6dNSStr3BEKuEygQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689955683; bh=dIPTCv23EQRhdZaNB2pCpBjjPkJ0A2huRQcSX8+7Fyf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EeVE6k08XCv3B6YJfJPLdvA8Tje76JkauZEhacYdkdtM3W9fVsbnZYMheNCdj3lJEgV0dhfYDnNZ4VJT+9vcyKvhr98ADi0jNNDitPODzoWelnQ6Vo04MvhUAJJdnhm50pLxdMHKaGXAMvemDHEj771+WFJzoXJ32sZHBd5kJPeKDm/vxrWCilH98EUPdFxJuY0Un6gaEFJLo968fNFmKECVeduBF9vZMS919sSEsHPIbVEd+t4n6stuw2F8fQdOawb11LhK1duH+mp1mteHcF3GPKmWfUbMCpbS3Xal1suxulqcVRlPsv1DXL2lm2pi5D85QZD/pQ79p47h+i+jUw==
X-YMail-OSG: 0xj9L5sVM1ntnkZSTmua4TVWKzhUhUz8QCvOgyIVoVS15BIs8Ccdr5A.H66hT3p
 51oHtH1L05Y_QpFMWXzYnYs1ZoDklscIpOIrXumYZoVU70uUpnU6OO_YpGPj0_F9yrHN9wKZN9Cv
 wLAE09NrTpKzfGyQA_jNnptuGtoN94pfZYLmVJbbUoymJuZv.qwXD59VWdEzEsxe0TLX1oxtcmx8
 YS8zKx1nyNKNWboYVRfRd7RxzMDdHFgiVSPQgWsv1MlIzJ1ZQHJ5VqKlKs_fx86j_RiQuJ2Wr9UM
 wpw2VYD.W_PZjtw3uXsxnyzw9IpktVrNH.oiOw5dkx5fSt4D9Xpn.obLJq1ZWHo_FkabdilazNSN
 h9L6zOFmDLie2c6OhtbYEvH55M.i9d9BYHCkwweDgMOB6aOxSZ8YNxC1UAksVz1q.Gwmlko57qU_
 StoVwPFI9X5kOm.CB7OMOdepw2dcad2ijKhJ8X_XY3yeUEW3hgTBYo1tCxj6ZLAfTkDIzh_LpH2e
 FFKo2NEvZsJ04K33HScgXsNOcPNshJBimBuNoxy2QAGu8xKA_KgvNFj_JDCnj24EKkYW81_A4ygh
 Fadgz9jxZp0Yn7Ud6_63m.DY7k1FUWj0h433s848chRdxhrwC2QS7roWHALKQwgN8WmnE8SqVWPL
 DvFFIRzcXhpPm2ufcbpvdHqPq49T57ASoeDjn2.x21wNyzRd_aycahds5FbJfYvW..OinDXmhcvZ
 hyACzWCuaZhKX_kSpGP9VXsZarg3CUOcJYO4QjwBZSDjQZOB0e5hHhRr.jhw9VRZjOFpTZcOVdFn
 _jonwSrVK4Lnv7I0wRqcfRoqyIvq5cX3UHir7zHVj0jsH_m4Fg8a0zw8Eiatemm36G8jaMe7nBqQ
 .BePKyKi3JSAl4q6StlD5VQH_KaLGOIYVGkUQCRzTpmGYi7BuopnAvE5TMvGnt.y8y_v2gMgLmv7
 pdlqS.49SO.7OTooinzRT1b4EkhQ.p2iTdHZswbcsEA0pSfBl.pHcngLE4Sei2qJRqAeNHLnsIaI
 4liR7HmDVF4LVPIibATjVghEY8CmXEMIIVokCpky.wgLpk0pgCenPe00z_qmzyq0o_jXH0mc4w0O
 CZQ1jStcC_5GTkKiUZ2qJWAgBLOXyP0Ga1t8rPXlcJxKCTQ79wrb3iV1wUlR6R3pxTQWig4NFt55
 yJqejarK_xl4yLKjN19OzVpIx1.ua2radRxyU8qiPeEW19XgiAP0vbFvw_yQwOSFP7Alzc9g6ds9
 dOtn9GqzkvqmX3UExxeqt8N1om9tsfG0zHciZ8t3DYwV00ENxASQNoUoovJLPMFQbYjXcJwKrzbW
 9nJptN7IJllsmrpl_YY3VGcywK3bIA7bzVCv_uZELJIlvsOf0wbhxrqtgF_PAf8RkaI9invawmKh
 4VUPyaokoK6uyH5VIqnv7QnppSHSULGBi.IVTtcBs41Qq84dpP5mMoqeDgEYuBXCz1VeDNsKxFBm
 G9Qgq.7eq4B2FaQBpnaE_7NtjsWUMXIs.LLcS7QZ3SpS3P4jwrbxaDhwKVXkqJMUFWrCLWXHhv22
 omLp8RYBsCqXMW_NIroqY2HUjDOszg0_vGW7QRFM96lg27JQFx5n4rXGjohq.k1KpTjwA48sF_hp
 46.MUkOctLmA4i1fpwQ0_vn1hkeD7WUG.q5Ipth1NsegAELXzoBL821SdEUisfsTxolxcWks0z23
 cmdrdXMinFzNAN9e0Nj18iRP6K2_RNqFEGOAv02EXCTSQyT3VBy.Pn8hcgaEJiODhW9VNTMwbaes
 q4KPRB._GH0oUWtLj.2bdfG9XEWTXcj8t10.RIctSwhQneai9PxXvwVpzp_pm_MBG2PXFPjdOF.r
 A7qfjio_ND0sbGnr.E6YeRHLtc4p8lM9sRR4zuueUkwQg817EtkFeTw_TF.Lmogrj3Be7c1aaXD6
 OhS1qzAeD2pqfk4pRNdvuK9n1boqPQTT2sd2rH6ASwclYxMTg9jg2W5QDsif8HUgJdjWyjOJeIYi
 opiqz03BYxZNl5_55.lZgwqEDcsfecxCgYE0xdoYBXuFShnq_4ePM2WndDzl.TSDHBTZ_qFCg9Jp
 m1FgmYv_wuLsqOJYPKEZYNyRA.2Zo9JW4AuxN7ODckAqtN4FcmLnxfMnqjh7MiJyXKDD.hB50YZs
 JXTP0MFAx3NXCOoG58F4ug4xxBY1whoPZKlBNSETHRp24rP8S.tK0PWturS85QD3kDuB3y0zC6PH
 WXB7UzzXi4zntga3I7rPDQPaRwBqAukGPdVO_EmEX
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: b0e38791-f7b1-4bf4-a0ce-7b25eb176b67
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 21 Jul 2023 16:08:03 +0000
Received: by hermes--production-gq1-767c8cd9fb-ns9p5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 46bbeec236ab3032b3222de6cea7f3d5;
          Fri, 21 Jul 2023 16:07:59 +0000 (UTC)
From: Ziqi Zhao <astrajoan@yahoo.com>
To: astrajoan@yahoo.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	ivan.orlov0322@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	skhan@linuxfoundation.org,
	tzimmermann@suse.de
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jiri@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] drm/modes: Fix division by zero error
Date: Fri, 21 Jul 2023 09:07:49 -0700
Message-Id: <20230721160749.8489-1-astrajoan@yahoo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709011213.17890-1-astrajoan@yahoo.com>
References: <20230709011213.17890-1-astrajoan@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the bug reported by Syzbot, the variable `den == (1 << 22)` and
`mode->vscan == (1 << 10)`, causing the multiplication to overflow and
accidentally make `den == 0`. To prevent any chance of overflow, we
replace `num` and `den` with 64-bit unsigned integers, and explicitly
check if the divisor `den` will overflow. If so, we employ full 64-bit
division with rounding; otherwise we keep the 64-bit to 32-bit division
that could potentially be better optimized.

In order to minimize the performance overhead, the overflow check for
`den` is wrapped with an `unlikely` condition. Please let me know if
this usage is appropriate.

Reported-by: syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com
Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
---
 drivers/gpu/drm/drm_modes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..aa98bd7b8bc9 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1285,13 +1285,13 @@ EXPORT_SYMBOL(drm_mode_set_name);
  */
 int drm_mode_vrefresh(const struct drm_display_mode *mode)
 {
-	unsigned int num, den;
+	unsigned long long num, den;
 
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return 0;
 
-	num = mode->clock;
-	den = mode->htotal * mode->vtotal;
+	num = mul_u32_u32(mode->clock, 1000);
+	den = mul_u32_u32(mode->htotal, mode->vtotal);
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		num *= 2;
@@ -1300,7 +1300,10 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 	if (mode->vscan > 1)
 		den *= mode->vscan;
 
-	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
+	if (unlikely(den >> 32))
+		return div64_u64(num + (den >> 1), den);
+	else
+		return DIV_ROUND_CLOSEST_ULL(num, (unsigned int) den);
 }
 EXPORT_SYMBOL(drm_mode_vrefresh);
 
-- 
2.34.1


