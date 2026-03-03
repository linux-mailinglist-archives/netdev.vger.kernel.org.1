Return-Path: <netdev+bounces-263428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLdCGuNUp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:38:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBD1F7A3F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C15130620D5
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB803932DC;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn087zih"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C713932CB;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573920; cv=none; b=lpf4IOpT3RnSitUTL2/JlrkKij4w9q+yiCy9o0l9Kr01oeVYEUA6xZCT5l8Z1/N7kdg+0HoExsMgplz8ku0k/O31IidwfV1lisMKJPD5MBpe4+gJZTbWlbnpZWAIAh3AyxJIKYJ+faqCmBz6nvuSgXDtr4x7bwVzePQ9/gw11Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573920; c=relaxed/simple;
	bh=AjH7WLa9bAhWMALSAH3NuMvfF6ECbIBSXWNf/e4MfJg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j+mI4hnR3mFKdimbZPq8ItEnzHzQvLhHyREJQeLVue2skxiBHNUV3uA7jyHiufkbNyi4m0kNrA+joZdX2UINS/XxqrfyNC/8HT2UcBintYYd7GdTEPcZp9+PEwAlzcZCVtBoFH3ruEOYGUvxU2z4VUSiWTejCrPqsLkl6qJrB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn087zih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EF2AC116C6;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573920;
	bh=AjH7WLa9bAhWMALSAH3NuMvfF6ECbIBSXWNf/e4MfJg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rn087zihY75Rgf6dJNfes7sHjzjTudtvvIhJssC0bBLqQZz5LZEwh5H9/94J9j3ph
	 5ROujE48IFsVEGemtSYZB2Fadxbs/ADGiyLG/ng/90LwYK5pBHsuuNcIBhqCFfH9s8
	 U37PifeiziEAFNt9CL8zAEiohEpyTizE7CUIlMAV8a7XNBq3PGmNm2MHUwl33dIecR
	 vKqT4RVIjcxOnnVYp60I6jbEVoRs2obqpnA0gRAr1cE5LvlUl1J5Bt1To8zhkGbM9Z
	 Z2JNkcqeQyR2Yl7YSUOFb5AMOrGZK7EB1Xr83XAwPpxmU0SFAi9FIRHNsRkiidTpkD
	 kNJdbdsYezYpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7E0EDEBED;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Subject: [PATCH 0/2] Fix typos in comments in Intel Ethernet drivers (igb,
 igc)
Date: Tue, 03 Mar 2026 22:38:19 +0100
Message-Id: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNj3dzE4pLUIl3DVEtLSwMLSwvDpGQloOKCotS0zAqwQdGxtbUAojo
 o1lgAAAA=
X-Change-ID: 20260303-master-1e99908981bc
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772573919; l=656;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=AjH7WLa9bAhWMALSAH3NuMvfF6ECbIBSXWNf/e4MfJg=;
 b=L/lPOvYciaiOzmbZFaB9ATg9XQKiN5iExZe8cRlu0nHygPOjY8Zq026P5Nt/nThTqABdnRJ0g
 Jt6S6R0m4IIDygn/0pWWTORonyao+CMPl5iUbD3KSErd876dkCdcEuE
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com
X-Rspamd-Queue-Id: B9FBD1F7A3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263428-lists,netdev=lfdr.de,maximilianpezzullo.gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[maximilianpezzullo@gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
Maximilian Pezzullo (2):
      igb: fix typos in comments
      igc: fix typos in comments

 drivers/net/ethernet/intel/igb/e1000_mac.c | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_diag.c  | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c  | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 4258db5c0acd08e795c78c7cd59f05860b7cb769
change-id: 20260303-master-1e99908981bc

Best regards,
-- 
Maximilian Pezzullo <maximilianpezzullo@gmail.com>



