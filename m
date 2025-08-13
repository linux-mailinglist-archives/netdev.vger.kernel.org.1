Return-Path: <netdev+bounces-213130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE2B23D48
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011D018876F9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DAD7261B;
	Wed, 13 Aug 2025 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pl8P5lcv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7F45948
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045492; cv=none; b=B1Ea7oKVS0hXdYjZQtS2zvRCx0z7z4JRYPvu48hXv9mRNBjrev9fkS4IKyu9PI7Xh3FbzNeNS7Q4cllGbIGXXV9n9MTlFmQqAGyr1PIFHB6zLgCqFTEnKAcDu6NBkuRmy3jZvJDxwQOsTqbSR2zkBBhlBc7Mnxs8D0siAlWmlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045492; c=relaxed/simple;
	bh=QBPKrwH22a5Y7QVBkT8D13Qhik9wM0qE3120tJke0lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYOiZerzJxdBht83+g+p+1W0SxnGGq4UWjIl8hE1CsqQE8uKz5tnsCL4cFvb4e5M0Km+9gpy1D83kbXr02j9XyF25SaBdsJkapZZ2Fhl1GQllr9/9SPuiIYALIPYfYeABcKN6bHBmJ3WoUsV8TBCMFDHfCV0paOSh7sq6pPu+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pl8P5lcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652EBC4CEF0;
	Wed, 13 Aug 2025 00:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755045491;
	bh=QBPKrwH22a5Y7QVBkT8D13Qhik9wM0qE3120tJke0lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pl8P5lcvdSRylRggXKT8xsDFoRW8M+/JtKiQFTI5C+1YLC1NP3coIfccv7P8zCTf8
	 5TrrjEqTa95te0Rf4DBh11dKvYsGFnKHHHbFN118I1oT1z3xJIWF0y80gVdQ+8QdwU
	 kX4ENdn86tzUh9mUwiOb37gt/Uutyb0GKthsz2hoU+p7aVddVwxz9cA1acig2Yh7sp
	 nTVCRgKzgaZ3OBe8swiRm3LA5kGuNCgZFwOG4y20pi8DI72Hnhaqewy+tdQ2cNtOQy
	 3rTDrXpxZedmNi+/zCQtHZSyaPps/6h+P2ruG2RkZi6FBUgcQnluqMDsSPo/gs9bNS
	 WZmHKUKT01Zmw==
Date: Tue, 12 Aug 2025 17:38:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Miller
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fixed: remove usage of a faux device
Message-ID: <20250812173810.5603a48a@kernel.org>
In-Reply-To: <fad5776c-2af2-4511-90c0-6d7c6e955526@gmail.com>
References: <fad5776c-2af2-4511-90c0-6d7c6e955526@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 21:45:49 +0200 Heiner Kallweit wrote:
>  	ret = mdiobus_register(fmb->mii_bus);
>  	if (ret)
> -		goto err_mdiobus_alloc;
> +		mdiobus_free(fmb->mii_bus);
>  
> -	return 0;
> -
> -err_mdiobus_alloc:
> -	mdiobus_free(fmb->mii_bus);
> -err_mdiobus_reg:
> -	faux_device_destroy(fdev);
>  	return ret;
>  }

nit: would you mind leaving the mdiobus_free() where it is?
Feels a little more idiomatic.

