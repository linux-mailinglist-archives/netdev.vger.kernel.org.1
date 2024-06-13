Return-Path: <netdev+bounces-103359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E3F907B9F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F6A1F27059
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA10E14B94D;
	Thu, 13 Jun 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtFJngTl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7D14B950;
	Thu, 13 Jun 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303848; cv=none; b=A6NqeJ4sXUS5MLeNU1YWCBd5L+GJSJVVMQYLF2ogvTTgixqSpmO/BDp3eB6AzyF+W6sgv9ILtSnjuuAQ8KAaD7YzEn+lxPiW34Hqjq1fVYaO8HBZ2qEgPIceZTKqvVjyHWuUoJgyN4V0XICAYc2/Xb3YSCNVI1W0ooffmfkFtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303848; c=relaxed/simple;
	bh=oTH+ughuU02RddWezh4SV95TGPKX1g7yleDmfGJor8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btk1B5e/muYqXFyVqikgc9ZVUKeK6HczkGLYdx6OS5MyEiQ9Cs4tJbqYyJjL6zpB/Kah3tF9G7Lz5EM+rzcOJPPT4x7lrsNPFSVkmucMoXQN/8k69qMY4P2S9IdeeDJKw2x2fAXsqjEQiwWYEn2zCz+ipbbcQXuCr3QBsf+VIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtFJngTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7222C2BBFC;
	Thu, 13 Jun 2024 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303848;
	bh=oTH+ughuU02RddWezh4SV95TGPKX1g7yleDmfGJor8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QtFJngTlZ8mOJWjCVHtuilUpq0F+RKBpc8vror+YhA01Qy/NNv1YcnzjN7wXgIeeN
	 tUVo7/v6HrDuJ+XyvGXeLGeEQjLhT0kreZIvcWuIhScjcHc/sMyK6CLztiQNA3M2cs
	 iD5rJHu8Fh2gDhDvWrWwwGFgV5CDIHo7WZZ5oO5XNk24eojAgg78zLFXd1ksdN7jgM
	 O0rfSEv9J2hT59ZW1lVs2HgTolpGzhBsqJWFC48AqXHhG1B/EhOx98oZxPzGpuKJ6c
	 C11xdfO3UzN8sK0DT1+0Ft7el/RNifEpAOoEIb92MPUKcyRp59eyPK/LdwLi6Eq78a
	 /Nl36FmIJyh9g==
Date: Thu, 13 Jun 2024 11:37:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.10-rc4
Message-ID: <20240613113726.795caf6f@kernel.org>
In-Reply-To: <CAHk-=wiNgwEpfTpz0c9NXvZvLFPVs15LeFfmhAUO_XhQTXfahQ@mail.gmail.com>
References: <20240613163542.130374-1-kuba@kernel.org>
	<CAHk-=wiNgwEpfTpz0c9NXvZvLFPVs15LeFfmhAUO_XhQTXfahQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 11:17:52 -0700 Linus Torvalds wrote:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc4  
> 
> Your key had expired, and the kernel.org repo doesn't have the updated key.
> 
> But for once, the key servers actually did update and a refresh fixed
> it for me.  Whee! Is the pgp key infrastructure starting to work
> again?

Cautiously optimistic "whoop!"

I only uploaded the refreshed keys to the servers ~minutes before
sending the PR. Next sync should hopefully get it into pgpkeys.git.
Not to excuse my incompetence but git tag -s didn't scream at me last
week that my key is about to expire :(

