Return-Path: <netdev+bounces-78906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD5876F18
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 05:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703D0281C42
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9213611D;
	Sat,  9 Mar 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiD7qAPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787582C191
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709957717; cv=none; b=fe9jdxGdYjJ+aIXQ1Cnc/164BRcNmiGVnhYfwDKKvqVceNygoyz6WPSD1B0TkP0EgS87uSZ2J8zYUJjnJQvoA8E8wwQT7h4dmQ+5uQN1CJ/NQB1BCzwRoJTHArxebgyZn/Dhj7OyRn5IBfwSHVjEx2SDDngdMwAkaJfwTHblcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709957717; c=relaxed/simple;
	bh=atQ87ZTNBX23VEUYtUJtMjpTt4pOt4rin5uq6yGwVFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7MYMmKg2mnXB+HU1gtZuwmqesFkmO7aXzoboqpuMdq3LGRB8G1sIwfjKfPplFWirigrx/N3sxf63y+LyOC4dgm1/l/1dezr0iH9+iIBQH0We2FZY3pQbwDwKXLz9B/Iotw2Nr6Li+1mPpeGtdSnM+CKvnKw+OpEWltoCwMp5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiD7qAPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB43C433F1;
	Sat,  9 Mar 2024 04:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709957717;
	bh=atQ87ZTNBX23VEUYtUJtMjpTt4pOt4rin5uq6yGwVFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IiD7qAPO39QHBgCQAvVq0ADhyu8XPFUTj6zi82+mtJG4veAkgQvgkTPKDU8LRUnKp
	 UJ8oQGbCpJeClGGw0vXDI40eQ+JxoruRcvbZxImBMJYYD3GjG0YENvSGzmyiASA1E/
	 EcGDmef3gJVhg1frb2iHzfM+STUW36sSi8jm1juCeUCn/M1Yj+I/5KRGeaig3FHtyr
	 MXbyQXMKNhmUhURkPFpofp7b+f3DA1H4wG4FE0O8yiLVTBbMjYJVhSiBiPzu2kPXMr
	 9U6K3eW2ul++sWXo12IbI088IwAb8r6FcXXdj60zON1V5xzX3oPydhfd/ZHlvTuJZT
	 2FsePfSHy6JUQ==
Date: Fri, 8 Mar 2024 20:15:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@nvidia.com>, <bodong@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Add comments to use netlink gen tool
Message-ID: <20240308201515.3b4aef71@kernel.org>
In-Reply-To: <20240308001546.19010-1-witu@nvidia.com>
References: <20240308001546.19010-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 02:15:46 +0200 William Tu wrote:
> -	/* add new attributes above here, update the policy in devlink.c */
> +	/* Add new attributes above here, update the spec in
> +	 * Documentation/netlink/specs/devlink.yaml and re-generate
> +	 * net/devlink/netlink_gen.c. */
>  

Unless someone feels strongly I reckon we should heed checkpatch's
advice and put the */ on a separate line.
-- 
pw-bot: cr

