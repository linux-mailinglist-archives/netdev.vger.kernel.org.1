Return-Path: <netdev+bounces-146059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16D9D1DA8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4289EB20C83
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3012EBE9;
	Tue, 19 Nov 2024 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqJ8t5mi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE5E56A;
	Tue, 19 Nov 2024 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981345; cv=none; b=iWyT5d5+PNFqQ0mzUJmFNIPMU5Jic7Ioyjv2vzbSQaY3ALayrcLvJUxegImO+8ZyQL4v0+SleUfIqB5GyfpiKiKy9bKFsCf1Q6Lowgg8hZgkosa2M2Y6CicR/fgE/ohuRci+49PNSetcmiAhFSRY7Cx3HIShKhZW1MzGc4c/88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981345; c=relaxed/simple;
	bh=ZPJK+nk8hgdsklI/K/2mlQ2j6dlpYyZucUmE40Y6YVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aR46k/49Adzdbc7egubzQI24L35yWOg+V4ei64BN/Ha4E+TJZKzoNTah+z46hsSTMGyWTSYeYl+ZCZl8SZeS4/om07OxyrclZQDSRA9PUcdc+6NnO2dzQnK6W3z293snm0gUBSMgfXQXRyaSztXlsq8Nq2Cj05y/Rk971ujx2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqJ8t5mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410B8C4CECC;
	Tue, 19 Nov 2024 01:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731981344;
	bh=ZPJK+nk8hgdsklI/K/2mlQ2j6dlpYyZucUmE40Y6YVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tqJ8t5mic1QVFCR2B5E58FQO0uOQLvY+D1C0rtU3bI/yms+Ba6oXxpXDTfTd60Y9l
	 r3bpU3X7EJx1cA7NWaH3Wp1HfjuHVKsRP3STZYARtme5OC3MFKMxhsQpFMbk72Kggu
	 trnyCDdaRkhnL8utDYJaT1JSnemPfvqgb44y0UBVTGj3ESgpJHP4zJA9KOzoQEvN8Z
	 QsU9prxVPQkl4t/AtPDstliT7Xk3zlIoI2fqy8nyA0im9+S4D/3DTTTVR2AlFExjBN
	 z2vuCp796q54cObr/0baHz7gzbhOQ346262NPqUv6tp2wM5X+v1oj4Of2xN+vKUS5k
	 amOrddSNXTGXg==
Date: Mon, 18 Nov 2024 17:55:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: sysfs: also pass network device driver
 to uevent
Message-ID: <20241118175543.1fbcab44@kernel.org>
In-Reply-To: <20241116163206.7585-2-mail@tk154.de>
References: <20241115140621.45c39269@kernel.org>
	<20241116163206.7585-1-mail@tk154.de>
	<20241116163206.7585-2-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 17:30:30 +0100 Til Kaiser wrote:
> Currently, for uevent, the interface name and
> index are passed via shell variables.
> 
> This commit also passes the network device
> driver as a shell variable to uevent.
> 
> One way to retrieve a network interface's driver
> name is to resolve its sysfs device/driver symlink
> and then substitute leading directory components.
> 
> You could implement this yourself (e.g., like udev from
> systemd does) or with Linux tools by using a combination
> of readlink and shell substitution or basename.
> 
> The advantages of passing the driver directly through uevent are:
>  - Linux distributions don't need to implement additional code
>    to retrieve the driver when, e.g., interface events happen.
>  - There is no need to create additional process forks in shell
>    scripts for readlink or basename.
>  - If a user wants to check his network interface's driver on the
>    command line, he can directly read it from the sysfs uevent file.

Thanks for the info, since you're working on an open source project 
- I assume your exact use case is not secret, could you spell it 
out directly? What device naming are you trying to achieve based on
what device drivers? In my naive view we have 200+ Ethernet drivers 
so listing Ethernet is not scalable. I'm curious what you're matching,
how many drivers you need to list, and whether we could instead add a
more general attribute...

Those questions aside, I'd like to get an ack from core driver experts
like GregKH on this. IDK what (if any) rules there are on uevents.
The merge window has started so we are very unlikely to hear from them
now, all maintainers will be very busy. Please repost v3 in >=two weeks
and CC Greg (and whoever else is reviewing driver core and/or uevent
changes according to git logs).
-- 
pw-bot: defer

