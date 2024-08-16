Return-Path: <netdev+bounces-119192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E97819548DF
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297B41C22450
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E11B3F08;
	Fri, 16 Aug 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+LOmn9X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632B16F839
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811909; cv=none; b=SnQRHsNk8wKbcepPh51/qDMy8hSdXKk/xw4cKzsvKI5/OkLvJhmghtxIeQCWZyA+9wfsWx8MyyRQhq3ieKZBw4LEabD9munRHeVM8hrk613pnoewq13cq6PKllLZeJQJKNOJEyb3C2U+hVseQ0nGIwJ06pRHc0RyUtZp5VF+6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811909; c=relaxed/simple;
	bh=nRyQyVL5Ag79jXdEfkESG2e+d8YyMtNRLsS6JqdBYBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dq4GKNpQXR5MxzMwaxQy7nPdj44NQ+4t/RIXLrHbd9gj2dK/55YTnRDA66G9kaoXmWaGrmskgMRmBQneW0zDwASRs3dPk/BIJk+El6brv3XSi8aivNBcTlLkfI4QA5lClH1sGZC6JZjMzRWqV2QHCvglR3XLRTRuyEP6qgha3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+LOmn9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBED2C4AF0D;
	Fri, 16 Aug 2024 12:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723811908;
	bh=nRyQyVL5Ag79jXdEfkESG2e+d8YyMtNRLsS6JqdBYBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b+LOmn9X6ktY/0UPYnlX+2zSYA/8Yyjj/RQvHM0XzqOS2TYmRV2FbhYswGKiAcf+M
	 +WBhmYRMQggTYojX+Ky9EP7IaxaxWnbaVGXxHE6Lhjb94tHM7Km/Pm8dnJite/79Dx
	 K3u2/kGmnuw5svNnN88FGp2PAuQromoY8tMShT1G1Pxz/DmdiFoBSTpMtcZ5V5/fYd
	 jrgQvFGfRdmwbvtF8d/RrWTDce4DBYx5w1b5kKPAIOJ56x11LGpvMokUoGN/IHoZOr
	 DQYv7dVx+3eXtoLP0i4lynXlURotTagl7FFoQzoEDN63OmkqwCpFJmtgEuDPYaCre8
	 /t3F+tbVOQf7A==
From: Simon Horman <horms@kernel.org>
Date: Fri, 16 Aug 2024 13:38:00 +0100
Subject: [PATCH net 1/4] MAINTAINERS: Add sonet.h to ATM section of
 MAINTAINERS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-net-mnt-v1-1-ef946b47ced4@kernel.org>
References: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
In-Reply-To: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This is part of an effort to assign a section in MAINTAINERS to header
files that relate to Networking. In this case the files with "net" in
their name.

It seems that sonet.h is included in ATM related source files,
and thus that ATM is the most relevant section for these files.

Cc: Chas Williams <3chas3@gmail.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a964a34651f5..c682203915a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3504,7 +3504,9 @@ S:	Maintained
 W:	http://linux-atm.sourceforge.net
 F:	drivers/atm/
 F:	include/linux/atm*
+F:	include/linux/sonet.h
 F:	include/uapi/linux/atm*
+F:	include/uapi/linux/sonet.h
 
 ATMEL MACB ETHERNET DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>

-- 
2.43.0


