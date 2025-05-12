Return-Path: <netdev+bounces-189863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D39AB43A9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A52D8C8249
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F7296FD2;
	Mon, 12 May 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDobWHBg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E679296FDE
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074271; cv=none; b=jbDT3Kj3BAPwdzTgceX+4/W04ZMaB3SY/hFK732M7957xRH6wDn41Bul3odnm+p5bkXVBRTgoanoHpZ/kLhBuP6GwKlHtu1QD42KbQiGytZT9/IE3eoUlGfewb87TsdUgWtlryaeSQ3vB3GO2dEmRCjUPeuaPhUFD5hESvvWHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074271; c=relaxed/simple;
	bh=qs3XTBxr7vLIqrLatVlAnlbBFITidr06Ot1fgfQIkPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6AdksUI5KtoUjrrN5FzebmQsaghNQuaEI/hfhF6lj0m4wWP3OCrCUFNjw2YHuPTgTfGfQtFj+Z0OaG4mrMirVQ8l2AJlPxUx0dVAVoXgKXpIJ0v2JYq7XIkqfDkWfIb8s1D0f5b7giEWsFKn3r3c30VUT3go/eDGtm3+oqPyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDobWHBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9655CC4CEE7;
	Mon, 12 May 2025 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747074271;
	bh=qs3XTBxr7vLIqrLatVlAnlbBFITidr06Ot1fgfQIkPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDobWHBgrThomqQa+c8hECZe8CjkoGD3Tcf7cGHC2hMoTcJRHN36vUcFyZIb2aeU9
	 GqWtIWHyLIT9v3wKDgfvZwLnmp3csPGFsUtd3/V+oi6ECkSJ3rff6toNFyY5VoYW4j
	 Uq873rQYihO5vvXxBU4TiAPXzHo9ayqPS6KRc7wcnkgU07dwr7d9ovDgMAJA4/n3rK
	 JbxZw9N58nEUJUTUtPycsJmIo3ewmQYHBOjZsSrm5LFCp/951IyhUvctX0nWbO6kqv
	 /i0HJdbQAo51/ZE/NmvTOAMue1gousp2Dt9ODCOWHOOW3id7w2TK8DNQb5Fqxk0h0K
	 4WzigzFrIF1AA==
Date: Mon, 12 May 2025 19:24:26 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 4/4] octeontx2: Add new tracepoint
 otx2_msg_status
Message-ID: <20250512182426.GV3339421@horms.kernel.org>
References: <1747039315-3372-1-git-send-email-sbhatta@marvell.com>
 <1747039315-3372-6-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747039315-3372-6-git-send-email-sbhatta@marvell.com>

On Mon, May 12, 2025 at 02:11:55PM +0530, Subbaraya Sundeep wrote:
> Apart from netdev interface Octeontx2 PF does the following:
> 1. Sends its own requests to AF and receives responses from AF.
> 2. Receives async messages from AF.
> 3. Forwards VF requests to AF, sends respective responses from AF to VFs.
> 4. Sends async messages to VFs.
> This patch adds new tracepoint otx2_msg_status to display the status
> of PF wrt mailbox handling.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c |  1 +
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h | 15 +++++++++++++++
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c  | 18 ++++++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
> index 775fd4c..5f69380 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
> @@ -11,3 +11,4 @@
>  EXPORT_TRACEPOINT_SYMBOL(otx2_msg_alloc);
>  EXPORT_TRACEPOINT_SYMBOL(otx2_msg_interrupt);
>  EXPORT_TRACEPOINT_SYMBOL(otx2_msg_process);
> +EXPORT_TRACEPOINT_SYMBOL(otx2_msg_status);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> index 721d4a5..e7c2160 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> @@ -118,6 +118,21 @@ TRACE_EVENT(otx2_msg_wait_rsp,
>  		      __get_str(dev))
>  );
>  
> +TRACE_EVENT(otx2_msg_status,
> +	    TP_PROTO(const struct pci_dev *pdev, const char *msg, u16 num_msgs),
> +	    TP_ARGS(pdev, msg, num_msgs),
> +	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
> +			     __string(str, msg)
> +			     __field(u16, num_msgs)
> +	    ),
> +	    TP_fast_assign(__assign_str(dev, pci_name(pdev))
> +			   __assign_str(str, msg)

In order to compile against net-next __assign_str() should
only be passed one argument. Likewise elsewhere in this series.

And, also in order to compile against net-next there needs
to be a ';' after each __assign_str(..).

> +			   __entry->num_msgs = num_msgs;
> +	    ),
> +	    TP_printk("[%s] %s num_msgs:%d\n", __get_str(dev),
> +		      __get_str(str), __entry->num_msgs)
> +);
> +
>  #endif /* __RVU_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH

...

-- 
pw-bot: changes-requested

