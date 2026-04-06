Return-Path: <netdev+bounces-275757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HWMMmMy1GmtsAcAu9opvQ
	(envelope-from <netdev+bounces-275757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D73A7D20
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05D13300E6B9
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74039D6FF;
	Mon,  6 Apr 2026 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ITiCqI+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AE23507C
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514205; cv=none; b=ojH/WuhKPyqgnJNT0UC4O3w57XzyARaK3V/oJUOuAGqTtaBrJNvBSDhhdUmCXZDEhgSKCg6KI4nEZRm8Sa8rWGfhSL4nAgVzZN7JhNG2JiQV85a2ZhSi7t4oi7rbIOwnm+yHuUeWXZxwcZuVEO5wo/unuvC5kOr9FkMvZLcSWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514205; c=relaxed/simple;
	bh=Dzh9prwsHZAewH/2ANXDZrBh4DfXzql92u7t5ojWTok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyEjh3qxoV+peYCsddUToAxwNYRhN0IxAauUKGfaRxVRmSbHs3zhd25f632t7+rhh7GyCy++uEQGtmav+XNdn/QWesZ1Ed33j1/ec7/9kxWCPmL1IH3aRbz0aljcOInYJiQd/nMiPeNavRY+GjCVX7cwHRX8NLmzbuX67lLouG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ITiCqI+V; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-82c70e4654eso2000513b3a.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514204; x=1776119004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AajIKddZ//bfxAi7wG0XsT4huE22PdM7J4gB/mDsIz0=;
        b=o9+EHxJwVFEjc4PIhxtAceLlJnrGH3WRr3LQcQ07fIA6KoqC+xI7N/fSot7mZ/CEXT
         9pORXEN5cLs1MuJqxyuhKixFeCMTRV7FHxyUtXP98vAUQAGEFzLp+9nU2Mob4UQB2guF
         J6mTBmcZ94rXl5ffJTZW0rMCZvuUxWynkKuKvpmw6aqUXIYshFLQpTe4oUf+vGkc9ft/
         4NwB2ppHz6J/lakMg4ufRqDLJON4+7CmEpmdifbn+dnOP6TOC5fSX7ZM+/QjcyXnBWPq
         5Rf02cSuVOEJwGkyIjdvr6hT3klDqEX6dVcyyLXNGHRZ2Jtvgppjdbnub5bOeStiePDo
         ZecA==
X-Gm-Message-State: AOJu0YyXGYPQ3EkufMYo1/Z9GN+Jl8ndsuff4dgUWW3JnrOQSItuSt33
	H7fm3VHRdFc2tYwq1L1R8FKWn6KEr0nAn2C8tdhIq5qsF0OjhuG9LrSuCf4J4JH7Emt+/Rry+uO
	2rzx6bCYOH5+lCeU9TZUNLJGegnjfT1bcO8WCdCwN6jJoQHVY2SrCj5pxWgz9rRFZaL1JKZkJii
	80mBDLl9JMxCtwmma9zYXzqslLfmmRRFkQRBc5Hc2mxy62iw6C84IA8UDdXbD3PhR+cTxmcQ+1v
	sxH0U7J79FyuWGxu3pw
X-Gm-Gg: AeBDieum7DaMEy2H0h2iKGBmDGek71RlSmoMzsCwEd8zmdKwN6gjOZ+dj0tlxb8/Cuj
	FcJ9lWouhBDKd0DfT17EhBM1O/jf7F29gORbSbIlrjnu6I2Hh8RVJ2ff8gH5LOkxnprw6IU0XKs
	1LWmV4t8wkTLLermOR136jnurhkGDjlY/sgfUiSprTM0AFsiexG03qPIcpjmKo9VIQJxQuOoGhw
	nmCbStujU6orY5dvtKi+2wGQk24pNZ3k8c4yJr2luKp+vn8k1TfLLfrTeA19DMFz5JW/CBjkqpg
	9XSobDRPKxUzFmVlMuEIf6Q2eFoL/bYA2XFo/uS2WXIzuiLrIeFz59nIiW5z9HuK0yZtQVyiS++
	G6wPft2sL5WooEmG8VgsKUbG87M8Jt/3OSkiRCv7HGYfAUUwU98Mcu59mR71ueE+uGaKNOeSuVm
	2CGzVaZBy4Shfs8KUiqEtY1oXRL1OKi03nDS7il2VatkbFNtTgo8mrV2i48tlNHSw=
X-Received: by 2002:a05:6a00:1894:b0:82a:6f69:7f7b with SMTP id d2e1a72fcca58-82d0db87a78mr13355174b3a.37.1775514203810;
        Mon, 06 Apr 2026 15:23:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82cf9a09160sm1459741b3a.0.2026.04.06.15.23.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 15:23:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so27762056eec.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775514202; x=1776119002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AajIKddZ//bfxAi7wG0XsT4huE22PdM7J4gB/mDsIz0=;
        b=ITiCqI+VwJ6rWkwzRoRnE/yOs7LXa4YDNvCQCe31Azp8mDQP1NexW+4lkZzWBTu7Oz
         tAkD0bb3C070jMxV6s8oPF0aKY132owhZenpCshvfPFYpDUa5s2IlhYv2gM2/X0StpwV
         0bQOyPRIw2RTuUGNBgDy1zgWkc4NqQ/7FXThg=
X-Received: by 2002:a05:7300:6ca1:b0:2be:2953:fd74 with SMTP id 5a478bee46e88-2cbfa4c471amr7518054eec.14.1775514201918;
        Mon, 06 Apr 2026 15:23:21 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca1:b0:2be:2953:fd74 with SMTP id 5a478bee46e88-2cbfa4c471amr7518031eec.14.1775514201328;
        Mon, 06 Apr 2026 15:23:21 -0700 (PDT)
Received: from lvnvdb0691.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb92ea0ef1sm11771909eec.21.2026.04.06.15.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:23:20 -0700 (PDT)
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	kiran.kella@broadcom.com,
	akhilesh.samineni@broadcom.com,
	sachin.suman@broadcom.com
Subject: [PATCH net-next 0/3] psp: add crypt-offset and spi-threshold attributes
Date: Mon,  6 Apr 2026 15:23:02 -0700
Message-ID: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
X-Mailer: git-send-email 2.45.4
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-275757-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C70D73A7D20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces two new configurable per-device attributes to
the PSP (PSP Security Protocol) subsystem: crypt-offset and spi-threshold.

crypt-offset (Crypt Offset)
----------------------------------
The crypt-offset attribute specifies the byte offset within a packet from
which encryption begins. A non-zero value allows a fixed-size portion of
the packet header to remain in plaintext, which is useful where
intermediate network nodes need to inspect a well-known header before the
encrypted region. The default value is 0, meaning encryption starts
immediately after the PSP header.

spi-threshold (SPI Threshold)
-------------------------------
SPI values are allocated monotonically from a 32-bit per-device space.
The spi-threshold attribute lets userspace configure the SPI value at
which rotation should be triggered before the space is exhausted.

A named constant PSP_SPI_THRESHOLD_DEFAULT (~90% of 0x7FFFFFFF) is
introduced in include/net/psp/types.h as the single authoritative
definition, used by both the PSP core (psp_main.c) and the netdevsim
driver (psp.c). This avoids scattering the magic value across drivers.

A follow-up series will add netlink notification support to alert
subscribed listeners when the configured spi-threshold is reached,
enabling timely SPI rotation.

Akhilesh Samineni (3):
  psp: add crypt-offset and spi-threshold get/set attributes
  netdevsim: psp: handle the new crypt-offset and spi-threshold get/set operations
  selftests: net: psp: add crypt-offset and spi-threshold test cases

 Documentation/netlink/specs/psp.yaml       | 13 +++++++++
 drivers/net/netdevsim/netdevsim.h          |  2 ++
 drivers/net/netdevsim/psp.c                |  6 ++++
 include/net/psp/types.h                    |  7 +++++
 include/uapi/linux/psp.h                   |  2 ++
 net/psp/psp-nl-gen.c                       |  6 ++--
 net/psp/psp_main.c                         |  3 ++
 net/psp/psp_nl.c                           | 27 +++++++++++++++---
 tools/testing/selftests/drivers/net/psp.py | 32 +++++++++++++++++++++++
 9 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.45.4

