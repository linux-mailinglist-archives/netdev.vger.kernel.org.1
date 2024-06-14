Return-Path: <netdev+bounces-103561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE367908A4C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA58282331
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28A1946B5;
	Fri, 14 Jun 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff1ZMpkG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C261946A7;
	Fri, 14 Jun 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361659; cv=none; b=XJEXMZaBq0hABpQyhUH5WnwpSnCfnwM/Up3TYSwS5PU3HaDl4jtYyBWlm0P9NeORe0RlWjgyLiYB8CPVVCa63MdEoUkWb7PEBURFA5dwIeJQjldvzNt0R6YDYl2yMV8B3FBRHHNUHY1SkPt9PAksWlEEi/mDImgWo61zZnFSABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361659; c=relaxed/simple;
	bh=B/VMUNEG6+XrQ+4IvPLk13QyRGjVOos0niB7ez3rRes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdyQOdn9SxWmeXBgqFbifWFtfcW7EeOJwf61jKFychwVk4tk+uN0ElS/KvksozZ7UzQzYjmoDW3ZjruLsb0GjwEKBbSa9L6G7B3KxTTl8CveR8J9HKAE0IQK/7cPbPgPwdDCGRw2t402xDW7ujNgoFCHSFH57GxiLX3fHmJXYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff1ZMpkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A076C4AF1A;
	Fri, 14 Jun 2024 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718361658;
	bh=B/VMUNEG6+XrQ+4IvPLk13QyRGjVOos0niB7ez3rRes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ff1ZMpkGwiDfAwnVgXFT17lPCrGYC47rrh8oJk7068Q7Bbpyp9HEbUL+D24RkKSOX
	 CAbOxQXsf5OKi/Xbb+r6qe2nL0ytQgbqxM6gxzT3UTG+FHwEeTT8vm1E+pj6BmniM7
	 Kpbeih0K0y9EDylXpKgbBQeAtlQiYrnGJG8WZQV5uYidXUfQ48X+dDAe7avNwgsC6X
	 GZKWk223E+0DQ8yT0qYSMFvGNOnYtLlcoFBao3eWmkhubVblR+3VjMjoxg9pu6STPb
	 nDIs7Ss8x7ZwRXd1B3NLGKagvDrymK65Yb6/Ef9i6l04Q0rGDxs0KptiCwKFb57Kf7
	 t8TKwT0EBbzxA==
Date: Fri, 14 Jun 2024 11:40:54 +0100
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [PATCH iwl-next v2 4/5] ice: implement transmit hardware
 timestamp statistics
Message-ID: <20240614104054.GF8447@kernel.org>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
 <20240606224701.359706-5-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606224701.359706-5-jesse.brandeburg@intel.com>

On Thu, Jun 06, 2024 at 03:46:58PM -0700, Jesse Brandeburg wrote:
> The kernel now has common statistics for transmit timestamps, so
> implement them in the ice driver.
> 
> use via
> ethtool -I -T eth0
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


