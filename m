Return-Path: <netdev+bounces-22683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C824768B91
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF721C20A29
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 06:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D008A52;
	Mon, 31 Jul 2023 06:09:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17497F8
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90422C433C7;
	Mon, 31 Jul 2023 06:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690783776;
	bh=ajde4IL4hlX3qTXAmdYiLS0pED7StaRh7bPWk7TWzlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPIpmK4kE3ycui1PdngGhqbrWZ/WekFkLo5RkqqRPIazQnncJ5/EazDE2M5A0PNGR
	 +9LHJLG1cKzdXH/Vp+uk471RDgxIzLPLaj7//1dhKGdBHpaHpVOa94TPV2OlOBQeCy
	 DqR7osl98ikrWuzB5DmCrVa22bIUyThkCH2dPo14=
Date: Mon, 31 Jul 2023 08:09:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ross Maynard <bids.7405@bigpond.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v2] USB: zaurus: Add ID for A-300/B-500/C-700
Message-ID: <2023073120-unpicked-polyester-9425@gregkh>
References: <69b5423b-2013-9fc9-9569-58e707d9bafb@bigpond.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b5423b-2013-9fc9-9569-58e707d9bafb@bigpond.com>

On Mon, Jul 31, 2023 at 03:42:04PM +1000, Ross Maynard wrote:
> The SL-A300, B500/5600, and C700 devices no longer auto-load because of
> "usbnet: Remove over-broad module alias from zaurus."
> This patch adds IDs for those 3 devices.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217632
> Fixes: 16adf5d07987 ("usbnet: Remove over-broad module alias from zaurus.")
> Signed-off-by: Ross Maynard <bids.7405@bigpond.com>
> Cc: stable@vger.kernel.org
> ---
> v2: removed reported-by since bug reporter and patch author are the same person

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

