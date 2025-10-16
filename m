Return-Path: <netdev+bounces-230104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C080BE4080
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 667D3501BDC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70809334374;
	Thu, 16 Oct 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVVzbw0L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86C1D554
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626500; cv=none; b=Nrmaz+NdBsusoXFBsOh3wJTBMMP8wJDft5rjvF+0Yl4p5JPkvJQyk9SEv8x4+c2siCt1jBw0LAxciDycAbtuEhu7IOPB3rGKRDPGmGn40ynCuSuJAU/RZXjtyuhnxwMtXTbjaoO+Lkrh1ykB4mTEhqs2DMSdElNhkFv6sXyPzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626500; c=relaxed/simple;
	bh=50jdzoROc/jZwzK+Q1N1dIczrV9tP/OOyZsaobiNmyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpR/XizQ8jp3j2OIOfe+V9d/3vrA8AW/t1nvrS4NVCnf8HCESiEZCmegMRzNdq8ckPmCUIrvJvkaKHenBOeix1PJEBYmJfEqDfmC9rVRMok/ZaQ4kBV7ayYyzwrWXqFVAHxWVG8Zl5/puprZSeY/PhHaUiJToG/KdzB4iSFqpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVVzbw0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D8BC4CEF1;
	Thu, 16 Oct 2025 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760626499;
	bh=50jdzoROc/jZwzK+Q1N1dIczrV9tP/OOyZsaobiNmyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BVVzbw0Lz5PMVl2+I734JviYTCJtTjOjM33p6kJdH3xW1E49DMbhDFuhkgb0fu04e
	 sKSmU7LlRn+pzgWUI9tn3QIOsh2ZzBJUmsWEKJA7ynUGEF7fdSYUdbVO0Jub0BBJh0
	 0lYgrgbGKEDIXxMXAuRaVHXM9XE+xUMNRNpayGrrn03J7dgi9vQQTFXSVshquGQzCf
	 LnrRxTWtmuHbTlt3mlMApp7TWIKiTupYtn+JzJP0SIGldyGtHv66pLhTuzq+mWKlis
	 orsAPnacXc9Mo3TvzA9/f1pC1hsd7w3AC8v8wTEeAMpGA5VrqEM2cwM+c7kaL0q/xg
	 ySu/O+/mQpU3A==
Date: Thu, 16 Oct 2025 07:54:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, mbloch@nvidia.com, Adithya Jayachandran
 <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: E-Switch, support eswitch state
Message-ID: <20251016075458.2b29fe22@kernel.org>
In-Reply-To: <20251016013618.2030940-4-saeed@kernel.org>
References: <20251016013618.2030940-1-saeed@kernel.org>
	<20251016013618.2030940-4-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 18:36:18 -0700 Saeed Mahameed wrote:
> +		esw_warn(dev, "Failed to create fdb drop root table, err %ld\n",
> +			 PTR_ERR(table));

Gal's new coccicheck says:

drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2395:4-11: WARNING: Consider using %pe to print PTR_ERR()

:)
-- 
pw-bot: cr

