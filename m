Return-Path: <netdev+bounces-44009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B17D5D1F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED351C20DAD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930A83F4BF;
	Tue, 24 Oct 2023 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0RAoPiP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F7F3F4A8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:25:14 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A7498
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a693d8de75so155024639f.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698182711; x=1698787511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hGuqXs3r7YbfflSkrPwDq7LlbajtnXssOWD2MeYe3g=;
        b=N0RAoPiPUGcmz5mXRr4tO6keL9oFfHf2VTd/+gU63wFejKsM9ZhAHmkOsd9DxThBzC
         M+8sY/bRZzi7txrBj//Gk5mExKywj45klcyW5p+lsf+iJQKqVNq1r4wSaUmoxC3m57ty
         ShT/M1tcm3e6n39R1Gs8AGC9KFb1xyC9hxFTP9WCoTF/gY2Arf4baUK8mWJOlTenxTCN
         7KHdYWroU7tJuqxNXJscYVq8VCdjZDIkyFrhI8DYNsBG5oWKhv442BnAsjwXNzzbgPhk
         UEscCwZUuoeAPP+Uv0Wn//5TFIWt8Ftj0oU4io9X1Ps/qfLkxdOcRrogfz6CYEnY1k8d
         a0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182711; x=1698787511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hGuqXs3r7YbfflSkrPwDq7LlbajtnXssOWD2MeYe3g=;
        b=ZytRfhmPTKB6JF/2U7fq9XJd7Jdk56qGy6QOiDVUzbe/jWg8HHDUm4lQX0WsW4t1Hy
         vMf23kMuPkEIOljqEoo27r38FOtrGTPD6YbLz2xNlr462hPxSkeWJETgnVciSjsxHzk2
         TBxNbqlEB/4uWHUe2WUPIVEEvBhvXvNkpfJZYfFPZ3W3f8imgiZTo6hfpseKI5gxCgMf
         j6fnVbt2LzNLdE6vnV2xXy9YafHy6lDs/46C7xmPxnBjCWd0QR+mMG8IwPkqmdifTLN7
         WI6oJRpw2TUXrXM80GXJD0DrH0UHsN8tEL3Nx8Cr6F+cb7h/9UjaoM78AnJGMigRq6lm
         m1mg==
X-Gm-Message-State: AOJu0YyN9mY0yZTkzSfb6LU6iXqOOcYljaLhkpki471S2HN3A9C3EtjG
	2Mf6Pa2wtZVpxpszJ4MWaX23iCWb1G4=
X-Google-Smtp-Source: AGHT+IEOK0RDek/X6bzgeK4muH8DaatIVsCLNzPIpjBAS7mqDCYaaobHsAZ3C5xgN/jke1FCNjoD9g==
X-Received: by 2002:a05:6602:154a:b0:786:2125:a034 with SMTP id h10-20020a056602154a00b007862125a034mr16213918iow.18.1698182710680;
        Tue, 24 Oct 2023 14:25:10 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id ei3-20020a05663829a300b004332f6537e2sm3070830jab.83.2023.10.24.14.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:25:10 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH net-next v2 0/4] net: ipv6/addrconf: ensure that temporary addresses' preferred lifetimes are in the valid range
Date: Tue, 24 Oct 2023 15:23:06 -0600
Message-ID: <20231024212312.299370-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No changes from v2, but there are only four patches now because the
first patch has already been applied.

https://lore.kernel.org/all/20230829054623.104293-1-alexhenrie24@gmail.com/

Alex Henrie (4):
  net: ipv6/addrconf: clamp preferred_lft to the maximum allowed
  net: ipv6/addrconf: clamp preferred_lft to the minimum required
  Documentation: networking: explain what happens if temp_valid_lft is
    too small
  Documentation: networking: explain what happens if temp_prefered_lft
    is too small or too large

 Documentation/networking/ip-sysctl.rst | 10 ++++++++--
 net/ipv6/addrconf.c                    | 19 ++++++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.42.0


