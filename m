Return-Path: <netdev+bounces-304083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hkTABb4/RmodMwsAu9opvQ
	(envelope-from <netdev+bounces-304083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:38:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 775AF6F6097
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:38:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NeHctBX+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="QRPxT/DN";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304083-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304083-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D8D3236783
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2034BC00E;
	Thu,  2 Jul 2026 09:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BCB4B8DF9
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:49:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985762; cv=none; b=U7u1/1gzW2IoQJFiLTZ4zovzEtXemdK0nlP8rau9IubbSUDbmfSO2juRCqVoNgLuBFFf7Jhwp7osBM4nJJ/f1i5jZbhdWNk86Fjj6S6tOb/Q4WZgztgyFb0Lg3M5ERUFHdXUwvu95vmlENpHA/sDCI9G2Kz8emwtgR3NQIOXrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985762; c=relaxed/simple;
	bh=EngYFkrMa/XGoGYpavK++Oku0gfzpf++oPWSjUjibJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POnGtzZsgScwVlhyK4SeGDXvACorkBnFPafhBpZEO1EIrhsBK1NdDwDOysHVkLaX85dVUgjkfiVKI0RfjZ+5NQ5iJKufKPqbKroja73FAoaBo8HVsezIS6MtXVBTkqxbKQXD2q7n9XVU6iFQNi0peMLedR2ayQzPwK7Rqltf2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NeHctBX+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QRPxT/DN; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6627TtMY3964256
	for <netdev@vger.kernel.org>; Thu, 2 Jul 2026 09:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=N9Ug3E1L34RiKmjnDmMnKa5yDGVvSvfqrRG
	G6d6TRjA=; b=NeHctBX+1DovOgKxz5xc+9J450oizlepHIsaZSCQU3cPhjREyWe
	FqfEIgeV3nQ8tMelT/FvepUlk/Od3GH5DRLcKQ1SBdOVhdalFhNrRglR6lwWcVs/
	acFvHNQXv/BSlwEAdgrnvIdYIenQe+MjOCxfTF+cCOpO3ee2Zw6iofhyzK/0XS/M
	7rRKdCPVy8jugI1nnpKjM2GL8/4spMcF5HlPs0YYTTcSF46rcHTE9YmxKaFWB1Su
	nUIyIV5hk0cl9hiI0bUAFtTXeNt6HxqUoheX0guJr9a1VV9v8gqB8prXRLMI5yhr
	TARzI1KeDYinVmtJA8Y7Z8FZKYxvGSSumDA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc0j6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 09:49:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1c7f135bso30674601cf.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985759; x=1783590559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9Ug3E1L34RiKmjnDmMnKa5yDGVvSvfqrRGG6d6TRjA=;
        b=QRPxT/DNIuQAc7NbfPBCCKsokQBjA05GKrOpoLRQoIR8dqJpD5cVBxmmVBUZW/whmg
         mv6sjnEbcoNb3hcKS8WoOmBReuX7+lYgLWEtXxM+6v849HFhFfp4EfeQiyiusywHcgEh
         y1wUBMf8XKDPPoDnERChrrJsW+SlmlrGJr5ADNN1qDs/C4fwDYy4F+whwyUBmNifljZP
         1pQcfznZ9FryGeb3ziXMVMPY51+8nRqBe5/rIMIlSBM5XDpAUoFhgvNisaaZvOv4nEfZ
         jAJIRma4KDymZXZQKu+MHasMJMF8F+0uwy9zCt4H1lhHluIa3fb105PPpObIY+I0VZYI
         bWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985759; x=1783590559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9Ug3E1L34RiKmjnDmMnKa5yDGVvSvfqrRGG6d6TRjA=;
        b=SfVe1jphQuUVfeIdxwQz+UFm4IZAsrkA7uO/ujK2oSWyV6qYUBlgU7GKbI9LlPQEy9
         C4ya1LkZu9RPfFjlgsVqGDDe82/oIWMRBQLNIYZhK1rFbaiJSZ/B2zHGb7RJNHXcENSg
         NGwoPbYxBBmuKuBL9Uu66lXzWghbrt+VtCuOs9Vdpd0Yrri/Mkt5fO2yK1INPqinc+2p
         UX3pAA+ztk79gwsrdd4NIpNGV6bXPer1XAc/8eXrJBTF+AbGFPUC2/iJwlxvYexhaMUI
         C1XCATxwrHMsijh4A4umJhwtD+RlVPSvzp9MqQapp8XvUG4dt+Y4oBvqswgiPKpwvsik
         RdOg==
X-Forwarded-Encrypted: i=1; AFNElJ+0lT0RWPAcs144MnnF8Kz76m6ENgefYvaIKtJ+mO20r5a5gPAFb0SlSIgIj9tg27SvBsKaEdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUPsGJRLjEIXmwO0IkH/uzKC5GKvKv93VjB0P8D/WKBcAbrkc
	YzwZMtwEzSekFWvdrfecDS5xt/gO4hMhCXiPk+Cn5NBGjZM7QMuYZBekFPZczNyU7mqB7scXdjW
	UIrAEB9854efUJ1I2tIpRY2T/CA/Nb11tKE3aDhsAjZ83HE47NWtCcyeL/pFGxzwEG5o=
X-Gm-Gg: AfdE7cnAknTEZj/m2tVvpNQyLgxUO91UOl3XVGpAlJ5xCk9WaHZo34qRwtB1AKVHWd2
	kB9FuOJDQzz83vd/FO3j0WxjSpgtLZEBhgMuQZhNnJWa7m7RCbU35iKwevX9U7xZGlePsz/u+6Q
	ufvSafB0Sdfa8nE6+suFZtScDH/huUckdkEDkbi4gUizxSH5rLCFTcW7ffREkRRxwc1K5tBliH3
	3c75QHHGJnwCpBLxtgBZtSJHOhAqxp9xl8Inx1LQv0IoPIPoldRd6ekMw4yTcVx2LXcSvE/+dTQ
	04zbpHxfmeFbbVRkQtqt4MTmLa4OJhcrxjVWvPXGxsUM5pgF7TyfGxzykI0hYJsDRoRCGHwHyn9
	Ndq6NcNGK7e04MtNtOSHx8nJyS18=
X-Received: by 2002:a05:622a:410e:b0:51c:2068:a9f8 with SMTP id d75a77b69052e-51c2acfd494mr53987101cf.5.1782985758687;
        Thu, 02 Jul 2026 02:49:18 -0700 (PDT)
X-Received: by 2002:a05:622a:410e:b0:51c:2068:a9f8 with SMTP id d75a77b69052e-51c2acfd494mr53986811cf.5.1782985758266;
        Thu, 02 Jul 2026 02:49:18 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c631557dsm35070955e9.0.2026.07.02.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:49:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Luo Jie <jie.luo@oss.qualcomm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next 1/2] net: ethernet: qualcomm: Unconstify function arguments passed by value
Date: Thu,  2 Jul 2026 11:49:09 +0200
Message-ID: <20260702094908.79859-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=EngYFkrMa/XGoGYpavK++Oku0gfzpf++oPWSjUjibJE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqRjQUZsGHdo0fwPvhDtAp3gcYidIwbBnPC2vYf
 J+1mMN640KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakY0FAAKCRDBN2bmhouD
 18rlD/9VofBNvIzc9qh2iQ4CMyvhOjt+Z/1igbwXXmCBsfZkMOtS8n0+G9jbXw2rghtjxG6PJN+
 FM29X4K0E2nk5xT0wv8oqWLQic9HN09Nj+RfgA7gOBwBH2jQ0AYbFseyWaHwaLy0YjqulivUbbX
 /RJP/Ob9bWu5HyMUlgTGEF0Q+qiO8WZt9lS8NFXj6Qrysg9U0jbhmltxMXActXgn1EiLAdfpCMb
 sowUHNaRSnIGPR98R2kZubGZHqU5i+mRDP0nIRpNC2dfK5oZ0Q+sgQ95cfOkwxHsp157o2ZB2Q5
 g6jb8VT/uQF2sJi1GDEAlxeP4/cqzEzBwmxNOKhInEnF5C9/fugagEpVJ4ToAERt+YHgHj8m2jM
 uvhmeG8qo146XaXuGtIVrmctzUevFV4wt4CBYa78DTsfHaCpqkO7lzxONj6dpr5EzQMCFYmIwpi
 VrGrVP/r2Uy69T+3L84FC8UpKusWQS6QQE3vHMPZuWVxHDNRZ4c6gZhrpBMdejeGIixTjhuEf1N
 yOxYFvGonqWxl1552bblRm99iM9028aKU2FhavLnqHMHDXXEHfQhmX2tUMAmG7vrCXzjDb++anl
 4Gy9vpztT5fSRHSqBsqePpbWfgLF2PF3JUzlmoPTAyvIEeT3qPFI3K0i38AH43161ByT0OruETz HXpO7XhtmN+JQnQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DSY83tgSy4udMXM-bfTFI1cfYQ0UdpOs
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a46341f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=F22kyY_495aQC_nK6tMA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX/UyAZMiUHIGM
 wmv2Nxk7m68soUVQ4NtlikNcDGAFXmz0ZiON3U0PGjgdzsHHdwOVtUW/jbYbP/ASltjE7mOQY18
 aUp/sCuAsPl9b5pr7bcn1PC+bwTdyvt9wx0/dXT2rvp9X3RRVGkIhuGuV50QxcVi1EIbtnQ7N7v
 tBc6TJB9ei8S/WiCYOq3PVOjy4q3XRK1gTWrzw/L4YtWqUqTwsR+0iVACUrznfZUnBWVyUF3w+D
 PepDX7MCTWrAmicfO2ZzSIcqs6rmQ1PTbd5XRexVsyxxOFvhh02AcEd6em7HY48wtvEPDA5JnN0
 UE6JERC0X3uige+PBJb1MPN8YM8URW9foTZhfSh23LdRMABHRpBhgsw1rT8Yg17rlfuVYu19Vo3
 2TH2iPVBTSnhUAb9sVzGnr2+87YWKgn6lvVRlrN+FhHEdxxZCwry2WKsN6s0K91HW84G6eDU9XI
 UepYLAv06tE4DygYX+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX63p5LO1ojbNi
 U3ZqorziJPof5eZpnDpwKczs60XSXqxWaifMCmeCSz7rmM35YlmOu94w/Tn/EchKAX4Sc3aBpDm
 tGYQsVlA3u8SThxInR0qHrnMdjou3jw=
X-Proofpoint-GUID: DSY83tgSy4udMXM-bfTFI1cfYQ0UdpOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304083-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jie.luo@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 775AF6F6097

There is no benefit in marking "const" a pass-by-value (not a pointer)
function argument, because it is passed as a copy on the stack.  No code
readability improvements, no additional compiler-time safety for misuse.
Drop such redundant "const".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index e9a0e22907a6..94f69c077949 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -1380,7 +1380,7 @@ int ppe_ring_queue_map_set(struct ppe_device *ppe_dev, int ring_id, u32 *queue_m
 }
 
 static int ppe_config_bm_threshold(struct ppe_device *ppe_dev, int bm_port_id,
-				   const struct ppe_bm_port_config port_cfg)
+				   struct ppe_bm_port_config port_cfg)
 {
 	u32 reg, val, bm_fc_val[2];
 	int ret;
@@ -1586,7 +1586,7 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 }
 
 static int ppe_node_scheduler_config(struct ppe_device *ppe_dev,
-				     const struct ppe_scheduler_port_config config)
+				     struct ppe_scheduler_port_config config)
 {
 	struct ppe_scheduler_cfg sch_cfg;
 	int ret, i;
-- 
2.53.0


