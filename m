Return-Path: <netdev+bounces-304934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aSC/E2yXS2qVWAEAu9opvQ
	(envelope-from <netdev+bounces-304934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:54:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900837101FE
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:54:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hkaf0IXL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hLo5kcQU;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304934-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304934-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DAD733ED1E4
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4B438467;
	Mon,  6 Jul 2026 09:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3843786E
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:35:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330537; cv=none; b=D8oN4mPTkNnda/GCcDo1UUfEVJEWxVP7AeBF1J4vK3PTRgaisBA5Ufryt3q/fyO8ANpdTS+q1mzNxcF/J494omZbhY4ShEWU1Uc3ZpbaySS48BB/UFvo/5EzFiJ0AuV2Y3SPN+PK6G9BK1mFbVBiF3fnDQd2NYMj2RgLP478/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330537; c=relaxed/simple;
	bh=42Kj3VAyHdKAb4Mujj+SNBJjepZpYO0t8Hxlz5eSYok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVtLKWC6mW8UGOO5kdbllzln2QhnYGNcm2E+/iyTBAo5np5ox4BYEmWOicIXN0i5e9ZE1DRRNAc2AV+ZrNVHGYRVqqmA0ifZU4IukbJk2+CpmKhLctZGCzCZI22RtY/GpHeG3nY89T/fSnQFyuvT+6izNSmqk2mRdGGeqmWUZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkaf0IXL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hLo5kcQU; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66693xr4107755
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 09:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=x4hNt3rfNhUiPXOePYpG8Tjf20b4cSynXFo
	kVgMJOC4=; b=hkaf0IXL4USdEe3sk0UKsslLAhxribsbMOq4P5NJ+pZlGwyjVlN
	uNEa75X596G0RL4wNsJZGlRgf6SoaNrXLTNx6Q4uN5E6knM76KANsP2fviOsaVfI
	i2yn79rpzofaLkK5jExvWEA1U5LHU00cHqgXz05asUzOuaIz5SET6w3IThDN9uPH
	IkNCGnNbTj6HTzTBGI0e0pCJp3vP+HN5UGLrVz90lqJVN41bHds/+xijrmlctRkP
	L6yEUdH/41PmtxQTWdVLRP9JDOGrgn8HDiknXlvHF3XbeHIPMExD57joolQWzUOJ
	mEfcU6Vvkx32kVMsSLjQKKHeVMe/mww1Upg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891ur6x3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:35:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e63df032bso313801885a.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783330530; x=1783935330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4hNt3rfNhUiPXOePYpG8Tjf20b4cSynXFokVgMJOC4=;
        b=hLo5kcQUH/ZEoNTg9xQ55bRyXfHmQBLWEGRVS1P2KLG7HOOjBF69yzBI4IbfZOF9fF
         VveAq0e9ryyR3/vfbMK53uRi18vlyWNvekEcj5645fWJRwZAXU75sZSQW8UlOL/hdzFx
         SrkLAoNSeNGCA7/EPYHM/L4MVOoPAN2GoQu2+vaqhSFwTb+bputtY1SX+TS2AAheewYs
         nLjjtSTV1NuARvyQ0sVdjoKlThCMg5NC14o9OhQ5muMIO/VPuL3DIcKsqJfUglsuTqr5
         kDXJvhWqMg/YZkgzEKa//A2tP+qRahLvanlRi+nbQVstd4m0fzI6UyVtICyHD5grqO/G
         Ej4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330530; x=1783935330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4hNt3rfNhUiPXOePYpG8Tjf20b4cSynXFokVgMJOC4=;
        b=MAcoyH+mQnyn+yOtO5O0oQzgir3ggq2PBgVFePrwpi/b2Z1e4keDOY+w/7SJvuX1H0
         KIex6vKfyg75ktPZXN+7OKTdiCxe7RLpHawF4kyvADZn/voDi8VWCoiYB9ZcDfk6Nto+
         4pYyU1ZVO+nWszsih1thp+Sim36B//9AwgMgZgAyp/3c1gT2WmDfySJjCD5U7uURkdfK
         oJrU7A+xtgFeCYy0umMtq4/RCNcw5hiI4OrQix4v1+Itz2CLfFaxTmOA6qGM+9o29B6G
         PhcWbv7mRox5FnRyIoRQ9Ios2OayYNwzXSwssdrstar6hlMZwEre3sbZeqWW58p9plRw
         3SfQ==
X-Forwarded-Encrypted: i=1; AHgh+RopAott5zh9WtDd9quXXYEzu0cZA0VrGOQRTonrg/pJK9v9JB7RBB0VSHX3tjlU60mgzBS7vkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQC54K7C/stpJ1L72Q+K4W+px2bNxv6zBhhhToJLR5o7J0y6/M
	5RJYvrDPiX4lOxU16u6uaFzZSc6199iC33Ttbw3kG/H/ppz9AWFCi2lBMoyrQzp8mRrl6hyE1Ud
	oYP71eTrd0TlkUzDFU14+NCzaYGWeFLYlcaIBHruDCePCJKuneSLnvrW2DrM=
X-Gm-Gg: AfdE7ckjFVhADp9Dr8Hg1mS83ABPAf7CnOxFnddWm7RmHggi8B+6PAB/8tYgrKEuoYb
	HD0XUk686cKz3XYvGtVDB/daDLUaMhCqrfEl3sBA1qpQQCZq2bqEs0n2MupJxH9wwO50cC5QfVT
	CfrdwSbw1nTOg0JNHwjhlUq1ZlianhjbB8iOu/UvIfbO0SzLIaOIfBHLRGy836UjzHahb7yLPaw
	i0Xu3nfPm68kvWMaXa8KPhH5K1PT4lf22m0a8EkZCpgtrljd62QjT4DZ/Fm0Iqxixr46oL6Y9GP
	XVqsZfJZ7WH22ZpUMlV6a1w7NilouNrj1XXQEf6+CRYeaoGAe6SZueTrQATBhDwkgyg3jIJHp1x
	WoENUBbTDpjn+dAbgLj2Bd/AAtpw=
X-Received: by 2002:a05:620a:6082:b0:92e:61f7:5687 with SMTP id af79cd13be357-92e8b539407mr1666942885a.29.1783330530185;
        Mon, 06 Jul 2026 02:35:30 -0700 (PDT)
X-Received: by 2002:a05:620a:6082:b0:92e:61f7:5687 with SMTP id af79cd13be357-92e8b539407mr1666940885a.29.1783330529728;
        Mon, 06 Jul 2026 02:35:29 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce11497sm290925905e9.12.2026.07.06.02.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raju Rangoju <Raju.Rangoju@amd.com>,
        Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
        Richard Cochran <richardcochran@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 1/2] arm64: dts: amd: seattle: Remove useless clocks DTSI include
Date: Mon,  6 Jul 2026 11:35:24 +0200
Message-ID: <20260706093523.274093-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3395; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=42Kj3VAyHdKAb4Mujj+SNBJjepZpYO0t8Hxlz5eSYok=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqS3bcQfZBrCmFoiQLVudR7CeFVhhcE1ScGZ28e
 W0f9Y+B2S6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakt23AAKCRDBN2bmhouD
 17p9D/0TBfp+/n2xq15jwV+novyrQONMFBQzxVcD3OoZwwPOU8qtkM9NzipW4MzH4KE3E+woz0X
 BU3efE1WpDvV4kqwdfL5mTgRlDfRZ0jNG1m/bz5ZqetiEUr51n0mungnDcyOSfNOb95R+grGE2f
 Tbx1WrcD4Hoy3y6lU9xmTFjTutHdyXUeb7u1J5dx+5IjpkoVAl0mFikumq79U2QnCo9dxNObBI6
 7hVzSYtFoddGkC62brq4MvQXVKAokCabbsE8GIzZaSuGu/wRGNIjt3yLgZEFj9Jzm6KTqO3pQGh
 JVs9jJZ+Mnhs3+fTQzyrihS67Hhh6mCb9rv91uq4iqDhRw/k9RkjuBQUmy/rPD7aASx08TUy3DO
 N+KPQeIUtXJbf9lNoBQHLxJiAViV/kiG4kWPnpNZt5B0PYDOdNqoA+p+kr/jHMGEFRRTlFEbxFT
 eLjyb0YOwtrZpzTeNOFzvufkfSbHnKF2c4q48bBypqqu+jFpeP4xAz59ybY2MGHO5AtxuuTcG4F
 a7XA6BhG7383HWfezFLWMODQrIoSJpOKKnJmRNPKkzg1pniDbm+fkCEtafw/GlRgostlu4NZibQ
 y+BqC8WAblUCBOnSSHruMRldGpogIuQsdR5m5VoV54tTZBceYVURjWpV+CY3wfBE7me9Mise0Th Hd8KadIKhcCuXOQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TGQ5BejTFjf0mC3_XrnLFDV4YrYvesGu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfXwWKBN9a0mxfE
 Kc4x8cMvJYuizYUOiWKbm4J/D2o7DrgykKqMqmqojLyjJtexykLnRHMsFvgjrhI5idv7iMpEQFK
 wbJslgbcHq3E+Rwvdv5oe3jJak5iYMg=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4b76e3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=LplHZR8TypZ71DMuxxAA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX3rnXKEa2Y6bX
 4Q5wSWoz0JtQFyiL74XJ1f2Z+qFgKCy7yDOhFvfJmYY8jqV/XzCHlFkQZs2ncZ5RtycNVLwVehj
 jLCo/+Lf5mU7lzf8X9LjpMoBzlF2gItLKGa8LCzUMhFnl1ZjsJMXW/BI2uSulZsJ8vrqhckCowr
 uschfOM/FI7HBozeuSFisGvWka9CvDyGz+Fb5wjrAGxnLPhep3D1320RPpp9zj8e+o8/oqa9Bgd
 9bWXnHON6AbvYy+uiTc8igy0NoQNOI/vtIlqgfSmY/n+bPiBVuA5oOHz7zf5l3z5/+staED8qn8
 reQ3NxRu2NVgegfKn7pMXk4HMpxN26T37I2GCFCqeZpFuOKrWTJTqbyTI6Wd2yNubQYJnOc0wI7
 I2UTLonrLSRUQAvq85MoLTcWg/ITgZg6I1q5o5eMjGOjZtn665Aq/AnAgG7OcLi8KOBLBd6MCk4
 dWOMJwGxthdthviZBfA==
X-Proofpoint-ORIG-GUID: TGQ5BejTFjf0mC3_XrnLFDV4YrYvesGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304934-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[amd.com,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:suravee.suthikulpanit@amd.com,m:thomas.lendacky@amd.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Raju.Rangoju@amd.com,m:PrashanthKumar.K.R@amd.com,m:richardcochran@gmail.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 900837101FE

The "amd-seattle-clks.dtsi" file is included exactly once, so paste the
contents directly in proper DTSI.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi | 43 -------------------
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi  | 36 +++++++++++++++-
 2 files changed, 35 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi
deleted file mode 100644
index 73f687773ce6..000000000000
--- a/arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DTS file for AMD Seattle Clocks
- *
- * Copyright (C) 2014 Advanced Micro Devices, Inc.
- */
-
-	adl3clk_100mhz: uartspiclk_100mhz: clock-100000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-		clock-output-names = "adl3clk_100mhz";
-	};
-
-	ccpclk_375mhz: clock-375000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <375000000>;
-		clock-output-names = "ccpclk_375mhz";
-	};
-
-	sataclk_333mhz: clock-333000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <333000000>;
-		clock-output-names = "sataclk_333mhz";
-	};
-
-	dmaclk_500mhz: pcieclk_500mhz: clock-500000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <500000000>;
-		clock-output-names = "pcieclk_500mhz";
-	};
-
-	xgmacclk0_dma_250mhz: xgmacclk0_ptp_250mhz: xgmacclk1_dma_250mhz: xgmacclk1_ptp_250mhz:
-	miscclk_250mhz: clock-250000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <250000000>;
-		clock-output-names = "miscclk_250mhz";
-	};
-
diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index a611f8288b3e..c5b9dbfdf014 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -11,7 +11,41 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	/include/ "amd-seattle-clks.dtsi"
+	adl3clk_100mhz: uartspiclk_100mhz: clock-100000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "adl3clk_100mhz";
+	};
+
+	ccpclk_375mhz: clock-375000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <375000000>;
+		clock-output-names = "ccpclk_375mhz";
+	};
+
+	sataclk_333mhz: clock-333000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <333000000>;
+		clock-output-names = "sataclk_333mhz";
+	};
+
+	dmaclk_500mhz: pcieclk_500mhz: clock-500000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <500000000>;
+		clock-output-names = "pcieclk_500mhz";
+	};
+
+	xgmacclk0_dma_250mhz: xgmacclk0_ptp_250mhz: xgmacclk1_dma_250mhz: xgmacclk1_ptp_250mhz:
+	miscclk_250mhz: clock-250000000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;
+		clock-output-names = "miscclk_250mhz";
+	};
 
 	gic0: interrupt-controller@e1101000 {
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
-- 
2.53.0


