Return-Path: <netdev+bounces-108559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6221B9243E8
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E7D2829B3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F461BD00C;
	Tue,  2 Jul 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgZCeT0j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B014293;
	Tue,  2 Jul 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938915; cv=none; b=Z2G/AZ6zLyzaQaImzkBdfMak7eyjk94FT7ekYXkwY+RXKDlvWgNHwFMwnpuRdlMc6i1sYG6L9O+8JyCPzu07pn8dkpho+0EXt9kg9M4bi0ckMX360QhdY2xtaajbi574g1nvLB7EhpvsSj2TIDAqDBIGjo1aIYXmlb+IsCK0g1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938915; c=relaxed/simple;
	bh=gfU5QuXQlaiam67/XOpq2UzL8FJkb0/ESvDTmSYpo+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0qvfsIxHUP5EDboAEYrXFUM9x3IoUPGOuxNBBdosaJgNjRd87wlcVdWSLXKh91Eh/lDtdtPoz/vKwQywPh/f5adeWNbFAZRPtnYtBleOCcnn8uG4wtg6ubTZadi2rIhYu0t3Ovlj7OxQvKxIufkYF6e+Zb/rgGkx0w9wyJuf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgZCeT0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF76C116B1;
	Tue,  2 Jul 2024 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719938914;
	bh=gfU5QuXQlaiam67/XOpq2UzL8FJkb0/ESvDTmSYpo+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgZCeT0jiLJ2JP6oGESvJjatUQCqjDBnbc9LUuXhSVLYs2A9HUswO0QQzQNIQqtL+
	 8V8zQ194eu5KxiuIc23JK3LPL9a7bcIH5TcGQ6/nqnlVwjKIA2vtyktSWTh9AsAGRA
	 oDmfi183WIfNMP4AzpVASNrsbynOO9binPIdXcMYP8VVqRDAWLORmkzBsxOPJQGQa2
	 qtKWZbK0lRIPkGIVvGcvy5E9DPfPtdu8jueWMaxfxmJtF3KbKJ0Qh7X6bPVqFwBUY5
	 +XK2Hk4FBaIslMyBNDjc4b5ArcxiiAci3QMFsQMt8rgVpH5fy5VOHuC3KcoafF9GRH
	 omtXMsgQQ0OlQ==
Date: Tue, 2 Jul 2024 17:48:29 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 01/13] rtase: Add support for a pci table in
 this module
Message-ID: <20240702164829.GL598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-2-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:51PM +0800, Justin Lai wrote:
> Add support for a pci table in this module, and implement pci_driver
> function to initialize this driver, remove this driver, or shutdown
> this driver.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h    | 338 ++++++++++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 638 ++++++++++++++++++
>  2 files changed, 976 insertions(+)
>  create mode 100755 drivers/net/ethernet/realtek/rtase/rtase.h
>  create mode 100755 drivers/net/ethernet/realtek/rtase/rtase_main.c
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
> new file mode 100755

nit: Source files should not have the execute bit(s) set.

     Flagged by Checkpatch.

Otherwise, this patch looks good to me.

