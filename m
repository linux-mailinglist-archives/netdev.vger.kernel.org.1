Return-Path: <netdev+bounces-248577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BAAD0BCCF
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFF86300F899
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5973644A5;
	Fri,  9 Jan 2026 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKlHJ6t2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C450096B
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982329; cv=none; b=tb3LobrxKWp9Hp/+P2zoXEBxYYihUYjmnq/J/itz78zEkgo79aA3CT7Y7VRk3532A7rGywHDinqGf4SXADdr/skHCYwpFKX7w24g2qoRmjpUnFbClFmKDPDaYE13xCsujC3ny8Cgn54xfiBqSAws2n33xxNPIGE/VDgw9HujnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982329; c=relaxed/simple;
	bh=j3ewnioB6wnLvCgdro4quI1Q2RZxDcHLtkSCwS0mtic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvnUO0of0KHXEAs0Rnu6eYejEZaRnILnIAjE+d6PdJpQ/dA3qW6ezBqIra1Lm3Y3BhPFHutIcSXFXkj3lUSSv4gCjQM+1jCzeDf15QOydEBOjLJXWIRrRrpdbL/Q27lubpou+JbHPZuOzOxbncaJCyfC3jPF9y5hNaJNbc0ymf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKlHJ6t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C450C4CEF1;
	Fri,  9 Jan 2026 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767982328;
	bh=j3ewnioB6wnLvCgdro4quI1Q2RZxDcHLtkSCwS0mtic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKlHJ6t2d8pHS+X2q7qfKZqGiZE+z98W6+DMqPctPehZeyODtcn7l4tBya6MAs0iN
	 BxTFWOJn83bBV5fIAQMIEjIHXP0l7EzNIGDiE18sJofS7dcsg/bC6Nlzts50jR6FXZ
	 1smrLAtixpNK4yCy/OYDmyNWm5GXT5eXnzQi8uz3zO+AeHIuAsO+00k4GJVtJXdy7m
	 F7zBbbSPaRT0h7TsNlYs6byVUyOniATXp7uZFiGFJrGp5T+pa54i382wOrBDCeIGPe
	 4bdgQCnfvHZwDUl1Jq9hri58J4Fxy9A5gZ+BS2Z7IH4PH0VhVDZlf80RF4Op50TdJx
	 nnzgLaHaLZIPA==
Date: Fri, 9 Jan 2026 18:12:05 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: remove HIPPI support and RoadRunner
 HIPPI driver
Message-ID: <20260109181205.GQ345651@kernel.org>
References: <20260107072623.36727-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107072623.36727-1-enelsonmoore@gmail.com>

On Tue, Jan 06, 2026 at 11:26:23PM -0800, Ethan Nelson-Moore wrote:
> HIPPI has not been relevant for over two decades. It was rapidly
> eclipsed by Fibre Channel, and even when it was new, it was
> confined to very high-end hardware. The HIPPI code has only
> received tree-wide changes and fixes by inspection in the entire
> Git history. Remove HIPPI support and the rrunner HIPPI driver,
> and move the former maintainer to the CREDITS file. Keep the
> include/uapi/linux/if_hippi.h header because it is used by the TUN
> code, and to avoid breaking userspace, however unlikely that may be.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

I like the idea of removing unused code, so +1 from my side.

But, as noted for another of your recent patches,
please use ./scripts/get_maintainer.pl this.patch to
fill out the CC list.

...

