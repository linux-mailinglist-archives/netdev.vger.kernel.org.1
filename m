Return-Path: <netdev+bounces-166186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC3A34E2C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B4F3A4C88
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28744C7C;
	Thu, 13 Feb 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EpF+jkv8"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64928A2BE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473389; cv=none; b=DCp1mPwwomqaEGxiTlsNfU2EdEmskibpiHduGS9c24p3sHle3SuM8akdW4MPVhM7+6GhqubEAorrnDNLycGRZVosF+hN975WgLNfnbkA2sB//vu6fHV5Yo0ZqGhXdsxUZx6qYU6tWvse3DJeizXvh215XWN1h2LT0KfQA7VUtmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473389; c=relaxed/simple;
	bh=ITWtVpqbIbaKhmEd72FwWra4+/54V+ErklVGGsCblPI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YUKlWVL1+kqUHV9CMXLwF1FHkZ1UTuSRRSGFbPJgzzPxEsSG4AemsSyHQg9Qc8NLgHmlwnEwA19iT7KmQZImKuda3hFYqDY1OxmjOOguoCopMu832QwR9j+lWavMldR8A/RJbijmSKRGoFS+4EXE7OU0gnBInlnXZXFz9bOHhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EpF+jkv8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YHJ0YDCFzk/GsSEEXAqMqagrp5jzx+9Dwif40X4lnyA=;
	t=1739473388; x=1740682988; b=EpF+jkv85Cm2tRyoFA5qeVrn/HWiGD/gDpHgLb7mZRnUt98
	fK+PdeE8VogyBogN5r+Dljk7ewDFqbEMyF/XYrsXJc/EUtgmt2kDdGEYH4v18VVU6jIjF+qCX1J0L
	Iwqz+acWCXmjvb7FOEu5p9Cj8Qb+mw+i7KEUUkvBmIMsHRbkJiQoSYd7HXbF04FHkyg0j2d8y97p7
	EzXa8ZXkDeyhVLbW5VXc9rPfcfs9syAClZ8ayI+nbCQGwSQFykJpRNNneYBNK/zZysBzhiE/kZvzE
	GYv/2NbGsP3FYBJPXuBd6uH+9cS635JvuBByqby+RoHLQ8pMmAOjCpacGmEjQs5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tieUK-0000000DYAp-2wde;
	Thu, 13 Feb 2025 20:03:04 +0100
Message-ID: <2f46c4a25fbfbc4ae6d8352426a6316a50bfa103.camel@sipsolutions.net>
Subject: Re: [TEST] kunit/cfg80211-ie-generation flaking ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Berg, Benjamin" <benjamin.berg@intel.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Date: Thu, 13 Feb 2025 20:03:04 +0100
In-Reply-To: <20250213104618.07d9a5fe@kernel.org>
References: <20250213093709.79de1a25@kernel.org>
		<dd9fa04ea86c2486d6faba1eff20560375c140b6.camel@sipsolutions.net>
	 <20250213104618.07d9a5fe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-02-13 at 10:46 -0800, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 19:22:04 +0100 Johannes Berg wrote:
> > > We hit 3 failures in the last 3 days. =20
> >=20
> > Four, actually, it seems? ;-)
>=20
> Yup! I jinxed it, it failed again after I sent the report :)

:)

It's weird that it happens in this test, or are others similar?

> > https://netdev-3.bots.linux.dev/kunit/results/987921/kunit-test.log
> >=20
> > is your serial console simply too slow?
> >=20
> > ok 70 cfg80211-inform-bss
> >     KTAP version 1
> >     # Subtest: cfg80211-ie-generation
> >     # module: cfg80211_tests
> >     1..2
> >         KTAP version 1
> >         # Subtest: test_gen_new_ie
> >         oaction: accept multicast without MFP
> >=20
> > should say
> >=20
> > "ok 4 public action: accept ..."
> >=20
> > instead, I think?
>=20
> Oh, that's annoying :( Thanks for investigating.
> I think the CI runs when the machine is overloaded by builds.
> I'll add some safety for that.

It almost feels like it shouldn't matter - couldn't qemu just kind of
'pause' the VM when the serial port isn't keeping up? I think you're
using qemu? But I guess I could also see why that might not be something
you want in other use cases...

Not sure, but it really seems more related to the output (buffering)
than anything else.

Are you using the tools/testing/kunit/kunit.py script?

johannes

