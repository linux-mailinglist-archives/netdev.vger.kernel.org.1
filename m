Return-Path: <netdev+bounces-160158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04C1A18926
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E216AD37
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493115AF6;
	Wed, 22 Jan 2025 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctoyp+80"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B538DF9;
	Wed, 22 Jan 2025 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737506931; cv=none; b=sYFQT0M93hAciQbXALCF5B4sbpfek1YUQ77VTd+GuXIuzOoxnqfv0M8SmGYlIeanox+6q+M2mRATgsNC2kbw6MIR4RBcAlPf9rqx/wz4TriJpve+kFCoBgKoRP9DLbR/Mj90ZNHwvVyPIVj6u5yF1/minlaAwsO25njGDxurl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737506931; c=relaxed/simple;
	bh=GcKFIyv2MOD0MJb2FF5kt++QFNTgIhgiqmFHJD/rmsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8KP2JTB2R3xemGdXEXPFm0eS6AZPEqIv+PPyxsm1Q5ESXxdnAlh3HkKNjLWUhFS0iQZe4Upx7uaAz1rhp4zGv5WzV8OENVUg3L/XGCFNaFNYHBxus1Cw4GHKxhQ4Ps76b+KNJ3oKGkgExawuTag/S8vFSACFHik9zIJ2cKGn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctoyp+80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CA4C4CEDF;
	Wed, 22 Jan 2025 00:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737506930;
	bh=GcKFIyv2MOD0MJb2FF5kt++QFNTgIhgiqmFHJD/rmsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ctoyp+800yVEqzpGrGIOZC0/txjz9xuh3uaOfe4LLTD+x7Ux8TXAD6WeWd4bdy8nl
	 SnTiS1lh2ebjrlVt9sToC2yqbTimHpStTySO43FsMad/kRcnnASCbChgcaOq+N8+vL
	 Wej/HcG1+/3wvQ+eWIjJtyjHnmiGY/MSSkC7BHNeK0LnfubmAF3LgA8a5lf5Nw0Hu/
	 s+ci82ufndR1I5dw2iYjupynTGlknhaDSkanzyWMxiMEcTYT4caEMT8KluyUIfxPl9
	 Q1udfbj0diYF4tHDFl0RyUzm8oLqJnzIcaqH24I+ViSMal+vZBFozHGBdfEFom0m/R
	 ZMEsLht5cL5CQ==
Date: Tue, 21 Jan 2025 16:48:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Reyders Morales <reyders1@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, valla.francesco@gmail.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH] Documentation/networking: Fix basic node example
 document ISO 15765-2
Message-ID: <20250121164849.6ce9f40c@kernel.org>
In-Reply-To: <87h65remq7.fsf@trenco.lwn.net>
References: <20250121225241.128810-1-reyders1@gmail.com>
	<87h65remq7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 17:06:08 -0700 Jonathan Corbet wrote:
> [CC += netdev - they may want a resend after the merge window though]

Thanks! Yes, please resend after the merge window, and also include 
linux-can@vger.kernel.org at that time (ideally just run the patch 
thru scripts/get_maintainer.pl to get the full CC list).

