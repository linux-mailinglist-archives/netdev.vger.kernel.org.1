Return-Path: <netdev+bounces-33576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8877E79EA76
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD301C20C00
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228891F16F;
	Wed, 13 Sep 2023 14:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674791A717
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9F0C433C7;
	Wed, 13 Sep 2023 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694614114;
	bh=U0uF/Hy56VJL0mJg5gDqOTRdoiUMba1sRM09O5WC0A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXRh2XAwWjglZRrf4C8kmeEaaKwcdq7iyQv3rdUqUL/lHXxjECxSWAETJVrhjv0KA
	 l+1ZnZBjmsxRvWBL9bVGkQLlncKiR9g7ZSS/eM79YODZxZ5Kbke7TddQ6bpLDJdJl8
	 IjKcMHFA1k2RRdOYkB+FmCvpafbv+Aqr+24EAZGEo9Fwoj2YjhYyJogKFKVguMniaf
	 yJnaH3WxJmQxi0pZitFm1EUevL4DqkIa1xTnitflY8xl0Hy1gq1wYAlOdgcPo/kspU
	 mP4VmRpD1CzsOId08Rj/aHwQ4LHRGC26z+BKG/CyUUyELafG57JDa1+8GjHex7Zjdf
	 no+tTZ2JGzO8w==
Date: Wed, 13 Sep 2023 16:08:28 +0200
From: Simon Horman <horms@kernel.org>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, jiri@resnulli.us, johannes@sipsolutions.net,
	chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nmarupaka@google.com,
	vsankar@lenovo.com, danielwinkler@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v4 5/5] net: wwan: t7xx: Devlink documentation
Message-ID: <20230913140828.GU401982@kernel.org>
References: <20230912094845.11233-1-songjinjian@hotmail.com>
 <ME3P282MB27037E574DB3685216A0DF56BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME3P282MB27037E574DB3685216A0DF56BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>

On Tue, Sep 12, 2023 at 05:48:45PM +0800, Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Document the t7xx devlink commands usage for firmware flashing &
> coredump collection.
> 
> Base on the v5 patch version of follow series:
> 'net: wwan: t7xx: fw flashing & coredump support'
> (https://patchwork.kernel.org/project/netdevbpf/patch/f902d4a0cb807a205687f7e693079fba72ca7341.1674307425.git.m.chetan.kumar@linux.intel.com/)
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
> v4:
>  * no change
> v3:
>  * supplementary separator '~'
> v2:
>  * no change
> ---
>  Documentation/networking/devlink/index.rst |   1 +
>  Documentation/networking/devlink/t7xx.rst  | 232 +++++++++++++++++++++
>  2 files changed, 233 insertions(+)
>  create mode 100644 Documentation/networking/devlink/t7xx.rst
> 
> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
> index b49749e2b9a6..f101781105ca 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -67,3 +67,4 @@ parameters, info versions, and other features it supports.
>     iosm
>     octeontx2
>     sfc
> +   mtk_t7xx

Hi Jinjian Song,

I think that this should be t7xx rather than mtk_t7xx,
to match the filename of the new file created by the following hunk

> diff --git a/Documentation/networking/devlink/t7xx.rst b/Documentation/networking/devlink/t7xx.rst

...

