Return-Path: <netdev+bounces-124294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00AC968D36
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE512833EF
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D719CC30;
	Mon,  2 Sep 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax4/Mj41"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3D19CC20;
	Mon,  2 Sep 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301014; cv=none; b=DY+3lPvwd94+lVcP9WEG3mG1G//UMpopmGOcEGgEx2KMUgpqii8zkwc4bsWxEjez3Cpp1U7hcC09IExRx7abMHUGce6TCYsFqVZgyfRMmXxpaWbU6tskFHcukdmNdFQiNNrQUuzY6lMzH/FOcKxVose2pAYZ79yQXY/KVY1FeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301014; c=relaxed/simple;
	bh=14q4ZFgPzcArLjMgGqHApXO6D0Ht3KxRIxPkKQmf8RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOC2XMpA58qPPCp9TLvvqCYFMI4MUskZZfrIlNGkIr6MXM5KRCFu34CsV78Osm9hAwRpPfJe4jIEwUnOl8AL2GHazowkj44l4Uew+D34xdEq6ceCbEXsO934r3BkT4WiC1Wj/pyDTDPGz/DY4faTDE911nkrjZxxJYhEi43IqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax4/Mj41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1A7C4CEC2;
	Mon,  2 Sep 2024 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301014;
	bh=14q4ZFgPzcArLjMgGqHApXO6D0Ht3KxRIxPkKQmf8RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax4/Mj41WfpXUGoEq/BLZFxTLuUNbtwA5nWRnCWGbtBBV2G1OkUyior8efWVypSdB
	 Z+1it4HfziJB1gAHTHZ5as8VErVRo+fK/IcdL4Gf3Xp6zAS8JyNSRlzyprL552gTjf
	 DNW7N07SCqpvAUDevMIrgMoPOREmT8qHOlra/Bcn8GGE4+2LcNrhpiEXY0wTbicidS
	 gs0pCRLQXg1zc3kRA2W5pvzq7KbfyQgCeKqfS2X/ASKn4Emx6hwczE94IHPdoklGoa
	 Ebk/ViOll6NNqepqTFgmDUyaSGDTE+Icazf8JKpJnflU+AiaIqwdUgQdlGM2TqGRJi
	 zb2rOhFQbSKRg==
Date: Mon, 2 Sep 2024 19:16:50 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] qlcnic: Remove unused declarations
Message-ID: <20240902181650.GI23170@kernel.org>
References: <20240902112904.556577-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902112904.556577-1-yuehaibing@huawei.com>

On Mon, Sep 02, 2024 at 07:29:04PM +0800, Yue Haibing wrote:
> There is no caller and implementation in tree.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks,

I agree there is neither a caller nor implementation of these functions.

Reviewed-by: Simon Horman <horms@kernel.org>

