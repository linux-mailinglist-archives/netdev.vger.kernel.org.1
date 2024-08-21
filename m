Return-Path: <netdev+bounces-120470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD39597E8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8474228401D
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E851BA285;
	Wed, 21 Aug 2024 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScxUpvDk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AA1BA27E
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230014; cv=none; b=V2oAjm9RYUfbqywIj3PFEnh/Bkmss+FA0EMOBY7+wT8mQg3HpF+woDt82/HpjIiF59Oc7eABzIi3GpJiZdhlgPnOsNXRGUJGDGgwWEGZUVuKoY7ip52FnPrv7DjRuRtxJA3QQ2v/SNThY0wWzta+u1ylSKrLMN2JZqo7S3FI/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230014; c=relaxed/simple;
	bh=T9lkho/vKYy7rjGfIPXPBgoEClB/ES6Bv7rSqDdhTW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G6aj8jDiF8X1vBu0zO6mm49X9MWCoEJ1KliWeyPR/6M11KLx7unhO3AfbHVC1KCsVvj7AURVx6DAEnegEW531eoAWg6wagB6LCiPaLphE/lKQS1OmkOA0CSgskpEAfFDHwyDv4h0E7W8h5PMM6s1zR213xEgql61jVMwU3iDQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScxUpvDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F49C32782;
	Wed, 21 Aug 2024 08:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230013;
	bh=T9lkho/vKYy7rjGfIPXPBgoEClB/ES6Bv7rSqDdhTW4=;
	h=From:Subject:Date:To:Cc:From;
	b=ScxUpvDkYlSvHgP/1Gqv6JX3Jfr8ycDXrYhIv2SiJdFZ8jeCAz63O7nrZF6swVOjM
	 WPNwpXcQv9R8LfggxHik+5x9jd3tF86IacsenVi4oztVKXH0E+Ivjwt0RXVu5XnZqk
	 xHhOeavloEnVufTNRW+s6nffJ+yGaBIGkLPWVXJzzo26wEcvKEq3DQKTpvw+p9/3zG
	 lr3iaqR4xs38j5aXcWQmvRTAEGdCa5NVCHBNzVoX3iUkXtl/m6tttKBR8NNdc0McTt
	 fVJxerkKBndTjcsn3tiaDgdSGCy1PqsezKS80UAuJyk6Oy6TeRHkDkG5xEC7GiVF/5
	 sJC0VaJXCs0uw==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 0/5] MAINTAINERS: Networking updates
Date: Wed, 21 Aug 2024 09:46:43 +0100
Message-Id: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOpxWYC/2WMyw7CIBBFf6WZtWOAYH2s/A/TRYGhJSo0QIim4
 d8lbF2ee0/ODomiowS3YYdIxSUXfANxGECvs18InWkMggnJLnxETxnfPqO0QkmhjD7NHJq9RbL
 u00sPaBJMbVxdyiF+e73wfv2FCkeGZK9yVPKsycj7k6Kn1zHEBaZa6w9+N3gGpAAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Hi,

This series includes Networking-related updates to MAINTAINERS.

* Patches 1-4 aim to assign header files with "*net*' and '*skbuff*'
  in their name to Networking-related sections within Maintainers.

  There are a few such files left over after this patches.
  I have to sent separate patches to add them to SCSI SUBSYSTEM
  and NETWORKING DRIVERS (WIRELESS) sections [1][2].

  [1] https://lore.kernel.org/linux-scsi/20240816-scsi-mnt-v1-1-439af8b1c28b@kernel.org/
  [2] https://lore.kernel.org/linux-wireless/20240816-wifi-mnt-v1-1-3fb3bf5d44aa@kernel.org/

* Patch 5 updates the status of the JME driver to 'Odd Fixes'

---
Changes in v2:
- [PATCH 2/5] Add to SOCKET TIMESTAMPING rather than PTP HARDWARE CLOCK
  SUPPORT section.  This seems more appropriate given that
  include/uapi/linux/net_tstamp.h is already in the SOCKET TIMESTAMPING
  section.
- [PATCH 3/5] New patch. Use globs to match files in Networking sections.
  As suggested by Jakub Kicinski
- [PATCH 4/5] Dropped net_shaper.h as it is not present upstream
- Link to v1: https://lore.kernel.org/r/20240816-net-mnt-v1-0-ef946b47ced4@kernel.org

---
Simon Horman (5):
      MAINTAINERS: Add sonet.h to ATM section of MAINTAINERS
      MAINTAINERS: Add net_tstamp.h to SOCKET TIMESTAMPING section
      MAINTAINERS: Add limited globs for Networking headers
      MAINTAINERS: Add header files to NETWORKING sections
      MAINTAINERS: Mark JME Network Driver as Odd Fixes

 MAINTAINERS | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

base-commit: 0d76fc7e27b2097e18ee128e484d107ed6d45e88


