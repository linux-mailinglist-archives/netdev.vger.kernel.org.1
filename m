Return-Path: <netdev+bounces-16704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1774E75C
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021C62815D3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B89168C0;
	Tue, 11 Jul 2023 06:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AB63E
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2FFC433C8;
	Tue, 11 Jul 2023 06:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689057094;
	bh=rLCq6il+gOpNtxEJbxzI2Ce9xDoda14FwO05ImMBhQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4ahMrCFfuMkTa+Noeh5oeBU+FwgSXZFMkytOsnNYj0XPzgEjioWFbsE3NsaLpWIE
	 6rZRtrqRB4HpkrLArsvuSeuBSDsQmJIVKHtGghV8CI001WPGBBF347q6dnwBDsbWka
	 MeRgeU33J5rpr8FNKa3Bdmn6OI6vu2j6RpJfCvyghYvPiI6z+GWvgVxOQRxTuucJhk
	 5FGjxeAniw/KPT380IvmYz4Ql2wdKU70i5Q8J+puPv/8was0T93byQq2GPJbZ71Ztj
	 poJ1exuBZBnm1Wy8osnSja63wqAoi6rYkDaJntaIhV3p7QxDGjzFFTGcKPPX7gYzKh
	 xGqlMxbkdwQyA==
Date: Tue, 11 Jul 2023 09:31:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: menglong8.dong@gmail.com
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH RESEND net-next] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
Message-ID: <20230711063125.GA41919@unreal>
References: <20230710094747.943782-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710094747.943782-1-imagedong@tencent.com>

On Mon, Jul 10, 2023 at 05:47:47PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
> to clear the unnecessary noise of "kfree_skb" event.

Can you please be more specific in the commit message what "unnecessary
noise" you reduced?

> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

