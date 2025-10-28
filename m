Return-Path: <netdev+bounces-233398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E4C12BA3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD313BA0BC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB18242D84;
	Tue, 28 Oct 2025 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QT11imd/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23AA238D54
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761621146; cv=none; b=Cd2nLDAiM+RYJ3tRLqRAwKCFpS9Yz8aeD9UqeGU4MBYQ6LB0nhvcb/LyP6/KbKyaujcqUK7GG1PXeTbOOUX9wjwEWBwMBt7k3rRmUfrVl7YJK6/Z18xxb16r9GhFOefbBMDhgHvGgX4S1gRkZmmtJwtQbFcV+tTaG5T6g7xQVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761621146; c=relaxed/simple;
	bh=9C9uaHqt09WgAlCImcqTSbXZ8Af4aeOgmDf23bIYbMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzlMULSLuoonQpz/RlKUzRf/p3pqKi6ZEJuYXIdkxqmaMoJfWDsRm0laoAg8bkB4Y4TOJFQ0o4I/2rbBWD+KZbVo7ANDu2Xin2yKgSRX4XF1uFSGatl6+8zMQaQY+XbE1R9JWeDzsH9OdBW5If8jS+UqpGR7cQkIZtJajr/37ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QT11imd/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wxXm9veQgWIgbEFqx+EJk/pWoyvdOy/cJBURUdXhQBo=; b=QT11imd/HN4+HoerZ5CbUXA8SA
	+s+dVqFVJpSrE0wYAuEoIeRUfQmTVbiNYBUUHXf5bXdBFjhC613UhOr9S+/T/ca+vatO2P9y0UXsI
	e8QWk0n/07ecSWHDhi3ga3fnbmqrzR8Js+v/OpKn6Hdb2uAKLm23X5nDI41SkKU5hVPI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDa8A-00CG0t-7S; Tue, 28 Oct 2025 04:12:18 +0100
Date: Tue, 28 Oct 2025 04:12:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 1/8] net: phy: Add support for 25, 50 and
 100Gbps PMA to genphy_c45_read_pma
Message-ID: <691b8687-65ec-44c0-8c19-c3bd8bb6ed2b@lunn.ch>
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133844020.2245037.14851736632255812541.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176133844020.2245037.14851736632255812541.stgit@ahduyck-xeon-server.home.arpa>

>  #define MDIO_PMA_SPEED_2B		0x0002	/* 2BASE-TL capable */
>  #define MDIO_PMA_SPEED_10P		0x0004	/* 10PASS-TS capable */
> +#define MDIO_PMA_SPEED_50G		0x0800	/* 50G capable */

This is 45.2.1.4 PMA/PMD speed ability (Register 1.4) ??

50G is bit 3. So is 0x0800 correct? I think it should be 0x0008.

    Andrew

---
pw-bot: cr


