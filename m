Return-Path: <netdev+bounces-137023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4D99A40A0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A21F28495D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE55478E;
	Fri, 18 Oct 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOhG4qxD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C741A84
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260259; cv=none; b=pDD9FGdwXPuFpyI2lN7bbqmMz9qxetBcteCk/E5SLAUTkzM6Ek839r5LtJDzPY4ZMirvSO4RqdxU/BaMXGAwnTXpwmRM8VPu4SIoU+ZbvUKpZTvTNT5/BMBGEfx0rjUWUzyInDWiDAzAp3M9sRpAGxsS5r2NKg2hgeYhUmNL4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260259; c=relaxed/simple;
	bh=U7nzaN/aGDQkgAkqhEuG5C0PKfpaM67TKE+BZZ3R4XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/GhahKfyyaGy946FCDFiWB7cVyQVlYegKbkotohXgKoYfqpHicmcPYtCGc/IVy+NcT385wURDb3rdYAjumuPNUTgck2qgJ+WGHSWDP6hS3tYup/x+NmVvvGmU5fMQEM5B9qjm6ofvRACOU2hi9LLIigsb0Ew9TbytVAKJCSRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOhG4qxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE79CC4CEC3;
	Fri, 18 Oct 2024 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260259;
	bh=U7nzaN/aGDQkgAkqhEuG5C0PKfpaM67TKE+BZZ3R4XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOhG4qxD7gFdb1EU2a8pvjJMGnQIpmjykj203b+A74VGjV+7+E02Ev+gd1mEwahuR
	 99fbaqGNAnBMW9nQcUaDyuP8HvvV5/BpxPKxSpVcQNixM2eS0QOvwcbqnir5xVpvww
	 QDZJ0idHIO1jwuczj3xcnZcD13SDWMk1Qblubf5mzj5/pBhbmNyibFfTbKTmxk+3AV
	 o/bP3SbesE3KlHDFrRBfZPGfyWq5BAHoCtMvxc+/nt3N4t4kYHAdNH16dAuGznSIzr
	 vcCbQbv17EdhRsyQLSFWIYjkQFIA8b8t+/tagxcuRxmylcXyrvb4dzfd0V1nkiK6lM
	 b9T2b+J/4txuA==
Date: Fri, 18 Oct 2024 15:04:15 +0100
From: Simon Horman <horms@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: sysctl: allow dump_cpumask to handle
 higher numbers of CPUs
Message-ID: <20241018140415.GL1697@kernel.org>
References: <20241017152422.487406-1-atenart@kernel.org>
 <20241017152422.487406-4-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017152422.487406-4-atenart@kernel.org>

On Thu, Oct 17, 2024 at 05:24:19PM +0200, Antoine Tenart wrote:
> This fixes the output of rps_default_mask and flow_limit_cpu_bitmap when
> the CPU count is > 448, as it was truncated.
> 
> The underlying values are actually stored correctly when writing to
> these sysctl but displaying them uses a fixed length temporary buffer in
> dump_cpumask. This buffer can be too small if the CPU count is > 448.
> 
> Fix this by dynamically allocating the buffer in dump_cpumask, using a
> guesstimate of what we need.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

+1 for using 'nibbles' in a comment in this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

