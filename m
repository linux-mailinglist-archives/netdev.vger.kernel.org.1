Return-Path: <netdev+bounces-196754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE55DAD6453
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E79B1BC23DD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D235977;
	Thu, 12 Jun 2025 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5/2KZ4L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8979D2;
	Thu, 12 Jun 2025 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686666; cv=none; b=eUu7dP6G/mxzvEM4fgn0NZzxAoFyqJ7m7rtOtxn2Q2i+QZT+Jux7hzl2hYswevbmdniz/1TFnsk0U5nWaXAzDenzOO7lplctuZiLW+WlQs1iLx6KMDhoXk0zS4aVtJIW6JOzP4RHi2HNpoJqwk4pkThwTkDPw6vaYor7xYDRCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686666; c=relaxed/simple;
	bh=chdl8KTqcIxWtQmwJA4bH1QKh2idYqYeJmh8PFK8vxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3iZgXqO9UTmGGWrGa/0ejuXwsLvrRIfF8jF20706A2qHEjWUvjBpwjgZqDVi4c/Tyvcy+x7xZg+bhp+jHqcx9u+K3mJ0nyzJbmLXDRztmWrvj/rxbuFsgbWMysh4fi9bo/+ovoycpvow2mswJfctDloiwWj4tYyi14mW9DxmcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5/2KZ4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B320C4CEE3;
	Thu, 12 Jun 2025 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749686666;
	bh=chdl8KTqcIxWtQmwJA4bH1QKh2idYqYeJmh8PFK8vxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B5/2KZ4LKzIbYCV/9zcadAirye+IEmF41mZUQfHhcVxh4rA/Fxp9ERRj/mDlZF1LP
	 m3KVDlqWNr0HSKC+ngAL1ritfNN8ewZQVv72tAAxuHt5XKk4gj+iQcQMHkUri79mMB
	 kp8J0tjHjn/mb/KA+KyTKyLYUvGFQIbWc/DH58QSnG7lpZUA1sc7md+0cV1iykUo6f
	 YGN8fU/RLy16ULNnAd5ctjCEAjdQbJgyAjW9Y9PN3B5a8zxQFO1ARQZK++27dxQDW9
	 AD6LdhqCgKioNt8K9OjEbumpEwU+iu7kQ1xTpUEVdXIso31Vb2Vm5rJTY2vl/Xb2vH
	 lBi6UGDpUwHCQ==
Date: Wed, 11 Jun 2025 17:04:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Himanshu Mittal <h-mittal1@ti.com>
Cc: <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
 <rogerq@kernel.org>, <danishanwar@ti.com>, <m-malladi@ti.com>,
 <pratheesh@ti.com>, <prajith@ti.com>
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Add prp offload support
 to ICSSG driver
Message-ID: <20250611170424.08e47f1a@kernel.org>
In-Reply-To: <20250610061638.62822-1-h-mittal1@ti.com>
References: <20250610061638.62822-1-h-mittal1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 11:46:38 +0530 Himanshu Mittal wrote:
> Add support for ICSSG PRP mode which supports offloading of:
>  - Packet duplication and PRP trailer insertion
>  - Packet duplicate discard and PRP trailer removal
> 
> Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 23 +++++++++++++++++++-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 +++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 86fc1278127c..65883c7851c5 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -138,6 +138,19 @@ static struct icssg_firmwares icssg_hsr_firmwares[] = {
>  	}
>  };
>  
> +static struct icssg_firmwares icssg_prp_firmwares[] = {
> +	{
> +		.pru = "ti-pruss/am65x-sr2-pru0-pruprp-fw.elf",
> +		.rtu = "ti-pruss/am65x-sr2-rtu0-pruprp-fw.elf",
> +		.txpru = "ti-pruss/am65x-sr2-txpru0-pruprp-fw.elf",
> +	},
> +	{
> +		.pru = "ti-pruss/am65x-sr2-pru1-pruprp-fw.elf",
> +		.rtu = "ti-pruss/am65x-sr2-rtu1-pruprp-fw.elf",
> +		.txpru = "ti-pruss/am65x-sr2-txpru1-pruprp-fw.elf",
> +	}
> +};

AFAIU your coworker is removing the static names, please wait until 
the dust is settled on that:

https://lore.kernel.org/all/20250610052501.3444441-1-danishanwar@ti.com/
-- 
pw-bot: cr

