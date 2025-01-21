Return-Path: <netdev+bounces-159990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4CA17A52
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CC41882D30
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E711BB6BC;
	Tue, 21 Jan 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQHslruP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2F1B0422
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452287; cv=none; b=DKQY5r7Z+hQfr/1v83qn8x3G9S0ucKXvBzW3kabhqM1zbpdYvrTl/RFtWDdGGw+tfipzfms3Z/Dtcq4RjuR5l/YU6LlXuGNEO1mGrlxp1tue5onfSsscCGPcpmhiGMS38Kyj40iF6jnQOXCsfa1z62roWtwINFyHjM1M5BCX+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452287; c=relaxed/simple;
	bh=Zzr0E+wcMOTOHTXCTNJD3Sj4nW7lskoDbYMOLY2GJkI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=PLkkR/HIqMt5sAU8kn8+PPtwPvw6UBHTxVrGjF6gkhCkWehN4ckrvonpqVOPPu/DQxUt2NURLh6MSQ27/fQ9OwQATbUzCUx4Qilk3VS4RnJ4CIJjrcZm6oAj30zNZDQRsc4GEvAbwfGwZBunJMG8NCNEDFZt8+epWZMgjVTs5WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQHslruP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EF3C4CEE1;
	Tue, 21 Jan 2025 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737452287;
	bh=Zzr0E+wcMOTOHTXCTNJD3Sj4nW7lskoDbYMOLY2GJkI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fQHslruPwH/vwWT6U7HdhGUnCcjB6gXB4zKCBDW1jsMvCulqbTqXGUh3qerASH+jS
	 OQuzW39xdf5IzY56CFdk+nzgq+P23fw63pmeWcMX0UIvMY6O8DX2LdcIODAa8Eh9mG
	 XpY6M1hElxWz+hvR56cPiFiFFKO8fFshOHVFDruHv3qP3HwjzjLlES38Z1tmUVdayo
	 +yzcU3Wa5H6oNZNsBksiBA8iVOUrHgJGXH86Sp/hJTev49qB6CcahtgAINIYaCMfZy
	 qGi4D+PHA7fBw0Ft5NV+cNt+wG4gtO1f5mMEHY1JYvswx809dblds89MN/pVSL9kXi
	 HPMzje6Wv1Arg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250120114045.3711fdc9@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org> <20250120114045.3711fdc9@kernel.org>
Subject: Re: [PATCH net-next 0/4] net-sysfs: remove the rtnl_trylock/restart_syscall construction
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, stephen@networkplumber.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org
To: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 21 Jan 2025 10:38:03 +0100
Message-ID: <173745228357.4844.17327465949667802656@kwain>

Quoting Jakub Kicinski (2025-01-20 20:40:45)
> On Fri, 17 Jan 2025 11:26:07 +0100 Antoine Tenart wrote:
> > The series initially aimed at improving spins (and thus delays) while
> > accessing net sysfs under rtnl lock contention[1]. The culprit was the
> > trylock/restart_syscall constructions. There wasn't much interest at the
> > time but it got traction recently for other reasons (lowering the rtnl
> > lock pressure).
>=20
> Sorry for the flip flop but would you mind if we applied this right
> after the merge window? It doesn't feel super risky, but on the small
> chance that it does blow up - explaining why we applied it during=20
> the MW would be more of an apology..

That makes perfect sense and was actually what I was hoping for so it
can live for some time in net-next. I'll send a v2 right when net-next
reopens.

