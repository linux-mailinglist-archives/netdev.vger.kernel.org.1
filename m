Return-Path: <netdev+bounces-65130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6D839514
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD21F2DFFE
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC87FBBF;
	Tue, 23 Jan 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esa6oijT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803B7F7E5
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027901; cv=none; b=pp3t1xfMHuJRbDRdS/6Wv7em3t+8pLwkhcFB2uVSKVqLsOUTewnhlH0Qy2BzVkaacaIPjr7WJPSTBH1UNVaFxbYgk4S1JR4XvLcbpqCGqP6ehGGvCFXycgWyzm+tW+KReU+2jYiETuOKJ0Z/98aG4iZRn3eo4rkokhoeNQacwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027901; c=relaxed/simple;
	bh=neiDqjqlrAq+P9Dr03DcL5TOcjt9yIK/jkFGhWRFMI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2KXCSkY5E1qFvIfBpqjeVYuWd/SkSBuMFq/zX05u5lwlRl1Evc2EBG1918sE+TRmo4JrBwTw9Aa/Wgw+AJn/KFcb6FBeJGXutlm8TQcxJLiLgdygDOoLi9hPgKLk3NJO9qyy8Zn7R7mPOfwyz/bMMmnEftnOLBL+TUX4kfEOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esa6oijT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C09C433C7;
	Tue, 23 Jan 2024 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027900;
	bh=neiDqjqlrAq+P9Dr03DcL5TOcjt9yIK/jkFGhWRFMI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esa6oijTUzGsIB68xmQGVR3YIm2FmzzQ2URUJt3Y/kqVyeMQkpJiibfFcpoLjaIyA
	 6/Q1zWaLXLtsABbNN93v3d6vZS48Jq60K7rUfZsbCBFehQj2Du7XmAZzU5gHmr7aBZ
	 gVofmds9R4BKYUupCr+nhqWpkvPYZoeiqWl7fV1MdEMTJjSDx5e7c4OIvoyvBgQ+DF
	 4Bkm9pxOFLT1nP+TSuJvdoWK/W9UleXq1QDoj2B/hgUKOU2x8m+/hi2/BW1XiupsqR
	 8QjOHpz/42/G7BL5M04HDfS3CJYrxWQ2F5jg9kT7ROMZKkWQNgL74vUCW71zLGG+lD
	 C+sb9/DCJyQsA==
Date: Tue, 23 Jan 2024 16:38:16 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v6 iwl-next 1/7] ice: introduce PTP state machine
Message-ID: <20240123163816.GE254773@kernel.org>
References: <20240118174552.2565889-1-karol.kolacinski@intel.com>
 <20240118174552.2565889-2-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118174552.2565889-2-karol.kolacinski@intel.com>

On Thu, Jan 18, 2024 at 06:45:46PM +0100, Karol Kolacinski wrote:
> Add PTP state machine so that the driver can correctly identify PTP
> state around resets.
> When the driver got information about ungraceful reset, PTP was not
> prepared for reset and it returned error. When this situation occurs,
> prepare PTP before rebuilding its structures.
> 
> Co-authored-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> V5 -> V6: refactored prepare_for_reset() bit in ice_ptp_reset()

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


