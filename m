Return-Path: <netdev+bounces-94600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C68BFF8B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E428E1F2168B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51D47A5C;
	Wed,  8 May 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VosKMvN9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842867C09F;
	Wed,  8 May 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176478; cv=none; b=dSJCfyC6zrmgej5PqRAenjJwyqDnvp5JCxMbPFBYaFrk5o9oFkEjFP9pCpKGoxuL+tQXwmCF9hgENEc0R0b4jvKQVVBVWHxVhKriNO9sFyMp0sw0c405SLDehltHXp118RkL03DIWQFdoUKFv78uigCfXdXRQILeS9KuJ0Ts6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176478; c=relaxed/simple;
	bh=BVindEG8kkeqoVqnzxdnmSHNneCwyXWBRBgbxPuLyZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJw5zzgm6mB915dElQysjWF2b/tFtvOtREHYOaNpw6E8UcdC2LzvpbooaPYjRZLetD7TGaRpKnahSB4fD9OBDMvEKx48ILOAi5Qut59xeOuuUW2GNvLhcWu0d6BjDzwLxRaO0K1Nr/VCSLaTfCA0BqHVEjBTOlS8aFMkuqN4G2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VosKMvN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCD9C113CC;
	Wed,  8 May 2024 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715176478;
	bh=BVindEG8kkeqoVqnzxdnmSHNneCwyXWBRBgbxPuLyZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VosKMvN9G5m8W0xR/dY2Gmlj5VGjqY2IJpa1UAltsiCKSIfnNhSnQlxS4heE1btT9
	 ECCB9NJ5OGV8kY9EOjGeyQmbAPFrHnGMaf+3en7krFHyItjn1QucO9T3LYAv2npdHa
	 gx8ecsojvu4ZTqgx4JU2MInj469Xy0kQMEcz6Vdy6XGimiLMrtcY+CXzqUDVlkkoi6
	 gjAGLUW7tcSeMUCd1sI1ijvM3g7p14HQtG1oL/liW9paqkTrkKysH2ReCV6H/HzOAP
	 wPS4Pppx0tf9B6pPz6x6n/NGo991sHLWAzV2Ns+bC5if/EwzAcbmAhC2f/xje7vGg+
	 BqILBev026bOA==
Date: Wed, 8 May 2024 06:54:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeffrey Altman <jaltman@auristor.com>, David Howells
 <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Message-ID: <20240508065436.2f0c07e9@kernel.org>
In-Reply-To: <955B77FD-C0C2-479E-9D85-D2F62E3DA48C@auristor.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
	<20240507194447.20bcfb60@kernel.org>
	<955B77FD-C0C2-479E-9D85-D2F62E3DA48C@auristor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 01:57:43 -0600 Jeffrey Altman wrote:
> > Looks like these got marked as Rejected in patchwork.
> > I think either because lore is confused and attaches an exchange with
> > DaveM from 2022 to them (?) or because I mentioned to DaveM that I'm
> > not sure these are fixes. So let me ask - on a scale of 1 to 10, how
> > convinced are you that these should go to Linus this week rather than
> > being categorized as general improvements and go during the merge
> > window (without the Fixes tags)?  
> 
> Jakub,
> 
> In my opinion, the first two patches in the series I believe are important to back port to the stable branches.
> 
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com <mailto:jaltman@auristor.com>>

Are they regressions? Seems possible from the Fixes tag but unclear
from the text of the commit messages.

In any case, taking the first two may be a reasonable compromise.
Does it sounds good to you, David?

