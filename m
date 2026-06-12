Return-Path: <netdev+bounces-298563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R0mqDvHTK2p6FwQAu9opvQ
	(envelope-from <netdev+bounces-298563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:40:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A654678629
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:40:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298563-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298563-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2214D30046A7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667E3812C2;
	Fri, 12 Jun 2026 09:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAB36C598
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:38:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257083; cv=none; b=TLJH1OLqXZ03LeUTrmXn9+p939h41kBVC56TrFQYOzCg0sosUY4SjZoiFybFC9FA7wJZzzt8AURyMQhMFQwQAEdGc31Zd7PaeV4NDLNY31k3yR8lc0QnHQHiGNIJEzfMLMIfz+0CChvoRg8ipQfPB9gBqnuXuzla5PBhvAQmNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257083; c=relaxed/simple;
	bh=vhhjB4kXaYiuMv+eYNT4O6/zvd9PAY9mnZvz1EcCjwA=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type; b=NtenEV3NnC7rgU2JASxVE9M5nrALBtRsnQ6qqqIaz5DyOgZHhGiw9C+MzsLc/54x+JUcBoQM3jiLdptDFnDGfmnOYQQVnlmUTKHgBQYPgBNDjq7Z+cwVd+6ss3mB2UmTgKUILStGrM6DP7YuHi5M9L/XqNsazLsVkyqHKCE8SH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8419ab3a297so377367b3a.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781257080; x=1781861880;
        h=subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vhhjB4kXaYiuMv+eYNT4O6/zvd9PAY9mnZvz1EcCjwA=;
        b=e7lhO1Rw1vtGU8p103oi85qYmVYHD8M8cc74OiYBFouZxv5d5Wnbsnbwr/qkt2V3Ai
         u1VuFf3jGGsTtkudxkg/AWRsNxCJXhA39WKMplNtePzAO1vkBlvVUBvEr0L0T0R1ckQf
         R1JF1k5GYoP+HvPT5psPTaaG0B7Ltf1EST7jfLV1+V9cJPeWlCm9IfkwgVRqi26ETkOo
         nZr8I2LhIf/N9sZtZvkRT3+HqirFY5UY4BfvVLqPJsTlJSrTYdfrGCqT7XOGSmd29d0B
         afO9QJ0rShv2VpKGrJ7G7SfyiTItEMzeKfx8Ag6ZHute208bn5CZmD1KqZjzF2XBp1o3
         TIPQ==
X-Gm-Message-State: AOJu0YxYP/NXWBTV1owh7Z77MJjLM95v7FdvWFypPwdtAREXbnAwA23+
	6CQAqCfMCOx7HH0SqycBrnZzvpt5k/Kq1zjEcb4zFrOqReRGP06bVWISmzypDme3
X-Gm-Gg: Acq92OFrAshvEJb5DkFsiP4thwNG8A7SjpXk3JiULyDjDIeXcHLPKW705rqNK3WY1qU
	KGnpLvgcZYlHxMd4mdp0uxkjvISK3SSBVwv3x0o9aBjuCcj6e4afqnaeje5sX4Sac4Nf8+KHq5o
	TJSiRZfzk21cD4reeqrEEljJKv37dTQ49o6hGbNB3X4YUQ9KmIEZW7vyV2oQzKipQm/ppv0vkbk
	ng4YwCPdgI0wVKfkdxSvagg/wNrMm/8F/hbqg54omolbaD134kqL8aqQ6/ivNtW9DV+QEOSWQ61
	hy7lCg0bjTc2rUNtnCxYB4UyrBYj86MMfTQtpvKDaUb5oLUmRbyPNmHQbgFLpEmMpDgqwhQtzPj
	SnqVoQdYRp0mQ2n2iSE2xRUzPec40oSIfPicXpXgXR4st8kDnRqu1YdDwc1Di39pFy5DJrZ7rBO
	BBugQvSHiakx+8SZ04
X-Received: by 2002:a05:6a00:450f:b0:835:3949:3c1f with SMTP id d2e1a72fcca58-8434cf0e0d0mr2169034b3a.24.1781257079689;
        Fri, 12 Jun 2026 02:37:59 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b04b6bbsm1724054b3a.56.2026.06.12.02.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:37:59 -0700 (PDT)
Message-ID: <6a2bd377.4034e349.1b41bb.1c18@mx.google.com>
Date: Fri, 12 Jun 2026 02:37:59 -0700 (PDT)
From: Wayen.Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix variable shadowing in airoha_ppe_flush_sram_entries()
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.64 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298563-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mx.google.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A654678629

Hi Lorenzo,

Thank you for the review!

You are right, dropping the outer err variable and returning directly
is cleaner. Updated accordingly in v2.

Regards,
Wayen.Yan


