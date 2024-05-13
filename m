Return-Path: <netdev+bounces-96135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA568C4711
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A185C28146E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894739FEC;
	Mon, 13 May 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0fLk6CX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08C1CAAF;
	Mon, 13 May 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625755; cv=none; b=cVY7VcUO0Hmd/etgeKcE2xEyrQ32GUjMWNF4K2w/GuAfcnqsMcz1DhnRoSPFf6treB2dsNBeMENUAO7KxPA5aAJP9YZoLPhcSulO1UdwpnZeUj0CDfq5R2a1GX0Ha5zj1lWfazedmZFDsA5Yi4mX+ou0oDLV2+JNcGr8GOJz33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625755; c=relaxed/simple;
	bh=vflVzp1A0GkWtNm4fegjMCm97wJdDl9jRPwd9eWvaOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUyHTXRoKAPloovZFoJ4qGZM2ttJjVFh+Nj1GxujWvVvc5G53uNybQqfi1H6YbWV1J9W5nTe6SOr1jlORMlOgnKv+p9IP6DXiE+VJnA+eJwgeg21xk9pfuVGuojrWjc2K+azS0fsysHUuU7I72VKthlYWGu2Z34AEn6ITHidfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0fLk6CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB838C113CC;
	Mon, 13 May 2024 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715625754;
	bh=vflVzp1A0GkWtNm4fegjMCm97wJdDl9jRPwd9eWvaOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0fLk6CX6RRojI58r5e26p+XLRtH96irn9lbWm+4TKsr0x7WmUO2TgZhnjf6RbVBl
	 nefqqJR9+RQUKtbLyi6ORIFmQXdjzHhuUMDlQ0j8O05dHrp0dvIGRqTKa+RFRGRXwk
	 r5OULfz1e5BY7LXfn6AAvh8zKfj6rMNSTdxb9xvwS3fJ0XJTUyWSxbnCH3DWxijVAo
	 dkIqcft4g3eXAbl5OEFpBSotYUTjt5n8J+ZKgtxERxwxgtOMbjk9PKD+xRF3E4F1CM
	 gU0o8kfdQ7YyzGGsSFrhOgzyMxNlrIXwYVJz7EwG/zulansonU+Qczo30CUwfUZHE3
	 x4ZUKj+QU3r6g==
Date: Mon, 13 May 2024 11:42:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Jason
   Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Brett
   Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>, Jonathan  
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul  
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, donald.hunter@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240513114233.6eb8799e@kernel.org>
In-Reply-To: <1715614744.0497134-3-hengqi@linux.alibaba.com>
References: <20240509044747.101237-1-hengqi@linux.alibaba.com>
	<20240509044747.101237-3-hengqi@linux.alibaba.com>
	<202405100654.5PbLQXnL-lkp@intel.com>
	<1715531818.6973832-3-hengqi@linux.alibaba.com>
	<20240513072249.7b0513b0@kernel.org>
	<1715611933.2264705-1-hengqi@linux.alibaba.com>
	<20240513082412.2a27f965@kernel.org>
	<1715614744.0497134-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 23:39:04 +0800 Heng Qi wrote:
>  config PROVE_LOCKING
>         bool "Lock debugging: prove locking correctness"
> -       depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
> +       depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && NET

We can't make lockdep dependent on NET.
People working on other subsystems should be able to use LOCKDEP 
with minimal builds.

