Return-Path: <netdev+bounces-222769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F27B55F8F
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143181C226EE
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28F72623;
	Sat, 13 Sep 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaupoKaJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0763DDC3
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757753499; cv=none; b=lPd5bfNWiFxf9L9NP0U0Yd7bV52sMn9HFeJR/VMSOelmk8xi8C2IpaCuI/ZIvZqtHzs/cMYkXz4ucq4B6Lw717WjgvgnF0YPrVyEctoypHZKTdKBSdKrSqWSzwCSptqsmehAGAyLVTwYjXg6QOXjwiCnZfUs7lCxjUmAuT0loRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757753499; c=relaxed/simple;
	bh=2e3UV13BBEWqEXcntHUCbZiuIVL35wadRBGo5j7gG5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyav/KfAM6lp41eSp6UvCczBTboajC+qtSkqDZHYQWzapf6FuVqY9tOoM9QF8FlCyHgfbL95rHMcgC0K130KMRbmNtybghDRDY+AHwWH8lXV/Fqrda9cLNoT2tRH7BNDio6tbeyoBJE1MGbhOb/XlY/34h/mXxJyOIYSmTJ9BTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaupoKaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253D0C4CEEB;
	Sat, 13 Sep 2025 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757753499;
	bh=2e3UV13BBEWqEXcntHUCbZiuIVL35wadRBGo5j7gG5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaupoKaJNLEWC7ucUrTFuPboQoZMIV2QKo9hMKcOh9Zi0wDDCmYfEFRd7vabnZ224
	 ICi1NCwC9cbmY19ypmAi7r+x8GZYILCV8GaZTo8LKrUYU0Jiys5y6zu4IiQDkxMTxs
	 72eew2uTONqI5cUESHKi7QkF7TznthTheAwuhEsiNjWGFRdK3BTGYIEJW4v9DhJDll
	 Ep8HGqluBodsCxyqh0As8BOn3TIgO2yGSY0lT1AMjYWCWmdjlRbLrue7fhezniC4fE
	 gYY3mxJjrFIhHSnOHkEJyxcYVLkEMa+IOw6sOYFOYrj1/bgqncS3a7CHPceoq5fyAa
	 vxh+4TrvSx0tA==
Date: Sat, 13 Sep 2025 09:51:35 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v1] iavf: fix proper type for error code in
 iavf_resume()
Message-ID: <20250913085135.GH224143@horms.kernel.org>
References: <20250912080208.1048019-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912080208.1048019-1-aleksandr.loktionov@intel.com>

On Fri, Sep 12, 2025 at 08:02:08AM +0000, Aleksandr Loktionov wrote:
> The variable 'err' in iavf_resume() is used to store the return value
> of different functions, which return an int. Currently, 'err' is
> declared as u32, which is semantically incorrect and misleading.
> 
> In the Linux kernel, u32 is typically reserved for fixed-width data
> used in hardware interfaces or protocol structures. Using it for a
> generic error code may confuse reviewers or developers into thinking
> the value is hardware-related or size-constrained.
> 
> Replace u32 with int to reflect the actual usage and improve code
> clarity and semantic correctness.
> 
> No functional change.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


