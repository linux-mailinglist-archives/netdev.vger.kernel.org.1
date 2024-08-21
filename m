Return-Path: <netdev+bounces-120472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4989597ED
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E811F22AFF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD91A4B84;
	Wed, 21 Aug 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVXW2Bmg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF41A4ABA
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230019; cv=none; b=g7Q2GOT069noZJWTlWGxWr1iPu92sdVw6SFDg4cvYdcDz/D2rfm6GIH+9lKOTp65A9kWb1X7gelfYJyMiqZWiUp7nquz//JHFuhgheILMFYsih7+YKwwV5BWCQyDptRp1gRuMKP2N7LOI7lDPT3whRTrPrzj+fwhIqtXTGQiHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230019; c=relaxed/simple;
	bh=hflxzg9wTZcvaLmFqc3rwQHLsNSr7cJAgJZVaNI8H48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agiV0JYbsrh9VCBiHyR+P7AYkaXQlbmEyV3zL9N5BzWPKlCJmhAkgoO+CL69W+SYJBd1HFbNPMyiZvV3E/p1rCgmNl8YDpC7h0fZCJJdcnqpz9y7yq6v+QedlPtFWRyivlPJExMREnVJ6IR2591ZAvOaFdB5xTm1oyeymfnsric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVXW2Bmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6D8C4AF0E;
	Wed, 21 Aug 2024 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230018;
	bh=hflxzg9wTZcvaLmFqc3rwQHLsNSr7cJAgJZVaNI8H48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fVXW2BmgDXFAZ6TqLmryoXJeGZSnGgFd4p4uAd081AKNVYvyFOevaRm8K3lvCtMOA
	 nOkxNz9ZnrkLm5JX9RqC+4fH6KzDbocAUa7JLnBs/6gEcBFxGh+aART0f8l8+D1aP0
	 +2VxpXptBRMurj2kN6dHT7NBpkpB6SS67baWAMicVLowkLXuG1KDeJygq7idtki4HU
	 fyxH6AySI04WSDumE7+CcDznCOEz9a9lcZj2KeNEPnTYC/PxdHV39NYc3aKVqjgwWD
	 NHPLcJwCLBJuK1P8OtFFtYrvLMqrKKbojIuNBJLthebUs3UG9AQ7SXrPa+XR0g9V6J
	 N28uAskF0/wog==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Aug 2024 09:46:45 +0100
Subject: [PATCH net v2 2/5] MAINTAINERS: Add net_tstamp.h to SOCKET
 TIMESTAMPING section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-net-mnt-v2-2-59a5af38e69d@kernel.org>
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

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
v2: Add to SOCKET TIMESTAMPING rather than PTP HARDWARE CLOCK SUPPORT
    section.  This seems more appropriate given that
    include/uapi/linux/net_tstamp.h is already in the SOCKET
    TIMESTAMPING section.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c682203915a2..e5b9a4d9bc21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21057,6 +21057,7 @@ SOCKET TIMESTAMPING
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
 S:	Maintained
 F:	Documentation/networking/timestamping.rst
+F:	include/linux/net_tstamp.h
 F:	include/uapi/linux/net_tstamp.h
 F:	tools/testing/selftests/net/so_txtime.c
 

-- 
2.43.0


