Return-Path: <netdev+bounces-119050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C9953EE8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F6C28542F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A069417BA1;
	Fri, 16 Aug 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUQ6+BDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B4B647
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723771541; cv=none; b=TMV8TG3vGEVdnOiRYKAH1YTktgknyWtVOY+j3kpHBp3I1dcffo4/mOHrFg4bWeGuuRhCOmVt68nh4ZBHbmqyzzkH7ZVPRVG5HTBAokhI+T2sUHj1m6iVhCGvdnqbkGKyumGlXM2hPJmfZWLBKA20gItELzC5n2AtWJ6Ish+O/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723771541; c=relaxed/simple;
	bh=nvhypmzmOjvFBI+SkKeg++BXhLKAQdePZu33+HFC4bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcN71mYT5nK6RqGFIfTBJZygQUpP5DJZ0MEbRK1dUX+kDBqTgyzOpesirWUsS6zCQP5H1PQBwiS89ddlxXgx3dZWCPKziQxO0lmvdyl1JDQ7A6UTb6JHJAbc1d9oJnyW/+hS9njjsNSYLdNUPvMJmEWy0l2z/A83IcLTE2iKUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUQ6+BDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B72C32786;
	Fri, 16 Aug 2024 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723771541;
	bh=nvhypmzmOjvFBI+SkKeg++BXhLKAQdePZu33+HFC4bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUQ6+BDL/NCEZF43nr9Pz956i8kbntEaP/8AsELRSTh7MRVHhp6FZT46yeX1472Dh
	 Dze26MOcJFN7k9EbyvETopSrK5uYmjUAOTTVRz6AMgAgVyZvQCW2K+aJCIYIcHful0
	 qrdKqnnxBzv1FYqpKhL5FSLtlZg1/RZsJoBo8HDyeAIuiwC1GqwmBrYTSkju10HTFl
	 JRRcCiVOnEtGmnli3V6DAtSbFFOY77miyjrC4vN07P5apnlTtdngcu+T4mYW1nyi+D
	 ysnI8nScEZoa8noU+jrFIclZPuPZ6JpEJsZbsMSorNrKlKKQgK+DzVgYgchYYULyXg
	 zpbavisV8QCEA==
Date: Thu, 15 Aug 2024 18:25:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, faizal.abdul.rahim@linux.intel.com,
 vinicius.gomes@intel.com, sasha.neftin@intel.com, richardcochran@gmail.com,
 horms@kernel.org, rodrigo.cadore@l-acoustics.com
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2024-08-07 (igc)
Message-ID: <20240815182539.7388acd4@kernel.org>
In-Reply-To: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
References: <20240807231329.3827092-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 16:13:24 -0700 Tony Nguyen wrote:
> This series contains updates to igc driver only.
> 
> Faizal adjusts the size of the MAC internal buffer on i226 devices to
> resolve an errata for leaking packet transmits. He also corrects a
> condition in which qbv_config_change_errors are incorrectly counted.
> Lastly, he adjusts the conditions for resetting the adapter when
> changing TSN Tx mode and corrects the conditions in which gtxoffset
> register is set.

FTR appears to have been pulled, thanks!

