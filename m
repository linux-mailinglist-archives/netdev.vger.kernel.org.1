Return-Path: <netdev+bounces-196958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A89AD7164
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125C23AADC1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC9323CF12;
	Thu, 12 Jun 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTA4Ez8l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484519007D;
	Thu, 12 Jun 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734088; cv=none; b=iV4aqajoqM/vOoCuVzsnBiSTKvfEz4SpXiZZUIoDqlxHMGhDt3FyXZH/jViA3d9aoHCK4x1Vrz8ATJXQBDo4LO4aX+RRGzeOmybMwXIdKvEEdv1SgvuyjR4i+KAoYi3f9uyfvT/ohFYM42HBJdkGqz4/v7BodVFgowAS4NxznzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734088; c=relaxed/simple;
	bh=H8siLxp5Z7goMxpeQu3rlbqVTGHHoq3nq4mTKGcVgFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcxeYHO33LH680BmkfALTErxUYuM1zPW7hlAWrF2tlPjE0R1Im8bdbavE7ExUynCIxVTEIErVxPhlXU6IzjvbRAHNflxm0fkAfmNdBFdmT8Lhxjy9Aw5iUmo95SjUbxwKm9JiXR6JvOuEsOW+KrhTOwsh5G2A5rnTSJnhxTCI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTA4Ez8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E1BC4CEEA;
	Thu, 12 Jun 2025 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734087;
	bh=H8siLxp5Z7goMxpeQu3rlbqVTGHHoq3nq4mTKGcVgFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTA4Ez8lND8qAvz0fGv20t9F/RcjBzsUoe6V1Z5L05otD8DEbdW4B9jUSVw52ui7s
	 WkJ+69yExjhlmvbhOpGbGOQ2EijJg1COIAHojqFF7h1V9r6ioZUMtpZMDgHnKFSj+1
	 543exs5xHN7lLA7jXLYjA47PWDsjOqF3G6Fkhqbw3BlPrIXHUELkd6HMNI87VUCWHo
	 YnwDTj/3bjgN34NGUczRIwRQA4ZPfsME3v6wBnkxGxFsS4fLRagvhY/Ey3c05iow2C
	 w0dtJ0T2vrn3RUj2FUN9/0hPhCdVZ0bl+kvTqMDdfDr1LMSq+gVRcfTiH+1ppLEWyC
	 emwxFqWPFpyrw==
Date: Thu, 12 Jun 2025 14:14:43 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net-next 1/3] ionic: print firmware heartbeat as unsigned
Message-ID: <20250612131443.GB414686@horms.kernel.org>
References: <20250609214644.64851-1-shannon.nelson@amd.com>
 <20250609214644.64851-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609214644.64851-2-shannon.nelson@amd.com>

On Mon, Jun 09, 2025 at 02:46:42PM -0700, Shannon Nelson wrote:
> The firmware heartbeat value is an unsigned number, and seeing
> a negative number when it gets big is a little disconcerting.
> Example:
>     ionic 0000:24:00.0: FW heartbeat stalled at -1342169688
> 
> Print using the unsigned flag.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


