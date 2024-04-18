Return-Path: <netdev+bounces-89374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBACD8AA25A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E57F1C20B16
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E16E179956;
	Thu, 18 Apr 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvzJ3FAL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD884F8A3
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466736; cv=none; b=gfREoNPptrLiknfcVJq9S+dAL/H75apqXerk1/R71Xf6bcdykn3+R/ztFoPAbOfX/zKs7iydZcmrNp1iA8XhlYSdOjjJ1M1K4XXpQN9VrweOyzxIvKuCpK5+1oE/z8WU6mYHS+772VCuwfIc5VKEoPxjxgCVKdtfW8TCUrQjbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466736; c=relaxed/simple;
	bh=OJfrxBgGuxh2+UES3b54DAD8DCWEFeHj2lVIMs8BWl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrL7RTVjCPp4F8wXSYD+wPlRyRpM+Z7/VFMOk6HvE5sV1QVeSu2Or6I8xkr1fhdD5ZFOl/JAhqEGF9a21HDNzSJujCrFtxCAlv/GI8SUV/b64R4giAfKAfysTWvFYgQ8pYCdc3tMoCSw55YjVbkB2pqcoEYqQHDx9JX4XUp3crA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvzJ3FAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741F0C113CC;
	Thu, 18 Apr 2024 18:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713466735;
	bh=OJfrxBgGuxh2+UES3b54DAD8DCWEFeHj2lVIMs8BWl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvzJ3FALQKZutgAccVqLPrreL1NnjF0Y0heaInmrFqB05NwlbHZklHSC3v7GHFWTC
	 JnScCOPWFYTKIli0iXyxxJVZlQ+u2NzTrrzO324tNF8pWQFWMFsI62o58ITvJAhLcx
	 OEi6byn5ePG/8X+TxxccIa90rWmh52MfzOTolyVoW8IqLJR/Alcswh1i00iNY3fNSE
	 O1ntRBnzNy5gwecIBkmrqZgLp6XuXDEeqxm/nSax0oh+TKYv1Pn7r8vJVPI2YiWiHn
	 PvoLYbttabkf92OimyMsgn2PNM3+yquv0+96CzJY/nR5t7mZvfGXUUanWWyTcX9hZe
	 ouMyzm3AcFnZw==
Date: Thu, 18 Apr 2024 19:58:51 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net 4/5] net: wangxun: change NETIF_F_HW_VLAN_STAG_* to
 fixed features
Message-ID: <20240418185851.GQ3975545@kernel.org>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
 <20240416062952.14196-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416062952.14196-5-jiawenwu@trustnetic.com>

On Tue, Apr 16, 2024 at 02:29:51PM +0800, Jiawen Wu wrote:
> Because the hardware doesn't support the configuration of VLAN STAG,
> remove NETIF_F_HW_VLAN_STAG_* in netdev->features, and set their state
> to be consistent with NETIF_F_HW_VLAN_CTAG_*.
> 
> Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Hi Jiawen Wu,

I am having trouble reconciling "hardware doesn't support the configuration
of VLAN STAG" with both "set their state to be consistent with
NETIF_F_HW_VLAN_CTAG_*" and the code changes.

Is the problem here not that VLAN STAGs aren't supported by
the HW, but rather that the HW requires that corresponding
CTAG and STAG configuration always matches?

I.e, the HW requires:

  f & NETIF_F_HW_VLAN_CTAG_FILTER == f & NETIF_F_HW_VLAN_STAG_FILTER
  f & NETIF_F_HW_VLAN_CTAG_RX     == f & NETIF_F_HW_VLAN_STAG_RX
  f & NETIF_F_HW_VLAN_CTAG_TX     == f & NETIF_F_HW_VLAN_STAG_TX

If so, I wonder if only the wx_fix_features() portion of
this patch is required.

...

