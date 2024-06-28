Return-Path: <netdev+bounces-107719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B797B91C1AE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6280F1F26DF8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556D1C0072;
	Fri, 28 Jun 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LkkUJSL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A71DDE9;
	Fri, 28 Jun 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586361; cv=none; b=RQSIr/Wcq872lT0bQIJ+ER3BTDifu8dbohfD4UBXCQ7+N+Ggtyag2amQ/6w/bCnYzI5LxYe71CI8od6v0W+NUz/88BuSGeuPJozFNzUa1UQE/cvATguRp2Px/JZNBRREoZwSmgzizd4L3xieHLTs4+D3QqVNlTssiNhinsuMTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586361; c=relaxed/simple;
	bh=vZ0Gd1cDcY3qQgSgEEFxAnyHcWcTbNetGH8Pbn/F+Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCzDa2gk/8rKr8+Dk52Htx8XpqjtTIFn+BD/RWnr0pgY4XSDBwVODb83uRRo4BAvy+GW39JK/A8dmN1V8lKzE0DIYaeSFWsUyhO0L+Ur757G1/fUm0U3hDywJ9SMkx7mV099m20YHHkr/p9VsCG91M5UjSPx0aelutS5oD6F+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LkkUJSL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7062C116B1;
	Fri, 28 Jun 2024 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719586360;
	bh=vZ0Gd1cDcY3qQgSgEEFxAnyHcWcTbNetGH8Pbn/F+Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkkUJSL4BYMLJYkIhLyd0kRePbat2G4F7GxYVmxfA6CpmlVPnXrmEp21xnmJyz+I7
	 GcPeeji+WGmtHkazMOImbWzGoofNsaFFpu/9CFrkfoWi2KIr3Ve//wvAhGjW6IKE08
	 8V+2Gy/lGfpOIxShWqc7cdUgnzYm1YQ/ldEO4onA=
Date: Fri, 28 Jun 2024 10:52:37 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Kees Cook <kees@kernel.org>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	ksummit@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
Message-ID: <20240628-mindful-jackal-of-education-95059f@lemur>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
 <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
 <202406211355.4AF91C2@keescook>
 <20240621-amorphous-topaz-cormorant-cc2ddb@lemur>
 <87cyo3fgcb.fsf@trenco.lwn.net>
 <4709c2fa-081f-4307-bc9e-eef928255c08@infradead.org>
 <62647fab-b3d4-48ac-af4c-78c655dcff26@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62647fab-b3d4-48ac-af4c-78c655dcff26@leemhuis.info>

On Thu, Jun 27, 2024 at 05:51:47AM GMT, Thorsten Leemhuis wrote:
> I thought it was documented, but either I was wrong or can't find it.
> But I found process/5.Posting.rst, which provides this example:
> 
>         Link: https://example.com/somewhere.html  optional-other-stuff
> 
> So no "# " there. So to avoid inconsistencies I guess this should not be
> applied, unless that document is changed as well.

This is inconsistent with every other trailer that includes comments.
Currently, there are two mechanisms to provide comments with trailers:

1:

    | Trailer-name: trailer-content # trailer-comment

2:

    | Trailer-name: trailer-content
    | [trailer-comment]

For the sake of consistency, all trailers, including Link, should use one of
these two mechanisms for "optional-other-stuff".

-K

