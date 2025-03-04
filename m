Return-Path: <netdev+bounces-171719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D2CA4E54D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5DF421D90
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04242BD58E;
	Tue,  4 Mar 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqs6XRRz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F72BD58B;
	Tue,  4 Mar 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103341; cv=none; b=IL4kGWw+0RcPn/qvWrq1RoYRjoDytK7lSxkpiWAJgi4gt80i8Ti6+Uv/ryr8Tfy0x7ef/ABsIJMMLqAYO4AhYh4fibkGmKIttw0U+U7jfVjRrX27nHON+2V/v9jad6lxZylbqpdYiQCzEOR8q73I+zh/t2XyC/va11eNEFpg2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103341; c=relaxed/simple;
	bh=dZLruTUCD5U5xh33M4MnNCFbcQYK/v+EyNvVYHwt63s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOH1ub+9LQAxhSsc3JVmM2tV0BLFEAbAY8/Q1SOuefdkFpOuS1mmey7etn6feUrIzPYJh/mQYJ9/ViSKKr4mb+UjRnP8LYhLZRKW0n/h+PTjVTf4gBH3dZXQen4Bp/lFfzlJb2wPvhOPKK0dcV36IsRmx472DgofE3RpaR8V/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqs6XRRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3A4C4CEE7;
	Tue,  4 Mar 2025 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741103341;
	bh=dZLruTUCD5U5xh33M4MnNCFbcQYK/v+EyNvVYHwt63s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fqs6XRRz7cDZKvbOkSkmrcoVKOvzTesdFWxUiWr0erLvbX0vR0pfydFwwg81AY6D/
	 dMbPwoXfOsTS8C+vvzANSHzwZrime2m2uA5nvVcscvjK9sZ5vK+ib9wNM0JZq193JQ
	 pXwcyOzFeiP0OdkHO8NS+v1xYdeXAAQ82LhkvxQ+arNhwbDsSuM6XQ+1fW3YIEBgOb
	 zqbJnDF7e5tmKJrT1v+GIbeCsWr39y3CQoZo0YVQhAjdqxSf9KVROjvqrsC1srLxKy
	 gSbDqPhtK32apyXRge/scbKl+bjURE9PSiEVFuCwRes0ef995jDbDlRTgYXySolKgQ
	 N5qaJ7bvDMZZw==
Date: Tue, 4 Mar 2025 15:48:56 +0000
From: Simon Horman <horms@kernel.org>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v3 00/14] net:yt6801: Add Motorcomm yt6801 PCIe
 driver
Message-ID: <20250304154856.GF3666230@kernel.org>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>

On Fri, Feb 28, 2025 at 06:00:06PM +0800, Frank Sae wrote:
> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
>  and adding yt6801 ethernet driver entry in MAINTAINERS file.
> YT6801 integrates a YT8531S phy.
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>

...

> Frank Sae (14):
>   motorcomm:yt6801: Implement mdio register
>   motorcomm:yt6801: Add support for a pci table in this module
>   motorcomm:yt6801: Implement pci_driver shutdown
>   motorcomm:yt6801: Implement the fxgmac_init function
>   motorcomm:yt6801: Implement the .ndo_open function
>   motorcomm:yt6801: Implement the fxgmac_start function
>   phy:motorcomm: Add PHY_INTERFACE_MODE_INTERNAL to support YT6801
>   motorcomm:yt6801: Implement the fxgmac_hw_init function
>   motorcomm:yt6801: Implement the poll functions
>   motorcomm:yt6801: Implement .ndo_start_xmit function
>   motorcomm:yt6801: Implement some net_device_ops function
>   motorcomm:yt6801: Implement pci_driver suspend and resume
>   motorcomm:yt6801: Add makefile and Kconfig
>   motorcomm:yt6801: update ethernet documentation and maintainer

Hi Frank,

I'd like to suggest the following prefixes for these patches and cover
letter:

* "yt6801: "
* "net: phy: motorcomm: "

