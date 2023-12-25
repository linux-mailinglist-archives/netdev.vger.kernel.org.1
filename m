Return-Path: <netdev+bounces-60176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF2B81DF81
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA591F21453
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101610A32;
	Mon, 25 Dec 2023 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCKZ6+EI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEF13AD6
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF67C433C7;
	Mon, 25 Dec 2023 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703496972;
	bh=pn3mm75zzR2E6GKudky68lgSS4ky7Wdi7kq7bHXdAbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCKZ6+EIX7x3icGOSG1PVXG9sHVDdzESu49U5FnsEZrKFsxY4TQdYifoU2AoZqIfD
	 mbd7l0uNYYvdO9Jp1xKxWXwH5oL3HJkCkr51jHnAGTzKKOGChQIYC3Gw9ra7Ae7Zx0
	 REVsfHnj/MADAUmxEgas/BL8fr5oxCHIHzqkmdteePxi7pQ4DdTMw4T80i+Se5A9EM
	 hFMjG9Rimr65IGbUuvvDh7pLO0qqwoVYcgzI8Tmtn2tttdbP4QowyZyfz5ajm8nkTx
	 9Jf3VTn+Ah9wrWxLJL6XxuH2qPpB4I1vKdUmNDA6RP9RcEGHiU4vTfOk3Q44fGkcdI
	 NfEsSOR1864Fg==
Date: Mon, 25 Dec 2023 09:36:08 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH iwl-next v2 01/15] e1000e: make lost bits explicit
Message-ID: <20231225093608.GE5962@kernel.org>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-2-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206010114.2259388-2-jesse.brandeburg@intel.com>

On Tue, Dec 05, 2023 at 05:01:00PM -0800, Jesse Brandeburg wrote:
> For more than 15 years this code has passed in a request for a page and
> masked off that page when read/writing. This code has been here forever,
> but FIELD_PREP finds the bug when converted to use it. Change the code
> to do exactly the same thing but allow the conversion to FIELD_PREP in a
> later patch. To make it clear what we lost when making this change I
> left a comment, but there is no point to change the code to generate a
> correct sequence at this point.
> 
> This is not a Fixes tagged patch on purpose because it doesn't change
> the binary output.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


