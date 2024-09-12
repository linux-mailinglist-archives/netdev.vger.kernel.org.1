Return-Path: <netdev+bounces-127883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB352976F54
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C68F1F24206
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0CF1BF7E7;
	Thu, 12 Sep 2024 17:12:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C384D02
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161175; cv=none; b=tSOS1jugP4qqKtYPk8chKoClPQOkb17szUI1wtRXSuZbT3+Eoo565dmHpzylfx4goiKZPlNmxFyUPW772H9Uz0LXWr5gv19Fs2bkvc8qYSKEXK4EtXmyuWwNQ6/BUiafjGFE1uUpAb7CTwBUG88C9TZa2ib9AWLP4MBh6f0s1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161175; c=relaxed/simple;
	bh=++3fepj5Rz0lbYbQfkmlpRPY9f3mQ4PAV2aC7dZQOa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzMHKOQk2nZj4uZZr+38D3cZ+sjHhDSKtRMUNflhWr1YNPlW3r13CYtvIxdKViKd8pwPkK+Tt3ZaKxhNPICS7Qn5myT4Jc0VkZ9Tpe0mYgtnpc8hKibDvvVfFkts9O3Ff6UkmbvdANKuN4dcra0Fp85C46oKFiy/rmBDu04lNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2053616fa36so14558915ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161172; x=1726765972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PCFh4WV9z1k9+Xv+bLZUM6UjrP601IEujzXTIYzpYI=;
        b=BGZRUJZHs34H/B1ykR6SUC9PcfhW9VZLcSeP6GluNwDvNocP12GxK+FVTGUNQctfA7
         27zPPadxn1ASISyCRfN2JlS6TfKQTuAHQ6t57E6mImVXYLenhaOZuT1mFW+GnN8FZd9A
         Cbn6PiYsyl1XRX+NAVJO8OlTiJLpuYjppYjnMVTVW+nw4GwrSGSUpyD9zlGl4Dblchxq
         qA+NPJkokOCke75nbXkXagnXHJ/dW4PnLNE019u7ZaIL43so46+w+Eo5DM/1+cNafolB
         7g4nJ2L1V2iI8Hj07nWpKBS2PlsYpeMluwKfKh3kjKENRgD3qQH+2k1Gzog+ncofJg2M
         KyLQ==
X-Gm-Message-State: AOJu0Yw7z7ETDBQo3jKY0eHQELet3Vg6lKjlPk2kkP6tSRTAnWB4+j/p
	bo4jYoKjH3kl8ecuGoU9OyCQiKIgRTmpe5KrXdEFGGamDzz60MAQ++Pb
X-Google-Smtp-Source: AGHT+IFBSIBm4Os8D2t29rVK1pgQbvp+0ix+PhQ7c5BKXnZbLEbAJHiP017IFX/ETDH0NyxqPKvcJQ==
X-Received: by 2002:a17:902:f651:b0:205:6121:1b2f with SMTP id d9443c01a7336-2076e3063f7mr59570465ad.11.1726161172430;
        Thu, 12 Sep 2024 10:12:52 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af4791fsm16556805ad.109.2024.09.12.10.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:12:52 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 00/13] selftests: ncdevmem: Add ncdevmem to ksft
Date: Thu, 12 Sep 2024 10:12:38 -0700
Message-ID: <20240912171251.937743-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of the series is to simplify and make it possible to use
ncdevmem in an automated way from the ksft python wrapper.

ncdevmem is slowly mutated into a state where it uses stdout
to print the payload and the python wrapper is added to
make sure the arrived payload matches the expected one.

Cc: Mina Almasry <almasrymina@google.com>

Stanislav Fomichev (13):
  selftests: ncdevmem: Add a flag for the selftest
  selftests: ncdevmem: Remove validation
  selftests: ncdevmem: Redirect all non-payload output to stderr
  selftests: ncdevmem: Separate out dmabuf provider
  selftests: ncdevmem: Unify error handling
  selftests: ncdevmem: Remove client_ip
  selftests: ncdevmem: Remove default arguments
  selftests: ncdevmem: Switch to AF_INET6
  selftests: ncdevmem: Properly reset flow steering
  selftests: ncdevmem: Use YNL to enable TCP header split
  selftests: ncdevmem: Remove hard-coded queue numbers
  selftests: ncdevmem: Move ncdevmem under drivers/net
  selftests: ncdevmem: Add automated test

 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/Makefile  |  10 +
 tools/testing/selftests/drivers/net/devmem.py |  46 ++
 .../testing/selftests/drivers/net/ncdevmem.c  | 682 ++++++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   9 -
 tools/testing/selftests/net/ncdevmem.c        | 570 ---------------
 7 files changed, 739 insertions(+), 580 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/devmem.py
 create mode 100644 tools/testing/selftests/drivers/net/ncdevmem.c
 delete mode 100644 tools/testing/selftests/net/ncdevmem.c

-- 
2.46.0


