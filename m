Return-Path: <netdev+bounces-40960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E57C9312
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 08:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A55B20B2E
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52455385;
	Sat, 14 Oct 2023 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZv9zF57";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zI/SGN9W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0D5240
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 06:58:20 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E4BB;
	Fri, 13 Oct 2023 23:58:19 -0700 (PDT)
Date: Sat, 14 Oct 2023 08:58:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697266697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN/M4L6Q9tZIGosWFp/kcGmAa2Y/6EWiUPwyWfd8rKE=;
	b=rZv9zF571294pKPYQEo+flX23oNTcz7yICfujI8U7SWOjEeeQU2OGHKTocOVg8qTK6qRuE
	0mn5Ec8Hq/nbnU5rIKwT4ogtLCW0nFDa8cyMkdijXM0yc0Eioe0gPdIowLOGiYSwXokVYq
	JsJFUPuNvBFy/bm/4YQInOd+cPaMDL5iPBnMOraBIafXrx3KcfFMiT0Xi+RzKI+1Tczx7d
	8HTp1qamuebvdSiUlwMZBbD/5nQsjnqSHWMK41UodMJXMHkyGTn9rN70xZ8k5NCEnjocBI
	L64bjgO9iLDM7p0H6zdkODOX5RXAf1OA6pGbMvr1r4DbgU6Ifhftp6df1uyDKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697266697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sN/M4L6Q9tZIGosWFp/kcGmAa2Y/6EWiUPwyWfd8rKE=;
	b=zI/SGN9WX+UWpuGElmwJn8VnnTpxCeZTQAIXKLSxcDwJO/92htVLVxVMct33PGHEzHMWny
	OIte2F/uIaH8oAAw==
From: Nam Cao <namcao@linutronix.de>
To: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Cc: outreachy@lists.linux.dev, manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
Message-ID: <20231014065813.mQvFyjWb@linutronix.de>
References: <ZSoxLxs45bIuBrHg@gilbert-PC>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSoxLxs45bIuBrHg@gilbert-PC>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 07:11:59AM +0100, Gilbert Adikankwu wrote:
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
>

What checkpatch is telling you here is that the "else" is redundant and
can be removed. Although your patch suppresses the warning, it makes the
code messier :(

Best regards,
Nam

> The idea of the break statements in the if/else is so that the loop is
> exited immediately the value of status is changed. And returned
> immediately. For if/else conditionals, the block to be executed will
> always be one of the two. Introduce a bool type variable 's_sig' that
> evaluates to true when the value of status is changed within the if/else
> block.
> 
> Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
> ---
>  drivers/staging/qlge/qlge.h     | 1 +
>  drivers/staging/qlge/qlge_mpi.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
> index d0dd659834ee..b846bca82571 100644
> --- a/drivers/staging/qlge/qlge.h
> +++ b/drivers/staging/qlge/qlge.h
> @@ -11,6 +11,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/if_vlan.h>
> +#include <linux/types.h>
>  
>  /*
>   * General definitions...
> diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
> index 96a4de6d2b34..44cb879240a0 100644
> --- a/drivers/staging/qlge/qlge_mpi.c
> +++ b/drivers/staging/qlge/qlge_mpi.c
> @@ -909,6 +909,7 @@ int qlge_mb_wol_set_magic(struct qlge_adapter *qdev, u32 enable_wol)
>  static int qlge_idc_wait(struct qlge_adapter *qdev)
>  {
>  	int status = -ETIMEDOUT;
> +	bool s_sig = false;
>  	struct mbox_params *mbcp = &qdev->idc_mbc;
>  	long wait_time;
>  
> @@ -934,14 +935,17 @@ static int qlge_idc_wait(struct qlge_adapter *qdev)
>  		} else if (mbcp->mbox_out[0] == AEN_IDC_CMPLT) {
>  			netif_err(qdev, drv, qdev->ndev, "IDC Success.\n");
>  			status = 0;
> -			break;
> +			s_sig = true;
>  		} else {
>  			netif_err(qdev, drv, qdev->ndev,
>  				  "IDC: Invalid State 0x%.04x.\n",
>  				  mbcp->mbox_out[0]);
>  			status = -EIO;
> -			break;
> +			s_sig = true;
>  		}
> +
> +		if (s_sig)
> +			break;
>  	}
>  
>  	return status;
> -- 
> 2.34.1
> 

