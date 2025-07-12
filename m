Return-Path: <netdev+bounces-206333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14143B02AC8
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A5D7A417A
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC112749DF;
	Sat, 12 Jul 2025 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB8FSeBB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164881E;
	Sat, 12 Jul 2025 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752322766; cv=none; b=B2gbGrCQ1JXzILkUJpVT97Bm4crxxLzrqa8dRGFmAw+LqmKJUi03x+153pFbdYR3DIOiHmQ9Z+qMeCfn6FfHWw3PSB9FXqrhNwixyhijSBFwqlyesEoMXSWCvZ48J9u+kGytY5apg9KEBsTW3ngnUzCf5ayyt3Emo80abLT5N3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752322766; c=relaxed/simple;
	bh=P68eJR5emGW63LAuCAguVS/oe9tA0CEWUwyQxyOTP6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opJwWUzXl1vimak2Jgk0SY3QubDAcqrwjg+SBXXWvTp+AF1kkrkPJg8C56mGpAr6duxKHiZm7z9pgjVr1MoJ0gGE7vKkwpfXbyNYDTjCVIbROJKhaYBZ1J+QLqMubASGAZi235az1IAkCpPAfpwRP+uLYVEDw85IEs5DJp/2E1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB8FSeBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35E4C4CEEF;
	Sat, 12 Jul 2025 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752322765;
	bh=P68eJR5emGW63LAuCAguVS/oe9tA0CEWUwyQxyOTP6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VB8FSeBBGUr+Wkb+UWp9+72J8WU1wNdzpLbYXHtiby8TyugUtwajAB9/Inf34GwZ4
	 kQGzjsr21BviUYlZmGZ/cISeH4PdjnEyWFfZYMw9kdYMUNGtTmCksDh1Cs1MuIk7aC
	 7Kr+SrHgrgtvaPViS9wOfVaHxyZ6DA5IZ/de6BsvJu1q4aZsrXf8srfLPSPbEdL+PZ
	 vSUamH2vI/smlGopbggLCM0QkzSjRZwXDV3gyv/j+s3U5YeebPzXhIEKPyJAgwS0ig
	 U+sD795b6wi6NXy4Fssx/1mcz/tJdqn2QO/wazfTb2ebsADLBpX68JMqL7ZLDctgtq
	 zFOLkWhqPqsjg==
Date: Sat, 12 Jul 2025 13:19:20 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next 00/11] net: hns3: use seq_file for debugfs
Message-ID: <20250712121920.GX721198@horms.kernel.org>
References: <20250711061725.225585-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711061725.225585-1-shaojijie@huawei.com>

On Fri, Jul 11, 2025 at 02:17:14PM +0800, Jijie Shao wrote:
> Arnd reported that there are two build warning for on-stasck
> buffer oversize. As Arnd's suggestion, using seq file way
> to avoid the stack buffer or kmalloc buffer allocating.
> 
> ---
> ChangeLog:
> v1 -> v2:
>   - Remove unused functions in advance to eliminate compilation warnings, suggested by Jakub Kicinski
>   - Remove unnecessary cast, suggested by Andrew Lunn
>   v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
> ---
> 
> Jian Shen (5):
>   net: hns3: clean up the build warning in debugfs by use seq file
>   net: hns3: use seq_file for files in queue/ in debugfs
>   net: hns3: use seq_file for files in tm/ in debugfs
>   net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in
>     debugfs

Thanks for the update, but unfortunately I don't think this is enough.

W=1 builds with bouth Clang 20.1.7 and GCC 15.1.0 warn that
hns3_dbg_fops is unused with the patch (10/11) above applied.

>   net: hns3: remove the unused code after using seq_file

I suspect this patch (11/11) needs to be squashed into the previous one (10/11).

...

-- 
pw-bot: changes-requested

