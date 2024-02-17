Return-Path: <netdev+bounces-72611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF2858D14
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 04:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C72283D5B
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 03:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40CA1BC4C;
	Sat, 17 Feb 2024 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Qw1u3i5Y"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C918E02
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708140747; cv=none; b=h5afnGZI7HSMIcw0cmTupQeo/K/ovm8UMuAbldyggC+8pwDsTMzgSXT18IO1pd34su7kD45FuR7fN7SBOy3Zv8ghBES/t1BJo9Km3jHa6CwxxVUtIgoO9pjs39tRW/FFOP0JZrEe+x7kQUgiFfAZYQprbH/4YA4D0M47eOA0J/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708140747; c=relaxed/simple;
	bh=KwnWiWgBLK45ipQm1LvA4GS8zCYnWhhLyR9RnXg+/js=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WapbiCD0HrWhoF+af8t589AEeymov7Dd19GF2sxiie57yUnBMW/58+t/LqiK+ezC48BmXjjmOm5IXYKTGVhmTBBAAi4WFpPqYxWfLmJxadpgwaoC3wNoz/f889NmrXzG3e9d16oHIBsQnkSoOv21uFvdDjRj9PxuZLV61AnSBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Qw1u3i5Y; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8C8B820075;
	Sat, 17 Feb 2024 11:32:22 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708140743;
	bh=KwnWiWgBLK45ipQm1LvA4GS8zCYnWhhLyR9RnXg+/js=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qw1u3i5YnZ4HSz97Q2bwmaAaShO8K3tV2u94Fq583+8YYf7WPWNIIonz30xDCQNHS
	 G2Ldld/gQ+ESFfHLnlMB7dS9l1LHV4EvvpEDgFjOkuGLR7VDJzYuVCvHU98XfYVdi8
	 eGiDxHFZbeT1BJVnKF6TDUdkO50wBWeG6RHiYuSjk/rFvTY5tDAi4qg04vPxBrHH5c
	 m9xCebhR4umwSk5ODmnyYNTigxE5Bam9p82cpsn87EVcQwgbF/R57qWezv/mJSorKb
	 HTbEZpyt80MuhHonCETSEpwr7wSRKu9c7zbso3EWbhOQsI+JFFlXKJkRbH0Wsk1K/u
	 I/1gvb6WbyxOA==
Message-ID: <f2162cfdba3d388a94c6e8f66bdc899f1a2ca6c7.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 10/11] net: mctp: tests: Test that outgoing
 skbs have flow data populated
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Howells <dhowells@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Liang Chen <liangchen.linux@gmail.com>, 
 Johannes Berg <johannes.berg@intel.com>
Date: Sat, 17 Feb 2024 11:32:22 +0800
In-Reply-To: <20240216062304.2c3428d9@kernel.org>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
	 <73b3194049ea75649cc22c17f7d11fa6f9487894.1708071380.git.jk@codeconstruct.com.au>
	 <20240216062304.2c3428d9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> > +static void mctp_test_packet_flow(struct kunit *test)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_skip(test, "Requires C=
ONFIG_MCTP_FLOWS=3Dy");
> > +}
> > +
> > +static void mctp_test_fragment_flow(struct kunit *test)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_skip(test, "Requires C=
ONFIG_MCTP_FLOWS=3Dy");
> > +}
>=20
> These two get skipped when running:
>=20
> ./tools/testing/kunit/kunit.py run --alltests
>=20
> Is it possible to make all-test include the right config option
> automatically, so they can run?

Sure! I assume that's just a matter of adding to all_tests.config, and
getting the dependencies sorted. I will send an update shortly.

Would you prefer a v2 of the series, or just that one patch?

Cheers,


Jeremy

