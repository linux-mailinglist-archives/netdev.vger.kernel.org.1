Return-Path: <netdev+bounces-47923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FC7EBF5C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C14280EA6
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD065660;
	Wed, 15 Nov 2023 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmJpyZYG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9A53B2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FABC433C7;
	Wed, 15 Nov 2023 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700040088;
	bh=YSG65mEwUsCzKp+XWir268MP8D6kMHKJTS4saUD+Jn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmJpyZYGAGemaFpCxUSUHh1i4xfKqtEFvhp6NkPsroYrkJhbeOqtuLnGsdnlw6I3l
	 EruFYLCLblejqHVsPWY1KuJsm1pQCLVEMlU/HacH+vOYm1GSUpPM61LR8aT8AoVzI2
	 6iWySZCwbEwSpz6v7MDz4TG2lUM5TN4lMpDybsk+ySXrGOGax+MAts+Lhf41FCjdwM
	 7GYAVRhevwZMpTFu1aIsUAxpWgtUcIYekl5WDk7S7pHIZ1jZeoVCIYnHFFbZb1BsJZ
	 gIgeznV9fI/C0alZfSd0QVNNlT4j30PWYuuwqzPj1OKUkexjmf/KPJHR7a6nF6f6ZW
	 BAaAQyBY7IlaA==
Date: Wed, 15 Nov 2023 09:21:23 +0000
From: Simon Horman <horms@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
	intel-wired-lan@lists.osuosl.org, jeffrey.t.kirsher@intel.com,
	jesse.brandeburg@intel.com, kuba@kernel.org, kunwu.chan@hotmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, shannon.nelson@amd.com
Subject: Re: [PATCH iwl-next] i40e: Use correct buffer size
Message-ID: <20231115092123.GI74656@kernel.org>
References: <20231113093112.GL705326@kernel.org>
 <20231115031444.33381-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115031444.33381-1-chentao@kylinos.cn>

On Wed, Nov 15, 2023 at 11:14:44AM +0800, Kunwu Chan wrote:
> The size of "i40e_dbg_command_buf" is 256, the size of "name"
> depends on "IFNAMSIZ", plus a null character and format size,
> the total size is more than 256, fix it.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the update.

There is no need to repost because of this, but in future please keep in
mind that revised patches should:

1. have a revision number, e.g. v2

   Subject [PATCH v2 iwl-next] ...

2. Have some of revision information below the scissors (---)

   v2
   - Updated size calculation to use IFNAMSIZ and izeof(i40e_dbg_command_buf)

3. Be a new thread, as opposed to a reply to an existing thread.

Link: https://docs.kernel.org/process/maintainer-netdev.html#changes-requested

The above notwithstanding, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


