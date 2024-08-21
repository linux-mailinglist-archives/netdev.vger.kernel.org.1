Return-Path: <netdev+bounces-120471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF29597EB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6377A282884
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ACA1531CF;
	Wed, 21 Aug 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB31mL6V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F1B1BA29E
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230016; cv=none; b=gBqJ+1QA7RvztF6HKy1gW2Ardx6YQd5eI/MoP/oL61zx8AikpMtZh1Yrw72hAdtUrRrukZbnCR7r9gcan/K1tLEa+DBMwfolSJmJkcL5B3rVq980axtSPNj4fihaDT4q27OOfXGfSN2ZowePybGDhiqtdHvG+x/y4gkZqJQeLRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230016; c=relaxed/simple;
	bh=nRyQyVL5Ag79jXdEfkESG2e+d8YyMtNRLsS6JqdBYBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dSKJKYXCExKXkgZPsNk4Mvsp+DeEjSSHgfJT6a5KRENq3H9vi3LcFVAXUMDeIdzuwHXkvKFYaQjrH5ipPf2tqgzcMp6qNM2ono3YG57ihFvEQliL+dhO9BIJ349ac9nHTWaEms/lwlYjznoPZ1Bl3ItpCGDh+WF0CYTtoiqqhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB31mL6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF00DC4AF09;
	Wed, 21 Aug 2024 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230016;
	bh=nRyQyVL5Ag79jXdEfkESG2e+d8YyMtNRLsS6JqdBYBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZB31mL6VffT6J8fut081iPLwodonxU9+BmyoZL3re2/VC8yTd2BCl7ljK73CmZp5D
	 vOa/ISDVlXMeuIVoUKI6m68/7Xka3TFGEV+adW45QrxoA21goh9UerEKWiOX1nMYOS
	 3MIoC+bziYGwSnxDt9ADTnbTsUmdTY+FL07yYqLjHU41hM9E2sfOKK+3AxvWoEmokf
	 2cpLpvPBlcg78aUgPMIpNcbOGq4mIwOZ6dxAh2Ne0pRPmwPilPraqH/4ZQ7TCzneIA
	 QdSnEzxFE6g5BPS54kPDKAt+YgztW81SZNsJNOpo5YkhhPt79FrY4I5gn1QyV4WWOL
	 C3dbxKCw8jLnA==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Aug 2024 09:46:44 +0100
Subject: [PATCH net v2 1/5] MAINTAINERS: Add sonet.h to ATM section of
 MAINTAINERS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-net-mnt-v2-1-59a5af38e69d@kernel.org>
References: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
In-Reply-To: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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


