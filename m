Return-Path: <netdev+bounces-127236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A1974B6E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829291C2184E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D470127E18;
	Wed, 11 Sep 2024 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6qs1UWV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888F8494;
	Wed, 11 Sep 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039959; cv=none; b=BJ1H7Jq+7rlmTdiPoRpQd/NtFHWKFzMdssqoTSW4lZiuE6qeaccemELdmtPL6bTXgl5ja9PSW6xLV5978Bmy1fU8BRuo113aXPVzFJzlFF1km2hDQ/ldjdo1qnFSpUT7WCCLMHeLV/kVZyKZFNTtkJAUSyPnQizhF49dBkCY184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039959; c=relaxed/simple;
	bh=nbc4L8XAM+OrpsKsEcdEqyzGkb4P+wAT0pDlP6GzPYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPGvys3glzyFzuIGeVOXzoyQOVjz0BR/VQMsqIFm8/Sht3zsyvC/iDrJD+gjETD6/Um0j2xEkKXDVIK/Y8/tl7UCXuZPV268CYtdC8AQfVqqeR/MqqtRco0rEMHN2gcsddEoisktCxFvGcy8pmQ6/rwoplw6t1j83DXpkMRiPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6qs1UWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2EEC4CEC5;
	Wed, 11 Sep 2024 07:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726039958;
	bh=nbc4L8XAM+OrpsKsEcdEqyzGkb4P+wAT0pDlP6GzPYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6qs1UWVvPzJH7nrszhD0UUIq7rB0LNCO7O0KLbaPU4Ge8FEvoOI+myEQvtJxlaYm
	 wJP7sNTnNS2EeHMMXwCbslYnD6vQmP/Sj3wzQjpFBy6abWLMuuIPGrBIGD0IkI3tzZ
	 EsYojB4SkgbL+qlsLjG0D/ORJDHkm6gi2NRQBtCynhXmpnnOGnhH3IM/eVhAFATaNM
	 FdLbn36HDCaLg6Q05k7CztefrxdkOVkMlyt9XbwOuuafdex4CPLUpp/SQsZ3HdvZg5
	 HK03ro+ohge53en9xB9R7DS+1rizq42DzEytksyDXWUfDsAzLomCGLcvo1DNvt6qKN
	 q3c3KdMSwiRKQ==
Date: Wed, 11 Sep 2024 08:32:34 +0100
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org, petrm@nvidia.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Message-ID: <20240911073234.GJ572255@kernel.org>
References: <20240910090217.3044324-1-danieller@nvidia.com>
 <20240910090217.3044324-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910090217.3044324-3-danieller@nvidia.com>

+ Andrew Lunn

On Tue, Sep 10, 2024 at 12:02:17PM +0300, Danielle Ratson wrote:
> In the CMIS specification for pluggable modules, LPL (Local Payload) and
> EPL (Extended Payload) are two types of data payloads used for managing
> various functions and features of the module.
> 
> EPL payloads are used for more complex and extensive management
> functions that require a larger amount of data, so writing firmware
> blocks using EPL is much more efficient.
> 
> Currently, only LPL payload is supported for writing firmware blocks to
> the module.
> 
> Add support for writing firmware block using EPL payload, both to
> support modules that supports only EPL write mechanism, and to optimize
> the flashing process of modules that support LPL and EPL.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     	* Initialize the variable 'bytes_written' before the first
>     	  iteration.

Hi Danielle,

Thanks for the update. From a doing-what-it-says-on-the-wrapper
perspective, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

I do note that there were some questions from Andrew Lunn (CCed) in v1
regarding the size of transfers over the bus. I see that you responded to
that. Thanks! But I do wonder if he has any further comments.

https://lore.kernel.org/all/DM6PR12MB45163C3543368036C03B6E05D8982@DM6PR12MB4516.namprd12.prod.outlook.com/

...

