Return-Path: <netdev+bounces-186078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F01A9D007
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6FF7AB5F8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7371A1B424F;
	Fri, 25 Apr 2025 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4akh5Ll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F1191F74
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603507; cv=none; b=jRJfZdCGCKl9Xfw3QgiL6bMhBWxC/N+UgXn3qXeoYr3q38YtALJifBzc+b2HiuIC4Rr4hTKFwFuzHX7Px8pZseYha48w0Adfme5VH3caYBuqDE9kN6+VruahiRG6zuKxZCnOGbHE13lRDe4W0gf5KApS4ySuGHFj0XaH3TCrTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603507; c=relaxed/simple;
	bh=fpT/qX457YU2Zza6G3iWC4fjaELLorRrFMo5HBGKfiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFfhZijv2Q1oVFEEy40r/HMhpI/pbFVItRSc91WRsaXjXtGr0Y/E8HfTT0QPtoIhOO8Dabkqn8KaAeI//CFlmdL4elDOUrNy+Dn/KmILFlwKi0nmxUoD0HtxJPkT1i7RmQ8T5NeQby3lufl8qgG0yuZWuD05GVattUt5d6aQmLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4akh5Ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2322AC4CEE4;
	Fri, 25 Apr 2025 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745603506;
	bh=fpT/qX457YU2Zza6G3iWC4fjaELLorRrFMo5HBGKfiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4akh5LlBwBGX5t6unZl80JMMqiWd/P/kSjkcQotfTcysaCQC9dLqR0yqp1OxXPiZ
	 MDomP/nOnWiUJ+LxP1sqyEHmNorSZL0sOuTXq/JiGAU7VYPfIZvWOi5H0H5PRIq9y/
	 L3EI2iiyDzr6JK+WLIJDGo2ZALrldegx+cwcWMZj7+qPjqRW3HuwRxArW61tP40ciO
	 z+8dQkf5KZn8chwS9kQHwjhAoSlp50fQMuDnI8nvWb8rFfvjTwBRfDKM32pmsWyyLB
	 1DhXfgnwiISwabzhe6fVw5BwrrFyM7ESC8aprEeTxRhJw9bZjeTkJTXxtuHtZDZVbY
	 Qi1MGzsFr10qQ==
Date: Fri, 25 Apr 2025 10:51:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250425105145.6095c111@kernel.org>
In-Reply-To: <l5sll5gx4vw4ykf65vukex3huj677ar5l47iheh4l63e3xtf42@72g3vl5whmek>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
	<20250424162425.1c0b46d1@kernel.org>
	<l5sll5gx4vw4ykf65vukex3huj677ar5l47iheh4l63e3xtf42@72g3vl5whmek>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 13:26:01 +0200 Jiri Pirko wrote:
>> Makes sense, tho, could you please use UUID?
>> Let's use industry standards when possible, not "arbitrary strings".  
> 
> Well, you could make the same request for serial number of asic and board.
> Could be uuids too, but they aren't. I mean, it makes sense to have all
> uids as uuid, but since the fw already exposes couple of uids as
> arbitrary strings, why this one should be treated differently all of the
> sudden?

Are you asking me what the difference is here, or you're just telling
me that I'm wrong and inconsistent?

