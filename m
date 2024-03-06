Return-Path: <netdev+bounces-77976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B69873AB9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F0E1F23F3F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521351350FA;
	Wed,  6 Mar 2024 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF3BzkLX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E779134CEC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739261; cv=none; b=oG9JxjmC4UTcsdK68JC+rnbxft82lK9COWJv4Lsy7Umslf7lTCswrjRScwgaX3wnErfrrKrASb6TuTi/VrI6mP8+vpBHrrQL4VAsRPCA3Z/V+Bm4vuIPr6v+J/evdScET7SA5InCRgxofIxnKcPcwvoaYu/g6psRrIIFtWA9SWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739261; c=relaxed/simple;
	bh=FcFdSh4hwmfe1TKIF3CYnUDKR+A+GSdzG7p5A4g8NJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szHOBuJ1Vat54pfCUeFaL5gKGVFHi5IINM7Q79adT9QbD8E+EqNt2B78H0yXbxZNu8q5BPHqDGfZ0m64kbAhN53leh7NxbM4AFYyLrN4F/1opiy9YYJvjZfK3P7qlbYpAC3DOv0dNyRFzLASnnwoAsEOJ3mXEjA5jLLIyWbRFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF3BzkLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606A4C433F1;
	Wed,  6 Mar 2024 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709739260;
	bh=FcFdSh4hwmfe1TKIF3CYnUDKR+A+GSdzG7p5A4g8NJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uF3BzkLXT+NrpWDNM1abkZ5sKSMAiuhCUgabBVKwDm5w1Ov4Uwwww+GXYDGYaeKt3
	 ggSznFVEnj+mAsj95QduhRAOxbWyO19yL9PeBa1rK6J9uH9JMTHo7iJahakmECjdNF
	 5aHEGYBY1+4UoASZvnXXdwY8qX/fazRIRyJwBuNXNeEyoICsrR3nTG4Ik5gfbxfiJc
	 zX+Ogrgd9JQUNSZs6/jmqLrG+ipxnQmi4qmhx6yLAv84ccmIiel2jDv4pboJmm995x
	 EBWSY9Oq0ge4/fFkFgdbZfQjrB2ConOrHnpDUZvD1XUDGeLF+ku88ZnAcEvEOehh39
	 I/k3gWvXrlARw==
Date: Wed, 6 Mar 2024 07:34:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev
Subject: Re: [patch net-next] dpll: spec: use proper enum for pin
 capabilities attribute
Message-ID: <20240306073419.4557bd37@kernel.org>
In-Reply-To: <ZeiK7gDRUZYA8378@nanopsycho>
References: <20240306120739.1447621-1-jiri@resnulli.us>
	<ZeiK7gDRUZYA8378@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 16:25:34 +0100 Jiri Pirko wrote:
> >Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
> >Signed-off-by: Jiri Pirko <jiri@nvidia.com>  
> 
> Note that netdev/cc_maintainers fails as I didn't cc michal.michalik@intel.com
> on purpose, as the address bounces.
> 
> Btw, do we have a way to ignore such ccs? .get_maintainer.ignore looks
> like a good candidate, but is it okay to put closed emails there?

Oh, great, I wasn't aware of this.

I think I have his private email, let me follow up off list and either
put his @intel.com address in the mailmap or the ignore list.

