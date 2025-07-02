Return-Path: <netdev+bounces-203511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1643AAF63A1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A951C4304E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C52DCF49;
	Wed,  2 Jul 2025 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZRhdtJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92C2DE6F5;
	Wed,  2 Jul 2025 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489948; cv=none; b=fcwF/LM0+bmSuw3BOCXZNNwwItAKfgkDvSlhsHQOM/xFGE2u1rgUZfKwvM7JMGIUxGF+3SPmmr1UacUFTbxmcWYc+ekxIIosVCN1lMF2/0/dyX3KSNY4lni47UmT69nEkUo1kb7ftxpTjeznwHOVNEdFGP71TwF0vKjV1egX+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489948; c=relaxed/simple;
	bh=67e3qI+8BwMmEDIYadYYs76ovujH96lIQbOxZDywrko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tc5nH5w1flxTHP41XMYurEPKMKh+rhw62J19TfAWZYwZCdSXPlU9wBuTztL89+sZ/KFu7jPsYEMHkkotccsXxAudcoWXDMdohIRk8US2y7uMlGeInkdTLooKvytOtHlgZ/pAJNhQ0ys5z2nBqvcL2EqHgppA8WTYyp47oD00Lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZRhdtJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C254DC4CEE7;
	Wed,  2 Jul 2025 20:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751489948;
	bh=67e3qI+8BwMmEDIYadYYs76ovujH96lIQbOxZDywrko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fZRhdtJVpiY4XQryRoiHKjoGsbSmEoY7+0N9CDXi3J0ZIcUUrl37lwLuicUH90mLc
	 eZ8aIXA93+SrtAv6tk0nSHmQaoA9IPt/ZvFwbItDxBqeBTHYQFps0hTn27g5G1PEBo
	 CW9yI1sLFx7MzLnwr9fCmMdBvdz+lefRIt3Nk3B0WCsDBr4UGGvyBd3oUIDsSV42V+
	 8qQw+6US+4dvLTVRAWJXHtKPvsjV6buVYYBfLuFt7z10IgfQXE/nKzUJFXvpQozm0r
	 d/qJWmr9VV1YPXOfqPE13oUWdoXdMCwNVuYQsDZ6TORK2fR3KjIGQvcyBPdiAOLE0Y
	 4vI7UJTQh//DQ==
Date: Wed, 2 Jul 2025 13:59:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] net/handshake: Add new parameter
 'HANDSHAKE_A_ACCEPT_KEYRING'
Message-ID: <20250702135906.1fed794e@kernel.org>
In-Reply-To: <20250701144657.104401-1-hare@kernel.org>
References: <20250701144657.104401-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Jul 2025 16:46:57 +0200 Hannes Reinecke wrote:
> Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
> the serial number of the keyring to use.

I presume you may have some dependent work for other trees?
If yes - could you pop this on a branch off an -rc tag so
that multiple trees can merge? Or do you want us to ack
and route it via different tree directly?

Acked-by:  Jakub Kicinski <kuba@kernel.org>

