Return-Path: <netdev+bounces-125236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6307596C628
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954691C24F53
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CF1E1A2F;
	Wed,  4 Sep 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG0FE3X1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F5F1DC1A2;
	Wed,  4 Sep 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473798; cv=none; b=eHxwh2q75elLf3lCEaD5BrO/UrVCWJCpz0YfnVXZTTIa2tdQOdXagw78d78hdjKM3E3xwTB3JMe8DT40ZotRwV7oRTkzPDLYI/xstzdnliq55rI0tOigUX+XXSGML11YkTd8uK1RBtowWgpB39I0Ox79lIraTPMUgishoa3CySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473798; c=relaxed/simple;
	bh=DqYLkToEvVj8Gv/VXlW25VWy4LaPMkC3xaJEvxRnxUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKf8C6SE3aEhfKtfmAEd+xv/fO/SQpUZ/bHv9NIEWY4zISntDrOwLKOuKxHWBYeBQgISC+tCaZsucGCSZYxzu/8HFianF3hVZZZ0YSPTcFZJ2YPm4HnL6Zcndh7WIGHyveKkkX8/9zm4MwxMatDzauYE54kPW4gYQaueWphLi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG0FE3X1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6534C4CEC6;
	Wed,  4 Sep 2024 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725473797;
	bh=DqYLkToEvVj8Gv/VXlW25VWy4LaPMkC3xaJEvxRnxUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gG0FE3X1/3yJRyTWRLHwYeHHnPOm1SPWhRwbDe07LVLALSXtUHKtAEdPA/XXwQHfd
	 Cr4vSwkYyAYswKFxvbWDTHNKTVLnRVpFsVRHefn/Kl2O4g9kEHU1p/8ImXAKC8Ai4A
	 X7+LPeCK1KT/hzB4NiWxUlr9qkmxzvz4skMBBgXwYqcRRuLtx/G42JIHXdtR4IsszB
	 he2odl7nimis2gxfNVtb2U5YxEMshSNMe8tTjuNAbd7ynbLs1WfGCYhB1S0EYWLysJ
	 ZfrD5/o+QCxHQHy/1eQTCFlj5kwksYtsq5tydDHSphlBEYdgWFsokUH2k338QQaw2M
	 KmfKpbx4lfdEQ==
Date: Wed, 4 Sep 2024 19:16:33 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: atlantic: convert comma to semicolon
Message-ID: <20240904181633.GD1722938@kernel.org>
References: <20240904080845.1353144-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904080845.1353144-1-nichen@iscas.ac.cn>

On Wed, Sep 04, 2024 at 04:08:45PM +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Thanks,

I checked and I couldn't find any other instances in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

