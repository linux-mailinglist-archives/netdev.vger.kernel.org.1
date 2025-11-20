Return-Path: <netdev+bounces-240432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B001C74FDC
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 739FC365A09
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73DD364032;
	Thu, 20 Nov 2025 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ED0zFn4U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9E36403C
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651937; cv=none; b=uxHme5Yc0BQtFYV6vElqwgpvg3JkYd3UMyjJbTy8100Cx67pbeAujECHQnUseJ/6YVTaXR533Ye+Be/cCioyph37z3nUyjHBCyj7DhcSnf86P/e+UuuuISFD/vjUDb5RCpH+3WsD5C9q3HbhOhHCyW2+t0WB0cQpo6IT9+lmKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651937; c=relaxed/simple;
	bh=ga/ylwTfIbOxh/mMnl6r96V6WEmjetu1+5m97/n3UPA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WtlDmHUQA+LgolL3+UauqNWhKuqqhBJh1GrThxHwOM7qZSshtcX2WVSwo27a+l9qQlFnNvJV2o7Xa4FwZ48fcx/fLmcZx/S9ZOvkUm3GdQSMVURIFsbsdAF6cqge1YDE5MAPvRORoEU/nASg9DAVXpEb2JWyfuv2Moy4o8VME4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ED0zFn4U; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1763651927; x=1763911127;
	bh=EJwU/BjWhyfPG7QmP4FViJ7bQSf3HiQXggFyBGL0WIQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ED0zFn4ULVAZWhxbYZLXSBiD+BWGLyh4/L5B7/eYLEqfRSyiXdbkHRrtjcs6skuaO
	 Yag97AoPS060Rx6iHCSJs0wiI2QBhH8LkmdVt1VwrnFHh4U/rtJG/4nKG/Yu8MLaMb
	 og6sJeKpKEyPaELLeMrHEUcrG7UzkVzbw3krlE8oH0QNd/K7qoANVfhf1Xe4Tk1egu
	 9MK/jrQs3sRHp5SRKmaSiNZr+8fxB0x9qKTFjpic/hdsNKPXao4F2RDhEyz4aTi/Mc
	 aPgGP2LR3K9bL8IBDeVtgxcSqW2p4Snr9+bZXuNJli1xuPeKGCulVffmZdu+kmAQQo
	 T7DyL3JKRqUmA==
Date: Thu, 20 Nov 2025 15:18:40 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH v5 0/6] doc/netlink: Expand nftables specification
Message-ID: <20251120151754.1111675-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 6bb83a766f93632f4dce9c79fa87077729812c2a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Getting out some changes I've accumulated while making nftables work
with Rust netlink-bindings. Hopefully, this will be useful upstream.

v5:

- Fix docgen warnings in enums (avoid interleaving strings and attrsets in =
a list).
- Remove "# defined in ..." comments in favor of explicit "header" tag.
- Split into smaller commits.

v4: https://lore.kernel.org/netdev/cover.1763574466.git.one-d-wide@protonma=
il.com/
- Move changes to netlink-raw.yaml into a separate commit.

v3: https://lore.kernel.org/netdev/20251009203324.1444367-1-one-d-wide@prot=
onmail.com/
- Fill out missing attributes in each operation (removing todo comments fro=
m v1).
- Add missing annotations: dump ops, byte-order, checks.
- Add max check to netlink-raw specification (suggested by Donald Hunter).
- Revert changes to ynl_gen_rst.py.

v2: https://lore.kernel.org/netdev/20251003175510.1074239-1-one-d-wide@prot=
onmail.com/
- Handle empty request/reply attributes in ynl_gen_rst.py script.

v1: https://lore.kernel.org/netdev/20251002184950.1033210-1-one-d-wide@prot=
onmail.com/
- Add missing byte order annotations.
- Fill out attributes in some operations.
- Replace non-existent "name" attribute with todo comment.
- Add some missing sub-messages (and associated attributes).
- Add (copy over) documentation for some attributes / enum entries.
- Add "getcompat" operation.

Remy D. Farley (6):
  doc/netlink: netlink-raw: Add max check
  doc/netlink: nftables: Add definitions
  doc/netlink: nftables: Update attribute sets
  doc/netlink: nftables: Add sub-messages
  doc/netlink: nftables: Add getcompat operation
  doc/netlink: nftables: Fill out operation attributes

 Documentation/netlink/netlink-raw.yaml    |  11 +-
 Documentation/netlink/specs/nftables.yaml | 687 ++++++++++++++++++++--
 2 files changed, 647 insertions(+), 51 deletions(-)

--=20
2.50.1



