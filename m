Return-Path: <netdev+bounces-60209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A881E1D7
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5EA1C21057
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50052F8D;
	Mon, 25 Dec 2023 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDSWH1Y4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531A52F8B
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EE6C433C8;
	Mon, 25 Dec 2023 17:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703526189;
	bh=n1k6HuzWyWS9AMrWfQ0Omum45AU7m+qnlFz7QpVCIUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDSWH1Y4kuLnzwtkW5lUmZD6JiC96cH/yHIXUsNKuun/ewozmfxy1FN2rR5M4Ed0L
	 5sbH6bixfIya+uJ3+bsw3fiIbxRSi6Zw2MXA4AiIoFxgsUnT6FcVrbxtwEIntSAaJU
	 30n8y5NKCGOKHyTHqKE+2ujnqJxJQM8N4fPqfJGsfh7FUuuGa+LU5an7ONbwaKWd6Y
	 fNXOYzSz2fHISDaSKeqm6SOkiw7xduHaxBDbjI05i+4SkYotPYrGg5vhH43wXTDDrp
	 l7pILOFmQ3VdFSaoh6/+s/si7B6lLnlaASFy3PyPHn7N4roZVMq3Hbi7UFYeFbG/j3
	 XDjDPIuSZ5FDw==
Date: Mon, 25 Dec 2023 17:43:04 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 01/13] bnxt_en: Refactor bnxt_ntuple_filter
 structure.
Message-ID: <20231225174304.GM5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-2-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:21:58PM -0800, Michael Chan wrote:
> This is in preparation to support user defined L2 (ether) filters,
> which will have many similarities with ntuple filters.  Refactor
> bnxt_ntuple_filter structure to have a bnxt_filter_base structure
> that can be re-used by the L2 filters.
> 
> Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


