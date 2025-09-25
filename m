Return-Path: <netdev+bounces-226219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12391B9E31E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442DC1BC4314
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1890277CB8;
	Thu, 25 Sep 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8kQPhRY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950202747B;
	Thu, 25 Sep 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791323; cv=none; b=QTWDcJwHWzSvIvCjLrV/f5tbrwu/rPSJDoffCGn1NllY8eUWpmBs9/NX9w4cce6vZBpf4hLN1xSSftTE3x6l19UsHW99asTpGmQCShSBs0OO0HVd9LSedp4szDl2tNL2qQ3EyTrEnB1mQfUbVihy2fyVAgt770PUr4j1PSTjzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791323; c=relaxed/simple;
	bh=VjqXoY/wdBzy6KTAu1QM/KmRTBhmBOg6K71FyFsG1nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdbtKTEWIASW75EPvtpW5cV7A92RFHovBxxcQx/rXTZFoDR5xTfDrX/mWpcduHyDMe3oFjjBxA+WqY2Sjz93cVW9gDbr93ISK3+C+oOKsjaN72/xTkd1YsXMmdS9rJdrpHRmxjQ7w0gHND2S5iS0NoliCSRoYdgGduihWh0XlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8kQPhRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA09DC4CEF0;
	Thu, 25 Sep 2025 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758791323;
	bh=VjqXoY/wdBzy6KTAu1QM/KmRTBhmBOg6K71FyFsG1nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8kQPhRYbLG9i9vYBc0VFDSy0hXvdl9iWEwhGXcihvmG9stAiDXPenfi2Cd6kN9wo
	 /le+B/qgUpa/6z1t5fTtPOE51LxQhA1FjdG1gT3wGb8i0MZLCoGHjvig1umbfOvrFX
	 0VpbnSsODGt1P0SzNzHcRkZRQ8rKLUVfcqEnD/9oPLYDoj8XaY4VtTjmWCUfyldImv
	 lCY7H9LzMAbXqdtC/TJLOYC7oqodj7QTieNfI0EgqUOmR0porhcEMZpgL9ivyp42Wc
	 1kB8lhbogSf+/6rwMCl73r5NcdYVmcnE8FD5I2dOyqDFJYQfL9vblXN3QMKccqlfuM
	 FApQeAQGNQqbA==
Date: Thu, 25 Sep 2025 10:08:38 +0100
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next 2/3] net: dns_resolver: Move dns_query()
 explanation out of code block
Message-ID: <20250925090838.GY836419@horms.kernel.org>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
 <20250922095647.38390-4-bagasdotme@gmail.com>
 <20250923101456.GI836419@horms.kernel.org>
 <f41e4063-ac88-4444-b932-cc1c7cabbd7c@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f41e4063-ac88-4444-b932-cc1c7cabbd7c@infradead.org>

On Tue, Sep 23, 2025 at 10:00:55PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 9/23/25 3:14 AM, Simon Horman wrote:
> > On Mon, Sep 22, 2025 at 04:56:47PM +0700, Bagas Sanjaya wrote:

...

> > > +Then you can make queries by calling::
> > 
> > Please use imperative mood:
> > 
> > Then queries may be made by calling::
> > 
> 
> I think imperative mood would be more like:
> 
>   Then make queries by calling::
> 
> but I'm not asking for a v3 patch.

Thanks Randy,

Sorry for my incorrect advice.

I also agree that a v3 isn't necessary just for this.

