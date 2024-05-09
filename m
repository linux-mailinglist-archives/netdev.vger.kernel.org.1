Return-Path: <netdev+bounces-94743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37BF8C08AB
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CCFB20B9F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85173D6C;
	Thu,  9 May 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMvpkw6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217C2F24
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215814; cv=none; b=Kk9KO+5oYbLZ2rEeJiqvJMlraZJ4a4NTSUOyDKrh9c9Q+pdIR5+1Yj+A+uw+myzwWQ/Yryy10ELVfCOkRKn233BlX99UFVlNmZUdOgG87AQfhNqm9tH8ySEOS8IK5qUdj+qirF9aZ9l7nvX2CzJzU+2tnCtHQVlmbd/xubLC8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215814; c=relaxed/simple;
	bh=QDeU6IFhGyJyB6RbV2RpHl+z+L226La53hdruZiEoBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vn0N13ZoY1gZiaFn5E6d7Hot5NCzAKF/DJla4VRKtXqIkqoRDaYM9hIQbYvfAN9HDgZaCcXzM39cVlsE4D400FK3EE7g8P/1m/MHtMjR3SiL/POQ1uv22xWmKECcGJ3rvWgyX6GVH58A0tNXxprYlOSuzpHugRwpm5+FBLoJSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMvpkw6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE228C113CC;
	Thu,  9 May 2024 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715215814;
	bh=QDeU6IFhGyJyB6RbV2RpHl+z+L226La53hdruZiEoBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMvpkw6TSlI/4hSjkvHTLFwDhF7t9mkbiPF68xabJRtoZgK7ZmPlYcdXczckwcJmW
	 SmnM097TdWd366SVkw5+ulmC2LmDOjW6yBa+7t1pkMhN81xxBeKk72AGU8E37tbudB
	 /kq24b4CBeqbe//bywhXYqGjj8jiLnaKh2yK4YxTAgfG7GMBvZsgTmKPUVpOuNKeOm
	 GYFAr4fRHACjtFHHBrKd+z2Rab5xhzhv8bk27ODY31BWHkTj6nQF7JuO+WUdUohlir
	 uqu2DNk/r4n0xUn1R9auS+UswXDwUvicDZ8qhT95SSZFdPqRtoyKwe2QjDKgBo1OO8
	 91jfd/XwG5pMg==
Date: Wed, 8 May 2024 17:50:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 24/24] testing/selftest: add test tool and
 scripts for ovpn module
Message-ID: <20240508175013.1686e04e@kernel.org>
In-Reply-To: <d32b5a97-df69-4486-98ae-f73d9f3fb954@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-25-antonio@openvpn.net>
	<20240507165539.5c1f6ee5@kernel.org>
	<d32b5a97-df69-4486-98ae-f73d9f3fb954@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 11:51:46 +0200 Antonio Quartulli wrote:
> >> +TEST_GEN_PROGS_EXTENDED = ovpn-cli  
> > 
> > TEST_GEN_FILES - it's not a test at all, AFAICT.  
> 
> This binary is just a helper and it is used by the scripts below.
> 
> I only need it to be built before executing the run.sh script.
> 
> Isn't this the right VARIABLE to use for the purpose?

I don't think so, but the variables are pretty confusing I could be
wrong. My understanding is that TEST_GEN_PROGS_EXTENDED is for tests.
But tests which you don't want to run as unit tests. Like performance
tests, or some slow tests I guess. TEST_GEN_FILES is for building
dependencies and tools which are themselves not tests.

