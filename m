Return-Path: <netdev+bounces-221487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A19FEB50A1C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 127317B3B92
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421C51E32CF;
	Wed, 10 Sep 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eqz10GaD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBD1E1E16;
	Wed, 10 Sep 2025 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757466804; cv=none; b=KpdQj0tn+PptbVBuQpwZfnojs7rPnszohn6aJZeAznoXxqR2u7IqTQtZ9lAZJQSQuK4skZnhmET1f3o3Qs3tby53m5aSN1StQSNvbNi4KTMF2F/2Uc6atngL0aUX483US2gS0FeoqS8abkR0XU2wvJ/Rvg3vn6fxwETLrhSH5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757466804; c=relaxed/simple;
	bh=9ifm7TOkzMJw28uzLhYZW2hM17K9lfkkOUA7OSfU07o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrXZUSc4Q22uSyHw1gGwLMGbpupzUXGxLeA67T4lyX8Fc5p8PB4tRlOJmHWmvQbgsqCkHCUKvz5O6MR00SMdbMnInjQqZE9MEdAJPz44E2ht2f0pzpXydk5EyurQMl636VU6Rf+gzlgCU8soVgEEZVzadwIkC28A1Nob3oQxbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eqz10GaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEACC4CEF4;
	Wed, 10 Sep 2025 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757466803;
	bh=9ifm7TOkzMJw28uzLhYZW2hM17K9lfkkOUA7OSfU07o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eqz10GaDHbIs/LAcMlmZ4y5FV85agJaksnhDzHNEtT9tv6E1iVH+bG6N3AJC5fp42
	 i5pA6qx426PWXE8RlkCfAoFLRvTRjy2KP6zNGHyU+lePijSeq9D1M0GDaeSSkTqTFj
	 QnUFa7nFH6z/AyUAMhwNk3gnBVy8M6VgZiQhrJKZ0V0/golvXv5jhYy8kdQsalYnks
	 AkzYDzyO+sbfwjyIYOlMvDSbwogF+zfGnCp+yGHLcld0G+8mlp3D4MGDR+3DNYkTgr
	 Eu5UcPyoyaZ2v3G2QdRYjsTOimWGkLRL5mSap3qdQeQGrTOh723++nKgNO8UpEmyYu
	 +KpYBHF1ORmEw==
Date: Tue, 9 Sep 2025 18:13:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Palmer <daniel@thingy.jp>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP
Message-ID: <20250909181322.04dc2fed@kernel.org>
In-Reply-To: <20250907064349.3427600-1-daniel@thingy.jp>
References: <20250907064349.3427600-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Sep 2025 15:43:49 +0900 Daniel Palmer wrote:
> When 8139too is probing and 8139TOO_PIO=y it will call pci_iomap_range()
> and from there __pci_ioport_map() for the PCI IO space.
> If HAS_IOPORT_MAP=n and NO_GENERIC_PCI_IOPORT_MAP=n, like it is on my
> m68k config, __pci_ioport_map() becomes NULL, pci_iomap_range() will
> always fail and the driver will complain it couldn't map the PIO space
> and return an error.
> 
> NO_IOPORT_MAP seems to cover the case where what 8139too is trying
> to do cannot ever work so make 8139TOO_PIO depend on being it false
> and avoid creating an unusable driver.

Any idea if this is a regression, or the driver would have never worked
on your platform / config?

