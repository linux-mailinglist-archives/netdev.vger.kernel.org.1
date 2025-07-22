Return-Path: <netdev+bounces-209076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B074AB0E2BA
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EF7563EF5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970827E7DD;
	Tue, 22 Jul 2025 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bSgLNiBV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106919D082;
	Tue, 22 Jul 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206077; cv=none; b=PYT3IQUIb5HsJ2MRY7Rau6WobCyszjRnZbCaDskopBXtawzKhvARKLPwxyAgcJqtYZj4hRkwfxsNXNhWslqpcRkTyQkYB7k+kZIs0XhNE/TBhPrxFF+waOfYkeN8SWcfJfWPZ11D+MBVpGDKQ0sXWopQsCyojz0kJk9+9+IvL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206077; c=relaxed/simple;
	bh=skUXd2YpZcbtREi+ucT+2NZdJ3FgLZdJLotsihlVZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iytS8x2yR5Ew8Fe9iXUQsG2UdSIRnWz7dGyRXRVgjdLEQnEdRpPKuVSlTY/KWLLTfTOEnXxoTZtniMkQvQwPhdal7VIAO0okkZeblMQxsn3oytIIez1pr5W4sNbHgjK0l6V46I0WBWPMWpJN2/3VUUXPG5zWqxwScvU/VdFAb7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bSgLNiBV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pgop0txGfgW9l2DjzVuSEIR9yTyTyHdsNlzGiM7qYPo=; b=bSgLNiBV49l/s1yUKU36xZZRw5
	yKcx50prGOU/c13C+7MlLpp48sGhntPPIcsjIh+yDt7CePH+MtDSkLpTIQW5JLXI+4OQ+XCgLorj5
	Yq3Jg4FzRMCm2siGT5SObmqF2EjWZI2+ifCodMvoB328VzjoGg6J+YC8bmGChDIFf298=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueGz7-002UfS-Ri; Tue, 22 Jul 2025 19:41:01 +0200
Date: Tue, 22 Jul 2025 19:41:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kees Cook <kees@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next] net: Document sockaddr safety in ARP and
 routing UAPI structures
Message-ID: <7577b0f5-2b43-4e5d-89fe-7129c32acb47@lunn.ch>
References: <20250722165836.work.418-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722165836.work.418-kees@kernel.org>

On Tue, Jul 22, 2025 at 09:58:37AM -0700, Kees Cook wrote:
> Add documentation clarifying that ARP and routing UAPI structures are
> constrained to IPv4-only usage, making them safe for the coming fixed-size
> sockaddr conversion (with the 14-byte struct sockaddr::sa_data). These
> are fine as-is, but their use was non-obvious to me, so I figured they
> could use a little more documentation:
> 
> - struct arpreq: ARP protocol is IPv4-only by design
> - struct rtentry: Legacy IPv4 routing API, IPv6 uses different structures

I'm not sure this second statement is strictly true:

https://elixir.bootlin.com/linux/v6.15.7/source/net/appletalk/ddp.c#L918
atrtr_ioctl() ->
  atrtr_create()->
	struct sockaddr_at *ta = (struct sockaddr_at *)&r->rt_dst;

where:

struct sockaddr_at {
	__kernel_sa_family_t sat_family;
	__u8		  sat_port;
	struct atalk_addr sat_addr;
	char		  sat_zero[8];
};

This is not an IPv4 address.

Maybe this does fit with a 14 byte sockaddr::sa_data, so it is not an
issue, but the comment and commit message should be expanded to
explain this. And i only looked at the first SIOCADDRT i came across,
there are many other protocols using this ioctl.

	Andrew

