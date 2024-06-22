Return-Path: <netdev+bounces-105890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948EC913600
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 22:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB42825C0
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DFD5A11D;
	Sat, 22 Jun 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="NsnbNgyp"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416738FA3;
	Sat, 22 Jun 2024 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719087266; cv=none; b=RhYFqfRO+OnC32Fp3wAgw415m1XGr98sdELlXDFGHpyF1Rm/wT5WMEsd33nhKmM/6IvS+YO321JWwyRTyLfm2ZXLN6AcoNtyFQQeL8mn3t7obL8Gg4QdV0AMwjng/5k7vry97B1JpK/avyvOblz1AC6Tgr7kkuHFXoAWJUWt9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719087266; c=relaxed/simple;
	bh=tncH4LCqx7HSAnOYjxTSN/luXNO/LDb1Im3VW+uUmYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NljbxzhFROqyL89ppsY/UQbQOpKq8NF4efJExz3WaAFlXqkqDLWzwrert1wOpTJSCttK/H0edOQZYRyG1NXXakR8jYdlRln1JsDwXDW70NdnQ8wvJVYGsfGImMv45QQovSByUqvQfIrohCMlrH2/IZ6hHW9fpkmCemMxFuPKs7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=NsnbNgyp; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=iFliWZ3VVlpnHPHNOUml3WsBWXE3aFdRx+TsZn6swl0=; b=NsnbNgypwoHqCo0r
	kAcc/Jw/Gp7qblF/o0AaAiGf9olyN2shF1a0C1u0ZJOwWp3KbRtamawqsv7lvuBfLLCinFOzPTrnm
	qo0NTXcbuxuzh8Ae4fINaS6G/ijbG4MZbOxOsOZo4PKU61bGzegPLCKnsmwvLm3pVpNbehBy8dg0i
	cjS+KINBiF8uX597k5StLJoq9qOdbK+cyZ8wTWxNz0ydzBZSuroO9+9bpd03Hq4L/8HY8SYBZ1s5e
	Uvt3rAe5yBWhSxiRawsCDgAQEYA1m1/kNyC9VyuAiLUaHpTyzA9xDHaBZmKXsMPPXwKto1aqrQBbE
	FB10n7AKL8Sv9mShMg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sL77n-007nbi-2B;
	Sat, 22 Jun 2024 20:14:15 +0000
Date: Sat, 22 Jun 2024 20:14:15 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Alexander Zubkov <green@qrator.net>, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Fix misspelling of "accept*"
Message-ID: <Zncwl4DAwTQL0YDl@gallifrey>
References: <20240622164013.24488-2-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240622164013.24488-2-green@qrator.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:12:10 up 45 days,  7:26,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Alexander Zubkov (green@qrator.net) wrote:
> Several files have "accept*" misspelled as "accpet*" in the comments.
> Fix all such occurrences.
> 
> Signed-off-by: Alexander Zubkov <green@qrator.net>

Reviewed-by: Dr. David Alan Gilbert <linux@treblig.org>

hmm, should probably cc in some maintainers, I guess networking.
(added netdev and Paolo)

Dave

> ---
>  drivers/infiniband/hw/irdma/cm.c                              | 2 +-
>  drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c | 4 ++--
>  drivers/net/ethernet/natsemi/ns83820.c                        | 2 +-
>  include/uapi/linux/udp.h                                      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
> index 36bb7e5ce..ce8d821bd 100644
> --- a/drivers/infiniband/hw/irdma/cm.c
> +++ b/drivers/infiniband/hw/irdma/cm.c
> @@ -3631,7 +3631,7 @@ void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp)
>  /**
>   * irdma_accept - registered call for connection to be accepted
>   * @cm_id: cm information for passive connection
> - * @conn_param: accpet parameters
> + * @conn_param: accept parameters
>   */
>  int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
>  {
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> index 455a54708..96fd31d75 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> @@ -342,8 +342,8 @@ static struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
>  {
>  	struct sk_buff *skb;
>  
> -	/* Allocate space for cpl_pass_accpet_req which will be synthesized by
> -	 * driver. Once driver synthesizes cpl_pass_accpet_req the skb will go
> +	/* Allocate space for cpl_pass_accept_req which will be synthesized by
> +	 * driver. Once driver synthesizes cpl_pass_accept_req the skb will go
>  	 * through the regular cpl_pass_accept_req processing in TOM.
>  	 */
>  	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req)
> diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
> index 998586872..bea969dfa 100644
> --- a/drivers/net/ethernet/natsemi/ns83820.c
> +++ b/drivers/net/ethernet/natsemi/ns83820.c
> @@ -2090,7 +2090,7 @@ static int ns83820_init_one(struct pci_dev *pci_dev,
>  	 */
>  	/* Ramit : 1024 DMA is not a good idea, it ends up banging
>  	 * some DELL and COMPAQ SMP systems
> -	 * Turn on ALP, only we are accpeting Jumbo Packets */
> +	 * Turn on ALP, only we are accepting Jumbo Packets */
>  	writel(RXCFG_AEP | RXCFG_ARP | RXCFG_AIRL | RXCFG_RX_FD
>  		| RXCFG_STRIPCRC
>  		//| RXCFG_ALP
> diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> index 1a0fe8b15..d85d671de 100644
> --- a/include/uapi/linux/udp.h
> +++ b/include/uapi/linux/udp.h
> @@ -31,7 +31,7 @@ struct udphdr {
>  #define UDP_CORK	1	/* Never send partially complete segments */
>  #define UDP_ENCAP	100	/* Set the socket to accept encapsulated packets */
>  #define UDP_NO_CHECK6_TX 101	/* Disable sending checksum for UDP6X */
> -#define UDP_NO_CHECK6_RX 102	/* Disable accpeting checksum for UDP6 */
> +#define UDP_NO_CHECK6_RX 102	/* Disable accepting checksum for UDP6 */
>  #define UDP_SEGMENT	103	/* Set GSO segmentation size */
>  #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
>  
> -- 
> 2.45.2
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

