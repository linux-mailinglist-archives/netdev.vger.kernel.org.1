Return-Path: <netdev+bounces-119191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D3D9548DE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231431C21886
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211A9196D80;
	Fri, 16 Aug 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgjM+9F7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087A16F839
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811907; cv=none; b=S5pGWYIx8c5YujTeSoKm+lcmsd0qvshNTZlMQvCxlzffvLWFIMcjhlbv3JWrMUQ9biQMQYMWpSXV2a8Agte2rFMD1tWn2z8AJ2snLfKmHNYljM67Kbu47YFwhIZJCIcL0nSeQrnaKLAsMx6WH2QqvD1NLteOjWM83jh1tnhVP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811907; c=relaxed/simple;
	bh=SqqFc2cprXAmj16QNDwtNjWlLNvSpvpq4PrwWH9zzU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SUwqqULpieTEnePZKV5Jrisorx5ceeGX3Lh9dzhEeEQ6GVDSujbZK79m4/eleVAtUVD6s7D8+ayGsMCTNIt46GuzKke2m1DqXFyfDkYmiSu0nlZXSbI47xEWqTDsu1eF8CwjOg13RVBxuU7L3KxloOT3B58CDKuJw35NblXAR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgjM+9F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68445C32782;
	Fri, 16 Aug 2024 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723811906;
	bh=SqqFc2cprXAmj16QNDwtNjWlLNvSpvpq4PrwWH9zzU8=;
	h=From:Subject:Date:To:Cc:From;
	b=FgjM+9F7OfXG5W97ZktVJdiwzODcpUwOjjou+3ke+XCqLG/KCliRA9s9OQFm0sjZm
	 HjXzDLs6a4UJUV/ivYG4H9fcr3cgwgyvNg39AkFcR73mXqibC7xul9OcUZXcl5lCmn
	 yRZH+Ume6cNrXxJGr211594X8L2d7KzGaMiEApeBgybWxuOHuvOCZHdyvCREucTTPJ
	 lPIB1B9v03iC1VAyNDqHbNUsVDdKsxL5+dcDnGtWSRZBq+GPB3+MD13KpK9YoEEAnR
	 3WEdN9zJ3GKRPVtQhDJJmFQdr/intmw0NFT7xK64/ri43p7Rjmm5JXWXwQxnuPXkqO
	 J/ejrnf5+ghxw==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net 0/4] MAINTAINERS: Networking updates
Date: Fri, 16 Aug 2024 13:37:59 +0100
Message-Id: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACdIv2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Mz3bzUEt3cvBJdkzSjJBOjpJRk00RDJaDqgqLUtMwKsEnRSkBFSrG
 1tQDkCQWxXgAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Hi,

This series includes Networking-related updates to MAINTAINERS.

* Patches 1 -3 aim to assign header files with "*net*' and '*skbuff*'
  in their name to Networking-related sections within Maintainers.

  There are a few such files left over after this patches.
  I plan to send separate patches to add them to SCSI SUBSYSTEM
  and NETWORKING DRIVERS (WIRELESS) sections.

* Patch 4 updates the status of the JME driver to 'Odd Fixes'

---
Simon Horman (4):
      MAINTAINERS: Add sonet.h to ATM section of MAINTAINERS
      MAINTAINERS: Add net_tstamp.h to PTP HARDWARE CLOCK SUPPORT section
      MAINTAINERS: Add header files to NETWORKING sections
      MAINTAINERS: Mark JME Network Driver as Odd Fixes

 MAINTAINERS | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

base-commit: 3d93a1448ed017f3536319a2445568b5f3969547


