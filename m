Return-Path: <netdev+bounces-189046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3FAB00C2
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516141B67276
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7927A13A;
	Thu,  8 May 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGuO61PC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700778F32
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723282; cv=none; b=El7OaKfPWWGEePOLgnzzNl1Oe3iQT2QqUGd/HArhPgh9tjPn/3lR+WG585XpILWmP8pUQ6dQFRUakK6IT4Fjl4YJ1Lfk3qJJUnQcED51fUIMfpdc4vA6X+upw1+gf3xCUsNPoTTwOCqIw6oJCHnxiU75p6in2OP8C3A8FrFRq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723282; c=relaxed/simple;
	bh=uQhFLD0eiWgZP1MSZXB5q4j6NnKdgym1yEMlT6HbGvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHBxEsAUDTOKEh8aErxX5brZuuMmnpOKOgCafSoCHsOH7vVXG+aR0mKmTSIF/EEmBz+MlNXXDK9pjBk5+a1q9rSM8tDITnaw3G/clu2L/c/KLykfRkIfOK9WHLQLgiVYR1f8C3gAFbg6eoUNUgr9fE4rw2FyiHtEhKFIT/h1Myg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGuO61PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB087C4CEE7;
	Thu,  8 May 2025 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746723281;
	bh=uQhFLD0eiWgZP1MSZXB5q4j6NnKdgym1yEMlT6HbGvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pGuO61PC002giw5C/TRgNc2JV8+/kyt90iZfdLlP/c3csuB51YCuEzZgYrOP08lOx
	 Yw6KhrFSTO2AhVK4wcnG4G5FrUOFTftzii1dZXHOBthL1rES8HiSXUYDsUoat+mesw
	 isVMSSEVlhQGdCBZnqtjj1mG3KhyRXhKfoWzu/oAjk+jU3mZguGzaclbD5V6GiYGMk
	 s6QhlQhUT+UhyHQzOHNLo0ZxR/6STR49F+jkT5SiJKs5c//xVrl/56wIJmJkji6x3J
	 y0+VmveYJ2hOlqDfaW9AZmZ6Qfz1pVM4SfVJBmah21UVaTM/O4lJ1RUU9mqWx/cSoG
	 9yIj0059Cn3+w==
Date: Thu, 8 May 2025 09:54:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 1/3] tools: ynl-gen: support sub-type for
 binary attributes
Message-ID: <20250508095439.26c63ff3@kernel.org>
In-Reply-To: <CAD4GDZzR7DV-z7HA7=r9tmXmgkQu30K5QE9nAdz2eZfvKPOusA@mail.gmail.com>
References: <20250508022839.1256059-1-kuba@kernel.org>
	<20250508022839.1256059-2-kuba@kernel.org>
	<CAD4GDZzR7DV-z7HA7=r9tmXmgkQu30K5QE9nAdz2eZfvKPOusA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 12:33:10 +0100 Donald Hunter wrote:
> >  class TypeBinary(Type):
> >      def arg_member(self, ri):
> > +        if self.get('sub-type') and self.get('sub-type') in scalars:  
> 
> This check is repeated a lot, so maybe it would benefit from a
> _has_scalar_sub_type() helper?

I've gotten used to repeating the conditions in TypeArrayNest 
and TypeMultiAttr...

Looking at it now, since I'm using .get() the part of the condition 
is unnecessary. How about just:

	if self.get('sub-type') in scalars:

? None is not a scalar after all

