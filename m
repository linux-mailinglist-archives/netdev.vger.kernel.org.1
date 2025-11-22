Return-Path: <netdev+bounces-240923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE514C7C16B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1071F35923B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC629BDB0;
	Sat, 22 Nov 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfMWG4t5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AC1552FD;
	Sat, 22 Nov 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763774583; cv=none; b=rQiZsr0q8uVt9xXVmgbZ22N/eDUki7TSq9Q569N9w0GIie7FlV81+Rrasjl4pjfl2SSDAyB2bqFM7BJ104Wf7N0hOkk9fYGzGFU80Nr/V8L13LIBpoTc5eDYG0Vt9k20ootc8OIKfv0LrCxAio4dGjZNs8qzYzO3acOzda+3ZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763774583; c=relaxed/simple;
	bh=OIsLl4+xHKtTwnUmzVpR5Rzu4f8fsJsjrkR1+Cjih9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0dqI1J5TmChUUW4CGUMl83ftSjo59G6YgolE2392A9cDEYPvCC2Ilr1A350zHV4Kt78/fYGrUCbQOVU+ctI+RI5q6GsAW7X7cK4emGw4K3eh3EQsOjh4iND5cqDyEXKXJdSZhDVWCT5rIpDeh9YN4CiVZkrJ+ioZZedf82ChlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfMWG4t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24A4C4CEF1;
	Sat, 22 Nov 2025 01:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763774583;
	bh=OIsLl4+xHKtTwnUmzVpR5Rzu4f8fsJsjrkR1+Cjih9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HfMWG4t5gt+T6/6yNhtWcFTs/GLDnnr66XggzEAN4FkIx4KjTu3d6dHaNx2/coe0a
	 2fWAsJVAaK/HgV32keh29Kjta89SHQpZji9W7DIJsjEu0yq2pYwmF10SSXBqRzCH+c
	 eN9ntTgpdILgWh0dt8KOVclCWm6BFVhWIfPpkWipfNsFdHxNCiVSTAL9+lGsYJipBX
	 /g9NKu/fqkyo4x4k/JOl415/vt78jD/AVNta2cdFoduGhLHggp5UncnPI+BvGVaUvT
	 d2+5nFVal04Xe/Z/X0MyrySVkb5C3Lvs33vpPKHSmPXhb3TgL8+e7NIzwwz1ZkNVFP
	 /VZ1qu3fIsZDg==
Date: Fri, 21 Nov 2025 17:23:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Mohammad Heib
 <mheib@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] i40e: delete a stray tab
Message-ID: <20251121172301.3f488693@kernel.org>
In-Reply-To: <d396e86c-e466-4630-8b1f-7f5b640d88a5@intel.com>
References: <aSBqjtA8oF25G1OG@stanley.mountain>
	<d396e86c-e466-4630-8b1f-7f5b640d88a5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 14:35:07 -0800 Tony Nguyen wrote:
> On 11/21/2025 5:35 AM, Dan Carpenter wrote:
> > This return statement is indented one tab too far.  Delete a tab.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>  
> 
> netdev maintainers. This seems straightforward enough, did you want to 
> take this directly?

Will, do!
 
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>


