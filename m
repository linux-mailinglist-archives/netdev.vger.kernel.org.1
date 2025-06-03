Return-Path: <netdev+bounces-194830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A4ACCD7F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 21:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E1816CD09
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685B1DE3D6;
	Tue,  3 Jun 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6ndgiWk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E87748F
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977601; cv=none; b=CYwBHcKGSFiybgApF19+yfzfWMigB2rszi+9FpKMyYEPwpqodtOlNKe/Lb81OEl7Vbrfpd9VFjqbTsjLWBV1McUIgMimJDplqO7XKXv35Rhpnf+ddyz1sfU8ldpf9O767ifOa549RHEGKsEwfrn8gPe7YlpzXhGUB/RU94DNS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977601; c=relaxed/simple;
	bh=m8WJq+i1/rq2Gv5qBegaG2ipOSurNlDXD5EIAuFCanQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Bq5ID77UT9A0uOxiOKn5wsijd7wjqu7uyxzMZMzKawJRTVyHzZvtyRUdNaV0vrxC0G+wjw4hzhSR4bVJX2WuOAQKMWX6Ww4QJlGKdr/nQY0rN9CHVEh2nbnM9HQlPSrbvW2TvXG2VS/UJF/9lLYT9+8TWf7iM7+8vt9QLamaJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6ndgiWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60C9C4CEED
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748977600;
	bh=m8WJq+i1/rq2Gv5qBegaG2ipOSurNlDXD5EIAuFCanQ=;
	h=Date:From:To:Subject:From;
	b=j6ndgiWk/1HRkE8AsRRhnWKZhKSdAQ9T6LWBr4tnHm+Lhf6ZX0SsrxT9E+2DedVwV
	 WvWn6Jf1RljE6QLKzVSWTCBv0j0TgiTZ6eUATopdSYc7Y9EVpCap1kVHPHOkKlmQ94
	 LVIO0/v+7sGG5sjgZMwrwLBlau+ge8bAZtNJD/OaUMz0rpr3jXqsnrdNeENCamgTSd
	 onkcj4j1HStamKbN7s1282dPc04M5BkBPayxhrCn/vyYN5ithPjeamCccPQ8vFChE6
	 UYp2dpwyeUttFeBsLgAkS9q9EzNfKJG2x/QB11BdChh5gM/9WRVTW9g9SBkAXRyhXg
	 xNZnnUKKdjW3Q==
Date: Tue, 3 Jun 2025 12:06:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [ANN] pylint and shellcheck
Message-ID: <20250603120639.3587f469@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

It's merge window time so I have a bit of time to catch up on random
things. I added shellcheck, yamllint and pylint:
https://github.com/linux-netdev/nipa/commit/c0fe53ae533d19c19d2e00955403fb57c3679084
https://github.com/linux-netdev/nipa/commit/255ee0295a096ee7096bebd9d640388acc590da0
https://github.com/linux-netdev/nipa/commit/54e060c9094e33bffe356b5d3e25853e22235d49
to the netdev patchwork checks.

They will likely be pretty noisy so please take them with a grain of
salt (pretty much like checkpatch). Using the NIPA scripts from the
commits above could be useful to find the delta of new warnings, since
there will be quite a few existing ones.

I suspect as we get more experience we will find the warning types to
disable, and we will drive the number of existing errors down to make
checking for new ones less of a pain. As I said, for now please don't
take these checks failing at face value.

