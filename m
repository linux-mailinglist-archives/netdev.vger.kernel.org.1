Return-Path: <netdev+bounces-138301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E249ACE63
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051191F22857
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E112BF02;
	Wed, 23 Oct 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG+6cHH1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A352EAEA;
	Wed, 23 Oct 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696516; cv=none; b=SPEZKBNUp2UtM6GGsLUI8lZLrNLrqP8u50MXbrFik80tHeJB6NiTqV6/Sn0Hp54alPl3Dya/pO3YZ/UDSLf4dZT0pXJ8ti2dUa1PIfgTXB6W8rwl25/4WiIKQJLVQgI3s/oLCkErZ1heJ27IolnA+33DlrOwXg526bsbj5SRrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696516; c=relaxed/simple;
	bh=eN8F/lNDkjIAfUB0JM4j0vPqOsiKHYVixWKxi/Pt1pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gn+RZ7qDvbYDGbuV+G+eVvS4Y2882z+6tQyS62+Laue0ZGMRlO89H1bvSeZUkmvW1oyYU1NaRWhhz7ARMh4yCOYcKPtjEeVxEWA8WhqQA+2zQe4xyS+sQzW2USCxVIqlOAHTwZyZQbZ2WPNzn0VgnQ1zzlYgbErETHuzTbUKrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG+6cHH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10073C4CEC6;
	Wed, 23 Oct 2024 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729696516;
	bh=eN8F/lNDkjIAfUB0JM4j0vPqOsiKHYVixWKxi/Pt1pQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TG+6cHH1+2xLbh2vi1zJtsnou/pAIZQLsuo22e4xHmh/goTCkLgpGqDRnV5Lu7/cz
	 sJgGvRBpKTwqq+GbMRNbQY+7iVfUHEsDh1tVqS5ya6Httoz9alp1HUi+Ue7IZcslAW
	 dauJSlRUKWwnZpFOe441ybpb5NI67PvFbMRdwI+dHotS8+cOizF2/a7gmucWmxepOJ
	 j+BkzNm7tMF0K8W2H+cWyYkyc3jqunBWpKB9m2wYWXPCU0ssaWQxLHmYfG8eKdufh4
	 Xngd8gMBsw34e+MbFQidmS7VTdwFiUlkFOzMd9++PXJbh6HSNNVdaRKmmUSGlCx63c
	 b9C1xODOKVipQ==
Date: Wed, 23 Oct 2024 10:15:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
	corbet@lwn.net, linux-mediatek@lists.infradead.org,
	danielwinkler@google.com, korneld@google.com,
	Jinjian Song <songjinjian@hotmail.com>
Subject: Re: [net-next,RESEND v6 2/2] net: wwan: t7xx: Add debug port
Message-ID: <20241023151514.GA888712@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021121934.16317-3-jinjian.song@fibocom.com>

On Mon, Oct 21, 2024 at 08:19:34PM +0800, Jinjian Song wrote:
> From: Jinjian Song <songjinjian@hotmail.com>
> 
> Add support for userspace to switch on the debug port(ADB,MIPC).
>  - ADB port: /dev/wwan0adb0
>  - MIPC port: /dev/wwan0mipc0
> 
> Application can use ADB (Android Debg Bridge) port to implement
> functions (shell, pull, push ...) by ADB protocol commands.
> E.g., ADB commands:
>  - A_OPEN: OPEN(local-id, 0, "destination")
>  - A_WRTE: WRITE(local-id, remote-id, "data")
>  - A_OKEY: READY(local-id, remote-id, "")
>  - A_CLSE: CLOSE(local-id, remote-id, "")

s/Debg/Debug/

> Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
> 
> Application can use MIPC (Modem Information Process Center) port
> to debug antenna tunner or noise profiling through this MTK modem
> diagnostic interface.

s/tunner/tuner/

> +++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
> @@ -67,6 +67,28 @@ Write from userspace to set the device mode.
>  ::
>    $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
>  
> +t7xx_port_mode
> +--------------
> +The sysfs interface provides userspace with access to the port mode, this interface
> +supports read and write operations.

This file is not completely consistent, but 90% of it fits in 80
columns, so I would make your additions fit also.

