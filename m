Return-Path: <netdev+bounces-177829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7DA71F28
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B80A7A33A2
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957CB253F1C;
	Wed, 26 Mar 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="s+dUci+k"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492B1F5615;
	Wed, 26 Mar 2025 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017417; cv=none; b=YI+LsIpRLhgKnHZXR8EAaWRrWseSXFPc7PN1kj2ENJUCnW7aJKf/GL9+0ICsGERAuuRLf6lvNr/sF1VY962ElsQU5oLRiQEF3e1ysxTDmaj3RtCmS4mJUM4pAuIDUXI+MZiFtiTL+FXr6BWDC/FmgDDSdoAcTmRwDFaiq2KnvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017417; c=relaxed/simple;
	bh=wxUq5/+zFED3PwYMGEUHbaMBbiL1ADelefSJnSj5UJM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfnmK0jQ5/j3JQK7sdgkBQGKFbEq+lIBJDDEnMsTAeFNRKCn4znmWEnAMdKhS3h4kAW5Esu9CdBD4eZGT9xSRxyHOzQcVAfsN8YWqtCNjId17kMmfRtXBN3HLoIOkvmspR9mDujzch/xKzTK5utlSIWxijPIZBHBI8820U/Z/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=s+dUci+k; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 65003C001C;
	Wed, 26 Mar 2025 22:30:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 65003C001C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743017411; bh=eX/lMVrNqZtD4hep49X7pN5UAacbqvZzpjPz6T7IxOE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=s+dUci+ktO7iPhJ0NsGmw1iGBX6M1hSzOXl7Of69FJLNcRPUjkzoH+s43wqjzzKPE
	 lFg/WpdI0gUQj1qUsqRhzRF73HBExwBiCnPHJGotpYvwOXVMYcbeHFqpy04WXi2Gtn
	 JaDYyqYoTU3fTVgWLcN7Fd9AOlx3rmxU/ZyANTSzfK/4J0dKuCtzzI/qrspRV2oXW5
	 GmjsB56718Bjp8R63d0py949EKX/3cE2fRiwRui1qcJxJ1KI91IJMNFChe6OhRe3m+
	 SqJAycS4TEqr/SlDYfAF4B0jXjlOa0rsgLDC5kMan/Y9cNGJJB8lLKe4QBRABnprZm
	 o6FV01oUj1uuQ==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed, 26 Mar 2025 22:30:11 +0300 (MSK)
Received: from localhost (5.1.51.21) by mmail-p-exch01.mt.ru (81.200.124.61)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Wed, 26 Mar
 2025 22:30:10 +0300
Date: Thu, 27 Mar 2025 00:30:08 +0500
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>, "Andrew
 Lunn" <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH v2] net: dsa: felix: check felix_cpu_port_for_conduit()
 for failure
Message-ID: <20250327003008.cb7282960ade3c1821702c31@mt-integration.ru>
In-Reply-To: <20250326192259.e3m7ydgkeo2ix6wb@skbuf>
References: <20250326183504.16724-1-v.shevtsov@mt-integration.ru>
	<20250326192259.e3m7ydgkeo2ix6wb@skbuf>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64--netbsd)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Prob_CN_TRASH_MAILERS}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.200.124.61:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192129 [Mar 26 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 40
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/26 16:58:00 #27827169
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

On Wed, 26 Mar 2025 21:22:59 +0200, Vladimir Oltean wrote:

> Hello Vitaliy,
> 
> If the bonding interface has no ports, it is not a DSA conduit.
> 
> See the logic in dsa_conduit_changeupper() which, starting from "dev"
> which is known to be a DSA conduit, it looks at info->upper_dev which is
> a LAG device, and calls dsa_conduit_lag_join() when it is linking with
> it. Thus, the LAG device (info->upper_dev) has at least one port: dev.
> 
> Also see this comment and walk through the dsa_conduit_lag_leave() path:
> 
> 		/* If the LAG DSA conduit has no ports left, migrate back all
> 		 * user ports to the first physical CPU port
> 		 */
> 
> Given the justification provided thus far, I don't see a reason to merge
> this patch. The "somehow it fails" needs to be a bit more clear.

Hello, Vladimir.

Okay then. Pretty clear, thanks.

-- 
Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>

