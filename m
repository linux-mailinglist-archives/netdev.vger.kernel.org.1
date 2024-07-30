Return-Path: <netdev+bounces-114214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052779417EA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44741F252E5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA118B465;
	Tue, 30 Jul 2024 16:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293C18A92F;
	Tue, 30 Jul 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356058; cv=none; b=mICcB/DXED08xHCLekFWVG0COppxSjsJhhCgQQ4k3arI7xR8lhSrS9XXjI+bqdfDskYBtT81gaobxUJT7tiWsZ0E7Dj2Cb7FaL0+HoPrnwYWZgzfa2A8U0MDT8zhrsiZnfTMsCwtbu4Z2Tb8ACv9q451sHadqVtm725xZBS1UCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356058; c=relaxed/simple;
	bh=ii3HR5+wMx769JFD3o2IrRXFpu4Nzq9Jsjq3hmoXOFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPEQZEM0kSHY0ceSWVSIZBunKdPuATH0p5XjkFfSyAv+Yrj6T1jEDUGPrHPH1geU2E0GmsMIslmS3QnBwGcnPtAhrkMsIw6Fdg5Ttx3d84yJRo57nY7t6WN00UjOw3UdABlwvqCroi+fgery6/pCUDi7WfALIFAdU1H1UPK5ywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a91cdcc78so288512966b.3;
        Tue, 30 Jul 2024 09:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356055; x=1722960855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzhMg19ph/DOe53231JHDUwm37lww++KloBs0Jq6d4o=;
        b=lm6mqBkyOkl+2Izip/i/kiqMXrbfgKRvLvTTIDzvcIt6hnCl7ofe/vq7S+kY14ggb5
         glYhE9TXbs8quAzCbar07iKOWX73JZb3JRpQTtH9WCLuN00WrIthI2gpqysBK5JV//em
         Dkejj1wHjgtlmXGIbyiShDwrzwjY2jbmj9s+LHr7FalGBWT4lmTc60YtVF+dIUdTRlfZ
         yPBtAVUkVQrgVmMydDcSI1Aude8qaY3GsvG1Gd/w5GzqWi602jx7bG8kILvH2lJDhKIp
         RABmrYCA/xoZEez5UF288gtmsCXXFiiJCPhVrATJPXUsbHBCf+TQNChALqI6dr/2J+VI
         b0eg==
X-Forwarded-Encrypted: i=1; AJvYcCUG30tm2TSUuEr7XybXqtX7ztv8GkPbk+lvfAnrXllif/Dd1m6cu+djFiGM/OxmNQk1lywZyPV4wRVQUkfOx1UhUxvVCSNA/zGDHtQR
X-Gm-Message-State: AOJu0YxUERuO6/2Q3LaEc5qaZqT+VkapchYj9ZG7yW8X2b5pU+AAq3xI
	e/7jJMOWN3znjdF99Qj6S1PDUfImTXXlYtPJGinjlaL1jO23PHPz
X-Google-Smtp-Source: AGHT+IG3hCITzrgP8JYJVpqDsgLyS0/sYZMwDjPJXrkv6yJ30BIMqnDWBbGjOHHdjvwpFS7cEYx7Gw==
X-Received: by 2002:a50:9b5b:0:b0:5a2:e73f:1528 with SMTP id 4fb4d7f45d1cf-5b0217572b0mr9429677a12.12.1722356055033;
        Tue, 30 Jul 2024 09:14:15 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b145c8320esm4382814a12.17.2024.07.30.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:14:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: Add skbuff.h to MAINTAINERS
Date: Tue, 30 Jul 2024 09:14:03 -0700
Message-ID: <20240730161404.2028175-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The network maintainers need to be copied if the skbuff.h is touched.

This also helps git-send-email to figure out the proper maintainers when
touching the file.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog:
v2:
	* Move the entry from "NETWORKING DRIVERS" to "NETWORKING
	  [GENERAL]" (Simon Horman)

v1:
	* https://lore.kernel.org/all/20240729141259.2868150-1-leitao@debian.org/

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64087e9bde34..75f5607c1b84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15937,6 +15937,7 @@ F:	include/linux/in.h
 F:	include/linux/indirect_call_wrapper.h
 F:	include/linux/net.h
 F:	include/linux/netdevice.h
+F:	include/linux/skbuff.h
 F:	include/net/
 F:	include/uapi/linux/in.h
 F:	include/uapi/linux/net.h
-- 
2.43.0


