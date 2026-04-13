Return-Path: <netdev+bounces-278160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGoSOC0s3WmVaQkAu9opvQ
	(envelope-from <netdev+bounces-278160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:47:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE5C3F1A70
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99498301B061
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71DB3806D7;
	Mon, 13 Apr 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKkiGT3U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3E3803F2
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102441; cv=none; b=fHNZNV4DF6kpV/P6LR8bBSxTvBFdYd/7nZ449leNSp+QHhLU76f8U/m4N/pLvo9fwXo4zdiPdnb0h6fFNYGWPw7b2Nvd9JgStS1imghroD1SdT0l8VUiEFFQsxq6rGpmhWih6+xtgaKtq6aNuxpJutcCia5VVm7iJSn5m8xaA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102441; c=relaxed/simple;
	bh=GtwmbLiPSWMmwAX9UxYBj4wwkd0cc3klEapfAfVXbC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hi1IjDCRhVvStW7r+OzndL6Ij8xsDl5pteOmqAqRety/8aq9gIRhTVbMUwuj2aofQkThyr5NIZjSSGOUZdx9lS9B6wfev6r1lbzapy/I4U0QkdarHayPb652wsZeBKzLowWndD6AyVeRYtqPfEmi2O7jNAmjl5CKSVG5GE7OtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKkiGT3U; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfdac74050so483633485a.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776102439; x=1776707239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0lUUpSXi5MAMiel5JSrhfv0lEsBngpxl2EK1emznGE=;
        b=NKkiGT3U6YeNzoDBv0RHgkuMtBhNIkWxXX+G6MG/1gw14E2M7t9MMAma/qF31dCvHb
         dqH+3C7co80SsmmYURETBWOpuDlSRnVKIMng++j77q9qHa82m5k65gzy+tRRQ7WFcrb6
         BYVgl75vv/YH82ZiTKm9CjyfrNin1cS8OUp4MMR0iaHsS1aqlqbpFgzifyUmfVdk8Vmz
         GiRrIBrodntGyH/OztFl6O66mvg0JWPWLEKjGtuv5se8vTe0ydY13i7EgZL+reZEe7XJ
         ZGFwv6xHdECf06VtBSAgEqd7hCQyJfM6TTsqur1Z4osH1Bz9iQMNa65W3dUmV1ohE6L5
         Ui8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102439; x=1776707239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0lUUpSXi5MAMiel5JSrhfv0lEsBngpxl2EK1emznGE=;
        b=mz5uPc6SyZ3YO9MouiFwKhaD1fyFk5x0meV1kni4bQsmnxy4+ikD0d9NQTiXdslj/1
         q6qWfIejfcGo88BE7WHNvX1W3udMOBDlrxLP4gyF+0i/DAYRaG3s0p9+wmHhTGc8Pznl
         ucZD/kUqQm/Bh1D37ItsHf/3z5USe2FMU6HTzMswG0xuhsB19MJbqJrgGuucNmn9qaN2
         w33CPyLjV9e+j7dDwcKLpHbUbEJjCIUyy3MYuXC8VT5OtLsii09TMh7TIeeBR546jnb8
         Nwuid2r1rB+3ME1zE4N/1Au8A7M+ME9RD6JuG7wNukjsXs/9uF0isfJwewzCk/Xqr3Ig
         RaGA==
X-Gm-Message-State: AOJu0Yz6ZmzBa+lNTfx1PsmLhayhlcoA7wZV4LUVJ6vdtroBqXU2Sj73
	EroFrTAc9Uo9oKNxzM6e3Aiadw092GKTFXB9JFlFGpmp1I2V6fc1vJgrgjZVVA==
X-Gm-Gg: AeBDies2iTnPPpCivHM6e/FKgnqOX2EPHxDIoMOFq10o4V8Oa9+bQp/k2IEsbFKRM9w
	aSj1NtTKEomTzWan2lpduQTu+gk133iL2s9V896KN5slhL3sr7LxmRVlr4kDg/RQVsKMdoI3ywf
	TM6Dr7cyUFaLb/vpI24lvsfdns3sgb5dR0DmrX7vHB78HMhJfn+6x99ilSpIUWV31F4MA29M/3v
	3Yv1I2y9/Z2552/dTsjPNJygEQSYiWIO75vvr9sh4c8/6PRIXDrggYAtPwckNV8o6cw/MhJ2OES
	ayGjDzFyEyOz8RY7cBHb8CokRpeOtxgWkrC6EqWMvLdD1Prz/eHbup2g9Yuvva4sUqIHUBd/ZBQ
	glXL0umC0IAuuhW4DcoRTPKEXwrnLL5LDIZ7WFA0/QnEBuwSPmtRj7e/V3oz2abR1KiUkjMl1V6
	xrVJjtQwzbtWIbU7+eLpFQjF2B1L2Issrz2F+oea/y5KDnfIdb6KmvkXP5eZcNxr8Tr9Adp+KUI
	9XYVS41exTjvSQ7yHf/
X-Received: by 2002:a05:620a:6c0d:b0:8c5:2dbc:623e with SMTP id af79cd13be357-8ddcf9b4288mr2016896085a.50.1776102438999;
        Mon, 13 Apr 2026 10:47:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb915b46bsm923141885a.33.2026.04.13.10.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:47:18 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Simon Horman" <horms@kernel.org>,
	"Kees Cook" <kees@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH net] NFC: digital: bound SENSF response copy into nfc_target
Date: Mon, 13 Apr 2026 13:47:15 -0400
Message-ID: <20260413174715.197640-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278160-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FE5C3F1A70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

digital_in_recv_sensf_res() copies the received SENSF response into
struct nfc_target without bounding the copy to target.sensf_res. A full
on-wire digital_sensf_res is 19 bytes long, while nfc_target stores 18
bytes, so full-length or oversized responses can overwrite adjacent
stack fields before digital_target_found() sees the target.

Reject payloads larger than struct digital_sensf_res and clamp the copy
into target.sensf_res so valid 19-byte responses keep working while the
destination buffer remains bounded.

This was confirmed by injecting an oversized SENSF_RES frame via a
patched nfcsim driver, producing a kernel panic with the overflow
pattern visible on the stack:

  Kernel panic - not syncing: Kernel mode fault at addr 0x0
  Stack:
   4141414141414141 4141414141414141 4141414141414141 ...

Found by static analysis with Coccinelle (memcpy-from-TLV pattern
derived from CVE-2019-14814).

Fixes: 8c0695e4998d ("NFC Digital: Add NFC-F technology support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/nfc/digital_technology.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index 63f1b721c71d..5ef49f813f70 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -768,12 +768,18 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	skb_pull(resp, 1);
 
+	if (resp->len > sizeof(struct digital_sensf_res)) {
+		rc = -EIO;
+		goto exit;
+	}
+
 	memset(&target, 0, sizeof(struct nfc_target));
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
 
-	memcpy(target.sensf_res, sensf_res, resp->len);
-	target.sensf_res_len = resp->len;
+	target.sensf_res_len = min_t(unsigned int, resp->len,
+				     sizeof(target.sensf_res));
+	memcpy(target.sensf_res, sensf_res, target.sensf_res_len);
 
 	memcpy(target.nfcid2, sensf_res->nfcid2, NFC_NFCID2_MAXSIZE);
 	target.nfcid2_len = NFC_NFCID2_MAXSIZE;
-- 
2.53.0


