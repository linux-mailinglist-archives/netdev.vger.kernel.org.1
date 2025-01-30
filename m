Return-Path: <netdev+bounces-161577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2889A2274F
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429771883D89
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A82A93D;
	Thu, 30 Jan 2025 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJfslo3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182A7464;
	Thu, 30 Jan 2025 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198149; cv=none; b=aoqDK8Ny9Iz7l83ty2nCmIs7AMKFSW+lSUzcdKh7GG/Pp/blWPk4W1jSfcEn2THSN01f5vZO1iftw/RMU6TdZrF4DOx+jKiZzZpSsHaYGjbm+wEzfjFutncvlWdt0NravnaEzZeXecBPD9JKPNNM8VZOI6YlGHmHRxYdbM1xHks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198149; c=relaxed/simple;
	bh=d0P5Eb57YW1PGay+ikR2RJBnmq/7nUEZ2zrejKdL+nE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3+ojbB2biB8W5rgkfYfYKGQZguX0QNFXrazDTlmVfG36uD1R6TtXylHTJ8D/+I8vUpUJzgQ7AvbphUzslIFNuvVlJMLghs0cpd3nynExeKdh+yENuzxgZQXmPAZ3DQpqkUINKSMDGm3B89PgDNlnO32p5ZJAN5C4MHUDpbCYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJfslo3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E99C4CED1;
	Thu, 30 Jan 2025 00:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738198148;
	bh=d0P5Eb57YW1PGay+ikR2RJBnmq/7nUEZ2zrejKdL+nE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jJfslo3xiUNgOteIAyPWMjwSsMCaYegVVRqDkj667dvyL+pcaz2CzRdM8ysCN84ta
	 21PmdVXtWM/pDGuwzqdfXxgHzvtGJ0taALkBsNPFANWH9eMzWH6BBtuWM66rf/gH+o
	 O3WUTv9o43280Nl4hMkMwcq/NHEf+Oh0Vv/EyG7D6vouvF3j3ABfSlQ9ncDQLund/s
	 YeOP/3Bi+mApFmrAet+dlycLAu1O/pNN0m0ye+KnxT+4+wFoWt0jWXjzg5WlzS+3co
	 L2ZucNlrURE6mlQoHc/LKyDkTHc8K/sDTiAdPDBoJ4za4fTWQELRKxaUUsj8idkRkY
	 GiSjGbGOeSCBw==
Date: Wed, 29 Jan 2025 16:49:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: ethtool: tsconfig: Fix netlink type of
 hwtstamp flags
Message-ID: <20250129164907.6dd0b750@kernel.org>
In-Reply-To: <20250128-fix_tsconfig-v1-3-87adcdc4e394@bootlin.com>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
	<20250128-fix_tsconfig-v1-3-87adcdc4e394@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 16:35:48 +0100 Kory Maincent wrote:
> Fix the netlink type for hardware timestamp flags, which are represented
> as a bitset of flags. Although only one flag is supported currently, the
> correct netlink bitset type should be used instead of u32. Address this
> by adding a new named string set description for the hwtstamp flag
> structure.

Makes sense, please mention explicitly in the commit message that the
code has been introduced in the current release so the uAPI change is
still okay.

In general IMHO YNL makes the bitset functionality less important.
But in this case consistency with other fields seems worth it.
The patch LGTM.

