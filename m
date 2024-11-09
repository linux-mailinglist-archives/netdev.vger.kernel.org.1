Return-Path: <netdev+bounces-143541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE1D9C2EE3
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9171C20825
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7719E83E;
	Sat,  9 Nov 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqjQKT6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1719E81F
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174131; cv=none; b=V2e9tCh58LnAklqr6dcwijOwwoJ8zXqb3RGRPy278WGbU7rTVOY+fwUG5pUSWHineUSRWXNSHk1c5FTDQx3bXIcm854RiMFF6vaJh/CH0Qf/F++YivWwZevuVsoTo1dDqyInzrT4aQ56XtaefUuV8plk1MwWw41tk5gv7/roF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174131; c=relaxed/simple;
	bh=O8KRtIC7KOUZqNirfRdUs1qWbVHh+PFQUNFtJHyrXC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSx0fPfGK0oU0XLi7D9LJnsQIvrdpYo1wyQ+69j2viCV2cf2wroS4tNvdL4AKVK2dyFLNt+Dqp0fSuGgSoiNoWeOC32Miqtv8TKOYAbfS4D6tvj12aAc8OdWNqYXOMVxAWyLzLU5taSbMsNAQa0GY/jf3K/lLzS8ElJk8TvDy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqjQKT6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF33AC4CECE;
	Sat,  9 Nov 2024 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731174131;
	bh=O8KRtIC7KOUZqNirfRdUs1qWbVHh+PFQUNFtJHyrXC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FqjQKT6supnfELuvQF8r1nwfF/CfThGggs84Pfy4L0WpX8MYimHrTh6lzhHj8E24s
	 f9d+AnAv7OT3HmU8PYaWEtsOeRE0DskSZN65/dMaQ529mNPTB+f781PkGEcl8V2EPh
	 cx/DWF/GhGCfeXrj0xp9AigmJtltLwzwIo5UNciNfE5vqNcGnVEmxwS+Jo1Jgdydz6
	 PCeufhjNLrneOaZvaZ6XtW6Jsb5UYJgQFqQfJg141JYpM2PtznymFNqwye7zY6sykF
	 EY6/GLQP+KE+lJNvtk9/5K7yMJM2OPTMtgTnyxUKfJsWtSgGb6HFfTuRyeFeBVmrsZ
	 IX3V8dMhG0i5w==
Date: Sat, 9 Nov 2024 09:42:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context
 action explicit
Message-ID: <20241109094209.7e2e63db@kernel.org>
In-Reply-To: <58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
	<ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
	<Zy516d25BMTUWEo4@LQ3V64L9R2>
	<58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 21:13:50 +0000 Edward Cree wrote:
> I think sensible output would be to keep Daniel's "Action: Direct to
>  RSS context id %u", but also print something like "Queue base offset:
>  %u" with the ring index that was previously printed as the Action.
> If the base offset is zero its output could possibly be suppressed.
> And we should update the ethtool man page to describe the adding
>  behaviour, and audit device drivers to ensure that any that don't
>  support it reject RSS filters with nonzero ring_cookie, as specified
>  in [1].
> Does this sound reasonable?

I'd suggest we merge Daniel's patch (almost) as is, and you can
(re)establish the behavior sfc wants but you owe us:
 - fixes for helpers used in "is the queue in use" checks like
   ethtool_get_max_rss_ctx_channel()
 - "opt in" flag for drivers which actually support this rather 
   than silently ignoring ring_cookie if rss ctx is set
 - selftest

:(

