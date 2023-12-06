Return-Path: <netdev+bounces-54617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53212807A4B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE7B1C20B1A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C866F628;
	Wed,  6 Dec 2023 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqiOM5j1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D54B122
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 21:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85679C433C8;
	Wed,  6 Dec 2023 21:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701897913;
	bh=0K/Q3+TV9b4ZKPISgc1t6BvtY9or0a9QPAxTEXr8000=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqiOM5j1vK8ZL65l8ntjuTP2qD/pl+mPCCUKXQO4+X4mU06JmF7+kfojbILGrQEKJ
	 WQOLIdfTwdhzvy7DJUH2FvEKOsVSA59/qpvtbpMeLUjiCLvr8xx/nbyMF/5qsDMETN
	 wve6Jmvz+K1ThHXfTHVc23uQqJfQNxou+jSwX9uDnjMVKmjQNqGav2HqAjqSzYJL6/
	 yfOcpX+eWQMD5MomJT9QOVGKoKl+QbAhv/WYIJdL6pg9iBS4qmaKDne0AD3BI1cW/X
	 F3E4gCGapW/P/iOB5N8mLXvK89vM1qtK2dXoHBr48IuzYR1ZvDIi/B90OF3Kl2W63b
	 1bGWuI2xHlIyw==
Date: Wed, 6 Dec 2023 21:25:09 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Andrii Staikov <andrii.staikov@intel.com>
Subject: Re: [PATCH iwl-net v2] i40e:Fix filter input checks to prevent
 config with invalid values
Message-ID: <20231206212509.GA50400@kernel.org>
References: <20231129102311.2780151-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129102311.2780151-1-aleksandr.loktionov@intel.com>

On Wed, Nov 29, 2023 at 11:23:11AM +0100, Aleksandr Loktionov wrote:
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> Prevent VF from configuring filters with unsupported actions or use
> REDIRECT action with invalid tc number. Current checks could cause
> out of bounds access on PF side.
> 
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1->v2 add 'Fixes:' tag into commit message

Hi Aleksandr and Sudheer,

Some minor nits from my side:

* Probably there should be a space after 'i40e:' in the subject.
* v2 was posted not long after v1.
  Please consider allowing 24h between posts.

  Link: https://docs.kernel.org/process/maintainer-netdev.html

The above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

