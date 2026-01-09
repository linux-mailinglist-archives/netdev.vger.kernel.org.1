Return-Path: <netdev+bounces-248576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B22ADD0BCC6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A002300D43F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF90366559;
	Fri,  9 Jan 2026 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/JRLI9n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2A35B139
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982151; cv=none; b=cv/FxxmPcfgZc8drOY55AaBgCFZZReF6wneOTJDCoqICsNIzyHozeutyDHM6tb4ibAXNsYY/IYjxvBlm93rDiRGpDqrNXxf1foY7jAFat4+w6jJZZz0lxFdVUm+cWFToBP3O7FQ67NfN04VCMEjfeXfGiBM63CH6Y9Ctg6aRtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982151; c=relaxed/simple;
	bh=N8AcFJdDoo60pGQEJRYNNa8iodgu9i+pDf9cwbJDQtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkcCf25rtFRjX7a/xb2sWQL1jjOSQvhbWllQ+226xMXcGVUfWEZJAZBSFcjN6Xs//TIYEAIt1BVU872HSMyWDQ/Eof+Lc0Icy5ohO7qk/H7BZ91Q+eopbjWjimz5ww/qrTAvaRHexh/wxV/KLlZ8KWoafi8RDkXf3m/Ew6JbrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/JRLI9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B1CC4CEF1;
	Fri,  9 Jan 2026 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767982151;
	bh=N8AcFJdDoo60pGQEJRYNNa8iodgu9i+pDf9cwbJDQtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/JRLI9n3ra2vOCJW4HCJlSnW2jXSxTvbhR4THGi15Vtk7R3tfyEhUZknNvGa+M19
	 jYlcUy7OQlp6OmsSvmvwgNJ20bA5Lus8hNEQSg+8+3tAha1RY8kpSb7UBOejvTAVfF
	 lXvR/5L+7bj0ntObN3+/qt50k5szIqkDw8P0Ay9dMW0uEWr5JXqc0O0TZiJRx0VD81
	 N/E3T1BzzUVB4AibqmSomO/AmTD5dvjBQLdVGMzSUxLdOqpPqoMNETCtkN1k3kvKDu
	 TgFbBlCMY8pycDCIDyZSC+WyMTWQ/cBEq41Lx9JBuhN5hTCiphoZ42U2227D3HQBGn
	 azesr5hAxIJ5w==
Date: Fri, 9 Jan 2026 18:09:08 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: tehuti: remove function tracing
 macros
Message-ID: <20260109180908.GP345651@kernel.org>
References: <20260107072401.36434-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107072401.36434-1-enelsonmoore@gmail.com>

On Tue, Jan 06, 2026 at 11:24:01PM -0800, Ethan Nelson-Moore wrote:
> These function tracing macros clutter the code and provide
> no value over ftrace. Remove them.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>


Hi Ethan,

I don't think this driver has received much attention for some time.
So, unless you have hardware to test changes on, I would suggest
either leaving it alone or, if we suspect there are no users,
removing it.

...

