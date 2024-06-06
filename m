Return-Path: <netdev+bounces-101198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE48FDB9C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28EA5B2187D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77679D0;
	Thu,  6 Jun 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxQOtYhF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2C4683;
	Thu,  6 Jun 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634884; cv=none; b=Ptzc91aY9uxjXqBJAbq3swNB/ngPtY2TIcha35jaFAvw1cw+bwajUUMfqpoxUvdI30cA6f4i+0CvKQPAodde+wFYyXz6QOCYc2ahLWMcjP85n8GSy17jW3KtO1C4F0+UcmQF6qVzuweVivG4OfDBPVU5k9ePyENzZuHNDQD1gf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634884; c=relaxed/simple;
	bh=iR7qCGvKa4GnFOsr+YD5UM3cwMIqnABlfcxvyTOVjrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hbw85x9hD8e6/cSR9MtreDybBP+Db029rR/m1Obz/hAkzMX7rAVh26xnaNInrC5/0YmDJOub6R/M8YDd+hyzT1OzANwhfmnjVmL4oMXlLtzn2dOn3TnW1eqmMT30z1wuxeCn0XRM5NwASuGX/3t2Z74YNc8z6Xosj1tP3rXVz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxQOtYhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BBDC3277B;
	Thu,  6 Jun 2024 00:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717634884;
	bh=iR7qCGvKa4GnFOsr+YD5UM3cwMIqnABlfcxvyTOVjrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cxQOtYhFIW8MSns9cdM8Uwmas6i11mn/mUelZKrNhdRzSenZBRCt2ZwgbpRRe4KB+
	 rM7CoHsvr25aF4VkzTFZ9R7O2u0hKr5CjbzrxdMps+xhgaXAEwyIvwJcdRo7p+d5wV
	 MQk/2Pwktuh9Kj1qoA21sKkHR2nNhXD87R7feppv27C+qfq3vgFGPaXHUt4qXPUmoB
	 CR3nVP1HL/a2uzgMu3rHOqWbQ0cTg5abnfLEPkajTUbHRJTlRGId5p5uVWezlCu0ZY
	 ENhbwF0XGGwsGBBaupu1lMNDL8EalhhkYTmCLaoLqOkgdwCmSsDhhvHLX7q0vM9fKr
	 gPISttyedlh0Q==
Date: Wed, 5 Jun 2024 17:48:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 corbet@lwn.net, linux-doc@vger.kernel.org, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next v1 1/5] net: docs: add missing features that
 can have stats
Message-ID: <20240605174802.0add2109@kernel.org>
In-Reply-To: <20240604221327.299184-2-jesse.brandeburg@intel.com>
References: <20240604221327.299184-1-jesse.brandeburg@intel.com>
	<20240604221327.299184-2-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 15:13:21 -0700 Jesse Brandeburg wrote:
> -  - `ETHTOOL_MSG_PAUSE_GET`
>    - `ETHTOOL_MSG_FEC_GET`
> +  - 'ETHTOOL_MSG_LINKSTATE_GET'
>    - `ETHTOOL_MSG_MM_GET`
> +  - `ETHTOOL_MSG_PAUSE_GET`
> +  - 'ETHTOOL_MSG_TSINFO_GET'

I was going to steal this directly but:
` vs '
so I'll let it go via the Intel tree :)

