Return-Path: <netdev+bounces-263623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLo6Jpvdp2kMkwAAu9opvQ
	(envelope-from <netdev+bounces-263623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:22:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 046721FB89E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 383473018AC9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2D3537C5;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFjVtNVy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13F34D385;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608917; cv=none; b=ay/EEOOi9xxXDeeP8eebcGn+cEeg8OBOZUl9MFI26DkhcPDXi5uf2+rFqceHBHdktooid8Ubf+K67qGM0Y6o0+FXSNbcdpHJx6tZM6oFsqRHArCwIftjNxSYFFmjKWbSBKiUJQ5hT/+y2XE7tNLoaqVArifbFs4NeFj97+LZaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608917; c=relaxed/simple;
	bh=rqm1hIKFXnYB5F1diGKPD+DC9avHWqfyIaJZ3phGQak=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ej6glgEBIDsrtfYwGwbFeIhhE6mUuXBSY0ExT/N5KFmrqiWRYu9f8kJNC8tAlmZBInwR6+e+8e9adoMXqXUyFCiOuVqlmEXCBnAPsxwOL6EFtPYas36rKTkntjwvWXN25wDkA/e2Rrb1Bq4+yRQ787GbC0hlatwazwJ2drR/T7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFjVtNVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7035DC19423;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772608917;
	bh=rqm1hIKFXnYB5F1diGKPD+DC9avHWqfyIaJZ3phGQak=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EFjVtNVyr9P91dwDw6fBSnxhY9/uQ1KUl/I2b6zgolUX95XdIsvGk50btt0DzglTs
	 IMSFvem0Pe2QF2Mxr1/UjtnkkmM5gYZs5p/IhXNVTgCBHFrQZgzz/rOXRLIvpZWbGN
	 boLr7X0+eVMgSANoPrJ1g9Cl76EERzXEMelhvTLwDt3zbaYAbQO4Ky6B6195Vs59CZ
	 682+p1tX3FGVohvFO68bL793nPU9mXvdeX3P4rnydzGmD/MMLjeHdx0li4/cEag8GX
	 sAtPBRZkes4LMeVYyJcmLD2kOzsgkTze+TsWA95z3UuKwJ/pzPhofcxsffgX+EDW5R
	 MFWfl+KOzBQxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5978AEDEBF7;
	Wed,  4 Mar 2026 07:21:57 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] Fix typos in comments in Intel Ethernet drivers
 (igb, igc)
Date: Wed, 04 Mar 2026 08:21:18 +0100
Message-Id: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqDMBBEf0X23IUQQ6X9ldJDk6y6UDeyCWIR/
 72Lh4F5DLw5oJIyVXh2ByhtXLmIgb91kOaPTIScjcE7f3e9Czjyju23loosmMqykLSrszT6IrW
 ZVKhhVt5IbZmiJWEfw2OILo9hyGD2VclU1/PrfZ5/iTsfY4kAAAA=
X-Change-ID: 20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-3b497b0df47d
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joe Damato <joe@dama.to>, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772608916; l=1013;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=rqm1hIKFXnYB5F1diGKPD+DC9avHWqfyIaJZ3phGQak=;
 b=jGLaa1WXEILpn8rGbNZrfHas9wq6FwGnb0CbwLp9lSUNsPN3/058qUyC7++bGPw7K1sgWQRmm
 5uUvoYTwCdADv8y8Mi2qy30t1bf7xB0s9WLxX1ycQNn88z8rC5f/MhL
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com
X-Rspamd-Queue-Id: 046721FB89E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263623-lists,netdev=lfdr.de,maximilianpezzullo.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,dama.to,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[maximilianpezzullo@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is v2, adding a typo fix noticed by Joe Damato in e1000_defines.h
("Device Reset Aserted" -> "Device Reset Asserted").

Changes in v2:
- igb: also fix 'Aserted' -> 'Asserted' in e1000_defines.h (suggested by Joe Damato)

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
Maximilian Pezzullo (2):
      igb: fix typos in comments
      igc: fix typos in comments

 drivers/net/ethernet/intel/igb/e1000_defines.h | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c     | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mbx.h     | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c     | 2 +-
 drivers/net/ethernet/intel/igc/igc_diag.c      | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c      | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-3b497b0df47d

Best regards,
-- 
Maximilian Pezzullo <maximilianpezzullo@gmail.com>



