Return-Path: <netdev+bounces-280110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJQXGrRv52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF043AB83
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8104300421D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349313BD226;
	Tue, 21 Apr 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNXUwhuq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpvEt3HU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52921CFE0
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774922; cv=none; b=Lj/vGovQRYjyjlFofjf1osFnHZJWPXPHoMYZ6XsU5FEbQdpwubrTYbKJxBq7PfrXA6CuTnA2ZYcKDCzjogWoF7KEQ3f2A4xUZF5bsnuSC4hdWa4Avlu5dNdwc+4PiupkReL2Qe97tX1RdXPP+Yq+DiWuBczDeIF0HMz66gyD38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774922; c=relaxed/simple;
	bh=0EJ9YxVWaBS+cST2ToSkSQort5W3sfP3x2T/cCxVL3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u0FvOYhaqVklLq43nAQiE7VHrJMBqb6hwHuYEXsYNLci2oOjCaNDR4U+90hm5WFQKhXMDoB29yF1/c31G7WRz5jAtroIwSd+DP2bqbr3APDGMXL/CGzoOjDLb5G2k5dI8reKMaMwrSlCZFCKaZ//7V/nEHHAin1co74dbYRddLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNXUwhuq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpvEt3HU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776774919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6DyWgzF/0ZbRlr/ORBlatkQA01RdIil+zn8x1e8Sj98=;
	b=iNXUwhuqGSBOHDTIH/hVTADmUOtVYFVvfqvyOQUqcW3nhq+UFEJpFqiJPKl2c0LsMlSD2U
	nT85mSieofJJAGI9SEeyRtIGtGA5Wgfx/TbhrWxlFFkjMvf4f3ZiOIcmAawijzjMPxgP9W
	Gg1IjoOExrYI7jeBuPuqv7JQOyA4tp0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-R6M5H97YOX6WILM2n22x0g-1; Tue, 21 Apr 2026 08:35:18 -0400
X-MC-Unique: R6M5H97YOX6WILM2n22x0g-1
X-Mimecast-MFC-AGG-ID: R6M5H97YOX6WILM2n22x0g_1776774917
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c768a9a9so33248045e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776774917; x=1777379717; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DyWgzF/0ZbRlr/ORBlatkQA01RdIil+zn8x1e8Sj98=;
        b=OpvEt3HUHlMwVAi0McrbpiK8NR4EzP4mdVl4cBg0M8UmmRgIFfgRVHfK9FJjjKsJNR
         5b8/BE59+THC1Q8pbl1IdZ993/Ld4jPbouvMqxhluJDHTnYSqsQb5dNVQYvwQWc2BPDm
         9o0Q4tuvkSdWZy3AYXaSMli37DHAIUnewnBJhn+wVRS1FY7RoT18dANTAGmfrNWifscB
         3xew9G8KcO3oYsQYxlGQ/IN+l1+BAQ7sb/SoPslYieFhxiulnSnE2hJ7PlLmGnerlEEH
         5wuBoP18gR8gcpCyRt3xJAq+pvabOlgyZgQfnoe9SeVIt210fM7Cu+b5dQADDRGBv0oh
         ew+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776774917; x=1777379717;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DyWgzF/0ZbRlr/ORBlatkQA01RdIil+zn8x1e8Sj98=;
        b=nYNFZLNp91TLUBxtJzo9DcZhfmvScYAquhC6atUxzsjKCkEgEwDWodtaC7JgtL7dYM
         ne0I1Egl2pqvakROBR/D+2TPy9YCqMmh7iyvtl43s+IgGWlBnHDsm0PKkCkeKbAJOAZI
         Jk6VqVRYh/0iZ0aEhNsLTf61SzUjB6p2brgezbla/7ekBJEpAEoRDkABo6yHT/8BAJcT
         M5cImwXhzQZ698wGGEM1nfMr/vFZ5bLYJQxwFcb9ua6nLohS8Nfzgx2zI0iK8G3ZONie
         Otn2NpZFl/RLfDzR3RJ9hSQUzNCAx9DSgiEkTnO8haqKrr81f9LheTZ98FxZ3JrnEbRZ
         UV4w==
X-Forwarded-Encrypted: i=1; AFNElJ9ZYEisKocKFXcnsYfLVqt9h5lk+6SEqiYRUCcoYh4QceCFUUWoLkNgEDyixgBjTDP5MGr9vu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cwTi8OrJL190yDqg9FdSP7ASiCSXa63Pz97Ah9Wpxp2nZcxg
	PwEZBfMylt4nu+sCsD8ElRQ/M0D5Z3VYQCPuN3PMgbw0k1+xh9HqF/BKs2/5zr8FBZ+Txgl5mMc
	j1Ic73k1JCj7V79Ow19fzLED7DU8A3Bza+lzrrrtU6uhjP4EoAXQcOIWJmw==
X-Gm-Gg: AeBDieti9/odc/zD2gGS4D6CtRyAv/Lb5vR4D7Khw6cdY31yxA/UMY9meeLfm8ML/ta
	dm2ISlOL2fkIsu92GVkrHPLI/8wVOwK8eqCEF27p4yWlblxGyOJYFHB661i2as6sZRYx0MyuREP
	4gBaxMSJ5MyVxBiMyLNb375dZk6O1356NbnUPCDrgzf9nz1USYzI6+tjCfvCTt4sgszK6KJXBtW
	cmHIzB45wf7xBxdJNuNT5y+QuU/8nQmGg5PlTSpaxyIKvnmBPH/toizl3ATHwqHCQGQdCjXqsO+
	FvVUSw8ff3Tjwta1CT4Zxi45QBh6fXNmcFLfVU5CQ9X8uL4voeNi7wZcsjz3P8QfGVeuM/7kY9H
	h7FUhl5GYv2G2XgYnpCMwuO548PbhUI1rTYSgrv0uFp8jQeJs4Hleziit5nFTzzwXJsVpiD4=
X-Received: by 2002:a05:600c:5254:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-488fb6e62a8mr275756645e9.0.1776774917126;
        Tue, 21 Apr 2026 05:35:17 -0700 (PDT)
X-Received: by 2002:a05:600c:5254:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-488fb6e62a8mr275755995e9.0.1776774916541;
        Tue, 21 Apr 2026 05:35:16 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489207ebd3asm60397175e9.6.2026.04.21.05.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:35:16 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 21 Apr 2026 14:35:12 +0200
Subject: [PATCH iproute2] ss: fix vsock port filter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TrBFovpKRIittQQaWhKIf086D
 jNMhkiBKcLUZAiUOLJ3Fbq2AXNot5PgrTKgxF4q7ITld03Rm1MoaZCsGnHQGmp/Baryf83AV/D
 PTQhLKR9ZqNuJZQAAAA==
X-Change-ID: 20260421-fix_vsock-40c2ef4928aa
To: sgarzare@redhat.com, stefanha@redhat.com, netdev@vger.kernel.org
Cc: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280110-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DECF043AB83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

parse_hostcond() uses get_u32() to parse the vsock port into the
aafilter.port field, which is a long. On 64-bit systems, get_u32()
only writes the lower 32 bits, leaving the upper 32 bits set from
the -1 initialization. This causes the port comparison
"a->port != s->rport" in run_ssfilter() to always fail, since the
corrupted long value never matches the int rport.

Fix by using get_long() instead, consistent with how AF_PACKET and
AF_NETLINK handle the same field.

Fixes: c759116a0b2b ("ss: add AF_VSOCK support")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 misc/ss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index 14e9f27a..6e3321ac 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -2323,7 +2323,7 @@ void *parse_hostcond(char *addr, bool is_port)
 		port = find_port(addr, is_port);
 
 		if (port && strcmp(port, "*") &&
-		    get_u32((__u32 *)&a.port, port, 0))
+		    get_long(&a.port, port, 0))
 			return NULL;
 
 		if (!is_port && addr[0] && strcmp(addr, "*")) {

---
base-commit: e0517e612199cacaf2dc4d54cbed52deec640c94
change-id: 20260421-fix_vsock-40c2ef4928aa

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


