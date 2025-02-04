Return-Path: <netdev+bounces-162737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DCEA27C7D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B191886424
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92B0217660;
	Tue,  4 Feb 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDnlRUzx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE92063DB;
	Tue,  4 Feb 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699667; cv=none; b=arsm3TH0wiY+CcD3iXUwxWSo3S0GvWzhXdrB+UH3sGZ25QCexOcGZoHmX5nyezQCxZZyT+oC0sm0mHACscuTGW2S2sRswPf7FNdywez4Cb+AUHHADH7iZwquWeW3yp6KZ0oiG5H49+sfIt4OoV4XuWLTt4R5iLxceEppwboOqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699667; c=relaxed/simple;
	bh=5sSQ0HogpGQH3tWc5HY5mHvrRAVw5GKB8RCCuVydRrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDYQ/MOq5qz+queJs1KBFCbfz/b2T/bxWYqDJKXtAirXd23BeomDwiLjZfCdzJUUToqTR9LOYDUw52hwhhFccs0bG1IHS5XkP0YCwwTDjznIiFNCblbHtyXcIpm7/dLyulZjz8jb0vef1WWXbor6/DgDm80UOKGNDEtpG1NcJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDnlRUzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0B4C4CEDF;
	Tue,  4 Feb 2025 20:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699667;
	bh=5sSQ0HogpGQH3tWc5HY5mHvrRAVw5GKB8RCCuVydRrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDnlRUzxFclO0Xz3jXXrKnPvOmh/NdHHEJcXo4quOHP9f7Z5j12nuQ5tHtjMu71rm
	 ikQKkySUI+5jRiGCBh0gv+SICxS61f5EaFE/+tV0WN6FuN9VkD6jEv27R3sAokJq2Q
	 AfXRmcehBvnGoaHiIBbkh2ie89WvdT3LZfLI7UsgR8PF+CuU+5NivZ+fjcflVfKC7M
	 sdFWGBenDFAaW8qvfUBSy/M/t2vrWY/OJMJsjh1euBHOBHXosoXal7UaWgeeOZwGdk
	 MSaNRI8Ec9yDpZSDJQ6UeAaCEBhtU27AUFOqnm6/he4Wph7fSyGm1jew9kcaxb/uUT
	 3h/lsh18R+EPA==
Date: Tue, 4 Feb 2025 20:07:42 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <20250204200742.GO234677@kernel.org>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
 <874j1bt6mv.fsf@trenco.lwn.net>
 <20250203205039.15964b2f@foz.lan>
 <20250204115410.GW234677@kernel.org>
 <de8d372b-0f2e-4c42-9d6b-8aecbb4645ef@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8d372b-0f2e-4c42-9d6b-8aecbb4645ef@lunn.ch>

On Tue, Feb 04, 2025 at 02:25:07PM +0100, Andrew Lunn wrote:
> > Thanks, perhaps something like this would help:
> > 
> >   Using inline in .h files is fine and is encouraged in place of macros
> >   [reference section 12].
> 
> The other major use of them in headers is for stub functions when an
> API implementation has a Kconfig option. The question is, do we really
> want to start creating such a list, and have people wanting to add to
> it?

Good point. Maybe it is sufficient to just make the distinction
between .c and .h files.

