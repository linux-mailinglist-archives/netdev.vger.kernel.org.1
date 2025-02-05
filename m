Return-Path: <netdev+bounces-163151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D47A296E7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869881882AEE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6461DDA14;
	Wed,  5 Feb 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMELZMWq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1651DD88B
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774801; cv=none; b=IsTMGvM3x1LUgE82DzLazZQO/cMks7jdPF8s1MGvyTGi9XhCIJHr5z+ne+rVpq9TZjUvgrTcuRguBAgISxwhMfRysvtwgB+737QMn6BKVUWMbhL/Aq2ae66E2smuFmEfA1bV+S5nwiGPoqHnT+19LOTYyUgLtrfQM5vSIejvoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774801; c=relaxed/simple;
	bh=CGRl2IdB7lK5Q0NyUwhuL92d361xJ/Hg4qfPhckBM9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nR/TSJTujOtP9S2Rrx9GarrjDyIR2355+CXbQkOD68fYMsGwiFgC9NbcqRDuU1ROWUGO/hza1EFBUPzkwp3vqpU2WL6q+ocVil9WFpKmQPifYfxK633lia9/h1h34rIL6RJOLnsnP2r5mBgVMaTq1POchzVlIR4g0iNCoA6kegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMELZMWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C180C4CED1;
	Wed,  5 Feb 2025 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738774801;
	bh=CGRl2IdB7lK5Q0NyUwhuL92d361xJ/Hg4qfPhckBM9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EMELZMWqqsc6zukudILVYxrSsY4rcZCdzEc0O0bLKHhOOGtKT1qEC3J8fe25QiFLA
	 p4pvCKdInOOTHBEjvtZ1QUkKAQdsSN8YmK+qpArwSMTT6dQOoE/3mEZ2zJOicgIYTo
	 W/EDrac3NMENobbcge1fRzW/IEd/MRGg2Ol/QgZ9stEOIx6Jory1gR8ogwo7dYLY/S
	 gOGLClczkSqrt7h+DnOB3E467Kic4lW880dOQRIj60Opx7F5gCLhS9sx7sCdPTzfTT
	 0OLKMmI1znVVUI0Swmt9PIZdByB7zCi8dn6iOF2EiQUFaCKhfKcaql+seCVPdGuZQe
	 2HKOlgczfC7qQ==
Date: Wed, 5 Feb 2025 09:00:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
Message-ID: <20250205090000.3eb3cb9d@kernel.org>
In-Reply-To: <87seosyd6a.fsf@toke.dk>
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
	<20250203143958.6172c5cd@kernel.org>
	<871pweymzr.fsf@toke.dk>
	<20250204085624.39b0dc69@kernel.org>
	<87seosyd6a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 05 Feb 2025 10:05:17 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Can certainly add a test case, sure! Any preference for where to put i=
t?
> >> Somewhere in selftests/net, I guess, but where? rtnetlink.sh and
> >> bpf_offload.py seem to be the only files currently doing anything with
> >> netdevsim. I could add a case to the former? =20
> >
> > No preference, just an emphasis on _meaningful_. =20
>=20
> OK, so checking that the feature works is not enough, in other words?

Depends on your definition of "feature works". Going thru all the
address types and how they behave would be a reasonable test I think.
Checking that an address from debugfs makes it to netlink would not.

> > Kernel supports loading OOT modules, too. I really don't want us
> > to be in the business of carrying test harnesses for random pieces
> > of user space code. =20
>=20
> Right. How do you feel about Andrew's suggestion of just setting a
> static perm_addr for netdevsim devices?

I don't see how that'd be sufficient for a meaningful test.

