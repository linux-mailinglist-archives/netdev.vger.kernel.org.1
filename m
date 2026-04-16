Return-Path: <netdev+bounces-279096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMb5A3wY4WmmpAAAu9opvQ
	(envelope-from <netdev+bounces-279096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:12:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 944244126B3
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C653037410
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4730B529;
	Thu, 16 Apr 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iInMvlMy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63AD246766
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359447; cv=none; b=k4eYFb5uQ3A2jePHihxZ2GNXMBMfrieE2dXLkzskF6on2QwUib8tCa+WPn/+OvRAMRl+vEpvz+Q8sA/OrrD8jrQmsshYYP9aKjtsY+cMLTMg2wR0U47gaixklTFpaVTWSL/b9ZbuXEk44hEmYJJpKcKrDZ+AEViVWC3F2oxsUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359447; c=relaxed/simple;
	bh=wk6CYLT9eq8gr3G+eIZXK4Z215gbB54QboYYP0yZNKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P4J36D4EgSEIJitPARh1Vh/tTkUFYh1yx5OJ2WiJSQ8Qk1v+brwUC/C52R/hV1Gt/KktJBVhHlHTTriC4iyRN00DeVEYIH5ed5ndCOihiIDPzkFSBmnauoaELawlUscQm2b6TJZkx7aKu3V6zLnzkw90NS92whfu0WA0MTyqQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iInMvlMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAB4C2BCB4;
	Thu, 16 Apr 2026 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776359447;
	bh=wk6CYLT9eq8gr3G+eIZXK4Z215gbB54QboYYP0yZNKQ=;
	h=Date:From:To:Cc:Subject:From;
	b=iInMvlMypBwKu8HGhVkhomaBrOsq1mgs/1aL9e67MyDwYLwG3AeRPMC51DYLod3Xb
	 drt/wE0ZX1+CGvBSkdyZSB36zUoSKUHokYceeoBoLK/wfGrJE4j1ta5zB3/jkB6JZN
	 Ck9rG5v68Uja9th7Oe+0R61e7kunuO40RVHl3Wm04Own77j8EzCjQKkTJUQtbpV5hi
	 ib8XYntEybCTtnHHK70OzJ0Rd/N7b3d09RD0axhNfzedufHUzmRMPmXdHYMusQ9ZFm
	 HS1SwwpDl5AfG8d7EVYRch4bZrALlr8fEUs+JD3r/l1mmaJ4k7gdBLZOu0X4tTcXDU
	 FAaKOH1CiZwCA==
Date: Thu, 16 Apr 2026 10:10:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Thalmeier <michael.thalmeier@hale.at>, Raymond Hackley
 <raymondhackley@protonmail.com>, Michael Walle <michael@walle.cc>, Bongsu
 Jeon <bongsu.jeon@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark
 Greer <mgreer@animalcreek.com>
Cc: netdev@vger.kernel.org
Subject: Path forward for NFC in the kernel
Message-ID: <20260416101041.4c533306@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279096-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[hale.at,protonmail.com,walle.cc,samsung.com,kernel.org,animalcreek.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 944244126B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi folks!

We are struggling to keep up with the number of security reports and AI
generated patches in the kernel. NFC is infamous for being a huge CVE
magnet. We need someone to step up as a maintainer, create an NFC tree
and handle all the incoming submissions. Send us (or Linus if you
prefer) periodic PRs, like WiFi, Bluetooth etc. do. If that does not
happen I'm afraid we'll have to move the NFC code out of the tree, 
put it up on GH or some such, and let it accumulate CVEs there..

I'm planning to send a PR to Linus to shed the unmaintained code early
next week. We need to have a maintainer established by then.

