Return-Path: <netdev+bounces-240927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E2C7C19E
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A363A2D0C
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1D3287269;
	Sat, 22 Nov 2025 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcp1hdPd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E6218AAD
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775684; cv=none; b=IaYEMrhJYDuUOC2qz9HfmSsvPMp/40MFzl9dsW1iIKq/k4t5DTMI8n4Kcv3bpc0pT22WNmv7Pht5J/T8p8TH7RBWusrvZEMVu/dPc3A/mlIfT9NnntVXIrshcvrAro09vlkdg/7SVXwfZxp4OmpVSbk+xgkQTNmqAvg4RdwXzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775684; c=relaxed/simple;
	bh=1Zo4g4BnIFj0jGtAcH/LN6GTDBxI//Q9ii6jf3Jq4gY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+33jOFdk4OW1AHKUnK6tmfrKdWQ9E/6D6tWenH4UjgFSkA7qj9d5Mq/r9zuDtt9VqWd4mUO6n7lWmybGQ15Z6GNinFBloCmZp7Vxs4soks+SS7E4b+ScKeEMOebdK96mZYtgXljPY7RjXf6nKnukGh/6NqPEg8YxEyVh2ydYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcp1hdPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEE8C4CEF1;
	Sat, 22 Nov 2025 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775683;
	bh=1Zo4g4BnIFj0jGtAcH/LN6GTDBxI//Q9ii6jf3Jq4gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hcp1hdPdhWWtGYxBp8g5MbBdJxeZ4SSeUsDfZnGVL0r41LJk+wqFVkxe87WA4TVcb
	 FezLJzp2N5bxi0vzL8n5/SqCgony9VKsVkNCd1QF3UcF5v/QOJQaUD7Crxyr0ocA2q
	 5Ih2i4O4Ds1F5hBTJyzgkPLPkvjzS1w1V34O1dPG0fi2UK6JUwStwTMYAgOFtl7orC
	 OVMEx3NroU0zUKbIEFxrz1KpWTgMg8tInGB7iLYBWaV2m+vtkaGMT0dXW9qXKV8YMJ
	 EQOAlSS7/IV8kjnAl849KaqYlzpPUtbcF1HAemK0XYaOZNc7jKX8XoWLefgBligmQ0
	 IUUMAihIfkj6A==
Date: Fri, 21 Nov 2025 17:41:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v1 2/7] selftests/net: add MemPrvEnv env
Message-ID: <20251121174122.32eff22a@kernel.org>
In-Reply-To: <1cfe74a1-092c-406b-9fe5-e1206aedb473@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
	<20251120033016.3809474-3-dw@davidwei.uk>
	<20251120191823.368addb5@kernel.org>
	<1cfe74a1-092c-406b-9fe5-e1206aedb473@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 09:14:49 -0800 David Wei wrote:
> On 2025-11-20 19:18, Jakub Kicinski wrote:
> > On Wed, 19 Nov 2025 19:30:11 -0800 David Wei wrote: =20
> >> Memory provider HW selftests (i.e. zcrx, devmem) require setting up a
> >> netdev with e.g. flow steering rules. Add a new MemPrvEnv that sets up
> >> the test env, restoring it to the original state prior to the test. Th=
is
> >> also speeds up tests since each individual test case don't need to
> >> repeat the setup/teardown. =20
> >=20
> > Hm, this feels a bit too specific to the particular use case.
> > I think we have a gap in terms of the Env classes for setting up
> > "a container" tests. Meaning - NetDrvEpEnv + an extra NetNs with
> > a netkit / veth.  init net gets set up to forward traffic to and
> > from the netkit / veth with BPF or routing. And the container
> > needs its own IP address from a new set of params.
> >=20
> > I think that's the extent of the setup provided by the env.
> > We can then reuse the env for all "container+offload" cases.
> > The rest belongs in each test module. =20
>=20
> Got it. You'd like me to basically reverse the current env setup.

=F0=9F=A4=94=EF=B8=8F not sure

> Move the netns, netkit/veth setup, bpf forwarding using the new
> LOCAL_PREFIX env var etc into the env setup.

Yes to that, I think.

> Move the NIC queue stuff back out into helpers and call it from the
> test module.

Don't go too hard on the helpers, tho. "code reuse" is explicitly=20
an anti-goal for selftests. I really don't want net/lib/py
to become a framework folks must learn to understand or debug tests.

