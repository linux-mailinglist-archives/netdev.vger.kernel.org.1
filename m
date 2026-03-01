Return-Path: <netdev+bounces-262428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHrDJkp8pGkkiQUAu9opvQ
	(envelope-from <netdev+bounces-262428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:50:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A21D0E1D
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DA35300638C
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 17:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D65308F07;
	Sun,  1 Mar 2026 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="qv36Fg2I"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-22.consmr.mail.ir2.yahoo.com (sonic304-22.consmr.mail.ir2.yahoo.com [77.238.179.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D002C0F6F
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387398; cv=none; b=NpuxCgCJb8NyMGu83rIMw7jZgnSMFNDW3cbQK67O7fSvnJJwi9vNqR3cbI2eS5Xti08kMCnHEsbhMYa/09HjigosEspio7X9LE/6Kj9UUfAKixlnK9LKnoDdGgFv99KExeOJFTp0+oDC4+lXieW8bxo4zr3Z/FA1pNxyAiWDXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387398; c=relaxed/simple;
	bh=UxfdGHVCeJ21M/kSRgmbZFbEQuKLJgRx+7S7+vEwzlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=j1Vq8HnCLXD/i+GYScJm8RI0ZRH6QSfSrh232YlTd08unROdaef/u6a3ac2ShwzR0QCst7aXfFX4w88h4olYcQRRMoHWLokLoJebgH7THC6CCJJxtyup7SlaT3+s72pAe8y31pVPo3W16UGUVWX1m66K21Iz3yLsYWcLmIscLSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=qv36Fg2I; arc=none smtp.client-ip=77.238.179.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1772387395; bh=gt0fXuJhKGC9VysHR3/EmSMYPMgQv3TFPxQ7pMOaYAA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=qv36Fg2I615ukGR0EgPcQdn7EF4YmodatcnTm3Hcn79xHX5jYs5fnDOLzpKdg8emKFsPVrAsR4s8aFXnU/YoHYADaFJ5eyoUpCb4m+E1X7qxFCKJopFPnHY5dQG+9ow1qsCdeUMpTcZi9fzMZpM3gm4iVoikp93kJ/0+qGK2N6+L6Xlfwk0uO2I6SXd3fQwT4euysMOStOd0jDti0VV6GvSmw/wHYRuz9qsbD2Wbzz1MpyQVTGaYY0Jjs8m0uiqbtATrOeqTWlizYvEjgMwMsKLFgvdtN4ffARf7Et5LKqTpdCCp7fxhImtir+SVV4Y4O/bccuuF7wuceCmxROXgHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772387395; bh=KOMKo4ia7JQdP80pxvZA/TmSZuY05pzBMfuuLH/0SvF=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GnrLwvvzxRVQXnZB6N95rTopiZbUnPekc1sMw5JEBKoqA/87WpxJzEhA64tY/yu50QLjQIWw68v0FpU6ehuZs3p7rdbTGhOM6VV8+6fTx4BNtiErvNVveum1qSZjg7gGkjHVG/u5QkXHVoNlTFNrgprqW+i85nIe/SKpLbhVeZ2A9CT9JioBjyHtwIAOT9lQ0eR+F2dS6d4OAR8wJYwGnzcx4uaelCfN6ZBrb24ccA7takpPYkl0gm5uLOibLsoVfvDma2LGxE1P3YVQFk/3jr3Q54pzKJLBjpznvPHqIWVKsvCKiHyr73pcjDOXMb2OLIt55jrZmqkY9Iyhj4qtcg==
X-YMail-OSG: 9hqfcF8VM1nyAm3vvV6CvNXNF0CGWKz4y9blT53hlTV6CfqfPLHVE3VLKpMrFo9
 VsuMq7dnZOF_Em2QDZ3G_dAMJvOhyIqLC8yFpLzJFEmYscr6g1CwdVT5P3Kq_g8igjr_mj9IhtA3
 9GctOvwOUNAx5In7XvYD5WCB70vHhuWQ68.qFTfy_4k70Ry.T27RYKPYUPWNhj18T2zPbLcG3EoK
 t9VLKsDF.9pKjnwhBGby1ZYz_VLNwNLNXkoVXy7Yk1IboZOnB1XRa2xRnUC7y8fPr95pzPQqhRd5
 0L2pAK1YsCPteE3fJDllgpRULAoIiRi.iv7D.Lx4BrKnlkRGs5IsHvSu1Qija7WzJo5K3cUQuEK7
 iKnmYoDlYnghWsgGetO0DzkSxTowfaXKc1hGXDSQrj7PJGDJlEbPDXF3kaYJyA06clvE9nTS5rfe
 XvTuFOwlIgDnMS0gBvM.oNU9MLZA0V3ZshZiwD3F.iAAof6QCP7ryMA_BK4xlNzXXMDjWx2OhFJD
 yr.kAzEW5iZOY4m9SvooC.MzSgm6ElMQISRsOmijsv5GOIYw_f_uJuzsKirgiDJ5sTzIwaW9cb1S
 c8DRgEKeqcEOuLMi.RTKwdELHuF.L1oGzFG1y1DvbylAVWVlQyVHFH3Hmfh7zBSoXopLNn8TvaTu
 .YAHrmq_fH7MsIjR8Y9BrthlY5x.7eZWIy0iVJMC4mU33wVtb_xhzn.yBUNQKbKDO11UZyJnOs3S
 9Hr8vqfi4VXMAsaQqKKkY2vmNvgJ.34o5q6vhzM5t6z0TvhtDtK9EG8vh.SzYQv6siRKrxUcgCEx
 m1RNZ_txOKLXNh1v_q8.vvGC7e.W25MVuBX2zty7woYCIbrXDdk3gjjJjiWy3lXRdwrzLPkMnGka
 0v3qcXFc1jetKS9KDQe._matNaSlUYTittDTlyhvyGvZfJ3sa6D8S8qZQHHt4ENYNg.X.Q8BMZO3
 BJ6IaWgoynG04IM7_jeWh_1fdLj6dzXXXO4V7LBYSiJjLx3hlWPdeLzZnRqYTW662KTQQspeCnxr
 kr51_w9_6vWc2bcFlpC2UnQYBVWy6p25BKg4HOvN632I9Dz6MkkzkRtfP9GbfaEGf9lQ_QQeMY9u
 zLwdPwKURHWQzRfX0VOJ.jT6daIIPRsIv0UopAHh7xJxxwK8Q9EiK_8cNbTUpymV1CghdqBx6fFS
 .73KpsvtDxeqmL9Rs5QIN5vb9WJrasKrcnLSNv3Enbg9gU_Gk_4h1L3ZK4CawXPfTJduK571H46u
 WidXwb04MSWqIY1PxzaTXaS7ePdEB8FQpam3TGF6.k9YiE1hJMMRQc7J9pnmBRbyPtkumEF.zcE1
 WFfJmZmzRaYWRW9YFKJ41RoJtuWZUhoxOan_dhk1AO6lq9tl3Q8YEI3sz.H4ylaOAfFV.7aWzeyZ
 jsWe.An7MLtHCQ69Z0jS9v9HIg4Xdbpv.SNwJ5Rnf6gSdc_njsHvhfGX1HkN6GoqmDUcC2qK_UFq
 KFJQbos2MnFZO3TyqGFnb832.9qkpLMvWzmQ9PDlrgzoa_cNF1jXdgDI4TdvWRDjL4wId_ETK598
 1AoPlbrJf.t4GB343oBCz12yyniLJC3iqfDGQ8Mk.Eolqm1GO5rO8uFHBXu9I.vyxrfuNvZGHisM
 S4uypROyuf5kj2ljEU0gqxJy1F3lbie2vaWQK805rRXBXYa2cjSi7gNQP85li5sAMLImFYhTKPky
 QlsoVANFfsPOkrvDWgsAml7Iy4HTnCAJ0qgYEntvGUS4V5toBE3wmj8Tdw8WwCcBGplOE1Mb.EMF
 jpWF_tEgm4QOzpSIKCmo0ftmOwTAu56V3kq3fGWYNB2bYviZuiMFKHYeo_RCBSS9HK.L1IzP42TL
 hnvH5w2lCy7qu5QpKGzRNYatR82Q4cE5zQfG0RnrzIpIcTyYQjErGwedLdQMNFDLtx5R5bDNNa9S
 ptkU7ajXdwiTzlCpjO_Rquvxl8UYRWu9FzFzsnrwxBAk0NZyAmsOblsw8LMt83zok.9zbI8rJ3MS
 xo0uQZRZgmsj3s9SZRI.UZyzMnZGIV247BqgjL3UPY8dn9gwzHV2mpLtSQ4F5szMuXWJZIlo1hMn
 ZfMDcnsE9XDj4NUCleIR9c9Wn322pwOe2T3Je.P9MletJIzwsx4FnbCWt3ImB_IqQEZO6DFBx_LA
 ixfrREaMBNWKRTasQif6v4FY7FA_xiso.TvWHoealVI1PJBLTSgXv_9xjwOSkfmnDIYvb5MxsOni
 IHyXBJoEnO5NHJ9EORJzLtQFIwZaWrN.bmxu_mQUBrTHJ1l3n_TofpniMeZ8v6Q--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 15684acb-2c33-48a8-a4e9-9157a452f385
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Mar 2026 17:49:55 +0000
Received: by hermes--production-ir2-bbcfb4457-4sf65 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f3f11ef6cffb74f33c75f244358355ca;
          Sun, 01 Mar 2026 17:49:53 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: krzk@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH net-next v2] NFC: s3fwrn5: Replace strcpy() with strscpy()
Date: Sun,  1 Mar 2026 18:49:50 +0100
Message-ID: <20260301174950.226192-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260301174950.226192-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-262428-lists,netdev=lfdr.de];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.unger@yahoo.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[yahoo.pl];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yahoo.pl:mid,yahoo.pl:dkim,yahoo.pl:email]
X-Rspamd-Queue-Id: E41A21D0E1D
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Replace strcpy() with strscpy() which limits the copy to the size of
the destination buffer. Since fw_info->fw_name is an array with a fixed, declared size, the
two-argument variant of strscpy() is used - the compiler deduces
the buffer size automatically.

This is a defensive cleanup replacing the deprecated strcpy()
with the preferred strscpy().

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Changes since v1:
- Clarified commit message: fw_info->fw_name described as
  "an array with a fixed, declared size" as requested by
  Krzysztof Kozlowski <krzk@kernel.org>

Testing:
- checkpatch.pl: 0 errors, 0 warnings
- make M=drivers/nfc/s3fwrn5/: compiled successfully, 0 errors, 0 warnings
- Module loaded successfully in QEMU (x86_64) with buildroot:
  modprobe s3fwrn5 - no errors, confirmed via lsmod

 drivers/nfc/s3fwrn5/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index 64d61b2a715a..9145deec7f6c 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -454,7 +454,7 @@ void s3fwrn5_fw_init(struct s3fwrn5_fw_info *fw_info, const char *fw_name)
 	fw_info->parity = 0x00;
 	fw_info->rsp = NULL;
 	fw_info->fw.fw = NULL;
-	strcpy(fw_info->fw_name, fw_name);
+	strscpy(fw_info->fw_name, fw_name);
 	init_completion(&fw_info->completion);
 }
 
-- 
2.53.0


