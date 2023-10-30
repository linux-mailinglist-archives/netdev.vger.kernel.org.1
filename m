Return-Path: <netdev+bounces-45319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23547DC16C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB9B20C8B
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E7199D9;
	Mon, 30 Oct 2023 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/PSkfST"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4988CA7C
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 20:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0D8C433C7;
	Mon, 30 Oct 2023 20:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698699108;
	bh=CPUFII5tBVGYQWTzzClF3posYcCkNs0uUZXtvYwH+7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/PSkfSTLLzzZ3AzvaKdnjX2oX48mkYgw65ImGWYjQ4vAkeOH4NmuOJ8XQli1BrqJ
	 LhRzoCy6td8yuSh+O0Cs1jNJKNOo5HyMWyv5FjEtpTBa5KHMEihuPjwBaMhTEZlVLc
	 CzOYugEwXYhPsJGHXusigZGntOftR1HBdPD+osoAWzp4RU7l6mspCqbpeKd2bhC4IW
	 pBaWWMZaL72SRxRCGmhTBbcy9uyY66B4SGGV1hNlm4H+tDcx2ZyYNkqcuVVtLAFaHm
	 PKBIGIRP+9cHA6SztLvQC6HY3+w9zOMWzWsXykayt5+sGfdVgYA73kDp7TyN5cattM
	 DxztWafapaTYg==
Date: Mon, 30 Oct 2023 13:51:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alce Lafranque <alce@lafranque.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, Vincent Bernat <vincent@bernat.ch>
Subject: Re: [PATCH net-next v8] vxlan: add support for flowlabel inherit
Message-ID: <20231030135146.2f0882ea@kernel.org>
In-Reply-To: <20231030193119.342497-1-alce@lafranque.net>
References: <20231030193119.342497-1-alce@lafranque.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 14:31:19 -0500 Alce Lafranque wrote:
> By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with
> an option for a fixed value. This commits add the ability to inherit the
> flow label from the inner packet, like for other tunnel implementations.
> This enables devices using only L3 headers for ECMP to correctly balance
> VXLAN-encapsulated IPv6 packets.

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

