Return-Path: <netdev+bounces-283596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNZUHEI+92k2dwIAu9opvQ
	(envelope-from <netdev+bounces-283596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB74B5B4A
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E8A43015E1C
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587A3B19CD;
	Sun,  3 May 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="dPwQUm4r"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C143B19C6;
	Sun,  3 May 2026 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810981; cv=none; b=pWzNgzjMLZyPgXaClLrNNGZ6isgP6dYkQZiEvFzVqqSX3aMp0meccyWFqSvPz63swxTnr0bIV1VEDFsF7WO7ZONuXsSbfzxwv8v54acH7Xj5NER68emB3DouYw76FrHepR38guLEYts11e7bz6m7ENfih5AjE+CAEHpZYGMWfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810981; c=relaxed/simple;
	bh=rVVDrd6KHlHSie/lH7b8n2cV8jhyUDO+nWJ9m1jRh8E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gOSsFkDQI8npttA+SyFAMa00uPBdbsMvd7kEpaArpmTTe6YNH3w8sUZ7iw+shM2eygD5c1iKqmIW/ONgBBlqwjSYTz3pcJlLwS77hwuovcw+G+LWC+9wbXIECAjvq7/4H9y4J5HDjREUbAAch9sUIiGIFhw3Ze63BIGRR2xReLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=dPwQUm4r; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id E17FC1FF1D;
	Sun, 03 May 2026 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777810978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JXg+3Cal2NtyoJqcb3yDaa8t1VMNblT1GtrYRFv3BPE=;
	b=dPwQUm4r1zmvSCCZACP/qOyu8qAsKjOa/a7WRloaTnqYBkOeTDFXclPnTnWwGRIkO9Hf+h
	du3m2RZ4/t/NBWQ9gbGPHknOAdFALsOyiEeGHhGOvnQJoSCOSn/G1vFr8Xr0irNYQL6i7e
	lkAxJsOL2MprkLD1LX7tIwCIsYhw6Wc=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Sun, 03 May 2026 14:22:33 +0200
Message-Id: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAk+92kC/yWM0Q6CMBAEf4Xss03OajH6K8aHFq56hlDSAzQh/
 LsFH2eyswuUs7DiVi3IPItK6gscDxWal++fbKQtDEu2JkcnE+XLamLquvSZBkP1ma42XGJ0DiU
 aMu+L0twR/OjbGY+/1ym8uRm3N6zrD+DKpc96AAAA
X-Change-ID: 20260503-fixes-followup-064092b7ff55
To: Marek Lindner <marek.lindner@mailbox.org>, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, 
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, 
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, 
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>, 
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>, 
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>, 
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=sven@narfation.org;
 h=from:subject:message-id; bh=rVVDrd6KHlHSie/lH7b8n2cV8jhyUDO+nWJ9m1jRh8E=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WSWzm5ee/nI1wvz3xSpbIrTLGMTiNUviTYQfjvz3
 rxVuppbOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATqahjZPj6Z8FmQU/9dU6n
 j6QFpss4+19M/l/ygcfBjZvBX17r0UKGP5yZYhuln6Ru5vw1ay//99OPTaZy/jLcxFm2pijlece
 CKfwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Rspamd-Queue-Id: BEAB74B5B4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283596-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,lzu.edu.cn,gmail.com,narfation.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]

While reviewing the fixes submitted to batman-adv in the recent weeks,
further problems in similar or adjecent code was identified. This was either
noticed in the manual review or reported by sashiko.dev.

Especially in the TT code, you have the global and the local translation
table. But when a bug was fixed, often only one of the two codepaths was
fixed. It was now tried to sync the TVLV preparation code between to of
them - not style wise but fixes wise. Besides the hardening, it will also
make the code less confusing.

The BLA and TP fixes are just some reference counting fixes - either
reference leak fixes or missing reference handling.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (8):
      batman-adv: tp_meter: fix tp_num leak on kmalloc failure
      batman-adv: bla: prevent use-after-free when deleting claims
      batman-adv: bla: only purge non-released claims
      batman-adv: tt: fix negative tt_buff_len
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: tt: prevent TVLV entry number overflow

 net/batman-adv/bridge_loop_avoidance.c | 10 ++++++-
 net/batman-adv/tp_meter.c              |  5 +++-
 net/batman-adv/translation-table.c     | 55 +++++++++++++++++++++++++++-------
 net/batman-adv/types.h                 |  2 +-
 4 files changed, 58 insertions(+), 14 deletions(-)
---
base-commit: 3d3cf6a7314aca4df0a6dde28ce784a2a30d0166
change-id: 20260503-fixes-followup-064092b7ff55

Best regards,
--  
Sven Eckelmann <sven@narfation.org>


