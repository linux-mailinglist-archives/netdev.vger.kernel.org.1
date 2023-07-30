Return-Path: <netdev+bounces-22615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D59B768508
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9121C20982
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209ED369;
	Sun, 30 Jul 2023 11:21:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145317C9
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 11:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF83CC433C7;
	Sun, 30 Jul 2023 11:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690716114;
	bh=d5cXKEa98CkccFbX7z5Yy+edmhGp37e3Sz0j4bKvfC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lz3cEeZ7EtauT9PvCC/G+SkMGuM4DcbIhr8Jm2U2e/zogzF5eqqRRTu0koLCaAXCt
	 L7jh1DbJh1Sd8frpqEM+Otl7aewuS9v4K3QSFMA4ilf7acjp4lzAhRGuclb6gzIYTe
	 RUrbfjxTycpJhNC0KgesXVhE6bfQB/t5nqQkGtFg=
Date: Sun, 30 Jul 2023 13:21:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ross Maynard <bids.7405@bigpond.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] USB: zaurus: Add ID for A-300/B-500/C-700
Message-ID: <2023073011-happening-caption-59d7@gregkh>
References: <8b15ff2c-baaa-eb73-5fc9-b77ba6482bd5@bigpond.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b15ff2c-baaa-eb73-5fc9-b77ba6482bd5@bigpond.com>

On Thu, Jul 27, 2023 at 07:46:44PM +1000, Ross Maynard wrote:
> The SL-A300, B500/5600, and C700 devices no longer auto-load because of
> "usbnet: Remove over-broad module alias from zaurus."
> This patch adds IDs for those 3 devices.
> 
> Reported-by: Ross Maynard <bids.7405@bigpond.com>

No need for a reported-by if you also are fixing the issue :)

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217632
> Fixes: 16adf5d07987 ("usbnet: Remove over-broad module alias from zaurus.")
> Signed-off-by: Ross Maynard <bids.7405@bigpond.com>

Please also add a cc: stable@vger.kernel.org entry as per:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

thanks,

greg k-h

