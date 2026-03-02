Return-Path: <netdev+bounces-262598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOFIEYZmpWmx+wUAu9opvQ
	(envelope-from <netdev+bounces-262598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:29:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FEB1D680E
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FF93305D6F2
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAA39B95D;
	Mon,  2 Mar 2026 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="js3p5gcv"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-30.consmr.mail.ir2.yahoo.com (sonic311-30.consmr.mail.ir2.yahoo.com [77.238.176.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053D39527C
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446766; cv=none; b=t1V+HdTo1vMBiEC3cvnM+dXUTbzro2BiMRZ8JwdfODm6LC8zCn8DtrfvcmhMPQJiGjwtOMGGZt27E7aErrkEcSDjsAT1xXqbi/BaxXdvebxX3lAo95unC6YF/PHNec9cCbQZOxVWrserjDg5/Uo6Oonh3LVyzuvQaSo4GhwTsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446766; c=relaxed/simple;
	bh=bLProma0DHl/1j4RJTh29W1mmGS92CuzeHI8c2d30S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=X+1e6gZv6w5VRO+OaORUpwmwvgpYxGIIxzwq4oa5CHFz/Pjzi9Uj1un6O8BXqahv2HumSrbwvvWg2YObQ87tloiOiS0dlq3QOB6izETFbMxbODEtX3QCu8al3txza9DEMtWt4p8vZvUey5J8E3/+u+X26CZ0Ceo+b+fBL2D/vyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=js3p5gcv; arc=none smtp.client-ip=77.238.176.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1772446762; bh=0B9sEv6mlxV1KYtt9m4HrAvho+QF9xsFUGyCQyI1pLc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=js3p5gcvlAzMxMu4FYlkoLWmks+BQK6+LtEmadQJrKmtTDYpNFOZME/Vylv87xuCg38aiqiUYuwGzJwgn8SlLLTHAz/QFWGzB+BVbg8+WywVwBKTAOltcnVaH2/M3B9sy0FoQV7Hp8EHc2UiilbY93gz8e9+KB0sSI3YMiUFz1wST0ylWw+MMsaHkKbsdsuJ6ur2WGXJXIRGQJfa+aStoCIaCCX3R99Kkt+WRLSnldx7Pf6hJolgyEPPm1+KHeOhURRsaypK1a07Wr75k0SU+tAM+NPBYm+8z4EquqP8PHYj32dZtkVISJSiBdjspBiNVon2+r2Iiv3tW4SC3slmeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772446762; bh=tZQIbgd0xqbaA+ro3f/OzEFfZCSef+bCQtz8EBB6EHn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TdNwSQJuzanEPp7MdTPYMbzqsZfGP3KKx/VQ0kXrMzxjXgcm86G/gWBb78hmvzk65oql22Jnf2SGuVk1S8YVaJBldVm/nRPLIryLeLd60LeyMbofTVGv+VWIroXoDCinY5LhB09S9IeicIz/358sV5UXlfbF7cNkilltMDq1XqpalZ4Nk7JiWLufGwxtzeAVQ1Stg8oU8hktTraDvaqVa/SDlbr8kw+AzIVDdsZfD193SRRMr+VZygCwT0nioevvmMGxfdY2U8MMmiv/M1/mb4C7ljhVT/XUOHfMv68Po4q036fUF2aqvpCGjQwapqarxpB8c9CblwPdKz91bzkuDg==
X-YMail-OSG: oqaa7Z0VM1kAdjIsC9UzteQZQjFWchAT_49mfoqRubek9rbBFo_nzhgVV6yXstC
 pHHqzn0FDloK1JG828lGWJvM1sD9YMh1Hc3pb.O._.df5KQyo26qbjXcdCPZ8f3k0CRzn0HauoPu
 Y5wNlvRgF47As3uJbjFPQWdzkmQQIXO8xYz942deoES23dBSaS0y1gZVpGF.XpH5D3ZU0gJvu5P0
 B8wvtnmJCxAgDKDwU11eqV09UM1nC46p8HMbytzOJ.fY2QlfFboFc5sgY13B8SZ9yTNMdUcWc.nl
 sKfhDmxtJkUPD2XkDqJl1X49Horc.UK6g14ZRnLSAJsbbLWQLSIvEUrICBm1MZewexiUA8gEkR5S
 5MwnpIq16tfGyFJfCSfkYeKmsN5GAuicUYBwYH3gptZ44pn9SxJsYc4JUTLgNFk._6hKAfhSi1HO
 2fOaCdKM8XkSN8Z.zpeA6eYp3pA_MscQJXxJPaXR2b6ss2iiBd9S5xb9YJB1o.yMuchrwJBJhr71
 MsfSX4X9CJ98OribdnonbioxiQD2s0lhF3RwDJwryCx4DUBnSsv4fSz_SsLwQIsvrPg5Cxy7mVru
 1hJnb2kJxx3nKiGdyHc2c98knj2HaqDoT2ieZAijL8z8F4YcWcC7oxxdpYTKg2pXIhM0.IgaQf96
 F8z_Cb7_EEvIm5nhwOO1_KP6hDfCLr.uMIjbE5OwYBvJzTIR9UKVjTN.dKCfByrrcfthLR6Saf_W
 UdWluhOsTO8TBCR3R3Ornc6Q72sImhdnllJOiWaQyNaikEYiI3fjGKpS4ec2h4OG5abG9HzUseSB
 ZTOXMHhOqTwhRJIODRTMDhDXH8frdTRaE2EdaajAei71OaZbWjNUke7kMulM15leqCpn_T_CbKu3
 rRVlwQ10WaKdd5iwtAbvgQv7PerHh7to117yvPIoYxujU6MF0TlIJGL0hbkEQWExJs5oNvylCM6C
 Kybf.S5i.DC.Git6ho_vFs0JWY42aHbRqbAgO71gudsGniddK0unj5octnu7mymZuHBuAceWKb_B
 vE3v3rbLhmReM06mYilRu0GF1W.t2Rh9jpndWS7DMoY8IK7gDLkhkzj3SH383aFtOfLoNokT97D3
 k2kb9PV8hU23rM6HJmpB1UOM5LNcudxnlau3E6lD4WzGHn7.rQRIWyxkLCjCmptZUN24ItnewqAi
 ARws0ryqfVZWB4m8DmuhPvtEr_Xpp5J7XJb7hrkBLgZ4gi2G0vVpL4dGo_WdI1YO_q5lq56Nw0kF
 evIcp8naValrkfztG8ezhOap4meOksU6tOYCzylVEkGODjNISa8nVRcT9T66NsOrzziqRZDk.qmi
 hzGXcuqR4poqIN4_1fka.WiJb0BM8Fbd8qKlRJrgJo_udg7jWgTfQEsmdjFHpFL8Mj2ERCpSn93b
 _5Wc1297PFAInqZLDBa_Vd34b6CnwfRnSIqQ80izlBniclBGDwHNfkTMuaAS.bdBwA7.DNjKJOU4
 ctRsTRl0EL.l_d3J7XAijStt21vJjYybL1DHWYtZ5Nj9hDBP3RzrP3Exff9cuWXgWVpr.QH1UM8D
 jNxEdE_IkON..PUSbwc.sIe.NMTXIpStcKxELSUKcU3Q5crFdV8R0skeodLRLhwVW8iZ4uOf3544
 Gn5DISHq7iTtw8QQURGskPTmJxSEJu7Ma0AakX1_BtfTZxFFBiQf8EuUOUDAMtvMs9xodDy9FZar
 l5HEF0Vhn4ry0oLemUB5SBlb5t1seKA3_hXMv63VWLJLleVjpxTosptR97bKFxdtIrBAF6.AwlVt
 HjEMKQKXA9Ku58xii11lluPyhwhTJPBpyGnh9FzjsPGV4M16CcLIL_z7sQrYpiq9p3q2k0yiyqJz
 FVmlgNP.qape_e.TtnqlAccD8l6TUDECPom9DpCBqtpuDVNLoJ8q_EoFc0sLCljqry20rsM_iQoh
 4XePVY_0WP1Ctklq5Li9kRf8hipFdIu8l10wtdtLRHqbMVM3NOkhHl2cBhr6JnuKDyaEhLsJn_6w
 60i5v6ehwmIFFJDo782Ia1RyZs5Z1GpPHD1TgcETrJsDRtfZwJ4MljreVObJgXOGkM13s7wytkxg
 QkVXakUtaXiyYHCx0WE.v.zv.VI3r7jmzd93XkUxt7eBpvNvuH7to2RHFaV4IgqFh13t6U4hquYB
 1K4GJbJCjVHSrYqemgj6yax9o.NZNZ6SM.rZoIP8XemNgfspZVRCHgfXOAG8CO_5yavbM11Feihq
 EaZ5jIHxI_rBSZ80IIWtTzDiUYH21mFrzrXa9K3cboEHuUQ2j.EUz9YfMm49O
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 9e68b505-d869-4a37-b6a1-f0b7ad82117d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Mon, 2 Mar 2026 10:19:22 +0000
Received: by hermes--production-ir2-bbcfb4457-d9ssk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 05798cde46ae7785b9d7f1959d335729;
          Mon, 02 Mar 2026 10:09:11 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: krzk@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v3] NFC: s3fwrn5: Replace strcpy() with strscpy()
Date: Mon,  2 Mar 2026 11:09:08 +0100
Message-ID: <20260302100908.26399-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260302100908.26399-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl,oss.qualcomm.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-262598-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.unger@yahoo.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 99FEB1D680E
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Replace strcpy() with strscpy() which limits the copy to the size of
the destination buffer. Since fw_info->fw_name is an array with a
fixed, declared size, the two-argument variant of strscpy() is used -
the compiler deduces the buffer size automatically.

This is a defensive cleanup replacing the deprecated strcpy()
with the preferred strscpy().

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes since v2:
- Fixed commit message line wrapping (Krzysztof Kozlowski)
- Added Reviewed-by tag from Krzysztof Kozlowski

Changes since v1:
- Clarified commit message: fw_info->fw_name described as
  "an array with a fixed, declared size" as requested by
  Krzysztof Kozlowski <krzk@kernel.org>

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


