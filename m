Return-Path: <netdev+bounces-269718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFT1Dk2LvGlv0QIAu9opvQ
	(envelope-from <netdev+bounces-269718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:48:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 955092D443C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15BE302D134
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077E13793A9;
	Thu, 19 Mar 2026 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P9Clj6eh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6C344D86
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964102; cv=none; b=h02BV7XXVHnXpA5VfEV7CHL3yLHujlcVpxvKwQMSvQp6q96bhnJ//ALy6yudhamWE97q5VabzLRRtdy0m3lOGn6BKdpvS4AuhRia0JpTTgUff1n3SzFwXsxSxwnnfHr9O0kKnrY0pCspY4F0h5tY/N9cdOh3NsGwriuMJ24aBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964102; c=relaxed/simple;
	bh=Wy2OuGuM1n34KopETezS/iSBCGSlvBFMvtm1YzsAfiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EWFb1icwqKTUAKRrvcr12FgoB6OPoXoA2TWSYnTcZKREr1kp2q7Z/6JPr7PlmLWkj9og/wrkWD/hWBQnJp5huT+wwcY9A0s9hofU2spwwCcqk/ySzIn1+0ra/nskRBzG3/4bJHUEX3y/5+myPFwojIVTmD+DZX8L2b9Y6OHrqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P9Clj6eh; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-64ad9fabd08so1300809d50.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964100; x=1774568900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5cmiGK1Zkwu7IrGjnCXhUrogpw/1TK847Pzk+gJ73g=;
        b=SpkTpJksc5PAJ1CSeFgv6A87+UR8lNTk6HOZDG55bW6yvNR4V8bS2BqYtzNr9U+/Dk
         uXqmw5qjtBhxJYeFlVF90zJ4hXUPHWRzG6xK5DAivfuVUcweiINDlu56z9OBqbo0+mEH
         fOsre5r8cmpixi5TaNN+buCepVJvUDK0CaFnfHIghyh83FNc8t1vGWOErz2iEdkw8Ygl
         H3BlUMARoFOrj3Iz/1fR/NrIYPZebQGrUHqAUXJ6Z6TARebt7X61RJleaD95fuy4YfLg
         PNit8lWbloK47XdrPvPjwDRlaEc1Pa7J6qO/QLX7NRS1YLnffcDXJbz1MApz14ReSAEw
         BvBA==
X-Gm-Message-State: AOJu0YxyfK18S65+gXEw9J/yW3MLhc3jGTGXT6ASCfT3UMmTTIlWrziy
	x9PpJt1ABAoKhbKaiSzVLd8wSK4CH6D+eGjhaHzrPbUOgUqHgsDQ6432txUZvQIQ/UCnkwAB6zJ
	7SBCjI2CxyTSSa5fgKWX1ak9Enw4NhgbEaiRiS1JVq2EtPZ487EuBnAZ2K7eZ/mHDKOjatf2E1x
	EsM7jBqwN6VT6kxgAJEzzGA5qPzONMHkX6j2lVMQf75SMPxb4LK798qYkqjjN3+EN/JATHF8jIg
	9CxnhFq7A==
X-Gm-Gg: ATEYQzzrC6zdjYIwRge0sSyTq2V9VBU/uy2Axf3PA6cAjDxPHU9/mHXclu3b9MMbaO2
	fnj1qavSwLlp23jX2np/DQDVd001LLiL5FxAehei+nmXbBvbqstYEqJazLECOUwd3rB/54jAMeB
	ASGYRkAgzIflT+VCOaRmGfT+8hvo/1Cx3afGXMGLJnnJ8GSiAzEj9juTrG+IzD1dfZ3zfIX3Gck
	NsT4P2Jf/zRyV2Q/vnCY8NXugeZ0zfzxahB2/zuZlX2/Z3N+LsG3gQTxf9fvIX+GwNFEWARKLN/
	rmGRyJhftpMJsYnwv9kxSunHO47s+uWOjxh3UMzFK6Xw9eNCcAVGuW48C0KaLJKSrmcKBR9CfM/
	qr5wlp3Mkk0eKV7xLuaDhubP7XWwIfA53scYr6FqnbuIxV4bQxf7+dLE2Gx+7U5aKNSKVLgOsR/
	1OvzHx96yQ+Xb33yY4S4BGjrVvqAfLwWvpjXOV2jHv568mU3f6elsa0hSwXA==
X-Received: by 2002:a05:690e:4282:20b0:64e:5e22:baaa with SMTP id 956f58d0204a3-64eaa811056mr1163319d50.72.1773964100476;
        Thu, 19 Mar 2026 16:48:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64eabbf8ba1sm50074d50.0.2026.03.19.16.48.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 16:48:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso1058388eec.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773964099; x=1774568899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5cmiGK1Zkwu7IrGjnCXhUrogpw/1TK847Pzk+gJ73g=;
        b=P9Clj6ehWKFz/FzNfysKxccjb8ZBP85NICAviCpdwJ3gw01YuD1JBhB/+WAypuG8Cj
         ZCFaGV8q4h9WDuFGWXR2NGezTpxVQHlScorBjqtu0JQ/iNetpYp+bUweYc/hH+yuy+a1
         M09mLsvKKzUlo573LbcTR/+P2YZZFHdbKFOeU=
X-Received: by 2002:a05:7022:f9a:b0:122:2f4:b251 with SMTP id a92af1059eb24-12a726cad77mr461572c88.21.1773964098972;
        Thu, 19 Mar 2026 16:48:18 -0700 (PDT)
X-Received: by 2002:a05:7022:f9a:b0:122:2f4:b251 with SMTP id a92af1059eb24-12a726cad77mr461552c88.21.1773964098264;
        Thu, 19 Mar 2026 16:48:18 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm1141697eec.24.2026.03.19.16.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 16:48:17 -0700 (PDT)
From: justin.chen@broadcom.com
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v3 0/2] net: bcmasp: Fix issues during driver unbind
Date: Thu, 19 Mar 2026 16:48:11 -0700
Message-Id: <20260319234813.1937315-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-269718-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 955092D443C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Chen <justin.chen@broadcom.com>

Fix two issues when we unbind the driver. We hit a double free of the
WoL irq and a double disable of the clk.

Justin Chen (2):
  net: bcmasp: fix double free of WoL irq
  net: bcmasp: fix double disable of clk

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 41 ++++++++++++---------
 1 file changed, 23 insertions(+), 18 deletions(-)

-- 
2.34.1


