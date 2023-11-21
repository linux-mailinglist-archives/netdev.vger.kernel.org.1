Return-Path: <netdev+bounces-49710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE6C7F32C5
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A87282DE4
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8858133;
	Tue, 21 Nov 2023 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="mwZ6NtI8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF98D77
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 07:53:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9fa2714e828so457841866b.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700582020; x=1701186820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YF5zRX0anlbd7P/lxY+pifF1Q2sI00JLjEQz2BjGPKs=;
        b=mwZ6NtI846MQFi2IWNrwmunx8+A/lXZ1ZEbPI4GbEJ40W6VqtJxgKrl5HkY5zbCn4I
         w+WDzaRQCNPMeSaCoKqHIKfURWTZ/2EuhNkFgx1qXwUSrDBOSAjjiu4r0fa7twJts1cP
         xgjv4LN7abCIQFn6BZ/Pe0kJTgGGLNUFW9XNLaF9hrzWOJgWEcWpyB992OnCJKvbEN5j
         B8WFcJLY6K7m54QMnOTd3kP9LEQ/lBs0eKg2OGnzSVN/0Tv4w+RAQrtfNug5uoCJHv7x
         LEc9CPDRlcFSwJLf8THq3pL0ld64F5iB9zIcd+rirOb+pVme7spSrsOs54QiEamiixXL
         iUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582020; x=1701186820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF5zRX0anlbd7P/lxY+pifF1Q2sI00JLjEQz2BjGPKs=;
        b=leLm/bPVocd1PeWR1CM/Y2KGa9XgJOso5M9aZeMcYEUIxtvl+TJpoWga7rWQB7zedR
         z6VymnzLQLeKG6bTHEW/GmIvAOQGp0HlTNZrqD+4ta/bCQqINAxlYrlByeqOfKZwoakd
         OtTCIqmu/CSUl6izlt6yq79HZhqj4EUqAoFwNbeqW91kO6MSRxoviQwCGKPmQmr+HwQy
         oei6GL/BtVzrZtAJsAndQ6aAcpxcUwzrEl4HUJw4Gv91ZFVcbwYLgt6RVAosCoGRJj2o
         7w4kBHzdRs7sXg67rb7SSz4iPewUPzr9hVgniNB1zmRaZbHq8Yyvh51OteNxhyFC/cJm
         CwNw==
X-Gm-Message-State: AOJu0YzUPHZL8D1F7Nzwmun/YYX04IedllmjrB1884V67TSICQPcupPj
	lIj8FY3dQVNucgy++SdspwBNeg==
X-Google-Smtp-Source: AGHT+IEDNObtDvR0uRy/QNp09TbPkvcmJIi7ltEStu4nk0Z25EsThzHrMknvOLYRhcTyMSDJg/801Q==
X-Received: by 2002:a17:907:8b90:b0:9ae:522e:8f78 with SMTP id tb16-20020a1709078b9000b009ae522e8f78mr9454682ejc.74.1700582020433;
        Tue, 21 Nov 2023 07:53:40 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id dv8-20020a170906b80800b009fdc15b5304sm2896853ejb.102.2023.11.21.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:53:39 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next v3 0/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H support
Date: Tue, 21 Nov 2023 16:53:01 +0100
Message-ID: <20231121155306.515446-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This small series prepares the rcar_gen4_ptp to be useable both on both
R-Car S4 and V4H. The only in-tree driver that make use of this is
rswtich on S4. A new Ethernet (R-Car Ethernet TSN) driver for V4H is on
it's way that also will make use of rcar_gen4_ptp functionality.

Patch 1-2 are small improvements to the existing driver. While patch 3-4
adds V4H support. Finally patch 5 turns rcar_gen4_ptp into a separate
module to allow the gPTP functionality to be shared between the two
users without having to duplicate the code in each.

See each patch for changelog.

Niklas Söderlund (5):
  net: ethernet: renesas: rcar_gen4_ptp: Remove incorrect comment
  net: ethernet: renesas: rcar_gen4_ptp: Fail on unknown register layout
  net: ethernet: renesas: rcar_gen4_ptp: Prepare for shared register
    layout
  net: ethernet: renesas: rcar_gen4_ptp: Get clock increment from clock
    rate
  net: ethernet: renesas: rcar_gen4_ptp: Break out to module

 drivers/net/ethernet/renesas/Kconfig         |  9 +++++
 drivers/net/ethernet/renesas/Makefile        |  5 ++-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c | 40 ++++++++++++++++----
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h |  9 ++---
 drivers/net/ethernet/renesas/rswitch.c       |  4 +-
 5 files changed, 49 insertions(+), 18 deletions(-)

-- 
2.42.1


