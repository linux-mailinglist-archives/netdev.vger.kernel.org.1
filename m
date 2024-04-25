Return-Path: <netdev+bounces-91449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CB8B29A2
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57567281E17
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D4D1534FC;
	Thu, 25 Apr 2024 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F0lsvCv9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510215250D;
	Thu, 25 Apr 2024 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076552; cv=none; b=VEKypFUxI8dVM3MgxyAUbykF5p19wgubUCmh+L0C6DxEy9j1nApsIWzXkIHAEWbxMLgivbVle5ZBGQ8W0N74iMLYILhXNXKCtNclpE0EbknKOZduBohPffsV/VCe2tY2LXePcwb3wcdQvFLl9iN40GOf0SyLbF/O3Imt7Siwtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076552; c=relaxed/simple;
	bh=iY/YqeSYhU/HR4W6nMkGqDZLbFNVXXqdil/ssUvHapI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddcKN/TUlZ4z3wH0tuR9LXUVoOO6ka2fjzm3Mp6RnUjGxmzwqW8XYxWBuoJTif9sFIhPH38qAADxLpxl1qbmu+TU5gtqQkrPOGTKsdBsvaLEEsL/BZLliPbHipwCd5Gp4jMluexfl+bi9kAhkTA6VW579bi9/9SmFF5BKtCBz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F0lsvCv9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1S9WPFSJU4dUJ5lqX6EbRE0n7VBs3SkuGiMw5pUdzL0=; b=F0lsvCv9eGsS9rejykVhEDbh/k
	qLvWU5esmLEFG6hKJnqKI4gycP5a1Ww7RGu38zDb4EACxLcg26HUVGPgLYn0uKFxAWHiaWjcLrwq4
	4QxEYCDEYL3dEySc1+TIYpT86IhOY5rYYROmBA7N2iYVxp6YJZh6J1H9rjg8fhMf/wIo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s05bw-00E1Eh-N6; Thu, 25 Apr 2024 22:22:28 +0200
Date: Thu, 25 Apr 2024 22:22:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] Differentiating "Supported" and "Maintained" drivers on
 something other than $$$
Message-ID: <0673a490-cebc-4b24-b231-95ecd15b5a41@lunn.ch>
References: <20240425114200.3effe773@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425114200.3effe773@kernel.org>

> The new guidance will take effect starting with Linux v6.12. This means
> that any new driver merged for v6.12 (i.e. merged into net-next during
> v6.11 release cycle) will need to come with running CI to be considered
> Supported. During the v6.12 merge window all Ethernet drivers under
> Supported status without CI will be updated to the Maintained status.

Do we have any drivers which today fulfil the Supported requirements?
Any which are close?

    Andrew

