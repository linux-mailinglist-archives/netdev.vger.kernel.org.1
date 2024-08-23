Return-Path: <netdev+bounces-121446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFF95D32A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1363283615
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA70189B8F;
	Fri, 23 Aug 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHC52a9i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF312B6C
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430194; cv=none; b=BOt6wEgVOaLxnkubv300u3fUXMOTQ5FfI368j7FdmYe4slYXoPwdMkwtLEp73akXn2XULFLommxx86lOYKhIAUXicxwvr50gLIV1wvK5Aslp55wnW2xsGNiXG8o6L9ZjitUN7Zh4ubW5FO9xsFqFs3wkhQ0NvTFX9SFaNpp0PkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430194; c=relaxed/simple;
	bh=3qlTn5svBoAvXKAQbnkbUztek9UbTGJUUeDAhqfPFpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9KuAjgwx7tRF7XJHICXfaqVVJtLN1o57/mcX98pn8v/zc7uHP6IgLptZRNbNxlT2UQRIlRFbaDoKfBN8e72p9jKsO0U9s8qr5HcQj1LAdP6iEuku+uGibhqKFSyvYjSQt+0SUkdFvfpHulcti+ofDwySQ998CN/yjEeCDlPZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHC52a9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C64AC32786;
	Fri, 23 Aug 2024 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724430194;
	bh=3qlTn5svBoAvXKAQbnkbUztek9UbTGJUUeDAhqfPFpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHC52a9iOLEyNaQJd8G4PZ/taDstUadbz5gv3+FrcDrxsg2bjtc/J115v/DPBgqiu
	 xIESORcTCJlas1SopUGKC5vilBh7gJ+q1nVwoTHWWX0crIiXDjVAyRS3QOmNQczOSD
	 XablHddKeADVt63/V0SCCrUy0sMJFa79r1wSYgGhSj6YfprNAh2nOqusOXrTgXjr1E
	 cpJINkpj6yv8D7jFMtaoC3lTN1uf86FLuCfuXSlLwpBD8NFzM652beZ9nIyfoIKubK
	 zxBErDQKIGlnEpXGzZlzb9VIldMECR2Sh/mlw6Kw2P8reijGtp3+D3FnAt5I258pzR
	 OfRQiQrkOaTSg==
Date: Fri, 23 Aug 2024 17:23:10 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com
Subject: Re: [PATCH net-next 1/2] eth: fbnic: Add ethtool support for fbnic
Message-ID: <20240823162310.GX2164@kernel.org>
References: <20240822184944.3882360-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822184944.3882360-1-mohsin.bashr@gmail.com>

On Thu, Aug 22, 2024 at 11:49:43AM -0700, Mohsin Bashir wrote:
> Add ethtool ops support and enable 'get_drvinfo' for fbnic. The driver
> provides firmware version information while the driver name and bus
> information is provided by ethtool_get_drvinfo().
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Unfortunately this patchset doesn't apply cleanly to net-next.
So I think it will need to be rebased and reposted.

Also, please consider a cover letter for patch-sets with two or more
patches.

Thanks!

-- 
pw-bot: cr

