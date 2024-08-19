Return-Path: <netdev+bounces-119800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991595701D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43D91F223AE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278E16C87B;
	Mon, 19 Aug 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCB+hFDj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711F13BAD5;
	Mon, 19 Aug 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084638; cv=none; b=lqQ24bYMpeWKR3P7lkDYID1V8eYmX6Y4aeetOLSbHEqlozV8EbWJXaYZDrZn4rZWlwWDxnwgP7exdy06HXyuC/H9EDZ4OpWI/NmTpYF3+ORm0hXfixvPiA7vyy0cakFagxl3czBqOhwQZU8Mn8dp3TcDSDbxgt1ANodR4ozwtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084638; c=relaxed/simple;
	bh=5mV+Zhd6KNlntw7MW/3UDT6FPgANySoyiqqOSRowSBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN4G+d3yj1AV1h1gt9Xjiso7b3sd1llSb44unczbuuhO8hXOI6b0PC5zt9Mt9djqBE6i17gH164M1hLdyAnM9y6MQbj4+aG6rewgM1TIXtQwGd6kep7j42dyZuOeFINBJG6xHUXdh6IVbG/rUDj6WX4hgQVu55lvxVRR0A3paVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCB+hFDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80543C32782;
	Mon, 19 Aug 2024 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724084638;
	bh=5mV+Zhd6KNlntw7MW/3UDT6FPgANySoyiqqOSRowSBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCB+hFDjE03yW30Rk/eocUOyqaCUqggMXScVmk/OoTFOKeezkDaz4kOsoVTabHzPU
	 SC6zxsaZJxKyRxOZ/0rNZcm1BYB5IpOflSEUVAhA7xthSQ1bu1iJctAzzoK7EDXife
	 w1f5fyFmNa9folOGjRhB3khWS+6r4zVq2tUhPyJM51+n62BEGKqfg6HVKSX6DVqoJ+
	 xp1f8+RVAZTjeNT/uHRDFj7xy+udPATk9OUPqDntrgXK1hNm4bNvZOnXyNPpkhkxCh
	 Ruzf/tMAaSLwcBjIQyWH0VP/23MQaFkViNUxdQ3TfrB3OAqHGL33RB8QJ+09+GSLiI
	 Skbzlwrqev0Qg==
Date: Mon, 19 Aug 2024 17:23:53 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk,
	kuba@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	richardcochran@gmail.com, rdunlap@infradead.org,
	Bryan.Whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to
 configure fixed link state in phylink
Message-ID: <20240819162353.GJ11472@kernel.org>
References: <20240819052335.346184-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819052335.346184-1-Raju.Lakkaraju@microchip.com>

On Mon, Aug 19, 2024 at 10:53:35AM +0530, Raju Lakkaraju wrote:
> From: Russell King <linux@armlinux.org.uk>
> 
> The function allows for the configuration of a fixed link state for a given
> phylink instance. This addition is particularly useful for network devices that
> operate with a fixed link configuration, where the link parameters do not change
> dynamically. By using `phylink_set_fixed_link()`, drivers can easily set up
> the fixed link state during initialization or configuration changes.
> 
> Signed-off-by: Russell King <linux@armlinux.org.uk> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
> Note: This code was developed by Mr.Russell King.

Hi,

I am wondering if we need a user of this function in order for this patch
to be accepted, as is often the practice for new features.

