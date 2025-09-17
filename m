Return-Path: <netdev+bounces-224134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35CB81180
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BE92A7790
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570E2FB61D;
	Wed, 17 Sep 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rMGRGJTR"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E52FB085
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128227; cv=none; b=oaoFE4fA1Wkn7Nx25eShikLDPVlar/tXT4Y4hgqUdMX2uAP91mkEKchHiQXlC1mM5tfH5cVFrdYqfa8sf3QiXjN/vnRu08In1zI+FX2SBGk6H4owYBaLQpi/GyU9LE4WB5SDUWQ4a3yU4rHhaIN3H4gsQtrJaUlXBw1l3ZKkpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128227; c=relaxed/simple;
	bh=RoYs+lOPKP6EI+cACs3xu9y1s81zhU0ASthwBE3+IQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CyCtkXfZS1QGfg2t0wY2uZAixgTpbTR3WQMaj1R5qp6+38zlbBC7kXhqqZm5GsQlefnL/Lbbcb+fU6tqkqY89huiPUqW4Vt0+zRqtWFluvUmv4gNqSOov7EdMA050ysJIppbYJ2Uusb64U/+U4PozngXSovMC1keX8bleE6fbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rMGRGJTR; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0be046b6-a48e-45be-9b0e-3922f298b089@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758128213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JoFXqqjHsUv55cfZ28zVmVLyTt7+FuolwMXE9BtBiU=;
	b=rMGRGJTREOYpdTnMVNhvvmi5BAKKTLUj7wP1zqJOVOHkUO0Ttj8HFZ3l5nXc/iaw0o1MQL
	2QM9jmog1MShmwUw6gyM0sKRbNzoYZwf7/8/VfUKicRYjLICunvr2ZhR3T3VADDscVI9EF
	wYhQDUM30pposu7scRj3bV4GGxVOhnA=
Date: Wed, 17 Sep 2025 17:56:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: nfc: nc: Add parameter validation for packet data
To: Deepak Sharma <deepak.sharma.472935@gmail.com>, krzk@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
References: <20250917140547.66886-1-deepak.sharma.472935@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250917140547.66886-1-deepak.sharma.472935@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/09/2025 15:05, Deepak Sharma wrote:
> This is v2 for the original patch, I realized soon after
> sending the patch that I missed the release of skb before
> returning, apologies.

this part shouldn't be in the commit message, it has to go under
strip mark ("---")

> 
> Syzbot reported an uninit-value bug at nci_init_req for commit
> 5aca7966d2a7
> 
> This bug arises due to very limited and poor input validation
> that was done at net/nfc/nci/core.c:1543. This validation only
> validates the skb->len (directly reflects size provided at the
> userspace interface) with the length provided in the buffer
> itself (interpreted as NCI_HEADER). This leads to the processing
> of memory content at the address assuming the correct layout
> per what opcode requires there. This leads to the accesses to
> buffer of `skb_buff->data` which is not assigned anything yet
> 
> Following the same silent drop of packets of invalid sizes, at
> net/nfc/nci/core.c:1543, I have added validation in the
> `nci_nft_packet` which processes NFT packets and silently return
> in case of failure of any validation check
> 
> Possible TODO: because we silently drop the packets, the
> call to `nci_request` will be waiting for completion of request
> and will face timeouts. These timeouts can get excessively logged
> in the dmesg. A proper handling of them may require to export
> `nci_request_cancel` (or propagate error handling from the
> nft packets handlers)
> 
> Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
> Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
> ---
>   net/nfc/nci/ntf.c | 42 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index a818eff27e6b..f5e03f3ff203 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -809,35 +809,61 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
>   
>   	switch (ntf_opcode) {
>   	case NCI_OP_CORE_RESET_NTF:
> -		nci_core_reset_ntf_packet(ndev, skb);
> +		if (skb->len < sizeof(struct nci_core_reset_ntf))
> +			goto end;
> +		else
> +			nci_core_reset_ntf_packet(ndev, skb);
>   		break;

every case here has it's special function. I believe the length check
should be put into these functions and then the return value should
indicate error. That's the actual style of kernel code.

You should also indicate the tree to apply your patch, as this is the
fix, the tree will be net, so the subject should be:
[PATCH net v2] net: nfc: nc: Add parameter validation for packet data

And the Fixes tag should be added to provide some information for
possible backports.

