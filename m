Return-Path: <netdev+bounces-289503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODt7IISKDGo1iwUAu9opvQ
	(envelope-from <netdev+bounces-289503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:06:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE457581F14
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 175C431793BF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A7E23C4F3;
	Tue, 19 May 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LhwxbXK1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB581A3172
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204761; cv=none; b=GArAVH4pHBYJ/JnrufcajYo7ALsr6iCtp5ZJ28qROB4ywUdqTwoXXRnQghEF6cRxVlwGk629Vxqfz7CxRg6EMm+PbH6Pnqk1Xkw4GlJ5fysksKy96UnxrBI6zMIFIXJPLcwhNMDyzwjBArqr74Oxpi8KiRbqQWIJ/LVBh1EDIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204761; c=relaxed/simple;
	bh=Ax590YbqXYIAmnaGMKl7FSUvi1v38AH/AztU4zuuBM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTXO/a/c84Ext/+i7OJ6hd6UFLKC0mouPltE5p9C/GSRtOz8hhT/jQs96N4ZMShHzgcLKEG+gfDKUfxwuiA1+pMRZDvG3kAgP0UrqwxN9E4up9OqV1nIcanYvH/hDiRpq3JfkHPWA41fm+234meaqrA+spQdGUoLqS1oga60CBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LhwxbXK1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479ef2b78f3so3564857b6e.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779204759; x=1779809559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMgg3DcMPG/CkFUdDvWT7P0SoXNm1HcPg5ezYHCRXcs=;
        b=LhwxbXK19yCgd8YZ23YM3Z/oBn4nXz/TJLcA+m5W65YjBwhi3iPoEmacQvginZh4+M
         4bKYxPpxEeiipCJOiUmlGDwFAmt1526G2zAABZ19nR9DnrVowNdEQ59LZEEmrq7fkSSK
         g7SSotT14tPQnTP3PCebckEsgtmfGuAFkqGqysgkSp7oUi5KUnkWc+Q/AOynwTRP7o8x
         NeLomN4euX3EB8EvIt/HTh4jSOjRLKMvoCN+knzS3C/UYDJnfVHDEWFL8KQJdWLCERSQ
         mCHpxCh7gHwcZ2jYUuL1gTBx9kS+UUJh7z1qjr/3A/4DPUUPKZiSMIPoQpIyBwaoNFib
         H/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204759; x=1779809559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMgg3DcMPG/CkFUdDvWT7P0SoXNm1HcPg5ezYHCRXcs=;
        b=WDvOr3LtUqaPSGtOTOd8tKSSikZZ8OF1AVPJwrZXvP/RuuKnoUZVEQ6wnxSOcjwlQH
         wGag235LMUCmEtcnhyJ4/ZHi34tDwCFKkhjYmCBW7pf6pfr1kctyo9Yi5bJMgOR+M/vl
         mdF7vNPdSKC45Bpt6JlylNQUjv9c7Z+iUMfQ7YE6IPEEPnqyiPjtCB3nfZVDhz78QTTP
         o7q5WW0Ds49pupbkdaclJhA5QpdULYT7dIlV4KZSU4O3J/v1a11R8u1XWGyHqoAFHB2q
         m20MDllpCXo0ucnrzFcXfsPk5aki6ZYwx+q2BQ6PLK/x99lyidRcC5T6o2us5Utqfy0s
         R1pw==
X-Forwarded-Encrypted: i=1; AFNElJ/3KUTRsM5KZASwaBb90RCdVjQzyvXzGwDkD6wYhmedjtoBX55QJHf5yt0u/hl4uChU22/zNgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx162+Xd6/R+m93BleInLdnIWNG1On57Lw4mMPqxe8QuJGSZxbk
	7x+f4YjmcRHQ6hhuVUqmEI2xu9BKDwdZoMOA13zwLfe0y3HiD9JGNxnJ8tIV2IXsWsw=
X-Gm-Gg: Acq92OEVB5QxWdSCirEhPZVwo9UPHzFrKTs7E8LPk2YLArbdKycc9Z3b+t8fJCskz9S
	4BUbu3Pqdgm5TUK6+xBkgpF9/I3FJQ0lgb4fS3DJ70tL5//xrOEd/q3NfTyhZ+3th6Fy6BHRGXV
	zvrA4kaUVWjM4lXqloR2KCAHIKzCkMRKN/n8UhfIMdTlj8X9iL6vvUtaDQP6bZCN/U1Sbk7g2zT
	q93TTPWz6QgkmbkxNfF7aVGDVg7DLBeLvZHgHbMgznvGn/1lgQ0pTu65Ft2DX7jhqwr1zUZzb6i
	BJW3ud7hLjV1rGFGRnZwAKP1sCZDHRoUp/oTd7UNbTmzPu0NATGxwIw1pCa3KsQ9kEvm0Q24DH3
	iATxKVtGjw6FsrWSNXACkmhSb00eYMK3WpVnZFCg3x/l2c6TGkpJN9YMZgWD3c51Nf/MMTgFerw
	fWC+Z09/L3a8+E/dmAESgyqa2eu5IOlDo7haXFmoD3sjj6EOvAyFZ734m8u9h0nIS9ZaRk11CWK
	GGIzw==
X-Received: by 2002:a05:6809:251:10b0:484:c3b5:9b11 with SMTP id 5614622812f47-484c3b5a183mr4889324b6e.36.1779204758974;
        Tue, 19 May 2026 08:32:38 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585cf66sm170094531cf.30.2026.05.19.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:32:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPMQv-0000000FCii-39HS;
	Tue, 19 May 2026 12:32:37 -0300
Date: Tue, 19 May 2026 12:32:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH mlx5-next] net/mlx5: Consolidate UAR index to PFN helpers
Message-ID: <20260519153237.GN7702@ziepe.ca>
References: <20260519-mlx5-uar-index-v1-1-1027ae724bff@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-mlx5-uar-index-v1-1-1027ae724bff@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289503-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DE457581F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:08:18PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> mlx5_core's uar2pfn() and mlx5_ib's uar_index2pfn() compute the same
> value via slightly different idioms.  Given:
> 
>   MLX5_ADAPTER_PAGE_SHIFT = 12
>   MLX5_UARS_IN_PAGE       = PAGE_SIZE / MLX5_ADAPTER_PAGE_SIZE
>                           = 1 << (PAGE_SHIFT - 12)
> 
> when uar_4k is set, uar2pfn()'s "index >> (PAGE_SHIFT - 12)" reduces to
> "index / MLX5_UARS_IN_PAGE", which is exactly what uar_index2pfn() does.
> When uar_4k is clear, both fall through to the identity case.  The same
> arithmetic is also open-coded a third time in uar_index2paddress(), which
> just multiplies the result by PAGE_SIZE.
> 
> The duplication is historical: uar_index2pfn() landed with the original
> mlx5_ib driver in 2013 (e126ba97dba9), uar2pfn() was added in 2017
> (a6d51b68611e) when the bfreg allocator moved into mlx5_core, and no
> shared header ever exposed the helper.  The two were last touched in
> parallel by aa8106f137b9 ("net/mlx5: Add explicit bar address field"),
> confirming they are meant to behave identically.
> 
> Replace all three local copies with two static inlines in
> include/linux/mlx5/driver.h returning phys_addr_t, which is the
> appropriate type for a value that subsequently feeds ioremap*() and
> rdma_user_mmap_io().  No functional change.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> mlx5_core's uar2pfn() and mlx5_ib's uar_index2pfn() compute the same
> value via slightly different idioms. Let's consolidate them.
> ---
>  drivers/infiniband/hw/mlx5/main.c             | 25 ++-----------------------
>  drivers/net/ethernet/mellanox/mlx5/core/uar.c | 14 +-------------
>  include/linux/mlx5/driver.h                   | 16 ++++++++++++++++
>  3 files changed, 19 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 428811fa805b..e61db29bc166 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2373,27 +2373,6 @@ static void mlx5_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
>  	}
>  }
>  
> -static phys_addr_t uar_index2pfn(struct mlx5_ib_dev *dev,
> -				 int uar_idx)
> -{
> -	int fw_uars_per_page;
> -
> -	fw_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ? MLX5_UARS_IN_PAGE : 1;
> -
> -	return (dev->mdev->bar_addr >> PAGE_SHIFT) + uar_idx / fw_uars_per_page;
> -}
> -
> -static u64 uar_index2paddress(struct mlx5_ib_dev *dev,
> -				 int uar_idx)
> -{
> -	unsigned int fw_uars_per_page;
> -
> -	fw_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ?
> -				MLX5_UARS_IN_PAGE : 1;
> -
> -	return (dev->mdev->bar_addr + (uar_idx / fw_uars_per_page) * PAGE_SIZE);
> -}
> -
>  static int get_command(unsigned long offset)
>  {
>  	return (offset >> MLX5_IB_MMAP_CMD_SHIFT) & MLX5_IB_MMAP_CMD_MASK;
> @@ -2643,7 +2622,7 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
>  		uar_index = bfregi->sys_pages[idx];
>  	}
>  
> -	pfn = uar_index2pfn(dev, uar_index);
> +	pfn = mlx5_uar_index_to_pfn(dev->mdev, uar_index);
>  	mlx5_ib_dbg(dev, "uar idx 0x%lx, pfn %pa\n", idx, &pfn);
>
>  	err = rdma_user_mmap_io(&context->ibucontext, vma, pfn, PAGE_SIZE,
> @@ -4327,7 +4306,7 @@ alloc_uar_entry(struct mlx5_ib_ucontext *c,
>  		goto end;
>  
>  	entry->page_idx = uar_index;
> -	entry->address = uar_index2paddress(dev, uar_index);
> +	entry->address = mlx5_uar_index_to_paddr(dev->mdev, uar_index);
>  	if (alloc_type == MLX5_IB_UAPI_UAR_ALLOC_TYPE_BF)
>  		entry->mmap_flag = MLX5_IB_MMAP_TYPE_UAR_WC;
>  	else
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/uar.c b/drivers/net/ethernet/mellanox/mlx5/core/uar.c
> index 1513112ecec8..a85d8fed1546 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/uar.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/uar.c
> @@ -66,18 +66,6 @@ static int uars_per_sys_page(struct mlx5_core_dev *mdev)
>  	return 1;
>  }
>  
> -static u64 uar2pfn(struct mlx5_core_dev *mdev, u32 index)
> -{
> -	u32 system_page_index;
> -
> -	if (MLX5_CAP_GEN(mdev, uar_4k))
> -		system_page_index = index >> (PAGE_SHIFT - MLX5_ADAPTER_PAGE_SHIFT);
> -	else
> -		system_page_index = index;
> -
> -	return (mdev->bar_addr >> PAGE_SHIFT) + system_page_index;
> -}
> -
>  static void up_rel_func(struct kref *kref)
>  {
>  	struct mlx5_uars_page *up = container_of(kref, struct mlx5_uars_page, ref_count);
> @@ -132,7 +120,7 @@ static struct mlx5_uars_page *alloc_uars_page(struct mlx5_core_dev *mdev,
>  		goto error1;
>  	}
>  
> -	pfn = uar2pfn(mdev, up->index);
> +	pfn = mlx5_uar_index_to_pfn(mdev, up->index);
>  	if (map_wc) {
>  		up->map = ioremap_wc(pfn << PAGE_SHIFT, PAGE_SIZE);

The only places using PFN here immediately shift it, this should be
using mlx5_uar_index_to_paddr()


> +static inline phys_addr_t mlx5_uar_index_to_pfn(struct mlx5_core_dev *mdev,
> +						u32 uar_idx)
> +{
> +	u32 fw_uars_per_page = MLX5_CAP_GEN(mdev, uar_4k) ? MLX5_UARS_IN_PAGE : 1;
> +
> +	return (mdev->bar_addr >> PAGE_SHIFT) + uar_idx / fw_uars_per_page;
> +}
> +
> +static inline phys_addr_t mlx5_uar_index_to_paddr(struct mlx5_core_dev *mdev,
> +						  u32 uar_idx)
> +{
> +	u32 fw_uars_per_page = MLX5_CAP_GEN(mdev, uar_4k) ? MLX5_UARS_IN_PAGE : 1;
> +
> +	return mdev->bar_addr + (uar_idx / fw_uars_per_page) * PAGE_SIZE;
> +}

Then there is only one caller of the pfn version in uar_mmap which can
just be written using phys and open code the >> PAGE_SHIFT

No reason to duplicate this

Jason

