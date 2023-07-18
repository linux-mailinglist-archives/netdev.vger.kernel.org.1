Return-Path: <netdev+bounces-18602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB4757D77
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8511C20CE6
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF7D306;
	Tue, 18 Jul 2023 13:27:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4BC2F3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFBCC433C7;
	Tue, 18 Jul 2023 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689686870;
	bh=OllI6hqwDmAP9/S7KjyQLxoCQsdlJakPqeGx3eqe7n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGcVLWbGC+0pwwepizlUfKJV2Ug+iwpitZdTNMNNIvD1MzWkEqHmjbPDbs2hno+UV
	 bzktmaGosHPlGAloJPdBOOCNtCSOrkL7F2ZHVMOs48+IU+AsgBBfgoVgrhxrjUeew5
	 J5d3ObW1bjqQUlLczqul6dC1DA/hdvPWMnxQuvHY=
Date: Tue, 18 Jul 2023 15:27:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ross Maynard <bids.7405@bigpond.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] USB: zaurus: 3 broken Zaurus devices
Message-ID: <2023071811-dandy-jugular-b306@gregkh>
References: <4963f4df-e36d-94e2-a045-48469ab2a892@bigpond.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4963f4df-e36d-94e2-a045-48469ab2a892@bigpond.com>

On Tue, Jul 18, 2023 at 10:16:55AM +1000, Ross Maynard wrote:
> Hi Greg,
> 
> This is related to Oliver Neukum's patch
> 6605cc67ca18b9d583eb96e18a20f5f4e726103c (USB: zaurus: support another
> broken Zaurus) which you committed in 2022 to fix broken support for the
> Zaurus SL-6000.
> 
> Prior to that I had been able to track down the original offending patch
> using git bisect as you had suggested to me:
> 16adf5d07987d93675945f3cecf0e33706566005 (usbnet: Remove over-broad module
> alias from zaurus).
> 
> It turns out that the offending patch also broke support for 3 other Zaurus
> models: A300, C700 and B500/SL-5600. My patch adds the 3 device IDs to the
> driver in the same way Oliver added the SL-6000 ID in his patch.
> 
> Could you please review the attached patch? I tested it on all 3 devices and
> it fixed the problem. For your reference, the associated bug URL is
> https://bugzilla.kernel.org/show_bug.cgi?id=217632.

I'll be glad to accept it if you resend it in a format that I can apply
it in.  I'll run my patch-bot on it to give you some hints on what needs
to be done here.

thanks,

greg k-h

