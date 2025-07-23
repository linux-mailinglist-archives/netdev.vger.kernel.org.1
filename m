Return-Path: <netdev+bounces-209321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6DB0F06C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC49AAA3C9A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2E290D87;
	Wed, 23 Jul 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlpwlbYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6924DCF6;
	Wed, 23 Jul 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267921; cv=none; b=AKhvyh6oXRWP8HpTZ1JB3kMe2GuK7ZDTKKEhbBrwdMkMeRiCvGWbctLkd+AcbbXL+9ksvV4mpyb3DMFx1nZL9n5bTkaxZM38bqQP9I+u6Ykp9Zd4vGpOvJvRyzwC+p+Q3fTdXRGOJdUujGtwO8rIYIDTuLkbCVNTe/BigBgImw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267921; c=relaxed/simple;
	bh=x8jm0xbL3K9WLliiR8StUM6ghTUoYacs70eccu1DI00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbUf4L78VHUk3Ww2/q/0tMYEwE3RFJolTnwvDCROvEIysPRHNhZ6UVwAzCKvXKgTUsgKUsF15xbCmvKIj3i9EymSF+hsQC64KeD/saanUTgGVIiOnIH7fitYjT/dRQW+saWzlgIQhpFeeYR15WBP1i/Wf8HbklpQaUJvOGASM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlpwlbYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3678BC4CEE7;
	Wed, 23 Jul 2025 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753267921;
	bh=x8jm0xbL3K9WLliiR8StUM6ghTUoYacs70eccu1DI00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlpwlbYO+sgbBucU9VsfmcCyV0Pih/wtUUivLYQDVFHlEmrOcR6vURrjdLEATHc65
	 tUYe6o8EGe1snttw3ImGjlaWHz1ApE11G4fzihdykci2VUbqZnax3jyfVtOyOPPKey
	 n89hDWRqJIBPSPRydEexDc4MeTnKLfG9yMd8po2Uc+Mv7s/zjayWED+SWHKkyGAnT4
	 iRyL1wNZgUgZDCyQ2WxiAiiMp+29wB5TIU06EhS+bGfxgvKWP0pcVu+VFWh+UN1yM0
	 SFYgwf5RhScDVXvPFIoAYq1BQpNYn+yg5CLr04SLvOPAjtxCnY6jL6S2SQ/s58XKbg
	 ca3Ft5qo8GWag==
Date: Wed, 23 Jul 2025 11:51:54 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Fu Guiming <fuguiming@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v10 7/8] hinic3: Mailbox management interfaces
Message-ID: <20250723105154.GZ2459@horms.kernel.org>
References: <cover.1753152592.git.zhuyikai1@h-partners.com>
 <463548c7cd0a6044f1dffa2b6fdef2f36c294356.1753152592.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463548c7cd0a6044f1dffa2b6fdef2f36c294356.1753152592.git.zhuyikai1@h-partners.com>

On Tue, Jul 22, 2025 at 03:18:46PM +0800, Fan Gong wrote:

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c

...

> @@ -25,6 +42,20 @@
>  #define MBOX_LAST_SEG_MAX_LEN  \
>  	(MBOX_MAX_BUF_SZ - MBOX_SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
>  
> +/* mbox write back status is 16B, only first 4B is used */
> +#define MBOX_WB_STATUS_ERRCODE_MASK      0xFFFF
> +#define MBOX_WB_STATUS_MASK              0xFF
> +#define MBOX_WB_ERROR_CODE_MASK          0xFF00
> +#define MBOX_WB_STATUS_FINISHED_SUCCESS  0xFF
> +#define MBOX_WB_STATUS_NOT_FINISHED      0x00
> +
> +#define MBOX_STATUS_FINISHED(wb)  \
> +	(((wb) & MBOX_WB_STATUS_MASK) != MBOX_WB_STATUS_NOT_FINISHED)
> +#define MBOX_STATUS_SUCCESS(wb)  \
> +	(((wb) & MBOX_WB_STATUS_MASK) == MBOX_WB_STATUS_FINISHED_SUCCESS)
> +#define MBOX_STATUS_ERRCODE(wb)  \
> +	((wb) & MBOX_WB_ERROR_CODE_MASK)

These look ripe for using FIELD_PREP.

...

> +static bool is_msg_queue_full(struct mbox_dma_queue *mq)
> +{
> +	return (MBOX_MQ_ID_MASK(mq, (mq)->prod_idx + 1) ==
> +		MBOX_MQ_ID_MASK(mq, (mq)->cons_idx));

nit: unnecessary outer parentheses.

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
> index ec4cae0a0929..2bf7a70251bb 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
> @@ -48,6 +48,7 @@ static inline void *get_q_element(const struct hinic3_queue_pages *qpages,
>  		*remaining_in_page = elem_per_pg - elem_idx;
>  	ofs = elem_idx << qpages->elem_size_shift;
>  	page = qpages->pages + page_idx;
> +
>  	return (char *)page->align_vaddr + ofs;
>  }

nit: This hunk seems unrelated to the rest of the patch.

