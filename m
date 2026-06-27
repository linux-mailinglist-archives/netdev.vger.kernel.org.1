Return-Path: <netdev+bounces-302352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wa/5HWo7QGp9dwkAu9opvQ
	(envelope-from <netdev+bounces-302352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:06:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB816D2AAC
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:06:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UsREzLoY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302352-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302352-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90B543004043
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8137F735;
	Sat, 27 Jun 2026 21:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC553803C5
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 21:06:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594403; cv=none; b=FhC3dGz9nef0DKwOvGkrBvsGGfVX0FnWL5i/RsVqQotUmaGKbZC/Fmj/2y5CqxZsbpWIrC7oQ53r0hOZIkdMODWBqX/+awKWQHbNcV3+r/XwuuaAXr7sCqjalISnlrgUBtGC0wQjdGU6YUjoKpWAJb8R3NLusUqwvksMsMezMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594403; c=relaxed/simple;
	bh=nILz1Z5b7EzsgPgmNo563wVi3lhcA2jWBLwDMyAkbT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3MJ1Qr9KKt0leYgVFFc1Jmyfch+bgxdyKEkMJwdgMkpGMYhlex3ktjWJSdoiVNY2hJw6HkI8lXOiinn54E24GrSedcjBEdCLOAT/tDVDWl1B+MKKFi/wYASTSdMUTS02noQ056vmhrO1YL1bRm3iNnPSYyrvQAu7qfnjqxL5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsREzLoY; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493a41ff870so2189745e9.1
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782594397; x=1783199197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nILz1Z5b7EzsgPgmNo563wVi3lhcA2jWBLwDMyAkbT0=;
        b=UsREzLoYW1MrrAS5e/RIKH4fcuWYHmBECXCdw2/jqXVe2crDT1lE5ywVbfWeZseeVY
         vo2O9GX6pQ2Bq9R2Es0i392/mGbfwsADM2Y6VjDet4Fro4s0zu3RkPE5/kALJ0Xnx7p8
         vEBQHyBvH57v6aOIvXcYR6GZKmLHE4T3ecTCEdZU2ocdvTWrZWhQsknE9Lgaaq91PLSx
         EVPo41FP7MYocEA4VoFmMBcPyNBEVVdXLkBLbs3cR7sarar7+ZOnKGFhhVXWvaU+UmL6
         vFfMoM50CtBNxZzE1q2tft9KhXt74b1+U6rACoKEh4iMrr6e7zl2sjsxEDQq2G+044Mj
         KXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782594397; x=1783199197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nILz1Z5b7EzsgPgmNo563wVi3lhcA2jWBLwDMyAkbT0=;
        b=lCqhlcKEtFa/JVYfFduT2uxyOQH7iIRRI589oUDoV8BNF1TtgaIqGiBlZo/GFKuHvi
         MUnWmchmV9eV1EwXtZp25GplisOZhtGDElj1AhqanmTKKUHKMXF0u8bq25U9i5udi6ZJ
         yZfGcVo8LVRwdEoUL5LlBSdzboUvzyhfmneoE/s90WvhaepA2bnphcCe+4yupnZN8Rtj
         kfWazAIZCX005DKftAa1lqPJn0Dyh+qtoSVgW25bZpfNK4wsfuDveW3CLzxRqUKJ7BTE
         I3PF8Yn2aSvDd1rjwD+9W63LgebXPu3sEOeBVgfKjz7Ezguow4eXtFhRAkj31Ck8LcEJ
         Sw2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8t6HmHiSGI7sa7kTfONPhLFnX5qo5oM/OQlxXLZ86jZy1P+dpnCnSCcHxdD3XaQ57W+zKwgvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZnMC3RFIB6+ZU5TqWn7i+uJRsdiJjVq6dv43RMd0RVfFZIvX
	GLDA+818saIH58g5DmLTvFc6qbdCLqjx39fhRA8VNSdMdJlH/lDuMJae
X-Gm-Gg: AfdE7cnojwijX3lgaq8b8fXSJcGGL0C1ivka4h+vKMTRI/NxkjGC1oIFsEnwX2ze5wh
	7bkpqB+6qoHdWkH+zaiC146egwdKKtTdRyR17lI8sffMAC0NLze2ZurWXmyptfX1wBqrSli71qF
	6yu3DJ5RBBJ/dafJ5grTckljELvQ1NPBklImCODnZ42NvgSLlLMX9aErTrF5pgAKJEJhxP7rBnw
	N8DZ0EwNPhvWGn1/puuDB033EyGhso6rXJmOLL9Ogn2ShZCgH4CTP+VfLtZtSl6thl76cTHHKAG
	6ctw5h5eUvCgVRe4E0jKmBDmG82XfZyzeMfEz27rBdX8r0Fx6bFShlM4WQSBFXnKHs5DYN3RU97
	opFqzp9emXon9y7+foUf54J0AavdMmMbRFRogChCh0+X9aUj7ImCudElMxFiOIjQfGb3/mFWEj5
	sFlmKCTOPAwTxsOzjjV0+dWcuxyYqlTA8JaQQgBKmBl+ZcWNGO2YIfw9G4gs3Lspqv3MGeiwXfG
	v65Bm45k5reEPgU0OnTACv6DL8juUkxDmnQrBx3/dLf3K4=
X-Received: by 2002:a05:600c:a086:b0:492:6954:1036 with SMTP id 5b1f17b1804b1-49269541111mr135494035e9.14.1782594397270;
        Sat, 27 Jun 2026 14:06:37 -0700 (PDT)
Received: from localhost.localdomain (p200300fbef048400fc99b634a1c2fd05.dip0.t-ipconnect.de. [2003:fb:ef04:8400:fc99:b634:a1c2:fd05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fcee16sm198439905e9.2.2026.06.27.14.06.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Jun 2026 14:06:36 -0700 (PDT)
From: Nils Juenemann <nils.juenemann@gmail.com>
To: rjethwani@purestorage.com
Cc: borisp@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	sd@queasysnail.net,
	tariqt@nvidia.com
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
Date: Sat, 27 Jun 2026 23:06:35 +0200
Message-ID: <20260627210635.89769-1-nils.juenemann@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260515212715.3151307-1-rjethwani@purestorage.com>
References: <20260515212715.3151307-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-302352-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rjethwani@purestorage.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BB816D2AAC

Hi Rishikesh, all,

thanks for picking up the sendfile/EOF fix in tls_device_splice_eof().

Separate issue we hit while testing, looks pre-existing in mlx5e
rather than v14: a NULL deref on the RX offload path. Trigger is
ethtool -L <dev> combined 32 (down from 64) under HW-kTLS load,
then a TLS_RX offload setup:

BUG: unable to handle page fault for address: 00000000000031c0
RIP: mlx5e_ktls_add_rx+0x268 [mlx5_core]
Call Trace:
mlx5e_ktls_add
tls_device_dev_add_rx
tls_set_device_offload_rx
tls_setsockopt

sk_rx_queue_get(sk) returns a stale rxq (62 here) after the
reduction; mlx5e_ktls_sk_get_rxq() only guards rxq == -1, so
mlx5e_ktls_add_rx() dereferences priv->channels.c[62], which
appears to be NULL. The resync paths index
priv->channels.c[priv_rx->rxq] the same way. This path is not
TLS 1.3 specific.

I do not have a proposed fix yet. Happy to share the full
decoded oops / additional kdump details or test patches.

Thanks again,
Nils Juenemann

