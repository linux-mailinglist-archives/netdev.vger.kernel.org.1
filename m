Return-Path: <netdev+bounces-234910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F8C29B11
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 01:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50E184EDA6F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B71235072;
	Mon,  3 Nov 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYaLF9vz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B51D5174;
	Mon,  3 Nov 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762128030; cv=none; b=G9OUwFOlR1ELxy50eFbTmAskAS0wfd0QaXGPpepxQQ1hQlc4QlWxvec6p1S8abxr376krx2PI572b8QNcNaz0UwBNkdcciDTIMHE6/0FvmKMbMafM6cmG6ribBpvlnw/eFDBg0BR9sigoKSwEyQFheYBjgEx+FPPEwcIU54eJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762128030; c=relaxed/simple;
	bh=sKArpJczTXZn4gEkD3RRmxatwVbJMx07DikxpV7LPNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWSOAmzClm187FujFC3/BXhWJuS+D+cC+ILihoH/H0aTKEzhVgxpmP1/KOadk2yhF0Ps1SxuWZ8OtWbM8c/KsZWfZEoGwfg1KO3oNnLn1zKlc/ks/ARXVRFClcGB9bbcBu9zfUJ6aW+0pnWOXBRolF9+Ap7t/HmjGsfI35tqdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYaLF9vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11A3C4CEF7;
	Mon,  3 Nov 2025 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762128030;
	bh=sKArpJczTXZn4gEkD3RRmxatwVbJMx07DikxpV7LPNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYaLF9vzxITnZLSiZdOa2kdpYOS+Wvz2k29Lrf6dE2KQTQFmG67vYu+NDGjAz9P+j
	 z8mBxFbovtljnNO/Gnd89THCojmyh5nj1nGEkFlxmCo61VhgOUcASZtqOv+4zyaMPb
	 JvUZYYOr8lSXWixVDuLK5+Fa/cI1tOwHzV3e0Ab/c0tDuGxRDDn+mJON4LT3+fx4mk
	 gulDRL4IYaNwDSPaHs7QGGJpbVSx41ba17bbUb/ohM+kFRezmCMN/ywBWHKz62Zv6+
	 nI1MMVHxWM2KIXdOiBDv8SNl2IjVfNXLHTJsreoXh6aUq0Q3Tx2VsnkE4Hc2kBPtiF
	 E6/T5U58IlQNA==
Date: Sun, 2 Nov 2025 16:00:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: ocp: Add newline to sysfs attribute output
Message-ID: <20251102160028.42a56bfb@kernel.org>
In-Reply-To: <aef3b850-5f38-4c28-a018-3b0006dc2f08@linux.dev>
References: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
	<20251031165903.4b94aa66@kernel.org>
	<aef3b850-5f38-4c28-a018-3b0006dc2f08@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Nov 2025 23:45:00 +0000 Vadim Fedorenko wrote:
> On 31/10/2025 23:59, Jakub Kicinski wrote:
> > On Thu, 30 Oct 2025 20:45:19 +0800 Zhongqiu Han wrote:  
> >> Append a newline character to the sysfs_emit() output in ptp_ocp_tty_show.
> >> This aligns with common kernel conventions and improves readability for
> >> userspace tools that expect newline-terminated values.  
> > 
> > Vadim? Is the backward compat here a concern?  
> 
> Well, unfortunately, this patch breaks software we use:
> 
> openat(AT_FDCWD, "/dev/ttyS4\n", O_RDWR|O_NONBLOCK) = -1 ENOENT (No such 
> file or directory)
> newfstatat(AT_FDCWD, "/etc/localtime", {st_mode=S_IFREG|0644, 
> st_size=114, ...}, 0) = 0
> write(2, "23:40:33 \33[31mERROR\33[0m ", 2423:40:33 ERROR ) = 24
> write(2, "Could not open sa5x device\n", 27Could not open sa5x device
> 
> So it looks like uAPI change, which is already used...
> 

Zhongqiu Han please consider sending a patch to add a comment above 
the unfortunate emit() explaining that we can't change it now.
I get the feeling that otherwise this "fix" may resurface.
-- 
pw-bot: cr

