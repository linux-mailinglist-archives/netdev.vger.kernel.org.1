Return-Path: <netdev+bounces-260377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO1ADkRXnWk2OgQAu9opvQ
	(envelope-from <netdev+bounces-260377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7727818334B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C63308AF44
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAEC36405C;
	Tue, 24 Feb 2026 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="HrRgrp+D"
X-Original-To: netdev@vger.kernel.org
Received: from sonic302-19.consmr.mail.ir2.yahoo.com (sonic302-19.consmr.mail.ir2.yahoo.com [87.248.110.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098562C21D9
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918987; cv=none; b=QYlRL3hltebZzpgSdqA5EpmerPvpHp7z96lFVhv+GbVBXiioOzYXhwB3wRQ+eN6mLZeY+DSDedR+lrA4Jk3iGqmRgPMHqsGCGQJEVvhUNy5+jYlBHR21kRBXWxdfV+GS6FXwBFsqWXUANcTHpy0ELbtcIRwTTmTcuoTkTY9ZDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918987; c=relaxed/simple;
	bh=bm2qPIWy/hHE4P+dDtjgplvlkXWZzasPiAQIXgfmf8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Okqb56fPQeZodmyy3UOv5jAStZdrPECe9DTew0VkomtIzJzOi0tBeeIAEBTu2chokPJ0NHYSpZO/8ztHsMi/Lu9TWZrFMBCZ8Rau4ZLEoLbHQEIhu+Wh2MQx5xEMpnObqcvxZqhxbjODHF2AqH+O7tOqYgfyf4zaoEOBcnVoqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=HrRgrp+D; arc=none smtp.client-ip=87.248.110.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771918983; bh=h5Gfv++c0AF2QSz5oCZrZRGlwBlnJtyXzPvoPPd93MU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=HrRgrp+Dbz6E+vN0PF8MPTfPiKrlnVEQrZO5Z76Cuh5QrD2mNHZJHf/Iy3EAzJRUoydXov1H+OM8sDO2lqqTYB6H+KYGZVwHebo9nmfqlClvneMdZkMifpCiJLxDLRroeYqgm6ZWDi2Oi+Tq4mSV/ozxplz4JZEgQa+4ZzrO+gsWQOK+fnvwRtn2i8cjCPfIZYRU7XSvpfjHn3dspU56f7JaG7cVqHDo3RBF9qUO0ozQDXBzpkNe635Pcr2Xc2LW3GabcX3Ad3/znSt+mZvScNr3m5UVr9y4asXNnXbmZOsmAH8t/uKWlZ4aufc/ADm34sCpAp4DhXer9nqWsK0ELA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771918983; bh=vpumSg46nVMiI4Iv8TCdU3jlQZm9ZcyIAJ18gR8o3MA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Hk7j6xKDqJUsaOa7NKUts4LauqKKpbbkXMwSVfOfdjLy8+yS0dpARJAfh04AO4yODIRI+Vsdhd+BK2Px+3Cf3QUr2//nc2ejzgNKLYjGUMKyHblDPWvrG1nZpHkc8FSlrWNkM3bJB1ZUQvIFGuPSeq1oVjp51ae5BasJklPHt3odNeM6vNqKJqdmPLEx3kh2/Fpd8wrC4j9P2Dn9axfO1E5/wUqs91vZIdynLqrD1dYDA8aQ2ksE7AxVdc5jjqctdlsgoPOM6IoT0KzwKWtfPvvJzGv9BFGqZNLVJZ+TsmAh62054udTRJIvT8Sjf2H8Q1YqFF5M39pcJelo9iSrMA==
X-YMail-OSG: J9zn06cVM1mvTf.BbIiQqZI.EgQCrz5D.BKh.2g.zNYLV74y3u7JuzNwbpoMv3d
 oYjx1HutQdW3T_qSbfBCIGtTYAOX.ExE1SkIaAnOFEOgkV_R8NVOWua0nrG.YoGVaXFXw..tzKkw
 rhOX7kyQglMeFtBQpBDhuytJDfMBSvkrxFyKOGeg3P1howhagfZRxma.QWP_KXSQO8CZkWf9WhsO
 _pSqAUIKcyWSwwGqbAabhzF.hlIwZO.iHcNrr.O84K_U4ZDxOj0nX0mUDh5TBCRCmySYRj.LMs4_
 Z94vPg4rxphxECYKahtMUov6OxRAvD92PL0efO41d7zNuzNhjtZ.8uito_pDo1Rl2FY6NydAICl0
 _hvG83RkNi.eoslzsJMBOpmqOGoNysCl4mXErRi7THANagPET2M1ZD4jQQ64xSz6ccpby4Sdc0pq
 wDGz91d4OsXqYvk2PoPtjVUQRY6UiFLREmj8gcjeNNECQfpkOe2PNwOCj2wB7wsG7jtHJaN1bnws
 tmsdFayrtMxXnp4eC4JuXL2nagGrh4HZFO88xIXaGGQBDcSMbKJGld0B4kbB11tN95kbsUSd3s7a
 1fEt9KTkJajyqxPJNDBieFrpy1CAVXYa0XoVyS.JmRJnarGuAc2VLMATi8uOBoi9u8ytJ9jF76H.
 iCaJ1P07nkmD8l.YDijW3ncFP1dMPWMVn7SBgwIKy8oZ07MUgBVDEZaXF7D2Cq.dSGhUV9ffuOOM
 WYbleQFGvkdgGkTJXl8kaaXx5F8qDH4ukSTtsHcdLS9vYmM4LptcxRTgolaFgKZuxPphAFeLH55S
 zuBqs0GM_thNBKIE4g.S8rkBTC1HNe2JRFqNvrcltWMSQotOd7SweVcFnrz1.HodXTtFvx3hyXuz
 H6N7h2anhmw8nel12kxPWZOLyIpwYHB2TwDPIVf6OtinZjXnTfqTLnTrjcPxHOD77WITo31kVvmZ
 JzcTghDT72Y6AU_8EGLD9Idx9JRhqegKtn60iTEEfTYf1WRj8NDPE_N90Sjmde3f4pA.AlG8NY2I
 beHVqn8Em9P7dJzhJCMcpTBCma8yEGWwT51m_Z5OPQNUBqRTtqVWG0tZ1kmFERVsNUYHZyXvSoSa
 AtPzJvkjHfU2Loxc0HZ1gJqZ8QMLPvySKF6yxYbnVYVSmHLKrD_IId7cAH0qtjeAsh69ZgsWh39c
 Jl.fJ2SPdOb10W7N_5apZYcqmtx2K9SXkGtm4Js9TZyVtnv5ZkXYKR3BWc2jLwmEmCR0StK0Usgz
 OdEN48oDcYw10CjJ.stsI9ACm4oF.jNXAPZ47MSe4ziuwWO4iX.OcF1beZSZr872aRV9P9TIAuCT
 svQL_Fv1oQVRHy5i4bFpUPDRvKNHfSrwwACvi0LigwHnL9IoGN6mjDSnuzMBaRm.eMRABZGQNdhu
 kemK4OsRg1ZyshZUo39_8JHodqDx.P3A_pPnI0e8DHhChQ7MafOpqquvqptg4QRvjIRwCDDnTfqT
 c3lVZD4W9fQ7MWQVwd0uUyw.HxW0GXW4pvoJhp4j36dtURY17OM5JCANQXONuxoOrqPSi7VOKN.l
 CVus8.Cc0ehGdsoYV1QJ2W3dzb2RriMLwqFmpBuhQZFev4dkW7exV26NwplNRngNuKq1jiJlFnHw
 S2LbvoX3xsdZesXuqg.VHqxK4uTU.rKBorDjhqXTxWR.oOAROp2A3JClU6bui_.ORiGxwZ7fZoMW
 3eOmLAkPMbe5NyMQ5Z_fN72uyWGVCEuCXqeNZswbliAptPpiTnXsdNkh5h_guBou5D8eIznsUEen
 ifq_LUOXy4sozdFHmHpfXOyRdcQgtpqMQDITXbYSCvOARbfXi8vw04_iUGOHP_8Ew8C_LSp6QGr2
 eNwbwU48ut07hYQ03FzDCLLHsFdWUhwQ4jpR90BCqu4x0xol.UJHnfPCWZBUoTK_9b.OWVUgE17_
 uyHHCOapiQR1.pYg2GQZtF7_wKoJSVqYGgJ7AGN.QrKIk78rp550T.YQPn2W3x03OMYBpxjuF1rS
 PCVJ41Jofd_DY7c3adaU_c_icRzZOTzxNPHeCNjYTizJgriGQz.53GwcM9ZTSNhpv0JIjxh4a2Vj
 RiZLIsKRi5na2BymBK86Sa38iusRQ1KWBXQ1YyrXLsbWltzIMiO1Dy_Ix6blP.ovuZS1MOESFQL6
 l_Qi78_Wa8B_0nKh29iXAeFzHZN5ZST4c9D1utv_LeBIxaAEYbZBR73fCGJXDt6jlmm3auyhfJmg
 GNXTD2FeLTPXa4JKvbrZKqA03VuKLfgbS.HQbCmD7NmqrWGBv69gOzoakZetM.l0Vq8cwRp31Skr
 Mvg--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: c81e2d46-f724-4656-8860-554ff225cc64
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Tue, 24 Feb 2026 07:43:03 +0000
Received: by hermes--production-ir2-bbcfb4457-9k578 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1044f27e29dc4477327e90f76ba8df04;
          Tue, 24 Feb 2026 07:22:45 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH] nfc: pn544: i2c: Replace strcpy() with strscpy()
Date: Tue, 24 Feb 2026 08:22:42 +0100
Message-ID: <20260224072242.32551-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260224072242.32551-1-tomasz.unger.ref@yahoo.pl>
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
	TAGGED_FROM(0.00)[bounces-260377-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 7727818334B
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

strcpy() does not limit the number of bytes copied which can lead to
buffer overflow. Replace with strscpy() which is safer as it limits
the copy to the size of the destination buffer.

Compilation testing:
- checkpatch.pl: 0 errors, 0 warnings
- make drivers/nfc/pn544/i2c.o: compiled successfully

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/nfc/pn544/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index a0dfb3f98d5a..7261e12aa6b5 100644
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


