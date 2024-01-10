Return-Path: <netdev+bounces-62918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D84829D75
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591C51C223F9
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21D34BAA3;
	Wed, 10 Jan 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu0DmLdm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A894C601;
	Wed, 10 Jan 2024 15:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBE9C43394;
	Wed, 10 Jan 2024 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704900124;
	bh=gWsPAmL2anoQhsQvpYXKzbNzdlPBBjjDlNA19iop+9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qu0DmLdmZg2WG4cu3TaM9yMTaDEkNHXhSkO8w4S0BRkFq/y7HAMMO0h1B8VpiktsE
	 TMp77UAlzc2w5BbN9IXENNUvUIWRqAmpVGruGSVCksmL6UZEphCrL5N8oTQalgbfyd
	 2HvgvCKFY2kggJOwVH2/1ZlPSLzOGWurkl/M8KDumLUeIMElQi1NGM7oJ/cT5W3u86
	 jsmOdgtP+MHDOdYsq7MZUpxjrgLjJyufz/VejPJpWpUPeR6Dex/JdmxyKNjbY/7Cvo
	 bop5LVrAAyrhpVNvfbjLTJE7GoV6WBrfY0o+m0mcTMR2ufZEsobBCN0NVv+zsta6Nt
	 5MzfMpTKhd+7w==
Date: Wed, 10 Jan 2024 15:22:00 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Ralf Baechle <ralf@linux-mips.org>,
	linux-hams@vger.kernel.org
Subject: Re: [PATCH net 6/7] MAINTAINERS: mark ax25 as Orphan
Message-ID: <20240110152200.GE9296@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164517.3063131-7-kuba@kernel.org>

On Tue, Jan 09, 2024 at 08:45:16AM -0800, Jakub Kicinski wrote:
> We haven't heard from Ralf for two years, according to lore.
> We get a constant stream of "fixes" to ax25 from people using
> code analysis tools. Nobody is reviewing those, let's reflect
> this reality in MAINTAINERS.
> 
> Subsystem AX.25 NETWORK LAYER
>   Changes 9 / 59 (15%)
>   (No activity)
>   Top reviewers:
>     [2]: mkl@pengutronix.de
>     [2]: edumazet@google.com
>     [2]: stefan@datenfreihafen.org
>   INACTIVE MAINTAINER Ralf Baechle <ralf@linux-mips.org>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


