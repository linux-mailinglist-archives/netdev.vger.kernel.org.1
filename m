Return-Path: <netdev+bounces-218429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A2B3C732
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 03:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FF15E7FF2
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4DD2153E7;
	Sat, 30 Aug 2025 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="G1l53QnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBF2033A
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756518650; cv=none; b=DDEZ4xolxA6DjffGB85ORD3yGuhnW9JlL8G0Xe/DD3ID5kB+CDfVWwgxn+jrdF3AnElLh0FrDIUerRSfZ3UDrFTlhrIKGIhAYR/qGJQ8O85hKc2Re4//BwZA8nKxi7l3T5luemPC2c1zXuSChQkfIYGUa6oKDbzMXm+wKMzR6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756518650; c=relaxed/simple;
	bh=kghbucUVWbm8nuRENJ+imfC/yzEi0iyEfATOQCijztw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ljlzdy0Uqe+3yGm4Ffn1U/SrRscLSW6O4zMo4ZOlzOIduDXQGO3WovJOxrv0yTLkwusatLRWxp/UgLOnwyB/HxmAT2H/3BDDVp28dWndyQuRQ1PnvThx7bxDJTydxH3jK6fFFOay1tfhnh8hGitOtLzsg/CS3BdyoT7ILIONQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=G1l53QnX; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1756518638; x=1756777838;
	bh=kghbucUVWbm8nuRENJ+imfC/yzEi0iyEfATOQCijztw=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=G1l53QnXCBlnmHWMPqG1lmKBTzBAeSkgwvetQoQIE9AJ0OFTqYqjz+PJLHrZP9+Xe
	 SUVv3vUnKOC8eENBVQD01UUU/5wC83Z6eQtQuaDH7zzTrSUhsI1GNuifRn2uMcd65V
	 K0NA0AXptaQ2cScIws2VxhqhjK/SoIFPVL6u21fvt2sTC3jwkgs+5HpBbY+mJzwmNP
	 5+vmd2n5VyUoFrcP8adIdiOtIq8WrS3BliUnluO7p8BqoAS064Z1lvdIcks2PTXr+u
	 SzjrRhu0IW41W+RBi14NtO+1pIFQwtSs0v32FsDjWKKhvA07U+XOad7jLAWTln6Uwb
	 +yvPiEBx73KPA==
Date: Sat, 30 Aug 2025 01:50:34 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: "Named T. Relay" <namedrelay@protonmail.com>
Subject: Cannot select IPv6 in menuconfig without including IPv4?
Message-ID: <O0MpigXMo6xF3ly3-KV3Lt1jwRZGyYlHwz-qHmca6gSgqS20WcZhnoUYpW_hGaozLSYOMAyo3jfvTKPvYkBP5ZVgTNf58WW3rpoSG1nzlrE=@protonmail.com>
Feedback-ID: 19840174:user:proton
X-Pm-Message-ID: 408732fefb2f1a0c3e1a47a749614688be3f2608
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greetings kernel people,

I wanted to compile an IPv6-only kernel. That basically is a Linux kernel
with only IPv6 networking support. However, if i want to select IPv6 in
menuconfig, i am also required to include support for IPv4. From my
understanding, IPv4 is not a dependency of IPv6, so it should be possible
to select either of them independently. Right now, this is not the case.

I believe the inability to do so is a bug.
Woud it be possible to have this fixed?

While this is not of high priority for me right now, it also is also not
something that can be delayed indefinitely. If someone can take a look
at this sooner rather than later, that would be very much appreciated.

Thank you and have a nice day,
Named Relay

