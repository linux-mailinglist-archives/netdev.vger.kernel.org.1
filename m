Return-Path: <netdev+bounces-168334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0195A3E958
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583E03B087C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCB6AD5A;
	Fri, 21 Feb 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH+2V8ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F738F80;
	Fri, 21 Feb 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098901; cv=none; b=nR2Dqp3WSmeb4ntpIhmdrRcCYisk9vA2JvYFUkB9sIAwWX/EvhFnWtrkKt/IDqimslWbL+H+RkJog8cx6vjR56w7v3ebJbel5x9CXmPZ0uVL5aGlYGyyGFyXaVLL4Va9Rp+tUTqiwmwdEB7rIvYZwLCnGSgLzt+VKxd37Boml9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098901; c=relaxed/simple;
	bh=MreBpDnwJEYvueT8OurrHHX91BzpSlbLwNcL1n91USg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlsL3Wk4unnSRzRfooIjWUCKePzGbO1Mycxw8/0AdEX4Pf8DlGJU52joYDT8a7j5/yRH45R46bYTD0phCGaO4hKPMq/2CK6kXHHgSdG0MUVeMS1M689XrNKix7OHO1bVvBxVkJnlXALROAt5mJ1qUbwJ6RtCzCA/cyPtlV0Qq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH+2V8ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41E3C4CED1;
	Fri, 21 Feb 2025 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740098901;
	bh=MreBpDnwJEYvueT8OurrHHX91BzpSlbLwNcL1n91USg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gH+2V8ns63ITpDnfcFbwqy2MOBArSLeObTYTmU+2N4M2VDk5+INJlZ5AbRV7ofAsw
	 RkgUlbQsOq0vVrADp0y6LP79+bKS3juNL5Cir/v9RBxaAA+nXyMoYmnBemFlzzs9/q
	 rW4VtUFwSO87KyZoOUBkL+35wJdVI/NRc6choZIh7i5sIPkbA4l50XnsilwKOJhtu2
	 MwlrtS3bKM/CAe2ECkzJ3o3wmyggXDFjAHwxX/CxZpZJxhPM6Whz/F747tv4v/dl/M
	 4FYQfzFAFNFZv4jp9tXJqkxX+pbApnuP7Lp1v/meNqoIdIxIa7Q1XFAq0/2GWRJ0sR
	 M8sudMEAV/mSQ==
Date: Thu, 20 Feb 2025 16:48:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, NXP S32 Linux Team <s32@nxp.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix DWMAC S32 entry
Message-ID: <20250220164819.044b509f@kernel.org>
In-Reply-To: <Z7fHNEFo7Aa4jfUO@shell.armlinux.org.uk>
References: <E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk>
	<20250220152248.3c05878a@kernel.org>
	<Z7fHNEFo7Aa4jfUO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 00:22:12 +0000 Russell King (Oracle) wrote:
> Right now, the situation is:
> 
> $ grep s32@nxp.com MAINTAINERS
> R:      NXP S32 Linux Team <s32@nxp.com>
> L:      NXP S32 Linux Team <s32@nxp.com>
> R:      NXP S32 Linux Team <s32@nxp.com>
> L:      s32@nxp.com
> 
> and the approach that has been taken in the past is:
> 
> -L:     NXP S32 Linux Team <s32@nxp.com>
> +R:     NXP S32 Linux Team <s32@nxp.com>
> 
> in commit bb2de9b04942 ("MAINTAINERS: fix list entries with display names")
> 
> However, commit 98dcb872779f ("ARM: s32c: update MAINTAINERS entry") did
> the reverse for the "ARM/NXP S32G ARCHITECTURE" entry breaking that and
> adding a new instance of this breakage elsewhere.
> 
> It seems these are just going to flip back and forth, so I don't think
> I can be bothered to try to fix it, and will modify my own scripts to
> eliminate the blank entry in get_maintainers output because of this.
> (In other words, s32@nxp.com will *not* be Cc'd for any patches I send.)

Literally would have taken you less time to fix it how I asked than
type this email :/

