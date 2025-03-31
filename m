Return-Path: <netdev+bounces-178359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93AA76BE0
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F351E167827
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65852144A3;
	Mon, 31 Mar 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQV0VG0l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAC1E5B61
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438147; cv=none; b=bxNUNmAryRiVaUxRxqhs/62S3iWJOIREg/3AGqqsr1swls7sSbGwrxQEv9+XLIK6joP5QOAFpxJdBfidjAo+UC6qHIUDmPswE7lhefCC4d/1mmHlqHkyFncYjX1X7ePRlrz32gwNNQGCLaR5uEmm9fH+PZ/RlImrwO6wSy9A/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438147; c=relaxed/simple;
	bh=jGsMhLGXGIcPfrnF6bEIKrNOTxtd7cAsJ0tGbDL2sFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arafSaia1LWaFdvrYNUxoZV+sKU8DPgEr1FRslDGzqpzxcwa+IwWcxqPjjXQLpzThDHRFSq/EKH2EjscmOOoW+X75sV0DRYa/Thn50w51UzoEs4gQ26YiKQWQHfc3Z7SFGQE+Ao+zlDyojBwd0/24W7PYwHG8x0kPSMydV8hC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQV0VG0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6992C4CEE3;
	Mon, 31 Mar 2025 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743438147;
	bh=jGsMhLGXGIcPfrnF6bEIKrNOTxtd7cAsJ0tGbDL2sFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OQV0VG0lqVP28MBlb8Y/nimcZtOaxf62tRoBfE6ur3ce0QWmLT5wXRuLHHdwg9zqw
	 bint32lGA2gHLOoFrvAqpV81bC3o1voizJCpPCIJfVd8gKMn0V6YX9OCO0dv4m6SI5
	 6dtA9hpn6DlCKkm58MTngbLF9DCttBVEdUpvbaxn9zOrS6HQ0mwUgT6CcAzTM9M+9r
	 YbgY55N+K0IEzCtBnYg5USAHXrqUy2h8wHFbITYXVj45Bl/dUUKRigeENzPv/NNj88
	 ZIuXU4Ir7yq9JbOXtLLjio0WIQ8oHKL/+s/kdsr8ICj3TQCNQqULIeLoqbW4yZXchS
	 5hTUvxEY8LtfA==
Date: Mon, 31 Mar 2025 09:22:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 parav@nvidia.com
Subject: Re: [PATCH net-next v2 2/4] net/mlx5: Expose serial numbers in
 devlink info
Message-ID: <20250331092226.589edb9a@kernel.org>
In-Reply-To: <6mrfruwwp35efgzjjvgqkvjzahsvki6b3sw6uozapl7o5nf6mu@z6t7s7qp6e76>
References: <20250320085947.103419-1-jiri@resnulli.us>
	<20250320085947.103419-3-jiri@resnulli.us>
	<20250325044653.52fea697@kernel.org>
	<6mrfruwwp35efgzjjvgqkvjzahsvki6b3sw6uozapl7o5nf6mu@z6t7s7qp6e76>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 15:06:18 +0200 Jiri Pirko wrote:
> >I suppose you only expect one of the fields to be populated but 
> >the code as is doesn't express that.  
> 
> Nope. none or all could be populated, depends on what device exposes.

Then you override the err in case first put fails.
But also having two serial numbers makes no sense.

