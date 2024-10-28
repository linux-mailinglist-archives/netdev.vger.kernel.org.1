Return-Path: <netdev+bounces-139673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2297D9B3C79
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99114B2187F
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE11E0E09;
	Mon, 28 Oct 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLNPnnkm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECB18FC75
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149679; cv=none; b=RAo41ztBanxcC/gp+Zr1R0Ty/OeBJof2gOMZNqSyFeMvnNohCx2CAHa5EDUH0XnEidVYiKndiUrwL8dyGzqwopeg5uvHGCWOjMOQqGf8Iril7uY9JqJfEQ6SWLHD0s4O54SwYMWN8Ri+RlDnn21n4Sd/BT1SirLsJyRvNRMmKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149679; c=relaxed/simple;
	bh=IJp5F4jfQwmPEC//JJYab5WYr00Lx8/sR5HlW4+qXJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URB2lN3wOUnhBvF4lwhuVjJaB5ncxv40zzymis3sTBZdW75lfWaMY5bepKnQWcxJcfBT8iYe//zofM//KGC9ut3/O2oY+vGMlVqW67YaPY9ohK8zFxq8Bg7QQ+T0mRnb4f64E1rR6kJPYRRFoqkeU+5c9UZb6UGnvO+8p3ew0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLNPnnkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E32C4CEC3;
	Mon, 28 Oct 2024 21:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730149678;
	bh=IJp5F4jfQwmPEC//JJYab5WYr00Lx8/sR5HlW4+qXJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GLNPnnkmUlnb9XPERGrN7H+bRbCF2EooetkE0HAMBt4QC6rzm/uwe/dtqysqW5+9w
	 EgGF47MDXPvnBSVVKP4Rp3Df6egMG1N1ClDy8BBdROAvljEfqbFx/CvID75/EXbZwh
	 Zn7NwMF28XnI1vCRCTToSKCXAVJd6GW1v6CbHGJTb0LD/kFNMInabDeboQI+A2aoRi
	 BGqN7KnfAjllCmuH1LhyxSQNOuiRP0n9v9ZUgHCrdIUHwArG3jsAZt35ycf8nj2vo4
	 okzsg3r9kSJu7YYFbKRkeBGtC09XjohrU7kHuDDYosOlIDinHpMJU5qeEY9Sf+TGYD
	 CNNopL67eMvSg==
Date: Mon, 28 Oct 2024 14:07:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
Message-ID: <20241028140757.571f5842@kernel.org>
In-Reply-To: <ZxjbPkQEOr0FBTc6@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
	<ZxjbPkQEOr0FBTc6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 12:17:18 +0100 Russell King (Oracle) wrote:
> It's been almost a week, and this series has not been applied. First,
> Jakub's NIPA bot failed to spot the cover message that patchwork picked
> up - not my problem.

FWIW NIPA gets the patch <> series metadata from patchwork.
The only possible explanation I have for cover letter being
in patchwork but getting flagged as not present by NIPA is
that it arrived late.

I keep repeating ad nauseam that the patchwork checks have false
positives so they are for maintainers to look at, not submitters.
I think the real failure here is that someone marked this series
as CR silently and incorrectly :(

