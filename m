Return-Path: <netdev+bounces-155467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816BA02663
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EDB164677
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1761D86C0;
	Mon,  6 Jan 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHeT7P6P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA30433CE;
	Mon,  6 Jan 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169785; cv=none; b=RJv+9Sx4BKU1A3va96k4xI8yRykh3EMchpRMCZJTZe0F+Ovdj0wpC+szaCSXDGEANaGAw+VFfRRk5XZipQfIDHUElXhAGCFVcUswdGeE8LbfId1WK5oheFOd6L0yxJHrE1wiEA3UxP/8i0J41eJAGLyu0V95kerG5gF/cQDB4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169785; c=relaxed/simple;
	bh=K5tq2lme0yYfypOyqqSCPn26xsmF+xHbpio7Ejb6UZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jusuA4E5zIW/ui2ud0unb4WWBf7gaaUxFSfpaxK8zhLIHq4zgv//kwEtyGYMxOYgFgvin8f19hyc9M0d8MSx55fAVyPmmOACP/D7QLH92bb9GmMgJLFdeLxkVApByMJM+S3EKqKq0IiD30vEmnrz8RVpSNhJxGigg05J2N/Cd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHeT7P6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC4BC4CED2;
	Mon,  6 Jan 2025 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736169785;
	bh=K5tq2lme0yYfypOyqqSCPn26xsmF+xHbpio7Ejb6UZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHeT7P6PSLtnTqCRkbJE/9vSbwTSLLDMFyXUDe47Esr/avjRSYvgJOuZRx7PPM1yR
	 dxCg/lfRRaMClXTOp8hJ6+L4Vj305/KPSXsnO86YRDGA0ZmURtcN9ZggPrpO4+JCsq
	 btPI1N7JyH/8aySp7tEg7WaeLDWsSKTWzbpoKT2RwPFs9MEew4Q5d5t5aFMN7r2aJK
	 JCXnNG7HAHA6QoHAfrKjMgTPceA9ogyHKzOzf2xmGPFpT26ikMdAx5MPh13wOjrFqc
	 QC17kNx/Y5c+ei2mMilS9GaqTE2qmXqbYGn5SAtW5lhSZSQv40VkukW0LZpMDCKagT
	 jE16PGBA9m1dg==
Date: Mon, 6 Jan 2025 13:23:01 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 1/3] igc: Remove unused igc_acquire/release_nvm
Message-ID: <20250106132301.GK4068@kernel.org>
References: <20241226165215.105092-1-linux@treblig.org>
 <20241226165215.105092-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226165215.105092-2-linux@treblig.org>

On Thu, Dec 26, 2024 at 04:52:13PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> igc_acquire_nvm() and igc_release_nvm() were added in 2018 as part of
> commit ab4056126813 ("igc: Add NVM support")
> 
> but never used.
> 
> Remove them.
> 
> The igc_1225.c has it's own specific implementations.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


