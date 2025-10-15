Return-Path: <netdev+bounces-229422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E75E9BDBF74
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5C234F0724
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 01:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478EB2F9DA7;
	Wed, 15 Oct 2025 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imHLErg0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159602F8BF3;
	Wed, 15 Oct 2025 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760490786; cv=none; b=TnHRrT4Exk7/Y6yVa4yA8N11mPsA1MkWgHo0+WVKMPvCSQi1qtPhrY9mCPSNsEfPWwghSATwyjlpCr5kLZwlSBR2rcO3xgG87mtZm/XmatXZ4NRQp0Zah6go12Ncahcpf7ZocUe608ElOCpy8uFGSh6JLV1TQ5WXiyUUhLWqKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760490786; c=relaxed/simple;
	bh=r04KuBjTFALlX6vLWenb1nfafbHbRWYkUuaNo7B96HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvPKLl8mPD8WTHaVlNZ9zXkFhnlXil7J1WDNkgg8h0u0wNUAnRWrY8nKcJEWRQXYJXLQCBxe41M3K165FnV4CcfzoJeN/pfzUvspfoCBizi0jhNwT69z+zXXccqn4TqM12G5AMNZ3L7W1uv8zgSgeBxZQfBEXolBfyk1ds7JSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imHLErg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC766C4CEF1;
	Wed, 15 Oct 2025 01:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760490784;
	bh=r04KuBjTFALlX6vLWenb1nfafbHbRWYkUuaNo7B96HQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=imHLErg0527hILuvzg62O5hWQr/Gb8+8/ykxO/Jc4AOkZrRrwb43/pyN04gmTwgGU
	 YgDwbot9UvLm0XeP6uLbXvi0t62J+Dee1kqGvzR9+hW2XdDRh9COBIClBz+e8F0vnO
	 Y+IdjebP43/zKaFbHVOFTl8JpU+3nfKH7wBcCiIfFPb0RHie+/m6B6Xqj1aK7xOdhs
	 w4gscZW3DDahuMcFoSAp+zs4BTtSuv7s20mkewvLH4okA9cOMrb6mDueZ+PN9oSLRH
	 Gp8HOJmzn0OquadtehTs6qKrcb7Vm9mueHTpYtK9mlUjgosz0lVTJX1mHUiqtuytJ9
	 pXLf2h2IzqTvw==
Date: Tue, 14 Oct 2025 18:13:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Frank Li <Frank.Li@nxp.com>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251014181302.44537f00@kernel.org>
In-Reply-To: <20251014204807.GA1075103-robh@kernel.org>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
	<20251014-flattop-limping-46220a9eda46@spud>
	<20251014-projector-immovably-59a2a48857cc@spud>
	<20251014120213.002308f2@kernel.org>
	<20251014-unclothed-outsource-d0438fbf1b23@spud>
	<20251014204807.GA1075103-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 15:48:07 -0500 Rob Herring wrote:
> On Tue, Oct 14, 2025 at 08:35:04PM +0100, Conor Dooley wrote:
> > On Tue, Oct 14, 2025 at 12:02:13PM -0700, Jakub Kicinski wrote:  
> > > The pw-bot commands are a netdev+bpf thing :) They won't do anything
> > > to dt patchwork. IOW the pw-bot is a different bot than the one that
> > > replies when patch is applied.  
> > 
> > Rob's recently added it to our patchwork too.  
> 
> And the issue is that both PW projects might get updated and both don't 
> necessarily want the same state (like this case). So we need to 
> distinguish. Perhaps like one of the following:
> 
> dt-pw-bot: <state>
> 
> or
> 
> pw-bot: <project> <state>

We crossed replies, do you mind

  pw-bot: xyz [project]

? I like the optional param after required, and the brackets may help
us disambiguate between optional params if there are more in the future.

