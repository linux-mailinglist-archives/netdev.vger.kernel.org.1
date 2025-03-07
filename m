Return-Path: <netdev+bounces-173046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8BCA56FDF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCBB1784FB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0B242901;
	Fri,  7 Mar 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URDSeWQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C372417C8;
	Fri,  7 Mar 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370411; cv=none; b=CdDh85cS+VphP3PKlgsb6dC6Ig2FfrhOj/9AlyFT0nA5HTHJRbr9L6xQ9ZK5O7ivcFgCCQBWl48QGl++o6RHeehgkO6BE7B+nx8R6IAtrfT1gANKDycwkq5GkZpYhdjJ2bRwojA4EfO++IcMquggBgrVL+2xy0rQW2ucp0WfInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370411; c=relaxed/simple;
	bh=ROXIrFWpvJK0VBYRRw4tGyucWLzGJ+3Ly0c2x9+xZqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndHxM7czslx4j8StR7Edemx8//PS1WE1dMhCokHkYm1jz7wsEV/fiw5GJ3W06BW9nzx7lJ0mzMB6UWSbEsekZZUcYNys99egyx85TZEhKFMnNQzdvka3MTOCLz/d6U6mUrzi82j0UpS1aVEsQWLFWvoO3DNeE+YeYUvqjEh+ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URDSeWQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1CAC4CED1;
	Fri,  7 Mar 2025 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741370411;
	bh=ROXIrFWpvJK0VBYRRw4tGyucWLzGJ+3Ly0c2x9+xZqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URDSeWQYLBCpGO7DhzataZEZq6u/PAaEXdUMToU4N6kjKCUx8o/SGMYxLJiqGn5hx
	 epn4ztMDj7B7dFe17f16mKMkW3HZmYfHm94tpyZBZ1e1pUucTGv0EXv5aHH0lp/9Ra
	 E/z0JnK1yH+Dcxq0p8QzSZAZbJbA8B3DLlw7zV377clQ5HJt4SPhIIMnxYjxbLY8Gr
	 cu+7c3bkmgMfjeTgS+M7Fgge3R2r/QbWsNt0flbg+6WAvqfp3NygxT/Ocny3yCatX0
	 kki0ESccgf21XnWeLgEZU/+T+yHn8b5A3RCRhiLfaEU6wzJnYeC80V6DagmXl9o+mO
	 3UtWqKKNmhhqA==
Date: Fri, 7 Mar 2025 18:00:06 +0000
From: Simon Horman <horms@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Christian Benvenuti <benve@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nelson Escobar <neescoba@cisco.com>,
	John Daley <johndale@cisco.com>
Subject: Re: [PATCH net-next v3 4/8] enic: enable rq extended cq support
Message-ID: <20250307180006.GK3666230@kernel.org>
References: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
 <20250306-enic_cleanup_and_ext_cq-v3-4-92bc165344cf@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-enic_cleanup_and_ext_cq-v3-4-92bc165344cf@cisco.com>

On Thu, Mar 06, 2025 at 07:15:25PM -0500, Satish Kharat via B4 Relay wrote:
> From: Satish Kharat <satishkh@cisco.com>
> 
> Enables getting from hw all the supported rq cq sizes and
> uses the highest supported cq size.
> 
> Co-developed-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

...

> diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
> index 842b273c2e2a59e81a7c1423449b023d646f5e81..ccbf5c9a21d0ffe33c7c74042d5425497ea0f9dc 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_rq.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
> @@ -21,24 +21,76 @@ static void enic_intr_update_pkt_size(struct vnic_rx_bytes_counter *pkt_size,
>  		pkt_size->small_pkt_bytes_cnt += pkt_len;
>  }
>  
> -static void enic_rq_cq_desc_dec(struct cq_enet_rq_desc *desc, u8 *type,
> +static void enic_rq_cq_desc_dec(void *cq_desc, u8 cq_desc_size, u8 *type,
>  				u8 *color, u16 *q_number, u16 *completed_index)
>  {
>  	/* type_color is the last field for all cq structs */
> -	u8 type_color = desc->type_color;
> +	u8 type_color;
> +
> +	switch (cq_desc_size) {
> +	case VNIC_RQ_CQ_ENTRY_SIZE_16: {
> +		struct cq_enet_rq_desc *desc =
> +			(struct cq_enet_rq_desc *)cq_desc;
> +		type_color = desc->type_color;
> +
> +		/* Make sure color bit is read from desc *before* other fields
> +		 * are read from desc.  Hardware guarantees color bit is last
> +		 * bit (byte) written.  Adding the rmb() prevents the compiler
> +		 * and/or CPU from reordering the reads which would potentially
> +		 * result in reading stale values.
> +		 */
> +		rmb();
>  
> -	/* Make sure color bit is read from desc *before* other fields
> -	 * are read from desc.  Hardware guarantees color bit is last
> -	 * bit (byte) written.  Adding the rmb() prevents the compiler
> -	 * and/or CPU from reordering the reads which would potentially
> -	 * result in reading stale values.
> -	 */
> -	rmb();
> +		*q_number = le16_to_cpu(desc->q_number_rss_type_flags) &
> +			    CQ_DESC_Q_NUM_MASK;
> +		*completed_index = le16_to_cpu(desc->completed_index_flags) &
> +				   CQ_DESC_COMP_NDX_MASK;
> +		break;
> +	}
> +	case VNIC_RQ_CQ_ENTRY_SIZE_32: {
> +		struct cq_enet_rq_desc_32 *desc =
> +			(struct cq_enet_rq_desc_32 *)cq_desc;
> +		type_color = desc->type_color;
> +
> +		/* Make sure color bit is read from desc *before* other fields
> +		 * are read from desc.  Hardware guarantees color bit is last
> +		 * bit (byte) written.  Adding the rmb() prevents the compiler
> +		 * and/or CPU from reordering the reads which would potentially
> +		 * result in reading stale values.
> +		 */
> +		rmb();
> +
> +		*q_number = le16_to_cpu(desc->q_number_rss_type_flags) &
> +			    CQ_DESC_Q_NUM_MASK;
> +		*completed_index = le16_to_cpu(desc->completed_index_flags) &
> +				   CQ_DESC_COMP_NDX_MASK;
> +		*completed_index |= (desc->fetch_index_flags & CQ_DESC_32_FI_MASK) <<
> +				CQ_DESC_COMP_NDX_BITS;
> +		break;
> +	}
> +	case VNIC_RQ_CQ_ENTRY_SIZE_64: {
> +		struct cq_enet_rq_desc_64 *desc =
> +			(struct cq_enet_rq_desc_64 *)cq_desc;
> +		type_color = desc->type_color;
> +
> +		/* Make sure color bit is read from desc *before* other fields
> +		 * are read from desc.  Hardware guarantees color bit is last
> +		 * bit (byte) written.  Adding the rmb() prevents the compiler
> +		 * and/or CPU from reordering the reads which would potentially
> +		 * result in reading stale values.
> +		 */
> +		rmb();
> +
> +		*q_number = le16_to_cpu(desc->q_number_rss_type_flags) &
> +			    CQ_DESC_Q_NUM_MASK;
> +		*completed_index = le16_to_cpu(desc->completed_index_flags) &
> +				   CQ_DESC_COMP_NDX_MASK;
> +		*completed_index |= (desc->fetch_index_flags & CQ_DESC_64_FI_MASK) <<
> +				CQ_DESC_COMP_NDX_BITS;
> +		break;
> +	}
> +	}
>  
> -	*q_number = le16_to_cpu(desc->q_number_rss_type_flags) &
> -		CQ_DESC_Q_NUM_MASK;
> -	*completed_index = le16_to_cpu(desc->completed_index_flags) &
> -	CQ_DESC_COMP_NDX_MASK;
>  	*color = (type_color >> CQ_DESC_COLOR_SHIFT) & CQ_DESC_COLOR_MASK;
>  	*type = type_color & CQ_DESC_TYPE_MASK;

Hi Satish, all,

I'm unsure if this can occur in practice, but it seems that if
none of the cases above are met then type_color will be used
uninitialised here.

Flagged by Smatch.

>  }

...

