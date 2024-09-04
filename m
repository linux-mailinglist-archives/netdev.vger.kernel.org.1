Return-Path: <netdev+bounces-125046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B396BBC4
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCCA1C20B03
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F021B1D0167;
	Wed,  4 Sep 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mlM2Nzoo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A271D4175
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452033; cv=none; b=r6VoSq+xv/O3R33WNWXMcCq3SVT569SvgBaMEAh6i3Zew7hUIcx22VPIyv2ex9W4uPgB0eS5s3bZR/VdKpjbIGqvcAHIbhmZYHY90/K68fKwT6qju5o1Prz3VQEKFle7daDlmZrNByfCjNCLBLQDVlTxG/tbGVNUblQq7G//oJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452033; c=relaxed/simple;
	bh=yzDJBItoY7P4Oa0onc63fgdZDI/hQiOkDASAHjJabvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlmZA/kPLLfRnls0/UOH/ExnaJwoS6W7+7oBcEO7EY91jsSiPM7f1g/pvzHnBqPBGZdavm9sRamLswgUmJiF8TTF0IQPRjBBDSqHM4vvK6Q24h0wx1hTTNdsnkun8iEYHp+NA1/vTw+QMaUpIZcfCtM9NG3L+9vekEGuiL40+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mlM2Nzoo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uh3zwQosGacku7wCYITExnVZrD8nWKDofzBx6XEt7T8=; b=mlM2NzootN0hH8Q8aa21fcpw5o
	2tCCGYTQ4pbiWGRmnkd7EoU81eNdhxGlbCh+XSoXBUm6oWfq95vQoll/fTCSlhwSm0uCk5+/Bj9Pc
	RZC/Y49CGWRamPWAiYaXiKbss5yg40DzPjMgqMaYfruv0WHbKM5D6cIjMdS4WbaObeN8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slotG-006YDY-SV; Wed, 04 Sep 2024 14:13:38 +0200
Date: Wed, 4 Sep 2024 14:13:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 net-next] e1000e: Remove duplicated writel() in
 e1000_configure_tx/rx()
Message-ID: <b6b56dd0-b6ff-47d1-a678-d2fde5184723@lunn.ch>
References: <3ef52bb5-3289-416a-81b6-4064c49960c8@lunn.ch>
 <20240904055646.58588-1-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904055646.58588-1-takamitz@amazon.co.jp>

On Wed, Sep 04, 2024 at 02:56:46PM +0900, Takamitsu Iwai wrote:
> > So you have confirmed with the datsheet that the write is not needed?
> >
> > As i said, this is a hardware register, not memory. Writes are not
> > always idempotent. It might be necessary to write it twice.
> 
> I have checked following datasheets and I can not find that we need to write
> RDH, RDT, TDH, TDT registers twice at initialization.
> 
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82577-gbe-phy-datasheet.pdf
> https://www.intel.com/content/www/us/en/content-details/613460/intel-82583v-gbe-controller-datasheet.html
> 
> Write happened once before commit 0845d45e900c, so just out of curiosity,
> have you seen such a device?

This is just risk minimisation. I don't want e1000e to be broken
because you removed a write. I'm trying to ensure you fully understand
what you are changing, and have verified it is a safe change. I don't
have this hardware, so i cannot test it.

> My colleague, Kohei, tested the patch with a real hardware and will provide his
> Tested-by shortly.

Please resend the patch, adding his Tested-by: and update the commit
message to summarise this discussion. Explain how you determined this
is safe.

Thanks
	Andrew

