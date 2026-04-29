Return-Path: <netdev+bounces-282287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM3RFMO/8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:22:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE005491216
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75493301388B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3A3AF674;
	Wed, 29 Apr 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OQ+j08ft"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899734EEEE
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450942; cv=none; b=K2YFykQp7ip0fFLONczzmQirtZpo779jhf+EkFWXtNBGEZ+ih+Pxee4d8B1MoXtxk8f38zke84F/oMPVcMYqL0dFv4ebMQs69CLwPupEaH0sAzy8Hk773MnxobwvyNSckNFLD7yht41IdqujFUMeY+gkblqLr1WBcnpNiCBW/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450942; c=relaxed/simple;
	bh=Z8o1khY6uQKVFqNYMz9pg5w4PYc5V8+KEbdDNWNph+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ACu5lfN9kd485VgcBuT6ZLCt/FSyXpAO9mlaVRZy/2CsUIsIu9sVf/Z6ZQDnq3cs1kK5Ge1th19YdLCgsafc53xH3scHq1cKmpK3O2SfUgv9vEv2EZkKO1JDClk/ccq5RKJY384Wnw5b7T6WPdlvD4eBClB1rwAKcCAQK2JwBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OQ+j08ft; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1777450938;
	bh=tQlrRa9erfttOXuoT74PJM3yYqoign92LdFf76tC5WU=;
	h=From:Subject:Date:To:Cc;
	b=OQ+j08ftSxOCdveReg4VgyabmWJa6GIlDzeqQRHLj/ic2G8Q/RtX0/sYsenjI+9w+
	 NiR7dXpjrmeKGN0m1Z8tf6K1X69OOrZ0cwamKDkzuD7A2nSisZ1YZwTKFPZxKMUsRr
	 2302oYUDpzReRQcALmjnirSAU8sXQ4dZ6ngClk5oFh6Gusp+oaHlIfi4A40Hq1T737
	 2uSNtJJQ1mCb712hdIsiHFhBGfiKmvLGUknzpa4shY8vVqZfEsACDsWuobvjxHwgH3
	 MIHwnRafoEFluo/9k99FnWK+W6iRPccWWITYcSUHxRVP+JjjEVf93VX3yHYMX76bsK
	 SKGUjoLXucnRw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 9699860263; Wed, 29 Apr 2026 16:22:18 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net 0/2] net: mctp: test: minor kunit test fixes
Date: Wed, 29 Apr 2026 16:21:40 +0800
Message-Id: <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJS/8WkC/yWMQQrCQBAEvxLm7MBmNUL8iniIu62O4Bp2xiCE/
 N0xOVY11TMpqkDp1MxUMYnKuzi0u4bSYyh3sGRniiEewyH2nDHxK9nIBjW+yRfqru1CN+S870F
 ejhXr4OGZCowum9TP9Ylk/z9alh8dr00kfAAAAA==
X-Change-ID: 20260429-dev-mctp-test-fixes-de1505add39e
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.16-dev
X-Rspamd-Queue-Id: AE005491216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,codeconstruct.com.au:email,codeconstruct.com.au:dkim,codeconstruct.com.au:mid]

This series provides two fixes in the MCTP kunit tests - one exposed by
ktr, and one found while debugging the former on different VM configs.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Jeremy Kerr (2):
      net: mctp: test: use a zeroed struct sockaddr_mctp
      net: mctp: test: Use dev_direct_xmit for TX to our test device

 net/mctp/test/route-test.c | 2 +-
 net/mctp/test/utils.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: dca922e019dd758b4c1b4bec8f1d509efddeaab4
change-id: 20260429-dev-mctp-test-fixes-de1505add39e

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>


