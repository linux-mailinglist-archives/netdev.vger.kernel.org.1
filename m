Return-Path: <netdev+bounces-249063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 512C4D13723
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95A28309902E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF82C1586;
	Mon, 12 Jan 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XulgnKH4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D02BDC32;
	Mon, 12 Jan 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229605; cv=none; b=KNDx/ep0R64E7mU0KQmHNFhriyFUD4ZYGv67/Jt6HZw/80cWCo9UqvYr/rThza+ZWYMj/zk+H94F23SiN0EViX4v/Jnu/o7QMXfajJrCKvOxyFsOw3N443GePFLbWkNpwa1q6DU6z3gAYCfbPmL18E0bVd1nsNDBSVEl3WV2j+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229605; c=relaxed/simple;
	bh=VhCW7vRIXwurZNwbV3YMAmi3ZKSjZNwGP3snZqr0BGg=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csmFJYYCjlms9pLEBFr3n6gpZ2eIJep5MB1ShZKBgeEzwydn38VadX2/eYpHu8wRbNycJE/7C6RXPFaeW9VKsjc42+8Lbe4W50inYfVitGhnB8mMHMr0F8wam400sExv0B0b3eOqXFBPv3RfNNEBxBn+g/sVU3Q3u5qm6BfzL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XulgnKH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF141C16AAE;
	Mon, 12 Jan 2026 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768229605;
	bh=VhCW7vRIXwurZNwbV3YMAmi3ZKSjZNwGP3snZqr0BGg=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=XulgnKH4jlHP07FM0FnsNUXv+kb2RHE2s3KK+u+B/mppKR3SXg2rgEDO+3nXNA7Bo
	 ZofRAnGSRijSaGHNKSr8yRU4NqTeXzP333Ty+kAcNnG0HU+s2YXf4urZ1qcodZb1Ky
	 xuYCc2SXx5Sd0UIe+b8lt2gn6QiUA4n+pxui7gXAWY0J/5fw50R+VimqGQWQf9he1o
	 i18GCrOTf6NCsjjAUJ+Zw+UHSVsiemmIwSbAe7CC+BJtiggx5RtiVPr/smOdV/zIm1
	 Wu6YI7eEeIJC6UQF9+84BdzsPijUABhgBrslSzQSbHRVpsqRWMTTSVj9o917QyD5mJ
	 vik+XsPDFrX4w==
Date: Mon, 12 Jan 2026 06:53:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jan 12th
Message-ID: <20260112065324.1f8fb086@kernel.org>
In-Reply-To: <20260112065256.341cbd65@kernel.org>
References: <20260112065256.341cbd65@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 06:52:56 -0800 Jakub Kicinski wrote:
> Subject: [ANN] netdev call - Jan 12th

Sigh, of course I meant Jan 13th!

