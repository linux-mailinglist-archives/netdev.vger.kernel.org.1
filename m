Return-Path: <netdev+bounces-159308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA58FA150CD
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07143A9890
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30BB1F7077;
	Fri, 17 Jan 2025 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnK5hwGM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD791FDE31
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121528; cv=none; b=YDCEybZzWtLOyU1dz95o1c6V6nIhnD8aIxw7OxVe6m50uzLGxmkXMclBMzYlgB4WrLNL8jj0zbYhxp83SF/ToEtu0DHJnlcwh80iOovI+5J8KJXWWY8UarM5fp86g3VBBjdbiYJ6yA1mhDQ4DyMpdCXra1WBRQLb0qP7NnTfSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121528; c=relaxed/simple;
	bh=xoY+Ga/apM59xHe9a1FRNm+jYHJkqmnRc1xIlP9KVqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1uq28GdiRLjtwY1gnoCcFVeX/IJcQ86/yE3CrJAE+J8i/MGhyRlZ8D6pr3ddmrmnkvbVVKeEpevGsHufP3I7nzNzb4aO2lYMBloGlYq4QEQmDetphHdVvLYpoLr9q4TcxsiKEfBnpVWtQ8a9KLWWlx84rdTROpTuBW6GCuWC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnK5hwGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DDBC4CEDD;
	Fri, 17 Jan 2025 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737121528;
	bh=xoY+Ga/apM59xHe9a1FRNm+jYHJkqmnRc1xIlP9KVqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnK5hwGMEqaQX7Goq/31DNmV37/vztohAxm4ah3asaNvKJrZKMyPANBPCLM6Of4Pl
	 zMKC17SPSypSMViKrFSl3xh143mI6fO5sij53R9G0S1rJNaV8zMOnoNDAHS2xnWAUY
	 oeDkt1OTM10P16DDv5u3czrjjwU18IQlMGNEOf1LC9Jai4weY8i8fe9QMmJMyOPq70
	 wljOmmO+Y/smbx0/BQtQO2z5pbLCZN0fHNEB1/7EyCd5KmHw2Usgca0NRdIA5jtI9V
	 0aQDa4jFTfJPgVOAea842SdWpBDJqWqcEDG/CX+zGLQQMv1/HGXiwYVeoJWZhVqAbZ
	 7rRlvfUurH+EA==
Date: Fri, 17 Jan 2025 13:45:23 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v3 04/14] net-next/yunsilicon: Add qp and cq management
Message-ID: <20250117134523.GO6206@kernel.org>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
 <20250115102249.3541496-5-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115102249.3541496-5-tianx@yunsilicon.com>

On Wed, Jan 15, 2025 at 06:22:51PM +0800, Xin Tian wrote:
> Add qp(queue pair) and cq(completion queue) resource management APIs
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h

...

> +// qp
> +struct xsc_send_wqe_ctrl_seg {
> +	__le32		msg_opcode:8;
> +	__le32		with_immdt:1;
> +	__le32		csum_en:2;
> +	__le32		ds_data_num:5;
> +	__le32		wqe_id:16;
> +	__le32		msg_len;
> +	union {
> +		__le32		opcode_data;
> +		struct {
> +			u8		has_pph:1;
> +			u8		so_type:1;
> +			__le16		so_data_size:14;
> +			u8:8;
> +			u8		so_hdr_len:8;
> +		};
> +		struct {
> +			__le16		desc_id;
> +			__le16		is_last_wqe:1;
> +			__le16		dst_qp_id:15;
> +		};
> +	};
> +	__le32		se:1;
> +	__le32		ce:1;
> +	__le32:30;
> +};
> +
> +struct xsc_wqe_data_seg {
> +	union {
> +		__le32		in_line:1;
> +		struct {
> +			__le32:1;
> +			__le32		seg_len:31;
> +			__le32		mkey;
> +			__le64		va;
> +		};
> +		struct {
> +			__le32:1;
> +			__le32		len:7;
> +			u8		in_line_data[15];
> +		};
> +	};
> +};

Hi Xin Tian,

Sparse seems very unhappy about the combination of __le32 and bitfields
in struct xsc_send_wqe_ctrl_seg and struct xsc_wqe_data_seg.

.../xsc_core.h:87:35: error: invalid bitfield specifier for type restricted __le32.
...

I did not look into this deeply. But, in general, I would suggest using
GET_FIELD and SET_FIELD as an alternative to bitfields.

...

