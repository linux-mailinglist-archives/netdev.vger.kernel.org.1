Return-Path: <netdev+bounces-178001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A2A73E9F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FF73B847F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AC17A5BD;
	Thu, 27 Mar 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRoAiYZ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9128EC
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104045; cv=none; b=hBfihjQzcFPCJZLCGH02bCcLqaIjxD/O/nMaeZgOgSQR9+DFSBiAOzDDscPsSEUoFYMqS6kANsZnyLK4IhpRkooMR/rJ4Pr7Enmpfxg6C/QFnu3v1oxKL3TnsPL+Y8tw8hS02/uM0rbN30PWKbbcSQbUWY19Y6DFe16Zf0PDwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104045; c=relaxed/simple;
	bh=cduo4t/UtxdsWs4sY9LvGkakBo/J2n26vN+AfK/6JKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCutnW2qoMi81IChVR0P3WI/v0fC9gDN81dsbkpASxpCCakV6xAoOlSKujIHk/7+ObSiJV0tBaKBVAvk6BLPrF3K+jeDkpPlQBj01xp+45mhwJDf4IMmxJZzB0x05oSaAb15G6OpWelpHDdxnU3mTSndDtxUCesqP4+bi+D5X4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRoAiYZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A14EC4CEDD;
	Thu, 27 Mar 2025 19:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743104044;
	bh=cduo4t/UtxdsWs4sY9LvGkakBo/J2n26vN+AfK/6JKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fRoAiYZ1SghW5FPVIfYep5+hZSLPP+mkfE+rLL7oRXNDKAhtKaAbkBXwcW4EtLns1
	 VPyItOlN8K4YUFCgA4S4KHYKqcyl87ubgbdwJWvnVU5M2EPMSCgLACXwMSjxnrMi0H
	 58sNTea2zuQgZDaD6RDsVow3E6uezYg0vk4TEu+WHoHlAqzzi270PgGY+1QxwQ4NT8
	 dG6QMkQ+en46vMMHC6z9mxgRJOQyJiJhmi0S7B/3OxSAvGWW25zHUFP8qvy/ROV7LB
	 GWQFJ8PUN03kuBUcItT0neQdFPx/2xHGJcb60HKMbsQX8oGO7aPHm5LmK4XJeI9W95
	 asySPU6LSTGxg==
Date: Thu, 27 Mar 2025 12:34:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net v2 08/11] docs: net: document netdev notifier
 expectations
Message-ID: <20250327123403.6147088d@kernel.org>
In-Reply-To: <20250327121613.4d4f36ea@kernel.org>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-9-sdf@fomichev.me>
	<20250327121613.4d4f36ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 12:16:13 -0700 Jakub Kicinski wrote:
> > +* ``NETDEV_REGISTER``
> > +* ``NETDEV_UP``
> > +* ``NETDEV_UNREGISTER``  
> 
> Can I ask the obvious question - anything specific that's hard in also
> taking it in DOWN or just no time to investigate? Symmetry would be
> great.

Looking at patch 4 maybe we should do the opposite. This was my
original commit msg for locking UNREGISTER:

    net: make NETDEV_UNREGISTER and instance lock more consistent
    
    The NETDEV_UNREGISTER notifier gets called under the ops lock
    when device changes namespace but not during real unregistration.
    Take it consistently, XSK tries to poke at netdev queue state
    from this notifier.

So if the only caller currently under the lock is netns change, and 
we already split that to release the lock - maybe we can make
UNREGISTER always unlocked instead?

