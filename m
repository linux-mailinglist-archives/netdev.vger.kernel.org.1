Return-Path: <netdev+bounces-48364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737797EE26D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1091F267EE
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75953315BA;
	Thu, 16 Nov 2023 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7Eaj5hV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EDD315B3
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 14:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83940C433C8;
	Thu, 16 Nov 2023 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700144078;
	bh=pLtniYz2EP22pnXHC8vz5PZUKTZzaVy3PVuTc2mpr0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7Eaj5hVQddwwGtNP0wYSBvCxTfclUPvTzlY+DLOG6+QI6rqCJXw324FB2U3Avs9b
	 8E2wQiVayfGlf11EyZ/8N+FU+N68vjlk4jLogETgIZQS23ztm4OlOMLypKRjM0p0Hy
	 37W2Thuk8NkBM9A6oWHuoLgJ1w72pjZUOQwEQLnZJDI2UTY9hn9/g2+uvnA4FKrfKB
	 8vPE1ZN4xzw72RgNIHn7fxMF5zGStTArAuj5E5Ynje+CzodbJ2k70ErPS+SE8ZxR2+
	 GFtnMz82ugeoUH+K/2XoisTP+Knc6lqfqrLiRhSxopUkidNaGXH2lB/zONgMF+jRTJ
	 EYdd6tQiYm5rg==
Date: Thu, 16 Nov 2023 14:14:34 +0000
From: Simon Horman <horms@kernel.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: Re: [PATCH iproute2 v2] Makefile: use /usr/share/iproute2 for config
 files
Message-ID: <20231116141434.GE109951@vergenet.net>
References: <71e8bd3f2d49cd4fd745fb264e84c15e123c5788.1700068869.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e8bd3f2d49cd4fd745fb264e84c15e123c5788.1700068869.git.aclaudi@redhat.com>

On Wed, Nov 15, 2023 at 06:25:35PM +0100, Andrea Claudi wrote:
> According to FHS:
> 
> "/usr/lib includes object files and libraries. On some systems, it may
> also include internal binaries that are not intended to be executed
> directly by users or shell scripts."
> 
> A better directory to store config files is /usr/share:
> 
> "The /usr/share hierarchy is for all read-only architecture independent
> data files.
> 
> This hierarchy is intended to be shareable among all architecture
> platforms of a given OS; thus, for example, a site with i386, Alpha, and
> PPC platforms might maintain a single /usr/share directory that is
> centrally-mounted."
> 
> Accordingly, move configuration files to $(DATADIR)/iproute2.
> 
> Fixes: 946753a4459b ("Makefile: ensure CONF_USR_DIR honours the libdir config")
> Reported-by: Luca Boccassi <luca.boccassi@gmail.com>
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


