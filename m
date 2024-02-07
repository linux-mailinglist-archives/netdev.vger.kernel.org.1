Return-Path: <netdev+bounces-69977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E036984D297
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997A228B581
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC886AE2;
	Wed,  7 Feb 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML6uDrzP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463F86ACD
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336434; cv=none; b=OwvyifiGaFlv8ueOgnXEQBp5xlKczfOt44t5dStQsFW0QShb9mmfWyf0ubX0NXKUQ/gPZtLILRp4YNvRyMTlLrVRXoZAtzTumioi0anZNg7lscuZnT57bZfcF2jYY4icao3ul84hBe0iI+eNoRDuZ8rlFCseQ6mMfqzfxGbINzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336434; c=relaxed/simple;
	bh=lfrwtifSImhwrmCBPSORxgigmLNfrR29nFrEhyNqYbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKHNuyrePYI0xaK1mwfhOHLpJr5yrEhSvspL/HGPd6Nk1jixsl6mxwF6m1fmJ0J8ENZj9sADxmnUngZw0XLqZmzKGgQNfGFRhlemm6WyUHwOyPaUzqFfBqt5H3vlEheFc4NJYgJN1bMs6ZmLgm98PL7jINgftc+ThzDv/LbG5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML6uDrzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250B6C433F1;
	Wed,  7 Feb 2024 20:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707336434;
	bh=lfrwtifSImhwrmCBPSORxgigmLNfrR29nFrEhyNqYbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ML6uDrzP9jLcrylDLHVLPP3Hta7AevM30Rz+tgMv0uMPMjGBSlQme8MCDnNDYA4eB
	 Z6D2OSriRwFzBLpzLRd4Dn0zD0lDaJouaGCySKDMRZXJzsDcP8dhQusVBt6iN92NcH
	 XCigYm+Q/wfzSYxSu2zOrMocYockghRC08PceW76zjV09WTY2e78VdUPPQb0Q+kPK/
	 jc0BhzF2ZOxA2z5Se0Dc4NE2rr3Ki+CoYFyf0QAFzZgzU0cpDGuGyKFqoc5e4QXeSg
	 O1z3kRpGEVpdFqW1dKyfd0rT4nA5CDa/yF1IEIvypPETAWX50ORO0pJx9T/CME3rOQ
	 +6aATFzwM2Sgw==
Date: Wed, 7 Feb 2024 12:07:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] The no-kvm CI instances going away
Message-ID: <20240207120713.68686bca@kernel.org>
In-Reply-To: <1dddd3ba-aabe-4ad8-aefa-fd5e337c88d0@kernel.org>
References: <20240205174136.6056d596@kernel.org>
	<c5be3d50-0edb-424b-b592-7c539acd3e3b@kernel.org>
	<20240207105507.3761b12e@kernel.org>
	<1dddd3ba-aabe-4ad8-aefa-fd5e337c88d0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Feb 2024 12:45:00 -0700 David Ahern wrote:
> I have no such ability :-) I cover the costs myself when I use VMs on
> DigitalOcean and Vultr for Linux development and testing.
>=20
> Kernel builds and selftests just need raw compute power, none of the
> fancy enterprise features that AWS provides (and bills accordingly).
>=20
> The first question about who is covering the cost is to avoid
> assumptions and acknowledge the service (and costs) provided to the
> community. Having the selftests tied to patchsets is really helpful to
> proactively identify potential regressions.

Thanks! Meta is pretty great at covering various community costs.
I try to keep the asks reasonable, but I haven't been told "no",
yet. The reason why it'd be great to have more supporters is that
(at a cost of slightly more paperwork) we could externalize the
whole shebang, and give out SSH keys more freely :(

I also heard that some clouds or LF have free cloud credits for open
source CI. But IDK how I could connect those to my corporate account..

Anyway. In my ideal world we'd write a check for LF and get a bunch=20
of VMs in DO or alike. In the present reality we have AWS which only=20
I can access =F0=9F=A5=B4=EF=B8=8F

Good thing is the system is distributed. Hopefully over time more
people will join in by reporting the results (like Mojatatu does
with TCD).

