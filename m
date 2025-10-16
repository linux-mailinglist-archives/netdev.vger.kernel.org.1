Return-Path: <netdev+bounces-229988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85CCBE2D74
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CB118939B3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079612D4803;
	Thu, 16 Oct 2025 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DXh4VCqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zih8xHqo"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530932861A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611169; cv=none; b=ql49SlisrsP1MR1HDkBu67VXsbPHE+6W5iucfL27pHHfrJRP06Du47PNiStMFOcdpQgxy3qdQpvnqfL61c/b2zi/UWWSu6s3Ercu2emq8S/T3U/raqCHLavEC1cEVSlh8NrIIaGpz5wghVCBSg5UejRvEv0+6xLTE5QHq6RMgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611169; c=relaxed/simple;
	bh=i5kjOw+naUDVhuStnM2Qr9S1F77NygydvvOdcVEw/WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQearP1McKl3yY7loW9Zn7acOtCohCrPjGlc5HdvyiPH9TXnMD0m0bjOzcYPNJ0zV5JOU6NCxzgBCp6ICvZB/yotE8a4owJb9wDnNIR1imHw89VDiG7dsayNzlSs/GnxOONXk/BYLay9lr8tc3BPWPVDa7kKmM75b9vybg8Tgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DXh4VCqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zih8xHqo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 423561D000BF;
	Thu, 16 Oct 2025 06:39:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 06:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1760611163; x=1760697563; bh=TYuh/S52WD
	+i0WWcOP0oIiX5dK9Z/CW2ERG8OUMdRAQ=; b=DXh4VCqRy2yaEJHpHTiDsXIG7o
	0dpGo/dYrJfZyKEwk20F2vhZjWm9qc7gjUBKi3LLWYQYjikyvRCAyzUQlK3uNNDw
	wvFyUaj02fSfZUJ5ljKcr8smtp+9VZFC0zsQrWDuEe4GaDObEnzQH1VLvRlxY2lY
	xIZduTWUkn82oX//EHyQqsnpypMsrWM4Mc6zpk38FuJR2tryFI9AT78qhhKBCM7J
	U20HDIjf1uj2PSwxVjYtLQ/4saSX4u6tq8rmoko3XNWjnGK7l6sF/pxHp+rQKUZa
	WUMP3LyCHe9MDEQZCuZopAFsyz6sJU5x1wSuKPQBzJuGS8bsLwiCsgs+yYpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760611163; x=1760697563; bh=TYuh/S52WD+i0WWcOP0oIiX5dK9Z/CW2ERG
	8OUMdRAQ=; b=Zih8xHqoAFthgI9rnTmdWz17iJUSpAQ0l98xrSK6n6lRVmzw/WM
	5I43r6rI++v0wvp0LbQBSNfXJa4wmWZOX6bO5/2eUxphzO5l2lI7A4Hs/bIvqE7H
	XbMT7xZTYUXhtYRdCBqpnpx1jJT/P/Q3AIaDe2jN6WjwT8uUpR+pFVM1lJGD1u6T
	UF3xI4JcnT+y9b91qO7ml+vG+YjD9FTHDOqTC79LEezTlgIc6Xj38JxuoFUiW71H
	cYLK0jjdYGg/5Aw2jvMfmXdJrw/JtixcagfxonqoHVr+28gTZOjvD/L9wChWyKBf
	vzczzSr+WQaQd6++K1doVlG5JHYrOHsY5qA==
X-ME-Sender: <xms:WsvwaMfQ9HyleSMPi54VvglCLwuqiJVj6txfBLRazqNW5fE0j0PngA>
    <xme:WsvwaFqmFeM1vvb_p06z0UwYdDhtiKnlivKFQctdqshpXK87qbxOQfvdgLsJlgHui
    44OuHvPCX66KN1iL2hu5zkKb7btXC9mdtiGX68NbP6DqSNQf_m99v0>
X-ME-Received: <xmr:WsvwaK64Ir8tbh3ljvXekfJ_7GQ_cuY9ltmqVOL3CiEOrBsyBuMSXXTysbuR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihs
    nhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeejtdeugfffkeejfeehkeeiiedvje
    ehvdduffevfeetueffheegteetvdfhffevffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkh
    hlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepshgusehquhgvrghs
    hihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:WsvwaLp556DWeYLKd7S21FlG0525N0wBv-7I3bFQyBDe-l4Fort0ug>
    <xmx:WsvwaMhrxWc2gHL9gZlXa3pQEyJClW30nNxggMA321J3ib_yI4993Q>
    <xmx:WsvwaFIV1mSAD6LU0YsjIJCG_7hZVOY3ET_x1nsAyMGZkCwd88vBSA>
    <xmx:WsvwaMDJuXdq-o9pXDKgv8mkjwv8SqOB_gudUEhgivCt5WawBco6JA>
    <xmx:W8vwaBSCCXq48xBXcgcnNJ5fJ6PEQHquvqaH6fMa82h7C8rImWuyE2Ot>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:39:21 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 0/6] xfrm: misc fixes
Date: Thu, 16 Oct 2025 12:39:11 +0200
Message-ID: <cover.1760610268.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are mostly independent fixes for small issues for state
creation/modification/deletion (except for the 2 migrate patches).

Sabrina Dubroca (6):
  xfrm: drop SA reference in xfrm_state_update if dir doesn't match
  xfrm: also call xfrm_state_delete_tunnel at destroy time for states
    that were never added
  xfrm: make state as DEAD before final put when migrate fails
  xfrm: call xfrm_dev_state_delete when xfrm_state_migrate fails to add
    the state
  xfrm: set err and extack on failure to create pcpu SA
  xfrm: check all hash buckets for leftover states during netns deletion

 net/xfrm/xfrm_state.c | 30 ++++++++++++++++++++++--------
 net/xfrm/xfrm_user.c  |  5 ++++-
 2 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.51.0


