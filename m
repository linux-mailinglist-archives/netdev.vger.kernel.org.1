Return-Path: <netdev+bounces-222112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D201DB53261
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA7D7B8017
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F7322528;
	Thu, 11 Sep 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkdZcT7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32A3218DE
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594096; cv=none; b=shDurrQeq2KDusuAPug6M4AheD+77QlcAW0qQn86j2ybN1ZmBLYGpXE0bsP6HwgmuGiZcrmkt63WAx8YouOfjH7Jnk1r4PYXy6sF/FTbJhnmNI98a4Cbepy1uao2QqO4kM84bcHHRxZqVC0l66JFGJA/zPhv0X0mKWEYXnpkWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594096; c=relaxed/simple;
	bh=skHi/yYt3vq5RuwKXxRdTHdLDH8mNuEdbyXsWZ2FjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoV3XMkacaIb+tnzyfoI+JKHGURLGjyFTF165xvwrfQHCXZCtaOxM8oqQKUCWa6LUzwWgRWcf8pfuhXM3Aar/SDQyae+CBBpq1ECWS7WSPxvvsojFe9EHP9v6Yn7BZDXzJLppOoXrh1mM1GD+XUF0wC1+ZZxqmo834c7fwBoIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkdZcT7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DB2C4CEF0;
	Thu, 11 Sep 2025 12:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757594096;
	bh=skHi/yYt3vq5RuwKXxRdTHdLDH8mNuEdbyXsWZ2FjW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkdZcT7j+BHbC8cfixmh8vn8O/Skx1cSs8sQZwF6reUi0YsqmyHtVYBnZJYQ4yrxy
	 9JEkm4fE8HEJMwFyggrqPVZNd5lcs8L0vYiAABsnHIJyvWnAKKMMSQ6H2GNYkiprN6
	 RGlYXVPfhV+HOOsw5Wd6UJD8vaUasm5z99hBboRc4d4RHXKYf/rBkJHnJJVJYGIGUf
	 +JPfbDQ5yTgTG4fIEai4IpVBXv5x0m/x9aZCHRGWoEUo4Mu9pUqOrDhEV6FfgMKgRX
	 A14fBykX2a65hI7cYtQx3LwhVYgLKDyA0nFB5roa3XneVdMOFDW4O1utsTUmGmQeCq
	 eR7RU6KTc8W/Q==
Date: Thu, 11 Sep 2025 13:34:52 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ipv6: udp: fix typos in comments
Message-ID: <20250911123452.GK30363@horms.kernel.org>
References: <20250909122611.3711859-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909122611.3711859-1-alok.a.tiwari@oracle.com>

On Tue, Sep 09, 2025 at 05:26:07AM -0700, Alok Tiwari wrote:
> Correct typos in ipv6/udp.c comments:
> "execeeds" -> "exceeds"
> "tacking care" -> "taking care"
> "measureable" -> "measurable"
> 
> No functional changes.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> v1 -> v2 
> added "measureable" -> "measurable"

Thanks for the update.
And sorry for the slow response.

Reviewed-by: Simon Horman <horms@kernel.org>

