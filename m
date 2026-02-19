Return-Path: <netdev+bounces-259576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCTXFXxjl2mnxgIAu9opvQ
	(envelope-from <netdev+bounces-259576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:24:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93C161F22
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2870C3030E97
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0482303A01;
	Thu, 19 Feb 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="E7loc9fb"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321A27F017
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529071; cv=none; b=Tf3ZeAc3/7+jVh5xBUHnAx60fWS6NnRvIEzaj7t3MeBDzgqnY/bpA6eaq9sF1T7egpi+MMq4siz191kjLV45i18c6hBontNkHNcjHiyRgkdF+PPHuIJy1H0An2xUkvVAzXrpNqMSoKuSXXptPXjZVIIJdY6LLBwjZRrNYhDBo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529071; c=relaxed/simple;
	bh=g9aw1h2lbRrKNRmFNy+58raEIbGXeql1NWBasM5x9lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=ljIQZgLopaVTPKk4wDH2MkbirdLHVThvUBGytlbizNDZIydm3J+7zGd789DwnLU8l/MIb4yjhXAq0/x5Wb1uDxfSHwAxPUU5lOPUNoaowOsRCPUS4qPacRMaNAoU5sK/WFV9vxZg+Wds/hnfEsPa/9uL2cgl0JpQq0ARAdMKlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=E7loc9fb; arc=none smtp.client-ip=87.248.110.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771529061; bh=3JkcDV5cuTOaDZPGYbCuh82fN1WQ+pJzyXz/Ohmpx4c=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=E7loc9fbNPBi6l3nKK/8mwx1Woar0ZulD8+rK9X7Mj44lltnGKePtg3thoITJS5gzSpLoRT8cAVphDHV8o5ujaeaBlHKDt7vALYWPSbVaR60k5g9sh5iGiO03sAVA8zj06TQtKV3MUCJWTGSQtI1nWV2eT2iKC6+S993/VdmPoyXSo3ip2UOOQ+eK35fJLqcvesX7h6egj/UWEcUbs2DcS1CECgQGS0YptgEX6X/Jk8lajzl+Lr29ijLDKMmWNRGjHc+ZhUaS7gFc+SjFiKLjFUH21pT/pVaV9kYxU5GB6Qo+PWaNg5OmoBI5lwgnwBbXUeRCL1zH6O+M/ha791vQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771529061; bh=C6HOYMYxlkLxLJmT8KnPmHXcBGUy7t0R8803S7o3p5k=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NGNobtKFhttd9oiPVU5SCHL2edLYuyYSu2MH3j8NrfXzfgCU9NfgNjMpH9x480RYMtQg6Yz8N7BDBInUBYxz3QuOQq/fgDKmXg6k2hSKFPyCRMmZ7Y72KT4kUIDLFGRxICHMpWeEGrHJUwpTog/mbJ5sTxc4rfELO6oSQb9F1q6Btp8tl6iJ+Txs6xecgofa4BRm6es3+tXdN8RlgVxV/gVYLnkGsSsnkyO7BObhDj41TGgbbHzTd3x1w2tukPSP6xlGEHYTCYGsSa7cf3rcm9rA21xwiL4eCib+CgnaDenCf8vRr1n1ELRNb5kUm6r35Ig6zwvOhGmdy6Owfcr9UA==
X-YMail-OSG: 5wabyDAVM1mV0UjXrhKbQE_97SDzUDBMfzXDLTHLqgoo78oXaP4.QFEP85j6fLD
 jV3B5yDBmGsxmskWWSiggZl3qFB7GYTlYm1WUgYL4TRtN_o19zlLc2IRJrXgWn.CoBj54wC9jJrD
 qzQSrMeB1YEVbNPuuKfookONGuLpln26oW1SPvEs2hgEpoLeoTlWLiiRokIix0nFiqar24LlwKbF
 _AfxA65.97gayBAldLqryT7M4Kg6FCrdyedHbL.zhHi9eDlz.h.PX1NdVoMgq9kD_hcmIMEJcK63
 RsFF82kJuhi2CRYi5nbpcFD.12vWO3s_f3mAmID4itaFTVsuKdrxQ3fAxgu7F8Au7QtB4_D7Mi6G
 cCzF3F3GyKBNMyd71LrhQp3UN9PnwB2.MPmE6b22Su9pHrY_fC0PgPh9oRbKANWByF1s8ZUDJbkp
 7Ao7U7qcnRV8DsR6IQzDW4wViQtcvkqqHzd.5HLwSRtBREAZPrdFx.kJLLmYhzuKDVfZY5RV4C9R
 jRaBu83ug5iqN7WEATLhCBq43BJnpzoMlSCSJS5zRtimJ6_PjdAM0Va5woqdjAUa9A6J1zhM.M4i
 YDjrIQR0sWo7o1MNOBr9JaixLBvYl3gYDFwXELhZ_xmMC4N1dNBlr9dOI54pUtQFeD_daBoVLLO5
 w5K64g_xMEys74R4_mPxO4jiHRcXy8O6k_LP1qwq7VhX4us5Sox2qMGj9d8imSamPOc0n7WUwxJm
 vm_GRULv_nFFwhe34rbbu1J8hZypfetyG.O2aMnRt8.Fr6SDeCVcfjEt0UIOBnZO87yTeN9gsCST
 _ZIpPdHpPLDQD22yHkWOVo0Z8Z8dyBniPEF3s9yhjXwUoy2LQsQC_1PVSyTZI2nU077Gc.hRRmWU
 .VItPP5ILqJnEsH9fl2157rRdjJIvOAzL3i0YRkpsk.9YXWN6mrcINqXDKxyLYo6H_cGxnLu648X
 y9ufR.bRJOaeeD0QpbaAX1Nh8xIp3hg2gOvxOSz4HKtoV4C7F76b8bNzJL1S8d7yoOeYzUUqqcRK
 RPiuAimbXAsaPrdcPEfLHYVFsLrb_0A0Un2a5BYoBvA49TsZ_LjWYvMivNOi6bu5I7ITNb1HSxl4
 8DgUTGU1b5ssty7ewPFMx34gGGIR57V6fplSD9ejoM4T_W.WowHer.TjoC0vyd9jZtO.ZYXBRzTQ
 PSD_gMg44QOVRlx35eOgOnab.V0L9c8psKBEOruIy6PomWNBBAZBmWyf72SpP3Gf04shHkSbeKui
 d0H91SvtXldivxSPf2Urx4dTDtZP3MTV_p76f6HD32HpJIJUocEsetg4jL0SK8rdIISJ6x5wgxTv
 4XNUJMusUKQ2JTeZxfCmnRv9krloL7LxAVxPjq52yiSEMSzqqpFuWAG6pvRD05aWsXqNMqQ5z4pS
 QDtcFqE5Mh5fgvG19RMZp.Om3kwXhTC2L58e1cfVxw6vJoLQR7DRHbxzPy_l6q3wVveFg1SlKfKT
 AXv5xpDX8Yoi.S81HhvVr7_RxDkyp36lK4nzL7Yfex_fodBLJ5HCLfTX8d8PH45X4hKz9aHflprC
 dGU2IcCN8uyJWFwSQs2dBO5xCFBbYfYlCumvbJzeIBOPMkJQfZeLl_Bgk.OL.aNup.JjN5PdSwWW
 6wQbIDAeb..Zfz3XcxYuH843p6kn2GvxOWtXFgi2YF_IFr4lNwlJL4EZJNJSuLTPxYzs0TgqcG6Q
 Y2HD4hOEWKpJG.pwdS2_Kg.IBwy2qfJhxmTXUCw9zmFlhdQaBHpQnF_N5MVivFhh3joogx5Ub0SF
 0a6Kk5IPTkcabl4vE6Lrr4lzjDurnjL00iFbfQyyM8OQlQ6NWQqzTTGQi8.G1AZjIA1sLoowZU5U
 _d3U1uNDY071PiPZyRIwIwohFpnLFCwRijh0wiEu.mMChYlYNpeD9L8NroyFLVk0dAgIgKP5vDDq
 tsBHQ6dWRxmEkC.LirROQ3oWarblL2YtAmmycvoscwKg8zDxAvtTVGh5OZC2ikMZSyzU2VQ3ET0x
 B2N7RZNVGlQmRxtj64YzIwRA2hLadj635qkuWBm4Mj0tJTYnRJH.O7NinK33yehzVOVNN_ouflM.
 kdGu1B8zW1w6ZQh4jWcvoihhQf7fVdOPCg25Mkf3PJvuya2H9gketAWLQ6gbN00Pf7d.tzK8LUMn
 7XXik.NxMW4a6ZYfbDWjelwj7bx36JchF8gK6dfCiGXK9igpbAu9IEScc_XFqerg5hI6q9YRcrwY
 K7WkFbQOuxtqrK0wAS_eR9_6KX4_psHtp1sZLeBm0oAMn5VTwMmBFADn7RJQdiSjSCNQac1wT76e
 uvg--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: c6bf989f-f13b-489f-bd11-c16b5327d594
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Thu, 19 Feb 2026 19:24:21 +0000
Received: by hermes--production-ir2-bbcfb4457-64r94 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7930e584e2bde0d09a9482761953a5e1;
          Thu, 19 Feb 2026 19:24:19 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH] nfc: pn544: i2c: Replace strcpy() with strscpy()
Date: Thu, 19 Feb 2026 20:24:16 +0100
Message-ID: <20260219192416.97654-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260219192416.97654-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259576-lists,netdev=lfdr.de];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.unger@yahoo.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[yahoo.pl];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yahoo.pl:mid,yahoo.pl:dkim,yahoo.pl:email]
X-Rspamd-Queue-Id: AD93C161F22
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

strcpy() does not limit the number of bytes copied which can lead to
buffer overflow. Replace with strscpy() which is safer as it limits
the copy to the size of the destination buffer.

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/nfc/pn544/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 1ecef0acaa50..b897357732fa 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -526,7 +526,7 @@ static int pn544_hci_i2c_fw_download(void *phy_id, const char *firmware_name,
 
 	pr_info("Starting Firmware Download (%s)\n", firmware_name);
 
-	strcpy(phy->firmware_name, firmware_name);
+	strscpy(phy->firmware_name, firmware_name, sizeof(phy->firmware_name));
 
 	phy->hw_variant = hw_variant;
 	phy->fw_work_state = FW_WORK_STATE_START;
-- 
2.53.0


