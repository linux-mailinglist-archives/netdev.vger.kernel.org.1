Return-Path: <netdev+bounces-117834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E694F7F8
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476781C21B01
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B1193062;
	Mon, 12 Aug 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zjpHMDcG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295B61FFC;
	Mon, 12 Aug 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493521; cv=none; b=djhbGKOgWY0jjhZRWWi4JbpXtp3IAJvzE9tvmpcywe0d5GsBWU/ueBG3edWQo92X0KFGv4cY2IZpUTqXSgJuE4LWrfrcv17pWk5yAJxmCKv6/oqFrmrte19tCL+eUzer8Nk2TYV+tO7o7ScvDjbffHfleRqNdzxc/nq+UwKVK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493521; c=relaxed/simple;
	bh=vYmPssGqOqy/ZSQEltkvYmFKGbzhf8ZDF8/bOM42FSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euuPo5X4fzI0/Ngv1hhxWUCtLxwyCmbSLZ3s46dSbXNYxCngwefWutNBjRkeVcGKWbfJzW+GgZ7Mmolj8MT9iA25nFkRkOqEPdYtx2WWqpohZHLCAuh/7d6pvCXMmfMq2bpeArVLGaUBpNnqWkcFekVwq0hqnLj4+5/0OMDx1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zjpHMDcG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VGMy3306yIbpFHFkAhMbZO0uaYSmXAMxfy0U/jGaKGw=; b=zjpHMDcGe+zuafgEtDE/2t/RyR
	koaZAdWeREuSWyVeaY2dDINXIHcdCkFrdG5LRJcl4jIrnAzsjP8xwGqatkM8aDqvz1ag16ThcE823
	dYHlpc7ZO/KYn5OPFX7IzcHJjTnTLfqSVRAygaas9QPXJD5bk4n6WenZhEl7UY+NJQxw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdbOE-004c97-0Q; Mon, 12 Aug 2024 22:11:38 +0200
Date: Mon, 12 Aug 2024 22:11:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 1/2] net: xilinx: axienet: Report RxRject as
 rx_dropped
Message-ID: <1a884b22-f73b-43af-9c1e-bb383936620a@lunn.ch>
References: <20240812174118.3560730-1-sean.anderson@linux.dev>
 <20240812174118.3560730-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812174118.3560730-2-sean.anderson@linux.dev>

On Mon, Aug 12, 2024 at 01:41:17PM -0400, Sean Anderson wrote:
> The Receive Frame Rejected interrupt is asserted whenever there was a
> receive error (bad FCS, bad length, etc.) or whenever the frame was
> dropped due to a mismatched address. So this is really a combination of
> rx_otherhost_dropped, rx_length_errors, rx_frame_errors, and
> rx_crc_errors. Mismatched addresses are common and aren't really errors
> at all (much like how fragments are normal on half-duplex links). To
> avoid confusion, report these events as rx_dropped. This better
> reflects what's going on: the packet was received by the MAC but dropped
> before being processed.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

