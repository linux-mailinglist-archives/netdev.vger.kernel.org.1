Return-Path: <netdev+bounces-57770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A338140C8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2144D28414E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F353A7;
	Fri, 15 Dec 2023 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buXX/njk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1A5382
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35f884515fbso1221675ab.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702612227; x=1703217027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vge5rHqVVvjq99JW0WTBd8/JvlXBd0hTb90qgXIyK2w=;
        b=buXX/njkFYf3YxjqgOFtqV75pD7v0YpCDAbI2Z7S/X9S1VOrXne5HZph0thtEgyg93
         +V9lrMYuIRtm/KH3pJ6NimyeHoYJ1aTgNbW4CaQ4rbCvYBRGNZa5cfuh+J8GSHzRSqfH
         rFW0Pp9d+umh8VXxsYkl5zfk6aJdH91n0V+jxDcCrhmguvwJn+s/b0hcqPhZl/7kaDyy
         6htvkkOHw/gXOuwLrndcZOrL5Vh+MLKsY4ToXVdmLAta3qZoAZE2QwqipaCVD6VU7hen
         sLqBiVV7jJuNccO/GXCKj+bYrWtBA1th94jlfyrxnIdZ/8vXTuAdunYbyvhcOd7XGYoL
         Fx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702612227; x=1703217027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vge5rHqVVvjq99JW0WTBd8/JvlXBd0hTb90qgXIyK2w=;
        b=QVhmWTvpBW9oJiqoVR1lfUYj8FNhzHk+32nBtAXMiTiwxWgaoUvGz/bCWi+yVDQNad
         QzFKtGxb3PArVq3iOxtMi64mYRvxGhw+IiOcz6AQ8yOo8aHo8vxylPTY8KVVty/MeAn7
         E/XGe04urGNkP0g6NJ1S9Ry1bxUibCW2FTnPq3sUmI4XwaCE3D1bpQxlwlSCVD0HrD5a
         juM6zyYKKAdW3XIVwh6kg2P8chJzbPtYhYnYTIaqP0mRgqOgF0F2kJd+ue2MoVHL1ETi
         5tpTqzch/7rZYzSw7GWE4ArTWeEhuGGXKXCX5DnTEYsMfigU1FirmtN5fLtuafHpHozL
         ilAw==
X-Gm-Message-State: AOJu0YyoM/arZuT0Ym1lNrm3mS7oaz8UoT8FJxSsfaasB5fCDPcCY2ld
	btlykbJ2lcZ+Aq9zfOkA4EGG+AVGcFbXaaPHiP8=
X-Google-Smtp-Source: AGHT+IEf5ECs08wrJuyTrKMLS4jUCJvDIrguprKXBWgaCs1BRDB+WY5Gj/WfTsUBAKW21hVscO6sNg==
X-Received: by 2002:a05:6e02:1609:b0:35c:8f50:acd3 with SMTP id t9-20020a056e02160900b0035c8f50acd3mr19271305ilu.18.1702612227479;
        Thu, 14 Dec 2023 19:50:27 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001d06ca51be3sm13124483plf.88.2023.12.14.19.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:50:26 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/3] ynl-gen: update check format
Date: Fri, 15 Dec 2023 11:50:06 +0800
Message-ID: <20231215035009.498049-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

Looks support defines in len check is not as complex as I thought :)

The first patch update the len checks. Add len part, and correct the usage
of min, max, exact len.
The second patch add the support of using defines instead of hard code only.
The third patch fix the IPv6 addr len definition.

BTW, I'm not sure whether the 1st and 3rd patches should be fixes or not.
Please tell me if I should update.

Hangbin Liu (3):
  tools: ynl-gen: use correct len for string and binary
  tools: ynl-gen: support using defines in checks
  netlink: specs: use exact-len for IPv6 addr

 Documentation/netlink/genetlink-c.yaml      |  9 ++++--
 Documentation/netlink/genetlink-legacy.yaml |  9 ++++--
 Documentation/netlink/genetlink.yaml        |  9 ++++--
 Documentation/netlink/netlink-raw.yaml      |  9 ++++--
 Documentation/netlink/specs/fou.yaml        |  4 +--
 Documentation/netlink/specs/mptcp.yaml      |  4 +--
 include/net/netlink.h                       |  1 +
 tools/net/ynl/ynl-gen-c.py                  | 32 ++++++++++++---------
 8 files changed, 48 insertions(+), 29 deletions(-)

-- 
2.43.0


