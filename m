Return-Path: <netdev+bounces-176099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E42A68C5A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244F317D478
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8770253F31;
	Wed, 19 Mar 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5ta34LL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8D1E1DF4
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385894; cv=none; b=P1aYRra7vVwCs7YGgiiXDvJ1J22x79rJR8K4F9l7dJBa0s6MOtEOP7I9Uh/+LQE/j078YNkBi3rC9GpHgmZ+MoL62/f0Gfo5R3/fmnaFv+PDvM/QOq4AsSxolR0IoVIkTCbPaH23Qgz0iWDb0W4wKR+kfUxkp9L/EDHVVqDk8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385894; c=relaxed/simple;
	bh=ZMyrHvoitlakcORiVIIG1lITyXvRn4xC/X59quiAAYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk9NXDdY/F5Pm+bcI7vGNA1FVRHQDrpheQeby92GJsGnzsCIxWBNEl9KbFf2mDzWErpVGV6aasod+BRWcMRv8lWbF3NyhTOuzq51Yxqe4cUdZT3jRnvrIqdrATn3EN+3OYPUUyofmzmPvlkpyQmcGPLCnSPmPMPEDTJvOp8pJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5ta34LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903D5C4CEE9;
	Wed, 19 Mar 2025 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742385894;
	bh=ZMyrHvoitlakcORiVIIG1lITyXvRn4xC/X59quiAAYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5ta34LLabktBe3js2yXymEo6qV78K6uZ3OPCqjAhKOMvHFL738uHDkd8iMUw4pj+
	 KMXHSOxgOekYObIyCNKRM68r79urWU9cCLGoUED0fm92vAmxS02nYK+2bMwRHE9XE0
	 FJRsJm+A4khaR8R14YFzQNJm1TfFwn8ZDsrECvVrfXjdl8Z5n6xpZDqxuR82Mu2sj3
	 Xp+NHg558Ywdc0lhf0vVqe+vjHimWzs8RYSid/ej2cYi5cpr7Aeo5rRFGyxnnVQ3c1
	 PD3iuO4owD/DWuimXoA1PngHCRkIIIKDdD6AoJbJgQMJcOfT52gHNCgaUF6pPsMnKz
	 xeo6K9vOCi3fw==
Date: Wed, 19 Mar 2025 12:03:20 +0000
From: Simon Horman <horms@kernel.org>
To: pwn9uin@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Minjoong Kim <alswnd4123@outlook.kr>
Subject: Re: [PATCH net] atm: null pointer dereference when both entry and
 holding_time are  NULL.
Message-ID: <20250319120320.GA280585@kernel.org>
References: <20250314003404.16408-1-pwn9uin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314003404.16408-1-pwn9uin@gmail.com>

On Fri, Mar 14, 2025 at 12:34:04AM +0000, pwn9uin@gmail.com wrote:
> From: Minjoong Kim <alswnd4123@outlook.kr>
> 
> When MPOA_cache_impos_rcvd() receives the msg, it can trigger
> Null Pointer Dereference Vulnerability if both entry and
> holding_time are NULL. Because there is only for the situation
> where entry is NULL and holding_time exists, it can be passed
> when both entry and holding_time are NULL. If these are NULL,
> the entry will be passd to eg_cache_put() as parameter and
> it is referenced by entry->use code in it.
> 
> Signed-off-by: Minjoong Kim <alswnd4123@outlook.kr>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Hi,

I agree this is a theoretical possibility, but can it occur in practice?
Have you observed this problem? I think some analysis of that is warranted.

Also, Smatch tells me that there is a potential dereference of mpc while
NULL. Perhaps you could look at making a patch for that too?

