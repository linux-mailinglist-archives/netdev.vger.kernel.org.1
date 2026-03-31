Return-Path: <netdev+bounces-273680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH0qHqvsy2mlMgYAu9opvQ
	(envelope-from <netdev+bounces-273680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:47:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA336C09A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD70431A0582
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E141C2FD;
	Tue, 31 Mar 2026 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="iowfm5iF"
X-Original-To: netdev@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFB411639
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971386; cv=none; b=XrLTyMbKkx1P+NjdS6N7U8H1+mwh54Ei/Hr0f4RtyW5/jMHUm+dbusCqWH8NP7q19w7MIZhBu+jK12SFvXALgk4BXwmCWHiO1vthcV647h1rRZR0jCPqbQOeWcSNbR8vtd33IwMNtKYAlNzmE5WqMl5aDkLrdfyG/Pb3XTB0xys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971386; c=relaxed/simple;
	bh=g1etV1cSaF1CLKLwroH2Otgkb2vKs+5Py45hjgAK/o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfBIQa6tDXV72a9JXov7YjOMZ2FEACRtftv2EA6uu7QhUseIZeEV64WEvJkOyCSsOBHQDTHeWFD2kHkUXU9UPljscps8O10VMcfTe1G6mavanbgBVWYuFc0PXC6e9wha8jvZlfCinDpffvMHlRBNX3sdF7zTWa2lo0ogFJC/Izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=iowfm5iF; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id 7YImwymMFjw8Y7b8jw6WDh; Tue, 31 Mar 2026 15:36:25 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7b8hwCfm3YA8x7b8hwIPbq; Tue, 31 Mar 2026 15:36:23 +0000
X-Authority-Analysis: v=2.4 cv=VJfdn8PX c=1 sm=1 tr=0 ts=69cbe9f9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=pGLkceISAAAA:8 a=cTJmZftdM5iI3n9nPlYA:9 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gPSiibnnkaj7DpyikZYTE/USxJvNbpGxOj64z/kQRZk=; b=iowfm5iFnDEeJ1Hpg3V8sI41Jc
	ZHrY11TWLlbsmX1yWaZ1D3OG42uvidLzJ825vTHKDil6WOmGmdVoVK9gswamXg/I6uW+a5fjtjnv/
	WhirNst8ZDoSenFXVfn6EQ0ONZEnG1pr+A79EPa0wt8QkXKS5gIGYF5juC4pbyQ0NPp9XR9u80u9K
	5sf90N/08DwvypFEphRvRIw4++M2KkOxHooWHLCJyF0d9IX4cTo46Qrcq+liUU+lW7+fUdzju0ZJL
	LwPSQIGS2ZjFTvN1cc7GSEC3PpiU+BstMBiBWDZi1p2zADlXUrgaBMT1vtk5Y8vyTSpO0dqzQLfWM
	o6m/Sz7A==;
Received: from [177.238.16.13] (port=60182 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w7b8g-00000002Jss-1lMG;
	Tue, 31 Mar 2026 10:36:23 -0500
Message-ID: <ddb5961b-02f9-4956-b618-31aab836fce7@embeddedor.com>
Date: Tue, 31 Mar 2026 09:35:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] atm: nicstar: simplify allocation
To: Rosen Penev <rosenp@gmail.com>, linux-atm-general@lists.sourceforge.net
Cc: Chas Williams <3chas3@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:ATM" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260327192407.365369-1-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260327192407.365369-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w7b8g-00000002Jss-1lMG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:60182
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 43
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCxGFXRcdAiGyb6XxFpZGyj9UB1E2PakUoqyav8wZ4E9bIGe2iJxZOevJdg4Y0A5mstEOV74YneK7zQQfVW4h4mAMgG8V/8KjAx0dE5bVWOkjaqucsP+
 eeSy7yEMT6VjZLp7nb9eiJdAhxlZAXe1Jr8jCIG1BM8FIuV5GN9HRCJROL8sok7ho812GqCDJXs4KMV7QAn00cN3GQxIAZDYiQo=
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[embeddedor.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273680-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[embeddedor.com];
	MIME_TRACE(0.00)[0:+];
	HAS_X_SOURCE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.sourceforge.net];
	DKIM_TRACE(0.00)[embeddedor.com:-];
	NEURAL_SPAM(0.00)[0.556];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gustavo@embeddedor.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[embeddedor.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3BA336C09A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/26 13:24, Rosen Penev wrote:
> Use a flexible array member with kzalloc_flex to combine allocations
> into one.
> 
> Add __counted_by for extra runtime analysis. 

Move counting variable
> assignment to right after allocation as required by __counted_by.

This is misinformation and should be phrased differently[1]

-Gustavo

[1] https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com/

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v3: reduce to 80 columns
>   v2: use kzalloc_flex
>   drivers/atm/nicstar.c | 18 ++++++------------
>   drivers/atm/nicstar.h |  5 +++--
>   2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
> index 24e51343df15..c0bed85daf96 100644
> --- a/drivers/atm/nicstar.c
> +++ b/drivers/atm/nicstar.c
> @@ -867,23 +867,18 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
>   	if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
>   		return NULL;
> 
> -	scq = kmalloc_obj(*scq);
> +	scq = kzalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
>   	if (!scq)
>   		return NULL;
> -        scq->org = dma_alloc_coherent(&card->pcidev->dev,
> -				      2 * size,  &scq->dma, GFP_KERNEL);
> +
> +	scq->num_entries = size / NS_SCQE_SIZE;
> +
> +	scq->org = dma_alloc_coherent(&card->pcidev->dev, 2 * size, &scq->dma,
> +				      GFP_KERNEL);
>   	if (!scq->org) {
>   		kfree(scq);
>   		return NULL;
>   	}
> -	scq->skb = kzalloc_objs(*scq->skb, size / NS_SCQE_SIZE);
> -	if (!scq->skb) {
> -		dma_free_coherent(&card->pcidev->dev,
> -				  2 * size, scq->org, scq->dma);
> -		kfree(scq);
> -		return NULL;
> -	}
> -	scq->num_entries = size / NS_SCQE_SIZE;
>   	scq->base = PTR_ALIGN(scq->org, size);
>   	scq->next = scq->base;
>   	scq->last = scq->base + (scq->num_entries - 1);
> @@ -928,7 +923,6 @@ static void free_scq(ns_dev *card, scq_info *scq, struct atm_vcc *vcc)
>   				}
>   			}
>   	}
> -	kfree(scq->skb);
>   	dma_free_coherent(&card->pcidev->dev,
>   			  2 * (scq->num_entries == VBR_SCQ_NUM_ENTRIES ?
>   			       VBR_SCQSIZE : CBR_SCQSIZE),
> diff --git a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
> index 1b7f1dfc1735..76635d46016e 100644
> --- a/drivers/atm/nicstar.h
> +++ b/drivers/atm/nicstar.h
> @@ -667,14 +667,15 @@ typedef struct scq_info {
>   	ns_scqe *next;
>   	volatile ns_scqe *tail;	/* Not related to the nicstar register */
>   	unsigned num_entries;
> -	struct sk_buff **skb;	/* Pointer to an array of pointers
> -				   to the sk_buffs used for tx */
>   	u32 scd;		/* SRAM address of the corresponding
>   				   SCD */
>   	int tbd_count;		/* Only meaningful on variable rate */
>   	wait_queue_head_t scqfull_waitq;
>   	volatile char full;	/* SCQ full indicator */
>   	spinlock_t lock;	/* SCQ spinlock */
> +	struct sk_buff *skb[] __counted_by(num_entries);
> +	/* Pointer to an array of pointers
> +	   to the sk_buffs used for tx */
>   } scq_info;
> 
>   typedef struct rsq_info {
> --
> 2.53.0
> 
> 


