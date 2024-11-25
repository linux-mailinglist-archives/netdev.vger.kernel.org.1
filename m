Return-Path: <netdev+bounces-147168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95689D7BF9
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759FA162FE6
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632B187848;
	Mon, 25 Nov 2024 07:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF02500D4
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519949; cv=none; b=R7+2ZWJzj9dY9eDOzaSQ/9JuvZUBOjM2a1ZHOp3eTtCN6K4+53BT8hf/ql5yhycBSHULfBLgK8gIrrvykKwgL6WHJmi9fm5pl9edq/V01sq5eJx/LMGBpsdZmWVzorgFw4O5PNiqOCSR4zfijpxdTK+PDiWLUfMlDGjEyGY+qiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519949; c=relaxed/simple;
	bh=vkI3aWRAJq4Z2z5u3GuuvRiNlBqr0nPXpq71/s49wHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ba7FDeZtRRUY99dkEnysw0+TVb5tTENgV9/EHbR/Q1r8Wtqp0deIZ31oq0/PLGYy/qshaEUdwRDvS7hEgIxq+y1uDzAYfSN1ZZukvjMFiV2NqQH7900HIzF2SU+tPmiqlpjOqXfHgIDgiDcfA3C0b/uGSdu0jzSTCEp42S4lEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6716e006aaff11efa216b1d71e6e1362-20241125
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c8ba459f-733a-45f6-adc8-5bfb6eb782ac,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:14
X-CID-INFO: VERSION:1.1.38,REQID:c8ba459f-733a-45f6-adc8-5bfb6eb782ac,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:14
X-CID-META: VersionHash:82c5f88,CLOUDID:086940e397dfe74bdfe8511f776ae2c7,BulkI
	D:241125153220MUBFWTFD,BulkQuantity:0,Recheck:0,SF:19|25|38|44|66|72|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6716e006aaff11efa216b1d71e6e1362-20241125
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1007067808; Mon, 25 Nov 2024 15:32:19 +0800
From: Minhong He <heminhong@kylinos.cn>
To: stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: Minhong He <heminhong@kylinos.cn>
Subject: [PATCH] bridge: fix memory leak in error path
Date: Mon, 25 Nov 2024 15:31:47 +0800
Message-Id: <20241125073147.68399-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'rtnl_dump_filter()' fails to process, it will cause memory leak.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 bridge/mst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bridge/mst.c b/bridge/mst.c
index 32f64aba..a85e6188 100644
--- a/bridge/mst.c
+++ b/bridge/mst.c
@@ -153,6 +153,7 @@ static int mst_show(int argc, char **argv)
 
 	if (rtnl_dump_filter(&rth, print_msts, stdout) < 0) {
 		fprintf(stderr, "Dump terminated\n");
+		delete_json_obj();
 		return -1;
 	}
 
@@ -214,7 +215,7 @@ static int mst_set(int argc, char **argv)
 	state = strtol(s, &endptr, 10);
 	if (!(*s != '\0' && *endptr == '\0'))
 		state = parse_stp_state(s);
-	
+
 	if (state < 0 || state > UINT8_MAX) {
 		fprintf(stderr, "Error: invalid STP port state\n");
 		return -1;
-- 
2.25.1


