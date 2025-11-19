Return-Path: <netdev+bounces-240106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F33C709CC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CA3632F768
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C84311C06;
	Wed, 19 Nov 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jb3NTaUm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF604304BC6
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576161; cv=none; b=P616iO+WVQFuRF8xAy1E87/H3bgzFUrpx8Gy/cpF4dNfq8I/1B7sRePOvm0FkTKO0whu2H3Od0XkjzcMGvnui0U4FOtlPLMMmQaT5mhiBlsvOGtBvtqyB9yqhddsXh8bfaHyDE7+55CtTTR9ELwr3OlUmUzU48FkImPBnPx1PLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576161; c=relaxed/simple;
	bh=+3xD6tKp+kdiCuI/V+/075Xv80or8BYIgOBRu17SCw0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Cx+iTh/0Tc0kC7iNV+KKJzhl9EE1VpdFfTbjWqPwo/ydLOsas2maN8pX3k6baT2eNBM6Cau9uqZf8q4TRxPPsbNSYKqO/5pLnFLpBtAp/NnI9MD/uq9ymMu3a6LjQ8+kkeKu7IcpXN/u+KA398Uv5KFInA/UjKKjm17bTdkfA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=jb3NTaUm; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1763576138; x=1763835338;
	bh=zFoXHkgO3zu52qHR72Q8R5DaIzCp5Od2Sa9g9H0NTxY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jb3NTaUmhyS7ehONoZ2hNWYQjiX91bus0X+KM37yHDg67QlFrOcTf/fivWwtzRc2X
	 K4l7UjLqSuMhDUeIt8Cm804OPYLLFhX4YB6I2lUUuuXpiX0g2TCrwj9RuKOpeZPZf+
	 TP5/CO6x/8U3NJFyME9SDKEmZ6pegzLg5KnJ0oceMuYGuUK2DLntvIa9ONa2iC/i7/
	 UWovWVozWSW1NnFkOwiOSFLAA9mwPS9YwbLWAXUtThFrYEdYQ2BmFOGj2chrT4zYZH
	 ShBRSFqo02vp13HD1H/akLb94o2HFJLNCGLWNE6JvrCxiRjWpuDGbzONzs7BmbBbzI
	 wuAWau/EVzNyw==
Date: Wed, 19 Nov 2025 18:15:32 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH v4 0/2] doc/netlink: Expand nftables specification
Message-ID: <cover.1763574466.git.one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 92db7f8a2e9f860a1ad935c0dc1defbc41b569d7
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

v4:
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

Remy D. Farley (2):
  doc/netlink: Add max check to netlink-raw specification
  doc/netlink: Expand nftables specification

 Documentation/netlink/netlink-raw.yaml    |  11 +-
 Documentation/netlink/specs/nftables.yaml | 658 ++++++++++++++++++++--
 2 files changed, 619 insertions(+), 50 deletions(-)

--=20
2.50.1



