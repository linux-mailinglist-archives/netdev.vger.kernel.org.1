Return-Path: <netdev+bounces-51787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E877FC083
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA81B212C2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818F39AE1;
	Tue, 28 Nov 2023 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9uiShlS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47839AC7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5D3C433C8;
	Tue, 28 Nov 2023 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701193702;
	bh=crFOJPBS6sdzC1k9tvY1aohgWClvnoSxs5C6fxSmW8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9uiShlSr2SASGIcMGno9BTTjULqCjW3BzL1OAPb4/67vASqiEn80pgbylkNf0rtB
	 rChfyNO3rKAKEC0TugcTEzaWsqlTnmorJHg5YIt5GQdcakV5e8BM/lUWpV02DsaX49
	 Gfaodxlekv/bCMVw8JL+LWo4zVOCS6YEi407EtWqvJzkkSqeZZLRea6GUmX5a8kaQm
	 TZTggTeoXF9uCGNxrFcG/6IOaBHZOR1DmWibi3ZJl92RPM+QoUSFLYHH03SiZz75F5
	 KREmhbebp5wnbkS/1GusyxvBh9RvosAOD7l9J1RV5Me+cJB6lcsr/X3IBD62M/6U99
	 WkydzwkokxNfg==
Date: Tue, 28 Nov 2023 17:48:18 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, f.fainelli@gmail.com, mkubecek@suse.cz
Subject: Re: [PATCH net] ethtool: don't propagate EOPNOTSUPP from dumps
Message-ID: <20231128174818.GB43811@kernel.org>
References: <20231126225806.2143528-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126225806.2143528-1-kuba@kernel.org>

On Sun, Nov 26, 2023 at 02:58:06PM -0800, Jakub Kicinski wrote:
> The default dump handler needs to clear ret before returning.
> Otherwise if the last interface returns an inconsequential
> error this error will propagate to user space.
> 
> This may confuse user space (ethtool CLI seems to ignore it,
> but YNL doesn't). It will also terminate the dump early
> for mutli-skb dump, because netlink core treats EOPNOTSUPP
> as a real error.
> 
> Fixes: 728480f12442 ("ethtool: default handlers for GET requests")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


