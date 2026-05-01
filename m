Return-Path: <netdev+bounces-283269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMMfOWz39GklGQIAu9opvQ
	(envelope-from <netdev+bounces-283269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 20:56:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E41984AEF79
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 20:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80D87300461E
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07E40F8E6;
	Fri,  1 May 2026 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OAUG4K2O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C635AC1B
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661797; cv=none; b=cgubGnhU5XGEuhypIph6a2Hw1uAhnI1a0Q5EPXAln/ywctqgCQLHvpLgQDXtSmiHxmlFWqz+GrgNKfGU84j3Y7lTRhpxZT7Fv3UsA/a4GQjOagSdqa/+dw8IOpaT2SNcxt+mizPDtA3I0G9usXqtkXTpzi3FuDsVEgIikXvbDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661797; c=relaxed/simple;
	bh=MipgI97z9nFj3W00/un+GHbbBHioHmr12rSs9f2advw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aXNW7zvLCqT1+tbz2Ej8KqDOfZGKObX1K2FiEeKtzB7PArX/B7fWWRQbcfGc2wzYijMP/QcmXDQwbsQfo3PoUoWwIRd5cf/NkXBSytiGiEBdwCqgVi6MIncYieewndTpijvZJNyNCVj34LFmboarHv33JYE+VUI9sDxF990rm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OAUG4K2O; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7b4ee3a88e1so33180477b3.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 11:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777661795; x=1778266595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eLs2LLlwAnhJrJzaDWOeThUHDTkRVv4SoE6GOMnLKk=;
        b=DMJ19ot2CTNWmIoxJYdZGYwAmtimkiR8GaC0vbGGrEvcSnR6/wqgCuFeE31+NhWk5s
         bn/McF6b2iepWiFBjcJdMGEh6qbHavMKCNy7mU+12YHLakClhtnHcPJBrdOJRY+sJoRq
         qSCp9N/6paB9QFdRLygyQSiDczdBYYEm7Zuaji79PdMP97U3jzQNqUS5BPkIVkLMsafG
         R0T3EGaNY/oS03sPcHHdRmBsVm2S+P5MnQZEWDlC7rBlMtFgBvJKkMeqyg3EJypce+6p
         WnZrvNGebKPd+l6Nf4G4ihOg3kSX8yMzlRqXkY8qjyei9hNOEAJX2g/m3/5htwOKlqNp
         YLdA==
X-Gm-Message-State: AOJu0YxoTdDpGs7b6QgsFcaZsteQtTchszu1YK7fF17AXahHRt9E3gQZ
	n07KKsLbS8UCQGQAXnN+UZkpRrg0N1kFutLIc4f9o7oRU0vgkzboGjpFgAgpOicQreC1LL8TvfV
	RtR9hRuQ6cvT1glM0yq/PovU03pw7jDfpzY6Fk21aJ0ZVVNG6cJRn997mugdoM5wShx55IDoxlQ
	l3+hWEnyJniSfd0B5wr/d71/gGNVvGNH4x1t1TTmdiR1m5ZF+MODfXoikZa9ot7fXKApYreUhY2
	AYggRCFVQ==
X-Gm-Gg: AeBDievZqZI5oyorKIzf7m/gpzGGog5c5T5R9mBDCE89AvCtSTAcKAEkBNz0F7YCx2M
	Eje1nFqnESjaBeP3QBNgalwuUZPs9AFquMTjvtsYbmiZ9VfXRx4pM6vPGW8NGR1bLHlXM9NHNFU
	NMafmg4/xjr2B+eKB1lExmJ0fSqQfLRHRWcnAgS3Mebtj+gdoS27dHfkXLypoBDk1lP73IRtB4I
	aKszqHabEKY5k4ycIHwMu32oOpgIu+TQm6OEKOayYklJg+fGit3w6/H+bPAS9U3oMrm/wuhG2aR
	wdirxMtB+gAZHT4E4h06tJ+ZjccmTGztXKbbJT2DK+ajLUM9z2vMWbWHQHsD0XGfUqJpJNr9XcH
	Nyz1AD3l1MQo9OJHTopZKZiQp1MTlXF5ZgHDvFtq4PFAp7aUvW97stpLmYt3GB94i0WZJbBAJtc
	gpKuFPkxtVgpY0o2+8rqz62gD1JudXEe1/tvVYRdhCpS0unT0OcipokRI7cXMLQGy8TQ==
X-Received: by 2002:a05:690c:e3eb:b0:7ba:ef98:9719 with SMTP id 00721157ae682-7bd76f75913mr7199287b3.10.1777661795339;
        Fri, 01 May 2026 11:56:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7bd66892173sm1964467b3.28.2026.05.01.11.56.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2026 11:56:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d5d03ae893so408048985a.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777661794; x=1778266594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eLs2LLlwAnhJrJzaDWOeThUHDTkRVv4SoE6GOMnLKk=;
        b=OAUG4K2OZT19py3SWrdKa02F3Wlgs/LXUpCdoaXOzPf+5nHB8kWLsiC3rUdTQR0fa2
         Yor0/TsP5HWpNhVrjQR5fKX/Vse9H5A26G/zS2QQLaK5mDcUlBsYPPGgS2GLi87eLKwY
         BF6rAv60HkDr3WYg9GCQ4Vzd2h2TKBHy0rrec=
X-Received: by 2002:a05:620a:2849:b0:8ee:eb50:4f64 with SMTP id af79cd13be357-8fd18c2e8f4mr94966385a.57.1777661793913;
        Fri, 01 May 2026 11:56:33 -0700 (PDT)
X-Received: by 2002:a05:620a:2849:b0:8ee:eb50:4f64 with SMTP id af79cd13be357-8fd18c2e8f4mr94961085a.57.1777661793341;
        Fri, 01 May 2026 11:56:33 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938d20fsm238003185a.1.2026.05.01.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:56:32 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 0/2] Keep PHY link during WoL sleep cycle
Date: Fri,  1 May 2026 11:56:23 -0700
Message-Id: <20260501185625.422361-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: E41984AEF79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283269-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid]

First we divide the init/deinit path to allow for a partial init/deinit
during a sleep cycle. We also remove some unnecessary small functions at
the same time.

Then we modify the suspend and resume path to allow for a partial bring
down and bring up. This allow us to keep the PHY link up and to resume
network traffic much quicker. Note we only do this when WoL is enabled
since the PHY is already powered. In the non-WoL case we want to follow
the same flow.

Justin Chen (2):
  net: bcmasp: Divide init to allow partial bring up
  net: bcmasp: Keep PHY link during WoL sleep cycle

 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 251 +++++++++---------
 1 file changed, 130 insertions(+), 121 deletions(-)

-- 
2.34.1


