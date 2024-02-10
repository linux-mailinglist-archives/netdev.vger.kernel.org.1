Return-Path: <netdev+bounces-70733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8465C8502B1
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 06:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396281F25259
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C15697;
	Sat, 10 Feb 2024 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/Shc34O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13804134C2
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707544445; cv=none; b=oq4l7QJ7msQbyWedUvwRRi+paa2NtIYwiXlutdXjKm/4OZK8Jbb+fONEud0GzqhDz5YtHg0JHuZshw14u2DqCgnIKaI6gAoMxg14ZtrPq3I/wWPHW2PUWso4oW6ocuCV7Lgy8vJL2fYNH7XNOTGeN3hkZYVMGhhocqA63ha44NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707544445; c=relaxed/simple;
	bh=5AXD5RoerGOSmlC3sREPcVONRY9Meaz7C3/6rjQdkb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXkelBw9ic6LVQxKBpWw2sZ8S422lbQ+BTvVvljoLkcEYwYyLVatw4cYKz9pbjymETWO5lvxp57xc7mSvvoXmXnmFRfbr7THXpTruY1w0yzgILLrJmaYBSPFG6iVXOU+9smPtBqYZOqj/Z0oYfFWVEOpqPaegBRTppu59XvQY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/Shc34O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E573C433F1;
	Sat, 10 Feb 2024 05:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707544444;
	bh=5AXD5RoerGOSmlC3sREPcVONRY9Meaz7C3/6rjQdkb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B/Shc34OMZLgoZaGm91SiJsFmyGUlLTfbevBAVR+F8AsyEnQsmPkXxkigaNCS+RAW
	 ELYc9vjHK600Xk7KOnebxh9zrJge7J0RLof8eqpMJbGi//jHScHxWZb85iFCH53dte
	 guCtFpGUmPRioPsQtZGrmYI7GXltjWnyQIBzZ2OpR6vrGPpxcYoOMsGryE2/LJK4IN
	 jyzeW5KAcj1BPZ8UYJwhAaVpsvw5JEZ3/fF0cjyk3o8brs77soqiFtEc2MLIDj9P4g
	 eiiyRIpU8fuP+7Ns2GEeJ6FrrtdyYfo8Dw46a4B5pBxWuASoloxBhiLMLVpgkmwact
	 VcS51WlYIM2Hw==
Date: Fri, 9 Feb 2024 21:54:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 socket direct
Message-ID: <20240209215403.04cf8f1b@kernel.org>
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 19:53:37 -0800 Saeed Mahameed wrote:
> This series adds support for combining multiple devices (PFs) of the
> same port under one netdev instance. Passing traffic through different
> devices belonging to different NUMA sockets saves cross-numa traffic and
> allows apps running on the same netdev from different numas to still
> feel a sense of proximity to the device and acheive improved
> performance.

s/acheive/acheive/ throughout

