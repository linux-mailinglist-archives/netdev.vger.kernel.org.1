Return-Path: <netdev+bounces-46381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D47E3841
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 10:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12606B20B8A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0012E4E;
	Tue,  7 Nov 2023 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pytBYZQV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCBE12E40
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 09:54:36 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCFE11F
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 01:54:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a62d4788so7361607e87.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350873; x=1699955673; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KVxbyf63W63AUZ1cjifrLlcVV0rg+APXv/mnMjOM+w=;
        b=pytBYZQV9ZnZlU4wxdv96tF2HwEufIfvVY8y7Q02ZSam9shdF5GNSTx1grkLNNkFoi
         mcr1D9QZweNlf/jGlm6aO4/TO3DYlg319BvMxpf81h8sIXz8PgYv4W1VcMp/TGZh2CUR
         rriWFufywFj6z6Myuw0TbleYODnd8eVqfNtUIdcrxOK0x87pxJxUhRi5Cq3ruY0m45G/
         HY39MkplRgMG7fNWkXT7c2spYrsgOWrnzutAhbzpj/dbj/kbj1KtAg6vhmoc/4909mlO
         Os/IkzoUiVPSeeLJzbxlfmLk7vrz5RD41/iCZTrb53F//YbFyDZgi5bf55GbghD71pPo
         3f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350873; x=1699955673;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KVxbyf63W63AUZ1cjifrLlcVV0rg+APXv/mnMjOM+w=;
        b=USwXBVlzr+Pmh68svyiSpbtj/QT7eM7zT/p3MUyt2QbmtC6DpdcLT6KKSlcGpMN4Ep
         L7oO1ZN5iuNXyQfdSuOZGwYXiiNELVM9nTAI8wlGH/8HPnskI2gyrRI19Uste3+fqczd
         Uc6rNkrUxEkS8o2ctLH0X8IJlD5Juz151sT6OIij4OIbvRv4nhgl/jizBriwIhH7pIwq
         O/AnFHvtYpWEL0rqJ2Fq+gCxPYjC6nENU8NMJLlN7937RWUVtWgto6uQ38Tf0D89Zt1O
         +PfP3gocx0Vr/rOKZlLAfUD8TakNR0I6DHPxWX8Z6tmfNe7I92fIIzqRGRQ0eNXKYxtk
         6+rw==
X-Gm-Message-State: AOJu0Yw2n+is84I1tLtPgwgP/9EX/EIjz95vflR/2SNZKA3EsCwOohnh
	UxhxuaVtDbeZcGo+Jo5WvNy0pw==
X-Google-Smtp-Source: AGHT+IHaEDMyUObMlXrFqoLoDzJvzNU0tys1WG7+cZQWqx4WDBC+KFxmSp6l8CrC/bJVSZX+Ze64xg==
X-Received: by 2002:a05:6512:201c:b0:508:266a:e85f with SMTP id a28-20020a056512201c00b00508266ae85fmr23464114lfb.1.1699350872555;
        Tue, 07 Nov 2023 01:54:32 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:32 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net v3 0/4] Fix large frames in the Gemini ethernet driver
Date: Tue, 07 Nov 2023 10:54:25 +0100
Message-Id: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEJSmUC/4XNQQ7CIBAF0KsY1mIKlGpdeQ/jAulAJ2nBDA3RN
 L27hJUujMv/J//NyhIQQmLn3coIMiaMoQS13zE7muCB41Ayk41UQjQt9zBjQD4Z8uDIzMAdPrk
 VrRqkPZ7EXbOyfRCUurpXFmBht1KOmJZIr/ori3r6w2bBG95brYVyUjqlLhMGQ/EQyVcyy09G/
 2JkYeygjDams23ffTHbtr0BA5R4owcBAAA=
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

This is the result of a bug hunt for a problem with the
RTL8366RB DSA switch leading me wrong all over the place.

I am indebted to Vladimir Oltean who as usual pointed
out where the real problem was, many thanks!

Tryig to actually use big ("jumbo") frames on this
hardware uncovered the real bugs. Then I tested it on
the DSA switch and it indeed fixes the issue.

To make sure it also works fine with big frames on
non-DSA devices I also copied a large video file over
scp to a device with maximum frame size, the data
was transported in large TCP packets ending up in
0x7ff sized frames using software checksumming at
~2.0 MB/s.

If I set down the MTU to the standard 1500 bytes so
that hardware checksumming is used, the scp transfer
of the same file was slightly lower, ~1.8-1.9 MB/s.

Despite this not being the best test it shows that
we can now stress the hardware with large frames
and that software checksum works fine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Do not reimplement the existing oversize check (sigh what is
  wrong with me). Drop that patch.
- Drop the gmac_fix_features() since we are better off falling
  back to software checksums dynamically per-frame.
- Add a new patch to bypass the checksumming engine if we are not
  handling TCP or UDP.
- Link to v2: https://lore.kernel.org/r/20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org

Changes in v2:
- Don't check for oversized MTU request: the framework makes sure it doesn't
  happen.
- Drop unrelated BIT() macro cleanups (I might send these later for net-next)
- Use a special error code if the skbuff is too big and fail gracefully
  is this happens.
- Do proper checksum of the frame using a software fallback when the frame
  is too long for hardware checksumming.
- Link to v1: https://lore.kernel.org/r/20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org

---
Linus Walleij (4):
      net: ethernet: cortina: Fix MTU max setting
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Checksum only TCP and UDP

 drivers/net/ethernet/cortina/gemini.c | 66 +++++++++++++++++++++++------------
 drivers/net/ethernet/cortina/gemini.h |  4 +--
 2 files changed, 45 insertions(+), 25 deletions(-)
---
base-commit: e85fd73c7d9630d392f451fcf69a457c8e3f21dd
change-id: 20231104-gemini-largeframe-fix-c143d2c781b5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


