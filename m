Return-Path: <netdev+bounces-60175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C281DF7F
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E76281720
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE510A15;
	Mon, 25 Dec 2023 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giTI23Ru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17A134BF
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B9CC433C7;
	Mon, 25 Dec 2023 09:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703496955;
	bh=LF/WJSgUBRPfQoLh6WGy2+fMbMkZEpoynqdokcSxuDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=giTI23RuXkTzuAMTEF3YZIgPuEDBVmSXs6JbQHINdZryLJUkIfr12NOu673Qn+iuG
	 rLQp4P4+rsDLme/KHJbJyd8lWoXgNUqxFZFx5bnvNoPNBcyt0eSxu0bNhp4rXsCEAY
	 4e5yjxiEyIv55boUmb8ZZxVzIfTvN+IUX6060cFV+NFk9omncsw+yHZh81D8wUf6oc
	 ELIWDksOP4CZRXWQEUFdI1Znm/wbXoa8tpLu2cNWhN14Mpj5FcpEg//zJ0TqYTEgg6
	 sgmIkq+HBL3so3QlwBsXt5yjbgFWi9ls9pg/ElFST0BREjl81BASD/QkckiU/VAa/n
	 C9B2DEyjaJTBA==
Date: Mon, 25 Dec 2023 09:35:51 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH iwl-next v2 02/15] intel: add bit macro includes where
 needed
Message-ID: <20231225093551.GD5962@kernel.org>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-3-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206010114.2259388-3-jesse.brandeburg@intel.com>

On Tue, Dec 05, 2023 at 05:01:01PM -0800, Jesse Brandeburg wrote:
> This series is introducing the use of FIELD_GET and FIELD_PREP which
> requires bitfield.h to be included. Fix all the includes in this one
> change, and rearrange includes into alphabetical order to ease
> readability and future maintenance.
> 
> virtchnl.h and it's usage was modified to have it's own includes as it
> should. This required including bits.h for virtchnl.h.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


