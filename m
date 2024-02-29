Return-Path: <netdev+bounces-76157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011386C97C
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75201F22EA9
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC887D073;
	Thu, 29 Feb 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9XZ4aHb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C637D087
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211016; cv=none; b=rxfO0CgKA7KRkODWGiCv4OPElPeQigm9PBXcUyOXwwLuNO7iSZ0bKzXhdcq7mkJF+t+PSgYXXxdf/q47B4DgI7T+wiTzhdqm0P8oUhooW8K88OKIKbdKRYgTrA9XHxRaaT3GpI4pPuSPyYWxOxuGJsWQkMq92aYmMMxdQpXKVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211016; c=relaxed/simple;
	bh=yWBiPZBP1pLHrN9GMIjis+iyHdJlNo9ZETACrRUvXB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmqK9feVT8ZtvCk7KAKNjPm0Bd/imV7hxU5pXUzIh/jQUheUL5VSGG3+GV6JlpbhbKRGJFYSJrXrYLQdavHDjNAfiBgFs66oEcfZ3wB9BplSzZWdHYdEWckMAJQcP71UVfEfNYF4abpIIr5k5aJM/79j1LzDXfLHOIg606Kyxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9XZ4aHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C811C433C7;
	Thu, 29 Feb 2024 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709211015;
	bh=yWBiPZBP1pLHrN9GMIjis+iyHdJlNo9ZETACrRUvXB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a9XZ4aHbHdIyCSuLA7CmP2klbPnow5/Cx3qsEq7Dr1UJ/vxZZM+LE+YQHAwTUH0yi
	 CTNbyZz1rpArslRNzg8AVgEj7WCvxNHFFDWXzDPga3K3qLHTMbbTs/MqC+LdgssBin
	 /AIMmuOuKEgMHYhHN4vC+ee7A5RoP3y+UQn+rOIC2rZ75C4cx6SZovZTBuxVTRSCVI
	 5VJM2pN3lcrD7pPi5ON8bg0/2PqN7EwFX9jdNGrr6TKq9sp4A8yRjJiWw4mxPqUBCi
	 zJUc8199SyijDbT3MQJ9JdUq22yRk9ApqRUaurwQsxF/2zzKDXrkVwjjpyqtT29rlA
	 SjWz6GynINMLw==
Date: Thu, 29 Feb 2024 13:50:10 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Frank Wunderlich
 <frank-w@public-files.de>, Daniel Golle <daniel@makrotopia.org>,
 netdev@vger.kernel.org, Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH RFC net-next 1/6] net: phy: realtek: configure SerDes
 mode for rtl822x/8251b PHYs
Message-ID: <20240229135010.74e4304a@dellmb>
In-Reply-To: <Zd27FaFlVqaQVV9B@shell.armlinux.org.uk>
References: <20240227075151.793496-1-ericwouds@gmail.com>
	<20240227075151.793496-2-ericwouds@gmail.com>
	<Zd27FaFlVqaQVV9B@shell.armlinux.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 10:36:05 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> > +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
> > +	if (ret < 0)
> > +		return ret;  
> 
> It would be nice to know what this is doing.

No documentation for this from Realtek, I guess this was just taken
from SDK originally.

Marek

