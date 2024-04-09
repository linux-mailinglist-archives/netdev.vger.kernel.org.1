Return-Path: <netdev+bounces-86132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67D89DA6C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D631F236A1
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11D131BC8;
	Tue,  9 Apr 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHK17UNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E4131BBD;
	Tue,  9 Apr 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669631; cv=none; b=Hg62XHuvEQhaRlbSbd1/porVnbHfS1flq7xf32uupIr7H1nWZWR/yBB9h0tM+zizW2HVlo/JDmWgq6x6RL8knsl7+IuvTWhmuyRVJd2RzpMOakyxUDUwygHCLfRcM/LdbZH997sXrH0SFq0TvnO95KnqNlZzlIcsWNTon6guB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669631; c=relaxed/simple;
	bh=DYQEw/FsqivozylDxjcphYLYBdtFFQq5JeNE+91tfac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCDQpRwtrrs1acBYgiqV0qEOVqEjYoUmT4Y9TS/LO3gyHE/L9mTzcoDkHeVK6MvEKl/rj85NHMjtp0oTqEfH0u8vKR1rp+X4WihUj4lZGycLmPQilZfHSHhHKlwcFhonT6h/uQwid4l2p0U9irtFeiMyF+hoZSvAIWTKSJkaSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHK17UNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE253C433F1;
	Tue,  9 Apr 2024 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669631;
	bh=DYQEw/FsqivozylDxjcphYLYBdtFFQq5JeNE+91tfac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHK17UNsIgo2jLN1kmk25FG/JGxXsMclID8GaVVOUrRaNKg49aec0K/v+562dCNgO
	 UU7hCioLAZYBPF6kJjN9xtkp+1t4ZBifRqhCaqvh02mIFQRtPs1sJRo0MsQUyN/Uo6
	 3ZV9Y5jRIYTPzzVSNasraYMtLxJ67ZsILqUPdaAN+KleVOfwIbD3Rs2xK2p6e01VfR
	 lF6NyTWc/ida9JDeLD6Ssmr5fKA4qqnPztor1KoD0dmnZDhkO8/ZTH41DF1s6a+Bcd
	 y4QmKkbnt0CLG4lXhZC/QlNxY2zlAgJ7FY7PbH2tfEHsV4QKa14aTR6v1KTHFmGk8Q
	 Qi0f8fP/TE8NQ==
Date: Tue, 9 Apr 2024 14:33:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - April 9th
Message-ID: <20240409133346.GA830026@kernel.org>
References: <20240409062735.2811d3f8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409062735.2811d3f8@kernel.org>

On Tue, Apr 09, 2024 at 06:27:35AM -0700, Jakub Kicinski wrote:
> Hi!
> 
> Yes, the bi-weekly call is happening today, I forgot to send out 
> the reminder. Time zones are aligned again, so 8:30 am (PT) / 
> 5:30 pm (~EU). See you at https://bbb.lwn.net/b/jak-wkr-seg-hjn

Thanks Jakub,

if there is time my colleague at Red Hat, Ondrej Lichtner,
would like to make a presentation on LNST, a testing framework.

