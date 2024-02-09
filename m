Return-Path: <netdev+bounces-70486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6B784F363
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF55FB29ABD
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3985269944;
	Fri,  9 Feb 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE1OClt5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275866B4D;
	Fri,  9 Feb 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474314; cv=none; b=U8q0D7C25N4cuMw9g9Jw2gvEzTn6eMSP6/km9waP/HodpGKy03SPGzl32+r/ojCC8JJ2eXBCmTyMmCGj8zsqr/4asrphrmfVdT3QTr4KtS7stBExu7yzcvQOGxRs5klhqmw3vw/NkjDbeDqPaNuxqWzkzIFlQ9xf0qUbxjh19nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474314; c=relaxed/simple;
	bh=Y32MPn/Ufif6wqiJdOYdU+WUjc6DHlkIRpf3oOetWNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppzegCvKdgVXDEXMIIH/vbtezjZ5ZKUjqUuCPfi14N3DzJylog+C39vw+5TDh7ILIUdLzD3xixiPW/cFgEsMlnmABnV0RzWvm/cPXEhvSFnyJLC/yOYrCai/jhfHEC68UGu1ttKZd/LTTwNOwi8zGjdTihSHL7xHsba28b7MSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE1OClt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE17AC433C7;
	Fri,  9 Feb 2024 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707474313;
	bh=Y32MPn/Ufif6wqiJdOYdU+WUjc6DHlkIRpf3oOetWNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pE1OClt5ExYKuuXL2AVJyDk9AsiCaFYANbrQV+LbEyFMZ7ReNw6eq4byjrSuV6JcN
	 G1FaedAD8OU7TCaDI0zRvkbMemE3e/Ol9MwwkS0aN2bW1mkOWwp+fUjq4g+oH4oE47
	 tiYoVQBuELLPlVeZdJNwktZGbSJ7bTIUc5qiRuLI421sb3Hl9y9i+pP+AXJ0H4Tb9A
	 dj98Rza+D5r9Yr2WdsGMBu6GH+8bbaei67pTkROPNkqHxvhHLzTYKaULZKULBQviVT
	 HXjkY5Ua2BUdAu1RKs6C+wVIHMrX8GU3utFccn2ct8fY7fMNT635Peho3Yr59/NeTR
	 uaqCLgi/KLP5Q==
Date: Fri, 9 Feb 2024 10:25:10 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] Wiki / instructions
Message-ID: <20240209102510.GB1516992@kernel.org>
References: <20240202093148.33bd2b14@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202093148.33bd2b14@kernel.org>

On Fri, Feb 02, 2024 at 09:31:48AM -0800, Jakub Kicinski wrote:
> Hi folks!
> 
> We added a wiki page to the nipa repo on how to run the tests locally:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-test-netdev-selftests

Thanks for this.

I am wondering if the URL should be / is now:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

...


