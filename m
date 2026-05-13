Return-Path: <netdev+bounces-287592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG3KKNB3BGqpKAIAu9opvQ
	(envelope-from <netdev+bounces-287592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:08:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67785339F5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 358A03086D2F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4342314F;
	Wed, 13 May 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv98Wn85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8E40B6F2
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677182; cv=none; b=qXxBw+PkCt34jBEviTTRP/59wa0Rz+UUuD1qMY0nnyWEGqIzfFtdZ5eocHMav72VQ/iWixl9VedRz1SMKq2gGV1cRzWT+IFybmEO5IIDNnVNfoUe4pT0U8/fH9PR2v6+kNwjm8T673S9Sf+RbO+5HVlF5z/6aJjXG31nTuubJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677182; c=relaxed/simple;
	bh=WJHk8maGSEB65sDoFPyWaoUlOubnzhtY1l+tFa9b1+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uo9drpCPsK2UYMDIUQyD4x9A7p+RjJ94dDahzSt92nMIPUU8FFhxH+vxxP02B65LgRzJj4WaX8F6iifhkXTrEUg//AQAyCYOt65SZRqN1TwzGR+j9kwlzUhcVnJ5dCIGu4EeicAZr9+PtjYVycLg5klLcyT/9I4oa1qRhOpcYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv98Wn85; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479ef2b78f3so5717142b6e.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778677180; x=1779281980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEd8B+4ETorMRvaZk4A2OA33txPGEogtxfH5SN4ZIzU=;
        b=Cv98Wn859DOpJvWMzZIyqEXrPZHikDrZUTsv0nGNnBpKDm3Y6/W3m6kHzmlvazCEOR
         XIc1e10sdw81ncgGOgMYLJOtzKZMCi0NgwzCQ/5G3xdgPBf84IO0dAxcW44SgaVJyh07
         XKYglN8ApKV1v82f3LkpcOEyMFpBEkGsN4OcubsCs6aOVkCSFjBUndGjl1mePv7P8w6V
         391MBqGzsI7TaDSaw2+jix8THCxoz87Q1F+WaCfaysWy6ix5rYZ8nV804I9yjaBo2/ZN
         UdGzOOjOHDoqjIhcB1H9VIF0VrkfzSFsUWRi1d9ileEKhnThT4mdhQLVOdKbwX7M6QNl
         LoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677180; x=1779281980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YEd8B+4ETorMRvaZk4A2OA33txPGEogtxfH5SN4ZIzU=;
        b=oDCL4MBHYXBGMZSNfPEFFoSc87qc/ofedonS11T7eZlIIHmav4xUAuLYQXLGRLcReQ
         bPak32Rk532niyWOiYQIJtU4bEUrtGF6ifQ6OriVJaOW0vb4R8e11ONcN2z26OH7b131
         sOK+zIYkGL1jYhfeNHwStc0k4n28gvtmwjegULJVgnLHfk4++XQ6Il78pgGBRQpuvMgG
         DMrc19Nv5wBHDJ3QAl409JV1oSiJeqPKmG7+gOUNeBF5a6d8q5oUa5OtXCXdgMu9+SpK
         ctbrnVIXmn2Gc69qTyLJMpqhdHJ0C+kyYmk/stpf4xiycvdS4Z4qMFTZSv6o8BMpETEY
         RiEA==
X-Gm-Message-State: AOJu0YxaWYuovRIY/xG8Ab2kwrYLX0O1dUAFJVcv9Aw23+wlnMuUTtfi
	khE6oB/D67M0l4U8kgNjSP5ncImRmCz/Hepxg7V+ImRo4lJQohvVeFtS
X-Gm-Gg: Acq92OFHv4GoJJWbOyUCy5gBzZpCGxogQodAeto57vH1DK2yyOqsnIOwIECmdVAAJHQ
	+tA0dieO9OXHzmny5rEKwMS/Fwg6N96NtTmcAd34AjZ1KvKfUJmHwZGNl+uKU6F9ScXX5DNUwc+
	nX30mkKhbA8O+I/hMKCt1G/5v2kQ9F+K0NEEDg3fKDuPYLIBNc9pdligmaAl/kZVS/+FezLUs3J
	nehRc+UfIuSzQ/Sd7hR9fl8sLVDi4Euj0pkBzv8ZKelkVzB2ddi7+3MS55PeUx9l8QQU8mCQ9xN
	PmeZ1/BzubVjFoqAYRyrL7NPXMjEvOoyvDx3w/Z1DwWo1p3JY6+6EEHihBNxPYg6Ppy0VeEJuXH
	CPUPpX/xSTCKb5ILsbCK84W7o+zqLUepoKLy4msq21Yy6x1AtXuV4Twecf4dN/bdTvFM7/L0nOS
	lEP7Bx56pcypJvRNVxybikrxjvHMWISw==
X-Received: by 2002:a05:6808:660d:b0:479:c81f:8e18 with SMTP id 5614622812f47-482b28c35cemr2091090b6e.3.1778677180593;
        Wed, 13 May 2026 05:59:40 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435574490b0sm15661031fac.17.2026.05.13.05.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:59:40 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 13 May 2026 05:59:36 -0700
Subject: [PATCH net 1/3] netdevsim: psp: initialize stats syncp before use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fix-psp-stats-v1-1-cdb3174f252f@gmail.com>
References: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
In-Reply-To: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: A67785339F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The reader and writer stats paths access this object, which was not
being initialized. Initialize in nsim_psp_init() before registering
the psp device.

Fixes: 178f0763c5f3 ("netdevsim: implement psp device stats")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 6936ecb8173e..92a2ed770a36 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -268,6 +268,8 @@ int nsim_psp_init(struct netdevsim *ns)
 	struct dentry *ddir = ns->nsim_dev_port->ddir;
 	struct psp_dev *psd;
 
+	u64_stats_init(&ns->psp.syncp);
+
 	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);
 	if (IS_ERR(psd))
 		return PTR_ERR(psd);

-- 
2.52.0


