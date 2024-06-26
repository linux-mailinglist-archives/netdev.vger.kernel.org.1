Return-Path: <netdev+bounces-106935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D529182F3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04CF281757
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DD1849D1;
	Wed, 26 Jun 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iel70Ee9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B318413F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409509; cv=none; b=lpRziJTs4BqkgPXdisV/ZVipCUurXdp4sMmCgi5RmfWh9sQz8rPrYfH/LtpI4pL4OuAMvDPTW+9c9Sw5aCkKcjjEC3ihUF5Jxg31QswcAL+4qz1SBSbERk3rIILvCyqX/SzbjTyvYhReLjH0RpBbr8crO1SyDCjQYaEjAJ5KBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409509; c=relaxed/simple;
	bh=kIDlr8n8ejMTZw8/3TN8En7PFAvavy285JHeS18IMgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPVFtOGf7FSq7WW3i8UNkQ7pgHcVDMgwwjvhlnJU44HrTEPV8S8BRhaV37EYBgo4BgTQ+DnL6HvshJ7Nx7Md41bx6GSZFZSNn/pLlWQX922MXkFXfvyovjrzD9qniA99GtOEvfd6VdCyJG/pnSidvqvuzIzVIeEreklIKY25/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iel70Ee9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D5BC32782;
	Wed, 26 Jun 2024 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409509;
	bh=kIDlr8n8ejMTZw8/3TN8En7PFAvavy285JHeS18IMgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iel70Ee9otiw+YVbkY4EXgzcuOnUViN9Wqvni/sRJXyDxvHazJ0T14fhUqYA7IIE2
	 6g0mftxpCk+PZj08dJPDBvW2X886HsXjdUiorRYxH29OWAjRuoNPJ5v//O5JfTID0V
	 FhF+HsgD4NYk8rKbnxuGM2ZzqUymFVWZWJbRm85MJiwLRFxD6qUX0WAM3tGqGWgm2w
	 HCWVIFXc3R08ftMubFoSrWGYOg56XIoOzOKgBNTP9OkRf0gPd4hFBP8xxBEM7Ka3Z+
	 x2FfYgL5KYhlsRNIrG8E1YBL61F1nvq7q19ueGiKW/jdB9BYPnnqte/JeYSqNJkxsR
	 pAXEQoUN3xPxw==
Date: Wed, 26 Jun 2024 06:45:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [PATCH net 6/7] net/mlx5e: Present succeeded IPsec SA bytes and
 packet
Message-ID: <20240626064508.06573a83@kernel.org>
In-Reply-To: <25bae4ee-f333-45ea-8c61-d9d520df08ae@gmail.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
	<20240624073001.1204974-7-tariqt@nvidia.com>
	<20240625172141.51d5af12@kernel.org>
	<25bae4ee-f333-45ea-8c61-d9d520df08ae@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 15:54:32 +0300 Tariq Toukan wrote:
> > wrong commit ID, I think that it should be:
> > 
> > Fixes: 6fb7f9408779 ("net/mlx5e: Connect mlx5 IPsec statistics with XFRM core")  
> 
> Right!
> Should I respin? Or can be fixed while being merged?

Please respin.

