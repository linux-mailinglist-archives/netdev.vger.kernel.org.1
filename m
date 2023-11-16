Return-Path: <netdev+bounces-48240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E47EDB66
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 07:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86F41C20443
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 06:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA98F75;
	Thu, 16 Nov 2023 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjN+hJ0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4E8F58
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38BDC433C7;
	Thu, 16 Nov 2023 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700114592;
	bh=3mqFKUsuT68n/sSTZqcH0Cb8LWIbVDw0n692TohaKl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IjN+hJ0obX4QdrYRIph8gkaAWwAvWhIAD/DxfdJ8gAmlVJSF/azMgC2Lz25mqb1/j
	 9bW4kljHbqs17Yu8C3H8HmxjcjIdaCg0tlJLECqbhMOYh2EeaB/Hoyawf5OnYnlJFt
	 nWay1GD6xH0S5dDSLOmLcMCCjgmeTg1aFKwV2NDFmvlR20ZI4Nc7/Z9EZwjFXTFbFD
	 85Yd/ZVaMUL+DA3k9UGgqRzqCcaioJCIr4ZnHC0GJlc1yecnqZGWCPnkzr1Q1AlY/N
	 eY+TQt2oE4Gt8INaw0JYXCpNFrJ1xwcvYF+dNxDCA+mrcaYUyIaTL6fMDRRxXm/VQ2
	 GKPGdqdOFMCnw==
Date: Thu, 16 Nov 2023 01:03:10 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Tobias Klauser <tklauser@distanz.ch>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] indirect_call_wrapper: Fix typo in
 INDIRECT_CALL_$NR kerneldoc
Message-ID: <20231116010310.4664dd38@kernel.org>
In-Reply-To: <20231115175626.GW74656@kernel.org>
References: <20231114104202.4680-1-tklauser@distanz.ch>
	<20231115175626.GW74656@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Nov 2023 17:56:26 +0000 Simon Horman wrote:
> To the netdev maintainers: get_maintainer.pl doesn't seem to
> know much about include/linux/indirect_call_wrapper.h.
> Should that be fixed?

I'm curious how many of such files exist under include/linux.
Files which are not really networking specific but only tree
the changes ever went thru is netdev.. 
But yes, in the interest of "taking responsibility" we should
probably claim it.

