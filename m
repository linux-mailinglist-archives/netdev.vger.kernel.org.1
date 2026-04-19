Return-Path: <netdev+bounces-279580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCXEIuGu5GnLYAEAu9opvQ
	(envelope-from <netdev+bounces-279580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 12:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D4423AE9
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 12:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B9AA300335C
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658CF2DF719;
	Sun, 19 Apr 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OOwj42SQ"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-56.consmr.mail.ne1.yahoo.com (sonic307-56.consmr.mail.ne1.yahoo.com [66.163.190.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F6228CB8
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776594653; cv=none; b=USaSTN6SZDGbmpDUPx4cqEtNqGRFsynHENVwTjKG38kbBAdNd3a9KM1pN4n4uYEBvPUS61ZzNHwvXxF5CTXJXrE2ShxCVbFW9kFD2O4kVN9M43V54cUao0ZYINoUssrruYv6sSoI8nGHebbXPHILI31qXfaUPWgOGAnjFZ8UX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776594653; c=relaxed/simple;
	bh=6FzEKlLlsmEY4dSz8zL0a0Glgra3jaPWbDACxTX0+6o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=bdJGKzCn3SMCswEA+WA19W3Wp1cbJCUOyBROrM5iBry2uaTEbGDQLCZ5pRjCj6SVg/sKUps8hHdaGEOVKYBSd7DbniLjerFvisCXf3pMEHCVccQXIIp0jekr1KB8no7YRVLW+ILRQoafDg7RNRuu2WIZVFyb0OvYqezod1MKZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OOwj42SQ; arc=none smtp.client-ip=66.163.190.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776594645; bh=BBDb5GkCZETMdRyyxSN4PCMmVIyMTMW/gTCwKA9bPyE=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=OOwj42SQu2sOecuG2lakk5eLNVRGN2O1FuXZ3oHO0qz4yr5pfmdhKwMBOhLkNh+LewYr3/t8WwjEaGR+sMCMi5BcYYxIIuR5VIurvUyl+vOrp4ROawXrqwxBTrLpCDcDwv8y2vWTa3CSRRuwtvOsVs3EUym9QQURy3eBoOVgg/1M31fkVhJE7H7wxzONcTw9LZGx2wSKi60spI9Y04m4heOBvQFkHr2v70qII4QpiPmPyV77WxcCQF3AzgngT/9vnCgA9vmO8WbjNa6PF7AqsOBn/xEt7P/pHH3mvkm8N4sLQgprT5AePi4TirbzM78J2egoWgRvFbUX3Fn2lCoPnw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776594645; bh=Yfz2dXDh3L6cQ3xF43Yh29YLWd8ih34I6ilbNqHTvNM=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=GRN6Sat3SBsuaSOwVnOpTkvEuqo98huJu+vsGbJ1S/IEc4nKP6pHry08qJJZnwXvC74MjSRNv6O+Vhnqoa2xF16HQe12eqsx5RCDw43ZD6is4TXuff4r5ltWC10/61FergK33MRwQpqyF4A76Lhz8OlnGhHJ4SrRMRSr1UWEESt46mCDlOk0Jx+SI7LXITPuz9FeyPmqm4WoN45znlRsn+saQSF6RCkjU/6nrS0y1lMWaCr7Z0E8+pVN/XWnUea1Vra6R1ga0X8RRm0kWyU4Pop+HJjVKBSKf95S+3cOWQ+DFZvbt9JAkL3lsS2qvWa+EnlU+o+/yTjv4VP22X/RWw==
X-YMail-OSG: vQ1JsScVM1nvOOTvjhJjFx6S4Rho2ufgXoIYVaGS23d9I0DedeGFxuURYior2o1
 vv06dh.1ucz2FPD940XUhk7AqsBRGjjJYm0y.kwJKaoELvHIPhbEMv36EXV6NzeH9is7u3wVrNhJ
 R9IXTdKQvCBcs23Tww3UFBthXCfM2qf6V4gOR4HmjUOFQKQRCpb2EIfwUHa8hek12lNjTEtpocrX
 5PnH4aFQKC8WRflnThtjDPnlmdzZlnu49Ons76VLvOIRXqXs7jhonv2IEVPH5_MBD6e7oKIp6g.l
 WdWylTALpJ.EkwdoOs27mLzcutUWONzfZAIPEnBhh17XlGJViTCPfM_t04FjRKpUcO6VGomxSESm
 i3is._wjD59lL7xGEeaBJppi7UwLLTUjXBCkSzNZLvSMgf58GrHilEHxKUNuBWw4jcHAP8ox46WJ
 3duN80XOKNlfCCbEa1OgjU1z.O4CBIldacs4FcttwPdDACrTaIOv4L1olMz8h6_O_UEg2J3vmfEX
 Fwjt12mOQTkdOzlVgKDpk3bBkqq8p40DM.S6ig.ChGQ_nBIehBX_jCOkaAweX_z4QvxKQmAitcJs
 xNu4Kp7jezetu92EbXCHjON7RM3jy27NG6RJSBO6nUmC9_eG5mSgvcFl7be3qC5ariuO5MUAZnnr
 bfixSYmDR7Dmn2WOdcDLnRBvBSpq2W20W8p9tOYKWqMESREdL3XzCUZIATU4otEyx3Hl3lG3Bu9l
 tPJn0IqR3zgOnRa9jtv1KpDUEvrtm.Bgw0oFRyIl.2stoMBAQ9w8Loksb3NG5Cbi.6rPUtunGU2n
 WusDh_CBvOcFYSJDdFsfF6s_SoQE0uU1IlHJI2tud4RZVZ4lyeQ_f3irvD2EtTSAicrD_Lj88.go
 MTjy4nYuadv3fc25v7xQ9dCVO43hLwMGd5taaKYpyTZigmrIVA93FM6StC0mTMnpy1RUo1LfIHh1
 LU6sSvTw8WIcXnCyl7uEk4J_RaZAgFEqQvmfMcRujISregplKo2XOn0JaykeYUNORuU.VtoPtXt1
 D6SByb98XwxIwxO4lN9XmDxn27BFTTaslggKmfqO7KNzYbEtAraxm1.5wcj_TgZKLJAmexVVwDZL
 qxAe7kAb99UDCubXS.IwzocetEL33gLAfysJAcerJlSDLvcCNsGFBlzkXM.vEUOa5dB_s9ThYYmc
 pZKolG8sXiwuAmYtwRul__CyqS0okTIPip.f58G.xWy1SXWE5RpIscmFDSOZOMvOrzQbvW7HiqZb
 VTRddX2l9tP7uoSSInQojGW4j26sJSW1i07IgkCCVM3Q6O5nkSrccwuLKcLYDGjWY7F4V.KVzA6T
 E6xSg7M7iPZamxi.71oujPpPpZe.zE6AebyYmmPaI_o7Rp4niWY0p184mV4Tvz16mNC36aJXH1MX
 fdTsIJoZHL6f0PXAHH4s2T9g0A8ub_QQNWhUWE6pJUy6T.KEnhnrQJZ_fVZo1mkYvN.TsHpff25w
 KnibQLTe3Oynt2HIo0FkHHy8WlY2g3i.2GexW5KLWLgQkzyaQ9Ipzbc195nvYG.457mIHqRjGr8L
 ZYRDVk.Yrik3Eopr7M0MRp7g8W5OZ998Mfxq7GIDIZ0yakif39Mb0BtYe9q8QHXyZHQLb_2A0o9q
 oojWk0CLXeberjxtC7XsLHkUSGjko.f8G56ELqJFMvb_fRYHy0WExpnKJSlrbjeQtSkB0PWkRq29
 HkLNJtXAJh._d8vBxbQqK6KoFLOwOlpb0BStFaWonTpyAN0EejhiT8MNCdZSCc5F5R2bNmAuLdf1
 tclhgqISdW.jfdu2_saeudUx50GXYCVZqo0m.XDTng7L438oQznTsCKrCSUD_GOcPH0P1m2O7sHm
 pYSANN_4m1o0wp8Wa5xBO9p..ZwOvPSD4kSmBNDGlHGwAUqvTDKf8DWaQXCRhmDHpOmxlns39fG0
 busEjU0A.xicQO3PoiPy6fISllnpP9I8dpdZtJ89OFWW_iVGM_TWXmfpHHjZcRd9w0Usf8BpUOkz
 LnY5iH4NVZ2uuTXDhND.st.Z6FaOGXsQaMz1NviJQvAhkEy01jw2xwkirY18RArU3Gm9N_KxLrZ1
 mZoW7gSPoq3G53IMy70J2hKR0H0WMpdkyu1AnHxH1APUCtfl3BBiovEWiBGUqa7FhN.86Q7LPUsC
 ZWuBnmWD2Y.Ye5d3YYNZomQm8YA00F16qsFNqDeDC6W9giRZXuKhkhYXbS2PCfPdHq3trV7FTEJv
 R.OujNWUlo9hF5oBBxH3Eb1lUsa61htBh.OFhu9nqWCQQ2UyYxCka1UrccG0tgHw5Hu.Ybetqlmh
 tmw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 658dd5bd-d1c1-4858-af1e-a701526606f3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sun, 19 Apr 2026 10:30:45 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d41e9e35992ffd030667b6f038e1867;
          Sun, 19 Apr 2026 09:59:24 +0000 (UTC)
Message-ID: <c1519cfa-5a66-48b6-a578-e0ac03a57484@yahoo.com>
Date: Sun, 19 Apr 2026 11:59:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: netdev@vger.kernel.org
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH] net: dsa: realtek: rtl8365mb: fix mode mask calculation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <c1519cfa-5a66-48b6-a578-e0ac03a57484.ref@yahoo.com>
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	TAGGED_FROM(0.00)[bounces-279580-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 209D4423AE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK macro was shifting
the 4-bit mask (0xF) by only (_extint % 2) bits instead of
(_extint % 2) * 4. This caused the mask to overlap with the adjacent
nibble when configuring odd-numbered external interfaces, selecting
the wrong bits entirely.

Align the shift calculation with the existing ...MODE_OFFSET macro.

Signed-off-by: Abdulkader Alrezej <alrazj.abdulkader@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index ad7044b295ec..b85c99216648 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -216,7 +216,7 @@
 		 (_extint) == 2 ? RTL8365MB_DIGITAL_INTERFACE_SELECT_REG1 : \
 		 0x0)
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(_extint) \
-		(0xF << (((_extint) % 2)))
+		(0xF << (((_extint) % 2) * 4))
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(_extint) \
 		(((_extint) % 2) * 4)
 
-- 
2.53.0

