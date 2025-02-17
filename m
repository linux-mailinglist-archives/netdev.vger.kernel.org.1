Return-Path: <netdev+bounces-167073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95940A38AEB
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E61169628
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF57231C8D;
	Mon, 17 Feb 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU7ZGyOz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E8229B21
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814711; cv=none; b=Z18GICDRNwuVUtWd1wLBUrYpyozL6eE9GSBTW177OFdnCluWU7WNW8aVLrdK0dZ6yNGpBppqbXZHeJprXU+zk8gKlWH2WT5wTwUDIcJ7k+CfPFntZPCX0s9aoKG/1X7fvhDd6IdO4vrUjPmBAQTr4PgdoCQJi02rt77P4R2Bob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814711; c=relaxed/simple;
	bh=TiONVQy+iWU84BUNbIfwwzD57Q6xMuP4EJbaQz8Av24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1mLQfpqTtAWhOdagelaZX4w2ToC/3NhzhggCi8TJUjBmPzD0TqEpOWOxIb0vaEZ+JcBeIrzWusLjdOLc0N3eTQzWz8JmcR59oP3VLcvmZ0+IpXxWyB6tRrHS2FRsJcAajNxUG2qntnhewkqdkMEVT9rC4+pReIzvVMpS37bSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU7ZGyOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1709C4CED1;
	Mon, 17 Feb 2025 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739814711;
	bh=TiONVQy+iWU84BUNbIfwwzD57Q6xMuP4EJbaQz8Av24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kU7ZGyOzrP30Lm6AWX8d5geF4TwktLcsIcbD4T3SryWwiRaSsVpD5uVUVoHYqI/hu
	 hqBmSMb4F31ogW19XDQja+bc28JXjmBA9J8y0AFe5dfT/zqpSWlnAFX9mJsoQd3B5n
	 oBWUjLaTlAVRf8J6lzoP9gmt/PL25krTqE8UDNQFOx9LfEVfXWAvqCku/IMl/IRMBZ
	 pSwZLy7q/O/mnr4YHJMZJPiO2DXyJYg575Cq2yIINgm7Kqd6B7oZqdOZzug5K7GF+y
	 fkPEFMc9LdDA0m9fBhq0s/Ly+SxptPhlHVi9eZesELBPLKqasiaurSJcXsJOTGVUyX
	 OUgaTAeIMaAsA==
Date: Mon, 17 Feb 2025 09:51:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: Allow setting IFLA_PERM_ADDRESS at
 device creation time
Message-ID: <20250217095150.12cdec05@kernel.org>
In-Reply-To: <87zfipom9q.fsf@toke.dk>
References: <20250213-virt-dev-permaddr-v1-1-9a616b3de44b@redhat.com>
	<20250213074039.23200080@kernel.org>
	<87zfipom9q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 17:13:53 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>=20
> > On Thu, 13 Feb 2025 14:45:22 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wro=
te: =20
> >> Eric suggested[0] allowing user-settable values for dev->perm_addr at
> >> device creation time, instead of mucking about with netdevsim to get a
> >> virtual device with a permanent address set. =20
> >
> > I vote no. Complicating the core so that its easier for someone=20
> > to write a unit test is the wrong engineering trade off.
> > Use a VM or netdevsim, that's what they are for. =20
>=20
> Hmm, and you don't see any value in being able to specify a permanent
> identifier for virtual devices? That bit was not just motivated
> reasoning on my part... :)

I can't think of any :( Specifying an address is already possible.
Permanent address is a property of the hardware platform.
Virtual devices OTOH are primarily used by containers,=20
which are ephemeral by design. At least that's my mental model.

