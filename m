Return-Path: <netdev+bounces-155463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243CA0264A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EEE3A605A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6641DC98D;
	Mon,  6 Jan 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmYXhxuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434B1DB362;
	Mon,  6 Jan 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169104; cv=none; b=g4n0qZULKX4JDS4CousWCAhjfvd10k5S+BLsRFx3D/IwiPDNbQTggYnJLhh0OgaXbK9G/gwa7LVQPQIZBQ9evH2bH1k7eWcHnQePpBa9sB6wlID4exs6Lo1FQmlk3WwP3/2W1G//TrQ2yTm5K73s1Ph+uaUnFcQ7k7fQf3s7k8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169104; c=relaxed/simple;
	bh=znXx1vBzSeFX/v04A2pBxldDMCIVvWraxlI9GGnBFS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPEkkaciqnLGe8ga5CMHAJHBwOKegtW8ksw0W8AiIXAWrrl5bshrIbYcUqA7EmWauwk1kwazw93XzuwOhoHn5OvP39nP45iHZXOVgp2q8drNxzig9A0jGvJJBecL2qFspcaq3W3xGNtOdbsM4KqN1v7heu3k0lY9SdbWwSFSd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmYXhxuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB47C4CED2;
	Mon,  6 Jan 2025 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736169104;
	bh=znXx1vBzSeFX/v04A2pBxldDMCIVvWraxlI9GGnBFS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmYXhxuyiSPJe4a6bbV3UUgMGunnWtXC4tIWCe/N5e5UmZPXytEz69M7HDZdhoVkh
	 O7JHjjLr7IKis7UTq1cG3v0faxQfuOO+5AI09mbLzjW6YBaR2OZ2FDbBBeFjn1Bk+D
	 gQgZrQ3hIaadbsNwgiXLfbQ0tk8QrfByYVkbZ1ZvyhgmqqH5XU6sX/EM+cXhcoqLLX
	 bEViFiXcszAyYusxnuNn4TMD+F09twpv75jRdljIL80M9teILh25cODGUKWjN+AgqY
	 djxZR51HaXoiox2SAEk0DV6KY5aPPX7PGOOjbYtIiPgcV0jvN2ca5Sh48SSRYJQyH3
	 niJ2TZTjWRH1A==
Date: Mon, 6 Jan 2025 13:11:40 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Message-ID: <20250106131140.GJ4068@kernel.org>
References: <20241226140923.85717-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226140923.85717-1-linux@treblig.org>

On Thu, Dec 26, 2024 at 02:09:23PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The const struct ixgbevf_hv_mbx_ops was added in 2016 as part of
> commit c6d45171d706 ("ixgbevf: Support Windows hosts (Hyper-V)")
> 
> but has remained unused.
> 
> The functions it references are still referenced elsewhere.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


