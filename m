Return-Path: <netdev+bounces-62345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC30A826B87
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 11:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03552B218F3
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AD13ACF;
	Mon,  8 Jan 2024 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYwTZdUL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482E13FE0
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 10:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48EFC433C7;
	Mon,  8 Jan 2024 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704709420;
	bh=CEIAKrzZawUF4QTrbXAB9pWT9IR7/szxVzMiCGSCYK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYwTZdUL7jTPbhbxs/eVxl5qSHHNUi6jc18pPfj0PJXLs1uICgTXqqRavKeIldbOz
	 Sq2WqnJHURBlyNMrGQGUWGloGqRd5y6mYduJoUnBkh+EdQnDby+StdgvmzwGNNKSzy
	 4NGoHR5hih2DG6utuSj37Ffqf0IwAQPyqy1fqoogQpXSZSpCZnadH9lrnlY/cYyn+i
	 JGzsZ9qHy//jpZLA+GI2BS1HwdnnrhH1lcNBUAeZgqmp2BPfJc/SQoC17rUw6X05ie
	 SRMgLbU4mLUlkzagkMzQa6oK2nrOqYFVx6F2guRaNYy7NcaTJmFzUtsknx0xUQcL9z
	 DDNSEpXhsUuGA==
Date: Mon, 8 Jan 2024 10:23:35 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 1/3] bnxt_en: Remove unneeded variable in
 bnxt_hwrm_clear_vnic_filter()
Message-ID: <20240108102335.GE132648@kernel.org>
References: <20240105235439.28282-1-michael.chan@broadcom.com>
 <20240105235439.28282-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105235439.28282-2-michael.chan@broadcom.com>

On Fri, Jan 05, 2024 at 03:54:37PM -0800, Michael Chan wrote:
> After recent refactoring, this function doesn't return error any
> more.  Remove the unneeded rc variable and change the function to
> void.  The caller is not checking for the return value.
> 
> Fixes: 96c9bedc755e ("bnxt_en: Refactor L2 filter alloc/free firmware commands.")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401041942.qrB1amZM-lkp@intel.com/
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Hi Michael,

I'm not sure this is a bug fix, so I might have cited
the commit using something like "Introduced by commit ..."
rather than a Fixes tag.

But the fix isn't going to propagate very far anyway,
as the cited commit is currently only in net-next.
So perhaps it is fine as is.

In any case, I agree that this is a nice update to the code.

Reviewed-by: Simon Horman <horms@kernel.org>



