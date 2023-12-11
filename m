Return-Path: <netdev+bounces-55976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6098880D07E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB07280A0A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C984C3C1;
	Mon, 11 Dec 2023 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aKEpdHCM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897403856
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RVOZKACN7S6KRe39gGSq2n8Snn8QaJkst9bJApxKv6o=; b=aKEpdHCMAI6wszoWUw4aFasHOm
	ecAbVWDgq4qI3zJlx3DaMHxzcSA4XV6BZQXsecVIEN2kkt7wAREG2wsrnl8//mh6B8VtV9UZUrjs1
	0bjU5iIrXzZ1eGfliS9LDAub9CNzHX0+MzFQ3IU2X5DYqu5gtmGj7SnVkQM7hsDAJ2/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCimr-002dXy-6K; Mon, 11 Dec 2023 17:05:41 +0100
Date: Mon, 11 Dec 2023 17:05:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add support for LED's on RTL8168/RTL8101
Message-ID: <5c67b0ae-439c-4da0-bb7a-c6b03149d42e@lunn.ch>
References: <bbae1576-63b2-4375-bfe6-f5fa255253ee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbae1576-63b2-4375-bfe6-f5fa255253ee@gmail.com>

On Thu, Dec 07, 2023 at 03:34:08PM +0100, Heiner Kallweit wrote:
> This adds support for the LED's on most chip versions. Excluded are
> the old non-PCIe versions and RTL8125. RTL8125 has a different LED
> register layout, support for it will follow later.
> 
> LED's can be controlled from userspace using the netdev LED trigger.

Since you cannot implement set_brightness, the hardware only supports
offload, it probably makes sense to add Kconfig to enable the building
of the netdev LED trigger. It seems pointless just having plain LEDs
which can then usable.

	Andrew

