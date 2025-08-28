Return-Path: <netdev+bounces-217830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE47B39EE8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950D656471E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531BC3126CC;
	Thu, 28 Aug 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAJ7C4XE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B991311C01;
	Thu, 28 Aug 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387740; cv=none; b=IIAztaoA9msKVJHUqiqdgqrBnS6L6JntLWmKY6ROCVounKhYORbCIIhvPo5lMndmAly/v5lIVgSCvLpCx4R+4t3sDMxOvxiIolcta/GOBokwulsFMJoMjW3nQT97aQhLzHj3AC2g6mmp7so9tCqOdVGANZv4pNE2KahsBOb6Zds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387740; c=relaxed/simple;
	bh=a8JHIINtiWA7YVZdVb+yiDyViWRKkCnZbCDfad+OfkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGXWCwQhkFBFBodw8Hdbwfq7VYnVEwFbz39miJSE/3U3HOY8SvO5JDp/hqI3B9u8TTXAAhAo99HqYhU8UDR0lDZJYShAN0Mj9CstSIT0V1MrjtXzLYfoWTO5/Qwk2Hot+rgmbLPXXCzmUoNOm/AVJC4RNKYtpHYmqwzm39Ksu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAJ7C4XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C386DC4CEEB;
	Thu, 28 Aug 2025 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756387739;
	bh=a8JHIINtiWA7YVZdVb+yiDyViWRKkCnZbCDfad+OfkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAJ7C4XE0ZXw76nxlPEtvNTBUmvJeTzCKTEWNuTX6fKVrtxYpwPpsbT8P/MuAbhka
	 YcK7pv3obRVjgGkGDzyrXRXztXDrK8PomcYr3dMeoIPtY7rhsuDWNmPNlOcBEF9KbG
	 H96oZ58SUzM33hc1xMwkgpeBDNNQxafdzrK1JFHPxcDQBcm1rzPHDVi+9cVPAATQEt
	 0u/Rrj5PANgAH1sFUhtLBQEtLbtdC45w/083xh485TZ/v8DG3w8Xpzda64WTh3xKzl
	 8gW0lgdqCC/jDuNj5puNzGssG5oInTct4gU3A/Fnmh6nkp4sl6NL5Q2guHNBJm1ecs
	 JCBiMUxOd2hVQ==
Date: Thu, 28 Aug 2025 14:28:55 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:AQUANTIA ETHERNET DRIVER (atlantic)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: aquantia: Remove redundant ternary operators
Message-ID: <20250828132855.GM10519@horms.kernel.org>
References: <20250827095836.431248-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827095836.431248-1-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 05:58:33PM +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr


