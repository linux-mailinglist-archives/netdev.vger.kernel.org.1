Return-Path: <netdev+bounces-198965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE8BADE70B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359AB189EB1E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6761E8335;
	Wed, 18 Jun 2025 09:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1E19ABC2;
	Wed, 18 Jun 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239172; cv=none; b=A3aPpFQhU4l+i7DWaTL6anBD6dwwl51zWKECV6YSLv0lddqym+XB3AyEwFHUtmaLEMnmjYaWCrDXGSThAE3sgT3N4N/hc1OnbdHpW56unSczX3ZSgrDdFlddNI3hon49sOacqnwDIGtliQWPzF/4gj6FquaSvd2Opz+ijzdGbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239172; c=relaxed/simple;
	bh=MvIKrVOBHZz1bYcvGMWkNIKBcys/7R02OPQEh8l61Ps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t5Yi9xo9TIrKltpzkk7bQ2T1aw5AyCxfnjD6ReHjHLaXievuZT4/3Guf0XtANKRmSRmXVjWYHEaL/qQcnqoV6JPoJ648vzhsXwfgWMFOR3rQdMRitH/X14+Ko6hVUjwMYsPBIMHDOT2epidGD/KUfflZylb/9r0Dpu/SOzP6r88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad8826c05f2so1325141366b.3;
        Wed, 18 Jun 2025 02:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239169; x=1750843969;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Njh2HYk3yVuPqMJTMfL5AxWhvuoh0UCZi5BrdHArxBw=;
        b=JXxzinHUYzUrRpRxeGo+f5vT59Mi7CCV/co1ZR4myudKfpi5FLxf8WEstFJXABzhlH
         ZZmu/8l/VtwOcd4bDL8mVFE27iSuRDUapW9mtx27SUiTl+wztd0U+gnycKJILeN/BRC+
         mH42eHNxLvCFaOLNShgxNCvu1qZ4/XsaFhgzml4bYRsYwTBrH4rFJandvNPBXddcXzLU
         SFu0MbZNklawhseYWpQshEIJyVX8ipa2+BXeeM2/5qw2NY8fUCt9L4haK9HITW9u77RB
         1k3FjWGvlzAO7b2fIrfxgh8yCIa7FVRdvuDU6BBBMBhutAH8o8zWE7AL4AoHC3fEc8bh
         BdFw==
X-Forwarded-Encrypted: i=1; AJvYcCU5bCtgcEbCqGDcucL8i42yT3rARdlQfusBvPA/Y1op5JB5pGY6jaC+UG3bmurrtl9CuxUX0I0Y@vger.kernel.org, AJvYcCV8/AWSmDLy/IQWzgH2pL9PIx5ewr165JeMVrUr1yFChtAt8ggyFmBl3hNp2OSYgE8Nptq7fnDIrGDMfjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmMYeN/0d/NpYZJPaE/zHuDzAanmOWm7g7wO+X0tsofxZiv93
	oMohO7ve1N4kuGOe78D4+Hi7ZHawiegqRKJAv7m2+gUJ6fJ+qc9M0qrU
X-Gm-Gg: ASbGncu5hcpGO32PQdE6Whk7l7pmvXIbF1RSjIX4NzZyLXY1xEQyoEV0ImL9tvjuJq9
	OWO4+xYsC7JKDxH5k/rNqzhnB8ntTVzPPOhcteNAPs6nbPTtz6k2VbNQ5xOfh4lKcCWvVVeQjwY
	Ej1k/LGkMuAZsRuLxZkazTxu/L8hqgn7pDaMs5CuK3SK60s7Qb05CqnIeKyWXTMl3LQT8oDW763
	uoDYDKcGudvRqkDEVLrcP/n1hUDLphCwhih8m3ZIfJKIvZIN1ldWgPD7wIZ8Q9j+ZeOjZMHZPfb
	qpaa1IZciwGwBDYHWoEcnOQKCieP1E1j+D3t209TOJWHaPA85doI
X-Google-Smtp-Source: AGHT+IEEzx/8tavTJoDCU3NQwXO+MejU4mgEdK+7IcvvQwC8ha1bbiA5adxkwfxpadAEB0+GLSh1hA==
X-Received: by 2002:a17:907:608b:b0:ade:3bec:ea29 with SMTP id a640c23a62f3a-adfad397276mr1491412366b.25.1750239168677;
        Wed, 18 Jun 2025 02:32:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf1b7fb8d5sm960036866b.98.2025.06.18.02.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:32:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/3] netpoll: Code organization improvements
Date: Wed, 18 Jun 2025 02:32:44 -0700
Message-Id: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALyHUmgC/x3MWwqAIBAF0K0M9zuh98OtRIToVANhohFBtPegs
 4DzIHEUTtD0IPIlSQ4PTUVGsJvxKytx0IQyL5u8LTrl+QzHvs8S5siLctZ0Q1WzaeoeGSFEXuT
 +w3F63w8Enoi5YAAAAA==
X-Change-ID: 20250617-netpoll_ip_ref-dca7934ea548
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: jv@jvosburgh.ne, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=leitao@debian.org;
 h=from:subject:message-id; bh=MvIKrVOBHZz1bYcvGMWkNIKBcys/7R02OPQEh8l61Ps=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUoe/2uZONTWRGMBSay1nWXGFCqXUUhS69ii5a
 zWO+PwvMeWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFKHvwAKCRA1o5Of/Hh3
 bSXrEACUyJTlq8RGPJvk6l/Exkb5Wbi80Q8bvCSEaDlpc8d/Nf8F5aILPMoG6zb/xVlsvabmgMS
 4aaFOEavBnKcuy4RR/nvEyF6I05oZ84S2yUX/tOQ4jmDaM+Xr+otrf8RY5mqfJsEXWbXZMChgAV
 mBtVtdCYzb38ZoMXh85xutRw6efft+sj6FdZokHcqr1VhbGiw5OKlw96M49oaCRIK9a5QyJcsgO
 C/MJbywBZ9eiPcoCNCcG7aOVDVka18pmsE77pFvWmm4Th6YpdvVK0dY26Ue1fheJxGIWoQ623KE
 fENTS/o3aX5iLt3/E+Ilts5uJbY4Oi6YXIAGgwoFvS5a8LQ2D1L+wBTMjQiGYUywWNolGFlOkB2
 iGgC+LTUtt22QV5cED76lVXDMDWTmXj9zcIdgR9WGiVbWedZPpQuMtz2umOPAcOQPyayS00hnQ5
 S3T6310I+2+ryx+N5boYwoJ1K26YnTfTfNJt7Z/110H2Zsc20f5tIDyWKOByUpBRDZXYYvmwPDp
 p5wEnA2aBGkd8QbhLAhNWcmORLXVdMDMy0X3CIRhAnjTN7vVsbgGddxGO7JJtRi2ugTGvfCzT6J
 HqCefoWOoqI1QxIjEb8b5l27Y6GWSvm3vSKFDiuxtifwPBxUBGlo5YWcvQoOZ2df4SN1Gprrs0g
 F4SjkwYHwVTf6xw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netpoll_setup() function has grown complex over time, mixing
different error handling and concerns like carrier waiting, IPv4 address
retrieval, and IPv6 address retrieval all within a single function,
which is huge (127 LoC).

This patch series refactors the netpoll_setup() function to improve code
organization and readability by extracting logical blocks into dedicated
helper functions. netpoll_setup() length is reduced to 72 LoC.

This series breaks down these responsibilities into focused helper
functions.

The changes are purely structural with no functional modifications.

This changes were tested with the netconsole tests and the netpoll
selftest (WIP)[1]

Link: https://lore.kernel.org/all/20250612-netpoll_test-v1-1-4774fd95933f@debian.org/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      netpoll: Extract carrier wait function
      netpoll: extract IPv4 address retrieval into helper function
      netpoll: Extract IPv6 address retrieval function

 net/core/netpoll.c | 152 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 61 deletions(-)
---
base-commit: ec315832f6f98f0fa5719b8b5dd2214ca44ef3f1
change-id: 20250617-netpoll_ip_ref-dca7934ea548

Best regards,
-- 
Breno Leitao <leitao@debian.org>


