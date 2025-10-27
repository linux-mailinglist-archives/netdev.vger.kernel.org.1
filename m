Return-Path: <netdev+bounces-233183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDFDC0DF4C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E3254F7965
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF62472BA;
	Mon, 27 Oct 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3wWirdwW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113D248166;
	Mon, 27 Oct 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570098; cv=none; b=ovTvakrb4+8y2Iu8QShoeYR4eltyBhsoRHKPsLwfodoV2udX7Q+9b66eivgmjhf9AISOLokkcr/LDKpCl6TmoyZm2ahAe0u+uxm9PaawBsj2KnoRt7hfdRz6CnJbodtiRhBf6kLVqieY0BKUc4BDC8o4hvpPE5A/dChQ3YcHQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570098; c=relaxed/simple;
	bh=AKKN2c1kBYwMdSjaTh3C9AgUeN+bJF5BFv8aHmXQN2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXuuWc+wgCerXwG5ZzwMuxYWdFlR0u7A2NSoM9X64yUQYNnl/642TWxjNy0bMKfmj1U46cShC0473adVpmGq3FFMDg1JgshBVWcXNpvKW1xbXAhKtwW8AfjM5aB0yJennu78PnQTcW83qLf6jB2IambOUluJLrUUo0ru25CPDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3wWirdwW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eqMmPsbXkPqmT8ZSYhoENewFeCKX7DIxuxmp0MwYrk8=; b=3wWirdwWDGSewTR2fQLrCPlupw
	ymc8Z1nfEg52zHsRzg4YU8MmDkNeOGDTUFhGX75tc7zgeewRctVUTGc+U0tG1A3zjmNrkqITq2Lov
	KBVPQu1fy88izGFYuJQFkiKKf0oYZQUKrsEIiADbOJvXDz/0kIvWJDQQLLiCTrseRp4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDMqm-00CC0J-K2; Mon, 27 Oct 2025 14:01:28 +0100
Date: Mon, 27 Oct 2025 14:01:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul SAGE <paul.sage@42.fr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org, mchan@broadcom.com,
	netdev@vger.kernel.org, pabeni@redhat.com,
	pavan.chebbi@broadcom.com, vinc@42.fr
Subject: Re: Andrew Lunn
Message-ID: <76aaa176-9012-4897-9403-92802610188c@lunn.ch>
References: <6e1641fe-e681-414e-bd51-e20cf511f85a@lunn.ch>
 <20251027095139.399855-1-paul.sage@42.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027095139.399855-1-paul.sage@42.fr>

On Mon, Oct 27, 2025 at 10:51:39AM +0100, Paul SAGE wrote:
> The tg3 currently call eth_platform_get_mac_address to retrieve the
> MAC address from the device tree before trying the mailbox,
> NVRAM and MAC registers.
> However, this function only retrieves the MAC address from the device
> tree using of_get_mac_address.
> 
> We are using device_get_mac_address, which use fwnode to obtain a MAC
> address using the ACPI, so as we understand fwnode is an
> abstraction layer for both the device tree (on ARM) and ACPI (on x86)
> 
> If true, it could be appropriate to replace the call to replace
> eth_platform_get_mac_address with device_get_mac_address. This would
> avoid running the entire function only to later check for a dummy
> address.
> 
> Do you see any regression possible with this change ?

I don't know ACPI too well, DT is more advanced, and i tend to keep to
ARM platforms.

Does ACPI actually have a standardised mechanism for storing MAC
address? Is there anything in the standard?

If you do make use of device_get_mac_address(), how is the MAC address
stored in ACPI?

Documentation/firmware-guide/acpi/dsd/phy.rst says:

  These properties are defined in accordance with the "Device
  Properties UUID For _DSD" [dsd-guide] document and the
  daffd814-6eba-4d8c-8a91-bc9bbf4aa301 UUID must be used in the Device
  Data Descriptors containing them.

Is that what you are doing?

Have you looked through other MAC drivers? Are there any others
getting the MAC address from ACPI? Is it all proprietary, or is there
some standardisation?

If you do decide ACPI is missing this, and you want to move forward,
please also add a document under Documentation/firmware-guide/acpi/dsd
describing it.

	Andrew

