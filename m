Return-Path: <netdev+bounces-131621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E34098F0D8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26BDB20C9F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246D19CC23;
	Thu,  3 Oct 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu4CGhJi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994951547DC;
	Thu,  3 Oct 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963638; cv=none; b=fPjN8e5HhTSs5k55Jfbl5kzw1aQNsEgF2HihNEAS7VvgmH3I63jiHsTDRfQA1JO7yZI6guuGL5MQdt0IZj4Ay+02TJAprF4glMWcLDoXtTHHHf1g4znEe+4cCcKElL79ZbzUN6O3fLToFVs5rzxeHG48Qu/XOb6YiHfvTN0aNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963638; c=relaxed/simple;
	bh=V7wL9d576mMnlSBCsFKYiCjgPRzQk/PV+oySoXjmUFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuASlrehjoOk/AadazxrPmIj1/y82UzLrBA/C8jazre4BVsFkBULm54MW69n83keqZUl016K2xwN6ZGxiysQ5qqXv6VO2NvDvCFfLjkw7wefJtzAhAmeP5sC/kkoVQLYPmTYRmSUzKjUW3ymmUQfkpCxCB+c1aFaqbDoPvIDemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu4CGhJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A5AC4CEC5;
	Thu,  3 Oct 2024 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727963638;
	bh=V7wL9d576mMnlSBCsFKYiCjgPRzQk/PV+oySoXjmUFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nu4CGhJiO2K2UxQVMyqJH7p8V0jLQG6p3NYyJjqeCIMGNU3AH4xmWVE4oymp4D3Pc
	 09RVzUHE9jFr77KO998FJOI7Yq/3MquuBO7tIsBTevYgEUWTZhS4kSMESK91mvd7Ht
	 loaXn0tyaS5kd+2q298GgwOAYPWLIrLF9Qsp/UhULOgN/IFitnV6NkRTY1TCAMolj2
	 7EQ3OTUdEueUcGPl6tv6xWWzbeSpLiKd0VXCHzBKMNQCa1shQsQeJ8x0Ye0eaRSGQ4
	 jI2JhbLsA0WY5ngvmyZH/k5ESNEl3fURiDA4VgBSXJz5JCSOP6P+jQRBeE0pfeevBM
	 pXgfQAk/g0sMw==
Date: Thu, 3 Oct 2024 14:53:54 +0100
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v4 0/2] ethtool: Add support for writing firmware
Message-ID: <20241003135354.GP1310185@kernel.org>
References: <20241001124150.1637835-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001124150.1637835-1-danieller@nvidia.com>

On Tue, Oct 01, 2024 at 03:41:48PM +0300, Danielle Ratson wrote:
> In the CMIS specification for pluggable modules, LPL (Local Payload) and
> EPL (Extended Payload) are two types of data payloads used for managing
> various functions and features of the module.
> 
> EPL payloads are used for more complex and extensive management functions
> that require a larger amount of data, so writing firmware blocks using EPL
> is much more efficient.
> 
> Currently, only LPL payload is supported for writing firmware blocks to
> the module.
> 
> Add support for writing firmware block using EPL payload, both to support
> modules that support only EPL write mechanism, and to optimize the flashing
> process of modules that support LPL and EPL.
> 
> Running the flashing command on the same sample module using EPL vs. LPL
> showed an improvement of 84%.
> 
> Patchset overview:
> Patch #1: preparations
> Patch #2: Add EPL support
> 
> v4: Resending the right version after wrong v3.

Thanks, this one looks good :)

> 
> v2:
> 	* Fix the commit meassges to align the cover letter about the
> 	  right meaning of LPL and EPL.
> 	Patch #2:
> 	* Initialize the variable 'bytes_written' before the first
> 	  iteration.
> 
> Danielle Ratson (2):
>   net: ethtool: Add new parameters and a function to support EPL
>   net: ethtool: Add support for writing firmware blocks using EPL
>     payload
> 
>  net/ethtool/cmis.h           |  16 ++++--
>  net/ethtool/cmis_cdb.c       |  94 +++++++++++++++++++++++++-----
>  net/ethtool/cmis_fw_update.c | 108 +++++++++++++++++++++++++++++------
>  3 files changed, 184 insertions(+), 34 deletions(-)
> 
> -- 
> 2.45.0
> 

