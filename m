Return-Path: <netdev+bounces-48730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865CE7EF5B9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C79F1F22F4E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2A632C76;
	Fri, 17 Nov 2023 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6rlMki8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16330335
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07780C433C9;
	Fri, 17 Nov 2023 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236407;
	bh=dXa66bOWhHg0mx4TgM7JyKU8tNk0DE4j2IZLa6h3j1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6rlMki8JzIFUp0c/Ny0tfTD+W2xMF6GeeJ1GPlsdq4hDyOe0ak06g0bHx+QLF4NY
	 YvBl6y6vy1AM7kt0az3BET34wGVTJwiVDlZKxSFNhigWt3Kxf2f3SXkVa29Az2momr
	 gG+OfN6eCd3vX1SvqkZUjxH8jpeBhoSyVJVdVToSH5xZFkLnb3UvELwXm+A7D1bwL4
	 Lgw2aJ6skxEwFjND9QXpcSdh7YTsTEc2mlqeKQLd4pfPN0k3NgZfgJ5ByXRTSdpClg
	 +rzpaZpuqPc+D3uL/YGeQ3YYmQkxnhE3cSYkMuoujcfKaL9rW3zhfecMY/vZ/dXUOe
	 zxFbJYBJYMb0g==
Date: Fri, 17 Nov 2023 15:53:23 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 11/14] mlxsw: pci: Move software reset code to a
 separate function
Message-ID: <20231117155323.GL164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <395237a59d495700926cefa8bb713cdd9364fbc7.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395237a59d495700926cefa8bb713cdd9364fbc7.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:20PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> In general, the existing flow of software reset in the driver is:
> 1. Wait for system ready status.
> 2. Send MRSR command, to start the reset.
> 3. Wait for system ready status.
> 
> This flow will be extended once a new reset command is supported. As a
> preparation, move step #2 to a separate function.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


