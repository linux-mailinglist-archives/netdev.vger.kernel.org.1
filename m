Return-Path: <netdev+bounces-231868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F3BFE0E3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4CF3A4424
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF12F39D7;
	Wed, 22 Oct 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ao9KTbJS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F829B8EF
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161818; cv=none; b=pwg8CwEnAwgKr1yoZ0iEghcZB6gODQAA+vaVK0a6zcr3+Oz+VRisNAdRZ5EeO2gBLDp8ThNBf2aCXEVU/yZF9AlKmKtLB1F8EuNF/geUN8+Yui2JjJ1MK927kk7Cu8sfgC509ZWYaId1cnVuwnaOews9BugpxUo0SLlEhohR8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161818; c=relaxed/simple;
	bh=fBOtIzcXjE7IPDheJl/AziHiueCgicpzGFj02ZSzMVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6KCSF/4QcAD4d4Znq7hs62NOKBQX7svJKFNhNt460UXiMq06m8fLFMGBComi2khvjfd6w0loe9DlxNNwp+6P5IR6LP7J/8WZ7U8LKs04+x+5hlvqUKycglpAb/34kSQhfOmjyJ5BAdGqfgq2MNtQAaYL+bgXUcAIRD3vFrolnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ao9KTbJS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=safbpmwl5fLs708AHrDZ84M9WSTNjMNRo/APE6jZwn0=; b=ao9KTbJScHRgVPJ8ziAqheQ0Oy
	lu7ZD++nE80j1iU47Q7XFfgtedyowInufQBkL8QtOxIann/cF2vxCSFr/krzqP1YEnskBIL5taj65
	5ub2gPYWm8fmseDLQW6BcUWETQ67tdfN1BiktagSS8X3jeRK3trm4nN0cwnXYsatXLew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBedi-00Bo56-8w; Wed, 22 Oct 2025 21:36:54 +0200
Date: Wed, 22 Oct 2025 21:36:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johannes Eigner <johannes.eigner@a-eberle.de>
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH ethtool v2 0/2] fix module info JSON output
Message-ID: <9859b471-5635-4e8c-bd63-00919b4a0965@lunn.ch>
References: <20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-fix-module-info-json-v2-0-d1f7b3d2e759@a-eberle.de>

On Wed, Oct 22, 2025 at 04:52:42PM +0200, Johannes Eigner wrote:
> In one of our products we need to show the SFP diagnostics in a web
> interface. Therefore we want to use the JSON output of the ethtool
> module information. During integration I found two problems.
> 
> When using `ethtool -j -m sfpX` only the basic module information was
> JSON formatted, the diagnostics part was not. First patch ensures whole
> module information output is JSON formatted for SFP modules.
> 
> The same keys were used for both the actual and threshold values in the
> diagnostics JSON output, which is not valid JSON. Second patch avoids
> this by renaming the threshold keys.
> This solution is not backward compatible. I don't see a possibility to
> fix this in a backward compatible way. If anyone knows a solution,
> please let me know so I can improve the patch.
> Another solution for the second patch would be to rename the keys for
> the actual values instead of the thresholds. But this is also not
> backward compatible. I decided to rename the threshold keys, as this
> aligns with the naming used for the warning and alarm flags.
> Second bug is definitely affecting SFP modules and maybe also affecting
> QSFP and CMIS modules. Possible bug for QSFP and CMIS modules are based
> on my understanding of the code only. I have only access to hardware
> supporting SFP modules.
> 
> Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>

So there are still some open discussions on v1 of these
patches. Please don't merge this version yet.

	 Andrew

