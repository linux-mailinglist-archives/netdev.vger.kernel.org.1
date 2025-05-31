Return-Path: <netdev+bounces-194453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64698AC98C3
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 03:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298D04E1AFC
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 01:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089A14F70;
	Sat, 31 May 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPD2T3W4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB3BE46
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748654403; cv=none; b=lHCobQHxvh3AeOXyUz/dx8npQLYuwoNNkJ8KC7W5Cl7eQNNF6HVP4n5F5ZzAADqFmcfmfslvs4iPh5D26S6PwyILM/goHigKS7v+slIp8sb3choiCKo+TW7nrJU6R8oh5f8RF4hElA49myZWj7u0805RlyEWGe5jXh1ngwU8sTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748654403; c=relaxed/simple;
	bh=8Vg6zNuC6cihI+R/dlXZN+qfGJWTdP+8vgkZ2lQCCpc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkHRDsrfQj0BvSfaFKrWhsIMU5b/yAJ0CxGPpAT8NxzA3G4URHMb+5F6MIvu5Od2O49MhQCUQK80ZIhsp/fhnQDGbixglk0gUMOu7BSRLyea0GosO1qfC3OktOlkkP2XuGSFRKvty3jsXlbE2Swxm9/iPeoSeuIWwivHkqICNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPD2T3W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A93C4CEEB;
	Sat, 31 May 2025 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748654403;
	bh=8Vg6zNuC6cihI+R/dlXZN+qfGJWTdP+8vgkZ2lQCCpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPD2T3W48p7Xpy2iVDwE0/jix7q4bp3v++mnISF690uXIfnsNKd2NSUPSCo1ofqus
	 wGZheeiMrs2OuzJNY3pNVvWWEUVeFKncqbtvd29ztWWav1jPfctv6rIPe6qArTiDPf
	 8Nk7s23/KXAsOAF4NNTAMdvekbaSr3/0jPySjT/SsYjmDzP1hCAf4Dl2iGcfmsHVEn
	 caBa0vvAMW+cKE6w8VO3Vli7DI8RFJInvg7zdOQr8Y1B713AGIaJ2UVydtl/xexoMc
	 +B6PUoU/eg0adA5quBy3jbvgWNRVCLUJ/C5CjkuT+bM36fK/nhrRVW+JqqBx00YAg5
	 UpInaaZQ4atgA==
Date: Fri, 30 May 2025 18:20:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: danieller@nvidia.com, idosch@idosch.org, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool 0/2] module_common: adjust the JSON output for
 per-lane signals
Message-ID: <20250530182002.557c8256@kernel.org>
In-Reply-To: <tby3ld5penbfzrpvlbocwrmnyyahtjrocejelqfhfcrryz3uzq@24fixhzgipcl>
References: <20250529142033.2308815-1-kuba@kernel.org>
	<tby3ld5penbfzrpvlbocwrmnyyahtjrocejelqfhfcrryz3uzq@24fixhzgipcl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 13:35:25 +0200 Michal Kubecek wrote:
> On Thu, May 29, 2025 at 07:20:31AM GMT, Jakub Kicinski wrote:
> > I got some feedback from users trying to integrate the SFP JSON
> > output to Meta's monitoring systems. The loss / fault signals
> > are currently a bit awkward to parse. This patch set changes
> > the format, is it still okay to merge it (as a fix?)
> > I think it's a worthwhile improvement, not sure how many people
> > depend on the current JSON format after 1 release..  
> 
> It's unfortunate that the format already got into 6.14 but thankfully
> it's been only about six weeks since so hopefully there won't be many
> (or perhaps none if we are lucky).
> 
> I wonder if it would make sense to also release 6.14.1 with the format
> change to make it more apparent for those using 6.14 that the change
> should be backported. SLE16 (and Leap 16.0) is going to be one of the
> distributions with ethtool 6.14 but there I can add the patch myself.

FWIW I'll try to get it backported to Fedora / CentOS too. 
So cutting 6.14.1 may be preferable.

