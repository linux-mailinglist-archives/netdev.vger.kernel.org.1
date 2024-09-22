Return-Path: <netdev+bounces-129191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841197E296
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324951F216A1
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C89626AF6;
	Sun, 22 Sep 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3gCPh7y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C06219E4;
	Sun, 22 Sep 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024396; cv=none; b=ixo8/c39/Q1UTo+Tndpi0X6qbhDiAHu9D1/3J70WJSKhOgZqpWViuEnHh7eFxgtbyk01t4dANPOjDtsf58h+VVOG4fMgF5pMvdodN9XyRXLxF/Au3w/W80yIAOiDe1fGp5URK/C/4ylX62xcXFLKAWaCn3H09LHDg7+CHqVib/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024396; c=relaxed/simple;
	bh=SCLexZ/RaMKo8XOThB7Kxlr0ZTSGEF/eJ+/2S0nvWGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/IwlwrNWbAHTsn3SkXsWq/mUaenPikazkltWDT/UrHZlBvHPtWdoV+CajzHE+GgikZhfz6fFgash+yZYMnLSPGE1Rk6aOh7v42fUVV0GD7yUcBq//3Ze2hkIWlKiIHEhVlnA5fCJcR0um1j/a4V6zoSDyHu1LJ2w8Kw5XAgbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3gCPh7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD98C4CEC3;
	Sun, 22 Sep 2024 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727024396;
	bh=SCLexZ/RaMKo8XOThB7Kxlr0ZTSGEF/eJ+/2S0nvWGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3gCPh7yJjD4E02kksOsCOvatAABfNwvb00eajBsAjgXdil3AoNGw6wFXe1sjymca
	 CV8bJA547vrwEtIZfYFJl/jhA1iC97jn1ChV4AKAClmfi4jJF+0JCY4JiO3tuvcV9b
	 3lO/7IsbcO0G9koeAnlmt9ACsMCDLdxMJvR884Yn7lIWKappC9Glxo6RA+emLPwfU/
	 js5rjrhRUfM1dlNGlq9wXX75ql2e628mgLtD7/wRUo/hnOaTy1S5SG9rmYrB/TZXCR
	 3FlGvnyLMUnlSUFk8go/MaeXU/AG3FrOrJG6ZUb5cEOnI3phE9tDpRenR+uqodCGbn
	 pjUfy6CXilGHA==
Date: Sun, 22 Sep 2024 17:59:52 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Andy Chiu <andy.chiu@sifive.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH] net: xilinx: axienet: Reduce scopes for two resources in
 axienet_probe()
Message-ID: <20240922165952.GC3426578@kernel.org>
References: <2e6f6f8f-89de-4b75-a0af-3a55bc046ab7@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e6f6f8f-89de-4b75-a0af-3a55bc046ab7@web.de>

On Fri, Sep 20, 2024 at 11:22:47AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 20 Sep 2024 11:08:10 +0200
> 
> The calls “dma_release_channel(tx_chan)” and “of_node_put(np)”
> were immediately used after return value checks in this
> function implementation.
> Thus use such function calls only once instead directly before the checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hi Markus,

This change seems reasonable to me.  However, I am assuming that as a
non-bug-fix, this is targeted at net-next.  And net-next is currently
closed for the v6.12 merge window.  Please consider reposting this patch
once net-next reopens.  That will occur after v6.12-rc1 has been released.
Which I expect to be about a week from now.

Also, for networking patches please tag non-bug fixes for
net-next (and bug fixes for net, being sure to include a Fixes tag).

	Subject: [PATCH net-next] ...

Please see https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: defer

