Return-Path: <netdev+bounces-231691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DDBFC9C3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244981882071
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB8F2A1AA;
	Wed, 22 Oct 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVAxDHhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5835BDAF
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144157; cv=none; b=P93YQtrnfoW/VBWlB5dTDUKN4iH2/6z44CBKk8LqLf9Ad94VotV3polAJzmTUv9A6xB6A5gPdpFa5CqJxFp9ii0a+oNUYv4AxImjBqRHwfgCv7Fq94lBifQpazPPjXv78g+d/EicLC8QrIt2418A7IIY8ub5lYjsx+aKSyHE9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144157; c=relaxed/simple;
	bh=rVtb9fcn7aUQD7lTkG3m9gca0zlP71v4qpLaES49Xk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzaXLdzPMyJ0o3TNutKMqibJMmdjUel1DgqvhOdZfoQx5Qf0atUuXUR42Sqzz81abGexSaKlxJr5mw2iN3U0IhrhTsmUpHMgbm4V+eG6a/i1zVykDO+5X/iRtHky16T1iByt5RwTTjdL/Yd7AokqtnfNga8fSJ5VLGnA5rq4rcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVAxDHhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BD4C4CEE7;
	Wed, 22 Oct 2025 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761144156;
	bh=rVtb9fcn7aUQD7lTkG3m9gca0zlP71v4qpLaES49Xk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVAxDHhi1z4FV+HOdPBne4X7YSW7RpqQFgt+0HVR7aIxccTPqfDfbnnHUeAZ/0iea
	 Uco2GtGI7/QgD3CB8LcD+MfTaQk/YpwqA0KLTLDJ27avy8kgbCkOT2yrOKwK0f49wT
	 /S/kgOA301xiPOGGN6np8wXPhx47jJmkHOU1J37wF06kY0ugDco7JRIXo+utcRP6QM
	 MBIqgt+4653WqPFf7/pbEKM/lwNOXTEZOIbTMI83FbrAriE5gxaX6n9+dnJ95V3xti
	 f9jPV9yxoBYBCfF0XeemHLFFHuobeMUbmSBVi91DxWmhk+m2dYqndIDDW+rkfzaR0h
	 uVpIlVOO+fXJw==
Date: Wed, 22 Oct 2025 15:42:32 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] ixgbe: fix typos in ixgbe driver comments
Message-ID: <aPjtWJVm9G3ObdbJ@horms.kernel.org>
References: <20251021191216.2392501-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021191216.2392501-1-alok.a.tiwari@oracle.com>

On Tue, Oct 21, 2025 at 12:12:14PM -0700, Alok Tiwari wrote:
> Corrected function reference:
>  - "proc_autoc_read_82599" -> "prot_autoc_read_82599"
> Fixed spelling of:
>  - "big-enian" -> "big-endian"
>  - "Virtualiztion" -> "Virtualization"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


