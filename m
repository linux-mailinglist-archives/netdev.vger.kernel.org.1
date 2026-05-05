Return-Path: <netdev+bounces-284224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEBlEK2A+Wn/9AIAu9opvQ
	(envelope-from <netdev+bounces-284224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:31:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D17834C6E6E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B208300492E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 05:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D351C8604;
	Tue,  5 May 2026 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNrS4olF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DD78F26
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959082; cv=none; b=UVm0CZiDatjuk0ezjOHhuWMsiDQFzdqJ59D7SWsrxxlYJQaWA8UgWmeHlnDrXndpnjV52AUQoLJyw632u2OomcG+rz2tpMLy55tV1ZPZWVDYbx3J7u9qoemWskbnB5l6rvAWvVEyuqAskBJQqUrHJS9Iakzl6suAefjFQoEgHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959082; c=relaxed/simple;
	bh=wka7qFdK59QVtAA0IHLqqYz4ouAxY9bZ6SSysificV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maWEHICJ2yo1tNRHNfSxkBYAVH29XKr9sztRGWRb5TObKSz8Pd7ZVxyVdB82N8k6HkzrxbVx0xNpmwQenJhDWSgkfpo3eUlKSwET9RXfacqf74/uWutBCM7dWTd0IRNe1RC/ZO1HS5PMc6o8Wjrz0tQugHDsqojMI7oDyxI5g3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNrS4olF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A8DC2BCB4;
	Tue,  5 May 2026 05:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777959082;
	bh=wka7qFdK59QVtAA0IHLqqYz4ouAxY9bZ6SSysificV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jNrS4olFsrGBVxl6/yu+H7xf2hOBbcgN7fFqjcGJPhg0SBv1Bj6m3DW76PwD43l2c
	 9AkzF5WwNvHH6oxY2SUpODmX/Hjhrtc4JfHvqb8iEt4UeBhOwVvvQPMNOTfDjF55GK
	 sjq4DFC4ylz1WDZEJ3JppEvFW4uwIgCGHLoxGLH64DEWqX69Q/x80HPNxeRL8p3odI
	 zAcryZQubUkAu3ONtjikYf/UTxCx6iu81HdIrLUz9gK8eTz7f8j4zFjCyxEuVc5OKb
	 pvA0U+Qh3EDZAQgRsQmr3bMyJVcJtNnaRccSxsz1cS9X/XCapgmJvH7iGQ1t0VqsxU
	 AjvSNtUdOF7/g==
Message-ID: <e3abfd12-6537-42b1-b35e-c79a06f87172@kernel.org>
Date: Tue, 5 May 2026 07:31:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: fix indentation error
To: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, qiang.zhao@nxp.com,
 horms@kernel.org
References: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D17834C6E6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284224-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi,

Le 04/05/2026 à 18:07, Holger Brunck a écrit :
> Remove the whitespace to fix the indentation.

Do we really need a patch for that ? What's the added value of doing 
this change compared to the cost of doing it ?

> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 09081f128a98..adf3863463f5 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -764,7 +764,7 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
>   		qe_muram_free(priv->ucc_pram_offset);
>   		priv->ucc_pram = NULL;
>   		priv->ucc_pram_offset = 0;
> -	 }
> +	}
>   
>   	kfree(priv->rx_skbuff);
>   	priv->rx_skbuff = NULL;


