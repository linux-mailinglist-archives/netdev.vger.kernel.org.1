Return-Path: <netdev+bounces-157090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9612DA08E2E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7206918838D2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A720A5CC;
	Fri, 10 Jan 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4z2qi6j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9A18FC80
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505555; cv=none; b=FMR3PIO/9t9jU5jW1oyjazdlZfxz2IT3XpH1q/5nI0CIHtzIksmvIgOVZbHmLN+N3ASTDfrK6SrL1Efs6iN6QHz2IqpMukTsffhs1knVR20Azd5shVXDq9hH6PSqnSiWx9QAwS94JEBifaE7GqlSIjpmgTRQeDYPc98oGvZYZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505555; c=relaxed/simple;
	bh=liHfGPdEEMc8smElUS4q7f+q7ez5lGK78TNTVuGso4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5grIGqi1CwBleJMdylKboeZJxRCMsE1hWx5cBW9vFoeULLNJCZlqqDeidr4Zrz46pPz/IgCdF+7b4tjwDiK1WLKnYTgUnX/AGLm/tyi4Fhdya3AHUTvK9pNMVdDvTMDqhPwYkWrEVhKuk52P+yOFkqk+L8ySX6AnaYuj7wg/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4z2qi6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE7FC4CED6;
	Fri, 10 Jan 2025 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736505555;
	bh=liHfGPdEEMc8smElUS4q7f+q7ez5lGK78TNTVuGso4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4z2qi6jgCstLrDRl7hJcKlE/YfnHjlCSyX5ET2wE3eXXLz83rJ9dzXNQ18X8iO87
	 YJ2tKtNPYzTQuKEIcud9AvhHrlVGUdL/ZjCHVpwvZ19WPZ9yC5qWItI21TgEUBuGnW
	 DDpQGma6WL8HllCDJcHaMH8IFVXzpg+1g5a25Dg3mRqP0WxS+dabc3OBrlqPKa3c0t
	 sqZEuM2tTjxcEJlqFokMSJvGb+HJscWUbnfusPqo21P9qIemgX34LO5Lu/4H5vngoe
	 rSifc1LLC6Ue0n8cyQdzSy6utts1MzpdnDHS4MWdwIOQTMLQDA+WuaY90tbGiwIaBY
	 2LCQPhYQ8lgFg==
Date: Fri, 10 Jan 2025 10:39:11 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next 1/2] docs: netdev: document requirements for
 Supported status
Message-ID: <20250110103911.GW7706@kernel.org>
References: <20250110005223.3213487-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110005223.3213487-1-kuba@kernel.org>

On Thu, Jan 09, 2025 at 04:52:19PM -0800, Jakub Kicinski wrote:
> As announced back in April, require running upstream tests
> to maintain Supported status for NIC drivers:
> 
>   https://lore.kernel.org/20240425114200.3effe773@kernel.org
> 
> Multiple vendors have been "working on it" for months.
> Let's make it official.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/process/maintainer-netdev.rst | 46 +++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst

...

> +The driver maintainer may arrange for someone else to run the test,
> +there is no requirement for the person listed as maintainer (or their
> +employer) to be responsible for running the tests. Collaboration between
> +vendors, hosting GH CI, other repos under linux-netdev, etc. are most welcome.

nit: are -> is

> +
> +See https://github.com/linux-netdev/nipa/wiki for more infromation about

nit: information

> +netdev CI. Feel free to reach out to maintainers or the list with any questions.
> +
>  Reviewer guidance
>  -----------------

Reviewed-by: Simon Horman <horms@kernel.org>


