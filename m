Return-Path: <netdev+bounces-231033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9233BF4211
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A218C2DED
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802F18FC80;
	Tue, 21 Oct 2025 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvg+NYI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD615624B;
	Tue, 21 Oct 2025 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005791; cv=none; b=ERCE5bTJkql3/FXjioPyv0CP8O8FCpIt1UavmebkpAujdj+ScXd1fecJEYMxhL4muvDiZR8ba1xZ8q56TME9x9kR7a8q7CobN+/PIqLL5SsGVfH9jeK1Sl5TJxuYcOgT1UBkdPoc8tXS4QshRw2P9e9VJPjTF6rGIXsqhWCckzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005791; c=relaxed/simple;
	bh=byVn4gwFjcc3i22Bio1fto4stbFidQ3PbKdyebP0pYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8J1oov2ZKHd1i1eXsi0tL5LnAZywE5rI2b+26LCWV3qIlw6fumD/DA5h2EnHVKwVEm3Q+aMg4Tho1ZCEmyJ8jeIps2xgH5HRt5r8OHNjVWTPBA2P63Xz0VIPch/4y3I9eZcWB3Ow2U3iPVcHWI4PFQq0+Z5aKYOQz2UPgBngVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvg+NYI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC7C4CEFB;
	Tue, 21 Oct 2025 00:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761005791;
	bh=byVn4gwFjcc3i22Bio1fto4stbFidQ3PbKdyebP0pYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hvg+NYI0GAjUoeaiQw19JnA2aSWvm1WAy2BVRyHdEDkzgK2WeUk60O4vlADEAdUNt
	 T1Pe31ZbiIW4NNEsFNl+JIxy57W5ozUoJ8Zp6p3YGG2ZI/o2xlIisKVmNxHw+yALxq
	 652130m/4xM1sMfa7No3U3Kvv621sdtFCClbSKJTcBommAhs2/coKFBALoekwTsUgg
	 mLxK7kWIxpFqCAKLqCcoopPEzgSqOERkCLnM6SXia89iFvULvvC9s/9/M0n+IAk1R8
	 BYpWe5sHOnDiuHBH3M3n8FAKE3q/0oqpM0wpPTUBkpiIzTFqJaFQSxOgqvI9w6rSpr
	 E6wmBuogNc32g==
Date: Mon, 20 Oct 2025 17:16:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Networking
 <netdev@vger.kernel.org>, Subash Abhinov Kasiviswanathan
 <subash.a.kasiviswanathan@oss.qualcomm.com>, Sean Tranchetti
 <sean.tranchetti@oss.qualcomm.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH net-next] net: rmnet: Use section heading for packet
 format subsections
Message-ID: <20251020171629.0c2c5f5e@kernel.org>
In-Reply-To: <20251016092552.27053-1-bagasdotme@gmail.com>
References: <20251016092552.27053-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 16:25:52 +0700 Bagas Sanjaya wrote:
> -a. MAP packet v1 (data / control)
> +A. MAP packet v1 (data / control)
> +---------------------------------

Why capitalize the "A" here? it could have stayed the way it was, IMO
lowercase is actually more common and (at least my) Sphinx doesn't seem
to detect this leading letter as in any way special.
-- 
pw-bot: cr

