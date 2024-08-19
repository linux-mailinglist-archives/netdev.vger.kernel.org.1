Return-Path: <netdev+bounces-119665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE619568A2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AECD281A5E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2515CD58;
	Mon, 19 Aug 2024 10:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B315B972;
	Mon, 19 Aug 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063785; cv=none; b=JHO5xOvtf2tpI/woxGj6750MSeXTRGsaF4bAL92G0Opf38MkIvm75/uECGqXoPay8+mPo9zKPX5m0RIEVRdkBonBbnPvjhvp43xi3atYF7zN3EaSalyKCEY1T4nzNeoUEqbyeK4tlcW6Gi00sfQcjvSt7kb+Y51p1NENI7iQB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063785; c=relaxed/simple;
	bh=UYxsxD6yoehB7K7pT2SFsXMGr4b4YQ7evFAGlbxj/dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPGyTStiremKajuu7aVrEYXCIKlPhAVpWh/KvO6tl/Z/a0myG7EKckfK6k978NskdUu8QW5m1u0A9zghGgDxzmAq0HrgilsfBU4XRoOJCRKtooAJ+mqpDWW1JcxtCdpyMfn6UZahlo9zAvI2RaQ/V3m5zMF7hNjxmni4GcX6lrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so295818766b.1;
        Mon, 19 Aug 2024 03:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063782; x=1724668582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+iWfezDg/+ri7ZmQdxEtPFY0++fEilW8G7oHDpy/rI=;
        b=h7eQCAnK7LDI7r3ueIhjqY5J+tnT0WICFigEMblaEqWk/lY8AjGflxJmMeLrV6/wsw
         E4ZiJe8yWr6HlimIKg9A+TDRO3gQNY+C+Q7eegBvqktowtWjf4psgfVrsTTrAiILZRSp
         /uRc8oIDtjMxiFqCQ1Xf+EWPWRdQHPO01ULJaoglT3dMwyk9JzPfRS4/2UdPiSjqKMlO
         bZmDaordyq6t4D1rbFjoAN8/oEUGzd6yJifFCR5LIBGVsiUclVIBjYnem//CzyPP5wCk
         Hi9nkUN/hU2VbMU11RYB4R4I0Jm7yGPHsip5t/m/Nzud0ClYoT4KFEy9wJqoOZLN0PNJ
         7vtw==
X-Forwarded-Encrypted: i=1; AJvYcCXyYf/BQzj/xlv4soZYQ/Mw1K+cOC9NJtkftSDVCNbo3SAvCfikSgvpkGTXx/UXBxu8xkjrgdiYiGIIf67CQnoTfmt4/pmjVWQZvNZH
X-Gm-Message-State: AOJu0YwOoOW7MO54s7CGZ3jKifinOx/ge7UoEmOiarZevgrys0PgKPoK
	rujZWJ5TvVfIuLPmZhjfEK2kN3KondwvR683fe+p022X7xfcR6xa
X-Google-Smtp-Source: AGHT+IHVmcmqJT+thDxFnN2AlqjlYqbiQyHPslu+SVAuOd/ivla648RYhv/dUK1MY5ns6c6vQytoqg==
X-Received: by 2002:a17:907:96a4:b0:a83:7ecb:1d1f with SMTP id a640c23a62f3a-a8392a03bc1mr723470866b.46.1724063781477;
        Mon, 19 Aug 2024 03:36:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946517sm613200066b.169.2024.08.19.03.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:36:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] netconsole: Populate dynamic entry even if netpoll fails
Date: Mon, 19 Aug 2024 03:36:10 -0700
Message-ID: <20240819103616.2260006-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of netconsole removes the entry and fails
entirely if netpoll fails to initialize. This approach is suboptimal, as
it prevents reconfiguration or re-enabling of the target through
configfs.

While this issue might seem minor if it were rare, it actually occurs
frequently when the network module is configured as a loadable module.

In such cases, the network is unavailable when netconsole initializes,
causing netpoll to fail. This failure forces users to reconfigure the
target from scratch, discarding any settings provided via the command
line.

The proposed change would keep the target available in configfs, albeit
in a disabled state. This modification allows users to adjust settings
or simply re-enable the target once the network module has loaded,
providing a more flexible and user-friendly solution.

Changelog:

v2:
  * Avoid late cleanup, and always returning an np in a clear slate when
    failing (Paolo)
  * Added another commit to log (pr_err) when netconsole doesn't fail,
    avoiding silent failures.

v1:
  * https://lore.kernel.org/all/20240809161935.3129104-1-leitao@debian.org/

Breno Leitao (3):
  netpoll: Ensure clean state on setup failures
  netconsole: pr_err() when netpoll_setup fails
  netconsole: Populate dynamic entry even if netpoll fails

 drivers/net/netconsole.c | 17 +++++++++++++----
 net/core/netpoll.c       | 16 +++++++++++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.43.5


