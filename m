Return-Path: <netdev+bounces-275146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGk0BRPwz2mt1wYAu9opvQ
	(envelope-from <netdev+bounces-275146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:51:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3623969D9
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D15B830A8489
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B603CF049;
	Fri,  3 Apr 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="etF5eNW8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8EA3CD8BA
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234647; cv=none; b=IsR8HVwBxdUvmRb6LOVK9HMq7r+CffVB23iM91d/x19obvCToCqV3+DTjBP9YvpA7kMV0V+RV+gtpVMKchbwlPxF29oQ5XggGBp+RmTpUW4RpEj4Z4qfWd19tRIdfVuUKyuUPuOKNRmtC1kgW1IWJqH910Pg2gb2i9bbqe6XjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234647; c=relaxed/simple;
	bh=c9ud9hMSAb29AtftWqh2+ul+32jl5aytaub0XxdrYew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ONNfkjENjVWtQmU6EPIP2ho4VBUrFERrKyuoeIUB9WlgAA9h8ORzO5aYpQ64Ex0jJAZ35z+jgnERfwHn30zxFBxI0T7lmjyZtMFII6hpkLojH6T9PdWsvxE0hzA4h34WdHKwIqjZuPkE8Ym3e8X9rV6CJRLAMcHi+9KRSfD1+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=etF5eNW8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c01854477so340658166b.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775234644; x=1775839444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqZBtqbXpsXcGM064lzho6jfnaB+LmMlvvuZ2cyPGYA=;
        b=etF5eNW8Jg6DicZwBnIiQit9sNj0mTP2qqkZ9o3YXuaiaV6380KVNJvQCmdEBHsXe8
         ytw3jLrliwUR3/Hlmm+kslPIgZvGe9U2CWHO9YWDYQLRIleJcBBZAj2r3ii00uh5aTB5
         HGNgjGMs9U+izmMAcQRInpSK1OeBIo/hkfj66rwF/qiIGPvqIoVbZ1k1yIdtFgSNw1YC
         V2KKiAFgJHo5x/W6Z+b+YEwkmSjF9CI4IQmzfryfVq4/cMBQHTO70PBFUqvB/BS0qvzl
         YATmZ9GG3I2xx7bgbJ6zaBautH0TLY/2/q4A7gsjvLKPtopV3D78lsUJ8uAFYhmlPK2A
         R7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775234644; x=1775839444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqZBtqbXpsXcGM064lzho6jfnaB+LmMlvvuZ2cyPGYA=;
        b=COQLfAoiQs09XhenYhqJFpSuGcETi2bUBDcdAhy0auKV7HqqWUGXOcq/qXAEE3UgC1
         AehvOMKyxjk7re8ueTnVPOT74bDKHms0f9K3I+6IX1Iy7kyjjkfEit4GI0MkUuWnrxzo
         RLSsm3yseZPyrKLswAp04svKvoFOrQWCpQeHPJcDuPzsQ7OzfghDblOYfYCuCjsaYGwG
         dtCTxsQkzqCZS5FNM01ByoLcfWpK3YB6a4v8OJGJO7SYYJR9v+msK1KCgM80a+FL5cLC
         g6FUzpZddU0s73ON92sHdiyonJYzcOO0wNadjS+Fc1xUCld0Fz2aAwDWXMJmRg4RPSXX
         lv6A==
X-Forwarded-Encrypted: i=1; AJvYcCWGq34AciSjfqDMcoPMGxIS8ZcqtVy+Xkq6CuneUF24w/oWG4yB31Agi6EnRQXItxyR4BclDC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8x+Jf+8FcBWenBraZ+OBL5lSPv5KBF5wGZ9Cv3sXUy3IZwBGv
	ErqoWwpOYQoSsgZ+u6tspJM93qnE5Ym7HVOE3emxsnf46nkstm9GwSmB9NLZ+jfYxes=
X-Gm-Gg: AeBDievKPSyVDxMGGM6hrGrRPPaW0LN0Zbmsv0p6E1nYAR9aeNN2ZFl4m1oWtZjiuKo
	8lRC3bwXC6OXHix6XazPnAvJNtSh1lOOJGuhwni5X9QAT0gxLWlKoA4dqNtwvzbmHUOCMEXLZsI
	laTOjxmeyM8XAbi5/Oa5j0Dz9YDyYXcgg85oV7R/yJQcIOYBt6M5CKEXQpxyDdo7SGj/XcaFdzv
	OvSlEE1akeLkOgUKECXshzkFIU6Oe01fhMZD3Je6gGYtBL1x0kSxlewc+tFuOZRmh/Rf2djHdWf
	FdvvuAYRHDeFYgZEhqrweetaGrd6SXABVuyk28vM053ZV00TupU32Kxm/xOefMMlG393ZA7hYX4
	/gqmAJWTNnu1ykcjDWSHkzKPO5PpOWC3DpsHnQyQ/3j7tw77/3mK9a3ScP+ZofFqJ+hDX5Tlq8X
	29SVuLYhYIJeiUWgjPqeXHRkxs8K7kJWLo43sRUBIlGATO/P3FC7y6yFOyHZae3LRMnBv65Tx2K
	GfEKe6kS1mrebbDr8hIoT3TjtvFNHDMurafRA==
X-Received: by 2002:a17:907:3e9f:b0:b97:ca81:e89a with SMTP id a640c23a62f3a-b9c66e8f0admr191031366b.0.1775234643574;
        Fri, 03 Apr 2026 09:44:03 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3ca9a145sm213492566b.25.2026.04.03.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:44:02 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 18:43:48 +0200
Subject: [PATCH 2/6] net: ipa: fix event ring index not programmed for IPA
 v5.0+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-ipa-v1-2-01e9e4e03d3e@fairphone.com>
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
In-Reply-To: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775234639; l=1402;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=niHCtM98CmwGu9tGXQ1iV8G8OUNt7CyQAHGOy0w2ztg=;
 b=96TjL2CndxnnjLRlVhkbxUrsefNcmkkxoxcUib1ZyUIjblzrlIaLz8j/6EGfZLBeALxZc02AG
 rCUST7ZUZePDpYuFSjdZWozuZDKvMxsQvBPjxu48IEQqCxKA26ZqcEw
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275146-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:email,fairphone.com:dkim,fairphone.com:email,fairphone.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D3623969D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Koskovich <akoskovich@pm.me>

For IPA v5.0+, the event ring index field moved from CH_C_CNTXT_0 to
CH_C_CNTXT_1. The v5.0 register definition intended to define this
field in the CH_C_CNTXT_1 fmask array but used the old identifier of
ERINDEX instead of CH_ERINDEX.

Without a valid event ring, GSI channels could never signal transfer
completions. This caused gsi_channel_trans_quiesce() to block
forever in wait_for_completion().

At least for IPA v5.2 this resolves an issue seen where runtime
suspend, system suspend, and remoteproc stop all hanged forever. It
also meant the IPA data path was completely non functional.

Fixes: faf0678ec8a0 ("net: ipa: add IPA v5.0 GSI register definitions")
Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/reg/gsi_reg-v5.0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index 3334d8e20ad2..6c4a7fbe4de9 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -30,7 +30,7 @@ REG_STRIDE_FIELDS(CH_C_CNTXT_0, ch_c_cntxt_0,
 
 static const u32 reg_ch_c_cntxt_1_fmask[] = {
 	[CH_R_LENGTH]					= GENMASK(23, 0),
-	[ERINDEX]					= GENMASK(31, 24),
+	[CH_ERINDEX]					= GENMASK(31, 24),
 };
 
 REG_STRIDE_FIELDS(CH_C_CNTXT_1, ch_c_cntxt_1,

-- 
2.53.0


