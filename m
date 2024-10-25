Return-Path: <netdev+bounces-139110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0C9B0454
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B16B1F21BF5
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F21632DE;
	Fri, 25 Oct 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkSX5Y0O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E9212178;
	Fri, 25 Oct 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863633; cv=none; b=IhIxfhwZk6Sa6CNt92N6NdhZeca2A05J77fVrUg6cYzlUTPiqUPjZv4M1PlC+i9xgoEwQu77FUZo90W6yCVQs11ubMGL4Jl81iFz39oYY2kTKYc/sjig4qjtv1AOGohc+SZjzKMul7z+oYR2WxWDIzCb+BqDU78xaiGTNUai8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863633; c=relaxed/simple;
	bh=pVBN/pYnecKbodkMkBrlE2AMRkbGJn4StYxxRVqPtJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrZ/yhawpJJVKel00QxeEbAewRx+eWBzV2qb1Dt+e7jOSjH9zJv70kvoFFv8aT+xAFERhJdGv+SXtX6Ha2ZYqFuR6UvlFRoDIw0JJrSCzOzGRzkr5CUdC2RgG2NHaQp1dfJracmtf4UdtByybh5h82K2ufF1X5qb73JN3/oaBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkSX5Y0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F69C4CEC3;
	Fri, 25 Oct 2024 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729863632;
	bh=pVBN/pYnecKbodkMkBrlE2AMRkbGJn4StYxxRVqPtJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkSX5Y0O06lKZVBTf+07pj6MacCDHVfYJaJ13wd5+BzO/6MXW+9rw2vIfr7mlrbZM
	 lhfMC9SjIEpl25Lfjdnd17pr4d5IjDpGwExR80cNnRMP0ITR3KG+E8E0hJXRLz7ggr
	 TWjyrZtC6laDDr2bVPF1plmgEx3ER78I5KwOTxx+FsH9i1910qMsW6qqkiCugLjbe0
	 5BQ1GZACH8UE6g4MY19zXhAlPyby+WdE794/je0UWdmG5iUY8dlztfVv1+B8yRk7Z8
	 dDS+kOseJ3cpZspqcynW4Bz9e++wzZ9qQWeCGH2Q5u8AFieiQAj0rdZKFI4kF8dRAp
	 73rJPZgsNaBEA==
Date: Fri, 25 Oct 2024 14:40:28 +0100
From: Simon Horman <horms@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	guodongtai@kylinos.cn, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com
Subject: Re: [PATCH 1/1] add comment for doi_remove in struct
 netlbl_lsm_secattr
Message-ID: <20241025134028.GW1202098@kernel.org>
References: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
 <20241025064031.994215-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025064031.994215-1-dongtai.guo@linux.dev>

On Fri, Oct 25, 2024 at 02:40:31PM +0800, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>

Hi George,

Thanks for your patch. I agree that is is correct and a good change
to make. But there are some process issues to be addressed before this
patch can be accepted.

Firstly, as this is presumably a non-bug fix for networking code,
it should be targeted at the net-next tree. That it should
be based on that tree (it seems to be) and explicitly targeted
at that tree in the Subject.

  Subject: [PATCH net-next v2] ...

Secondly, the subject should include a prefix.
Looking at git log include/net/netlabel.h it
seems that should be 'netlabel:'

  Subject: [PATCH net-next v2] netlabel: ...

And it might be best to make the subject a bit more descriptive.

  Subject: [PATCH net-next v2] netlabel: document doi_remove field of struct netlbl_calipso_ops


Next, a commit message is required. It should explain why the change is
being made. And, ideally how you found this problem. It should
also include a Signed-off-by line [1]. e.g.

  Add documentation of do_remove field to Kernel doc for struct
  netlbl_calipso_ops.

  Found using W=1 build.

  Signed-off-by: ...

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Lastly, please do wait 24h before posting a new version.
Please include information about what has changed below the scissors ('---').
And please send the new patch as a new thread.

More information on development processes for Networking can be found here:
https://docs.kernel.org/process/maintainer-netdev.html

...

-- 
pw-bot: changes-requested

