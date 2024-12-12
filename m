Return-Path: <netdev+bounces-151415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFA9EEA3D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DFE169053
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338F21578F;
	Thu, 12 Dec 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnZ5x3LP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDC2156EA;
	Thu, 12 Dec 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016049; cv=none; b=dUm3lm7ySZd/1f6zhaKVDE4IHafphGMnLzMZSO5Vp1chSsXzAo0rFOHy6KkvTxa8mzxjKHO6pjpMRY2TSz5/FtvDI5OLIXjAZJ6Ztd1pgihUM9IUeSbrSBVF/IYz+tHLS4xCK/sqB7w4j40ofvt+bf90B5yM0rMMVEOZNG5Zud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016049; c=relaxed/simple;
	bh=CX8AlibbY84H8JupjdmatQAcN3FLopAvDCOS2GrjDi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lj60gU/tat3omPCYRSm7RhrhPVv1GJdFTMN/O3PxuLGfFX59H+mdz81WtK0Tno4yscqoKHUxLeYq+GG32u6waeRa6io1+X0EI5sMdHDz6DtwgcQlJKfRfsbHhedp1kscWRSvo71ZorW2HrBnu0knaTfDDkqvO4kuukYHTSUnbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnZ5x3LP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCD1C4CED0;
	Thu, 12 Dec 2024 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734016049;
	bh=CX8AlibbY84H8JupjdmatQAcN3FLopAvDCOS2GrjDi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HnZ5x3LPBnoNsckOn/+LAfrvep3YkEPE3NC4cAiqYLdVJLHhKTBaO7X/U/fhgYr2n
	 fLdxvJojzoG8z4xqLGOuZDAfE2HrmLLqRCbDR/BDkC3I3tHi7AeUvKf0TrShLxfx6O
	 /Djkf049uncyxisJ+UGTNP/OfSeeTQK/YGoqIA5lsSsS6lIGKo6ut85c26M92Hgjh5
	 DRWYRkbeherswfc4pK4o8/YU1eoD1/ttFy0yLAYdu5dru3dpafXXIk8p+JTD+Vm9YM
	 AzcZ6adyN+SKMzkOJFK/mJE8sK2LNZvXU9q0l+NFdDBDOm69JybkZI9oXNSw3WMLkB
	 OEpjHBz8O8Viw==
Date: Thu, 12 Dec 2024 07:07:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, frank.li@nxp.com, horms@kernel.org, idosch@idosch.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v7 net-next 0/4] Add more feautues for ENETC v4 - round
 1
Message-ID: <20241212070727.2eeedb46@kernel.org>
In-Reply-To: <20241211063752.744975-1-wei.fang@nxp.com>
References: <20241211063752.744975-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:37:48 +0800 Wei Fang wrote:
> Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
> some features are configured completely differently from v1. In order to
> more fully support ENETC v4, these features will be added through several
> rounds of patch sets. This round adds these features, such as Tx and Rx
> checksum offload, increase maximum chained Tx BD number and Large send
> offload (LSO).

Doesn't apply:

Failed to apply patch:
Applying: net: enetc: add Tx checksum offload for i.MX95 ENETC
Applying: net: enetc: update max chained Tx BD number for i.MX95 ENETC
Applying: net: enetc: add LSO support for i.MX95 ENETC PF
error: sha1 information is lacking or useless (drivers/net/ethernet/freescale/enetc/enetc.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
Patch failed at 0003 net: enetc: add LSO support for i.MX95 ENETC PF
-- 
pw-bot: cr

