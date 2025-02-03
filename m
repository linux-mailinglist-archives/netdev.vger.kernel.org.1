Return-Path: <netdev+bounces-162048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D6A25772
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FBA166DAA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B1202C2E;
	Mon,  3 Feb 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftAmbKNM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EF20125D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580109; cv=none; b=JI9Rhu/9Kz4r39NqcLH0I+ExipeeTvkAUnqBvIvnMSnBEwctIK3MXgwBUbbAUdTT1eZEbizx+SNIuI6Elalf/odMxDwSO817WvsUFmQ8tn0nAlZZw90NROQklvHpoUoyQ4+iS/3O4k8DCWyttZXaNuMMATvuvYEphMC+bcl+SuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580109; c=relaxed/simple;
	bh=P8nn5HnuPEnjw9l4YBAZrOh7MjH9GPSZnBk+krjA6y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/pHvlbH9CaAjYe5wlTqvowtKxcgJdAnjLmY7G20T8Mel7mavKY1IuX4wfCrH9b0YXb9PTwaMSsYhB+C7qSQtbV3Cs476x22Y2Npe9yLyLpRLaMZml4B1QAelRudM91fIEzF3mFf3T4DOVYClS9SXOgQFzSb4IF9c+fWVbsIVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftAmbKNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69002C4CED2;
	Mon,  3 Feb 2025 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738580108;
	bh=P8nn5HnuPEnjw9l4YBAZrOh7MjH9GPSZnBk+krjA6y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftAmbKNMAbjO1c7MRKKrKKdEXvCd+2/W2E7PKreXI0pscBZb3kOYzRRqez6JAHX9c
	 c1wUo9XIgtHmIzUbKAhAhSzWHOTjmcMBUXRu0IPLZgKiJsxFwyx6aa4J31zIkGdM2J
	 Us4N9GVUzOuRtE5falXyDeWT9KpgEbIFB/FsN1pI+DqkkpEsYzEVl4MZ2C9vlKRmNP
	 FUbLYiqFNgWWOtAgSbrXHiV24KDlDSXHk/IMVjerqg+jjeLPl+btTPpNMFqO34uzIA
	 bjqrfwTLobjztZZHNyUZ3k/w1zWAoUAsCIUFc1Cm9yP3pkFoAM0eBNh/kaQn6U2cua
	 KB6ICVhPAPl9Q==
Date: Mon, 3 Feb 2025 10:55:05 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net 1/2] MAINTAINERS: add entry for ethtool
Message-ID: <20250203105505.GF234677@kernel.org>
References: <20250202021155.1019222-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202021155.1019222-1-kuba@kernel.org>

On Sat, Feb 01, 2025 at 06:11:54PM -0800, Jakub Kicinski wrote:
> Michal did an amazing job converting ethtool to Netlink, but never
> added an entry to MAINTAINERS for himself. Create a formal entry
> so that we can delegate (portions) of this code to folks.
> 
> Over the last 3 years majority of the reviews have been done by
> Andrew and I. I suppose Michal didn't want to be on the receiving
> end of the flood of patches.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: Michal Kubecek <mkubecek@suse.cz>
> 
> I emailed Michal a few days ago and didn't hear back.
> Michal, please LMK if you'd like to be added as well!

Reviewed-by: Simon Horman <horms@kernel.org>


