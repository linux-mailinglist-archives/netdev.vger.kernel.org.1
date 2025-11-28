Return-Path: <netdev+bounces-242472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70DC909B4
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2746C342F55
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D361A840A;
	Fri, 28 Nov 2025 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaIA7XpY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA782AEE4;
	Fri, 28 Nov 2025 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296265; cv=none; b=mZdbRxS/4KWG7BLMQu9R6x3Y0UpK0LGuV+j7SF6MsrR/DR5CtMLppgHsWpxDITMC8/JX5ltfu8DvZ5n0oM6Jco80SphNBG63YFrXwiauBXO/UzPQ2JduIQNy9MjkFLat6nsBgllkMyzb0ul1ID1kwiAyLXXMcP9feGZe5mRo+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296265; c=relaxed/simple;
	bh=SzV7gS7eT16VNQgode+21fYqzP9alV9kbhEuiViEoLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChCwfCwVvvpkF6nnVP1CQrmyryMIJubYNtiiOey1bGu86tNKcP2W4Jwo2+MeevwgTH3N3O2x1KTqU0hMHwt/TYQELolb6LIxHZUqCDHaDb6SwKCAQCTfmavUBoPo+bGHa+Qce4VrkqIIKz832bbLqJvShpQQT54Dd6cx5BdTtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaIA7XpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEC3C4CEF8;
	Fri, 28 Nov 2025 02:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296265;
	bh=SzV7gS7eT16VNQgode+21fYqzP9alV9kbhEuiViEoLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WaIA7XpYYx5ZLn/vi2dD2KdoJVTlG+SjHi8n4BDDSdBQb2HHu7c9QLrgEA5djDHXl
	 yErlCwNUOSUSvEdmwsghQeyIzIiJ4fwjLLw5NroOnaifBvpmwOvPYZWfwIjMr+Oe1f
	 F6adfMqjtJbXmO5JUZWbKRhaXSrj36omgvbVN/fM1DMxcvAsUsnZFpDB+c/0dFTPAb
	 nqlonrc2EPc9V9Dw5C4x2LVI5ALVRMQVXgqbWYOoIDi1li7OtmrFI9IR5th4KTtf+4
	 AenLbKQsXO790lyctulqyeuqBqBcq48Ijzut98LScKKbwIpbvohI9RZwT4XojoCrvg
	 L5zBBGL2cqMzw==
Date: Thu, 27 Nov 2025 18:17:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Clara Engler <cve@cve.cx>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] ipv4: Fix log message for martian source
Message-ID: <20251127181743.2bdf214b@kernel.org>
In-Reply-To: <aSd4Xj8rHrh-krjy@4944566b5c925f79>
References: <aSd4Xj8rHrh-krjy@4944566b5c925f79>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 22:59:58 +0100 Clara Engler wrote:
> @@ -1796,7 +1796,7 @@ static void ip_handle_martian_source(struct net_device *dev,
>  		 *	the only hint is MAC header.
>  		 */
>  		pr_warn("martian source %pI4 from %pI4, on dev %s\n",
> -			&daddr, &saddr, dev->name);
> +			&saddr, &daddr, dev->name);

imagine there was another comma in this print:

	martian source, %pI4 from %pI4, on dev %s

we should leave it as is, I think.
People may be grepping logs for this exact format..
-- 
pw-bot: reject

