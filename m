Return-Path: <netdev+bounces-234200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145AC1DB0D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DF0534C202
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402742F6169;
	Wed, 29 Oct 2025 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koj3qsXu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A617224B1E
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780794; cv=none; b=sqFYHPAgyMMEdx2DlJaywlp50cox9yv2JQOTQIBtArxvE2RTfOS1phiwmrFdQSZOF27/9Bgw9qaCnWlyvf5VxMdM8AzATAqYKK/JdJpqb++3Ssef8kAPNL8J5dmWPIThEGhUQPhMtXVha61txg7J4E8IhuBbFiM+ENG7olIAOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780794; c=relaxed/simple;
	bh=srXMJwzDFInEa9m9dIuxYh8FywxH/wohhkngOUjXQO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WL7Y1TwiQVY5Nkjp2R1nSdzz+vh0H1vu0kf7lbkstjFBtpHiw5h9j6QI5MnCOSo4PwrKSZqfRrC5npdCDOZxI5EmxCnvubPMQDVFNg0JLHmBczeJCWcC7qVj19q6/o/Z1ck/S570gU6TL4ywQEaGKT8q4owKAzthuUn7XodIiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koj3qsXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22977C4CEF7;
	Wed, 29 Oct 2025 23:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761780792;
	bh=srXMJwzDFInEa9m9dIuxYh8FywxH/wohhkngOUjXQO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=koj3qsXuZjiUspAs5WDcIHGP4q4G/9cyE1cs+sNgZ5PXXPB2O01FzYk63zLLJizXc
	 QsvyDLDe0u0CBUJxiCVHyXgeZ1wl1N7baM84Fp8Ae+KCOfM15vwwyk1tIa4ic3YvSy
	 AiFw+J9c4XlOBqWINT46l0jpCA3nO+nYprNJ8KqNdMuQ/uUpGAHtcrxNmeU2PQRtsc
	 BH6hm3ShpBWkBglCtGZmWE3t12pvN4Ei0HokLqwYHid6HFlZbJJ91z73gVRND/aOcW
	 lEOXnBP3eRWUNia2vKg+wCH4heM7Khc90WdMw8AqegdBmJrMWNnqyhuGtc3Vhu3C3M
	 nHYSAT+PD3YEg==
Date: Wed, 29 Oct 2025 16:33:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: gal@nvidia.com, adailey@purestorage.com, ashishk@purestorage.com,
 mbloch@nvidia.com, msaggi@purestorage.com, netdev@vger.kernel.org,
 saeedm@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug
 severity
Message-ID: <20251029163311.3ad31ac8@kernel.org>
In-Reply-To: <20251029164924.25404-1-mattc@purestorage.com>
References: <3edcad0c-f9e8-4eeb-bd63-a37d9945a05c@nvidia.com>
	<20251029164924.25404-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 10:49:24 -0600 Matthew W Carlis wrote:
> On Wed, 29 Oct 2025, Gal Pressman wrote:
> > Allow me to split the discussion to two questions:
> > 1. Is this an error?
> > 2. Should it be logged?
> > 
> > Do we agree that the answer to #1 is yes?
> > 
> > For #2, I think it should, but we can probably improve the situation
> > with extack instead of a print.  
> 
> I think its an 'expected error' if the module is not present. I agree.
> 
> For 2 I think if the user runs "ethtool -m" on a port with no module,
> they received an error message stating something along the lines of
> "module not present" and the kernel didn't have any log messages about
> it that would be near to 'the best' solution. 

I assume you mean error message specifically from the CLI or whatever
API the user is exercising? If so I agree.

The system logs are for fatal / unexpected conditions. AFAIU returning
-EIO is the _expected_ way to find out that module is not plugged in.
If there's a better API I suppose we can make ethtool call it first
to avoid the error.

