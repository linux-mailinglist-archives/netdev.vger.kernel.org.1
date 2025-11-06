Return-Path: <netdev+bounces-236150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECEC38E05
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4268A4F03B6
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7A31D9A5F;
	Thu,  6 Nov 2025 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsLkJHnn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF71A9F84
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396395; cv=none; b=UPyIo73Bann7y/WzP7CX7VLOlp1MRBMXoC+dFlwJooPRX8ybHqFc4XVEHTeuAh+SHmN/OjGmAp7Cw283lxaiuIvZ/U8GRRdvQ8jgI+c/ypgjNgJWktlbwTfWzF5MN0M1rfYWiVEA515r4x3wdHDPuUj8qta6rPIrjdlwB4xCcik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396395; c=relaxed/simple;
	bh=L6yUB3qwZ6IxZCWcXn+Yxe53qZsVGCNrL9uxC/Xdhhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBY4Nvnkm0TXyzVyzc7F6e6WPpsBtj47+1kkcP7G/bYRXydxWgKnKRKYJ+YDA6wMCh/VSJt9sFPeJf4DieL+wDQi0Kbq/VrUsDHta0tCSn1qjF/DHgQNQBqoW1fV9X0eZeKAc7/cli9GRCEVT3JJIhWHNGouPKwwJ3OaiQP8kEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsLkJHnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B94C4CEF5;
	Thu,  6 Nov 2025 02:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762396395;
	bh=L6yUB3qwZ6IxZCWcXn+Yxe53qZsVGCNrL9uxC/Xdhhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GsLkJHnn5C32GfZdMjmAcqtidUmHwoTcJWzT5HAOrxemtlqqxE2f8+1ALUBCMkYzG
	 n4hnMaDNLRZBxUlNeOf2KThr+h7WVeUHMFofKZpzWlzajc2iyME+TQzTWzApANeDOV
	 z0nPHG08xGUNlmCa4Xs/pG6yf3EzRAcAsYJ/fwUYh+Ro/7Af6avJdy6ibQaEpyvNwu
	 h1du81utXNHmN1X4Fw1Y6SmehSK+OQe4vFeq2oqgsXrcLXjmTK+z0xGloU6X1h4gkJ
	 r2Eodu4GVhm48leDHiknbuMBMgFD/9nfByA35gxQjtW2VaUocWEpcdb0mOgXGKLtW3
	 44fknun8F4k6g==
Date: Wed, 5 Nov 2025 18:33:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Stancek
 <jstancek@redhat.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv2 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <20251105183313.66a8637e@kernel.org>
In-Reply-To: <20251105082841.165212-4-liuhangbin@gmail.com>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
	<20251105082841.165212-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 08:28:41 +0000 Hangbin Liu wrote:
> Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
> ethtool functionality. The framework includes:
> 
> 1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
>    operations
> 2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
>    feature gettings
> 
> The current YNL syntax is a bit obscure, and end users may not always know
> how to use it. This test framework provides usage examples and also serves
> as a regression test to catch potential breakages caused by future changes.

And how would we run all the tests in the new directory?

Since we have two test files we need some way to run all.

