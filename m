Return-Path: <netdev+bounces-96963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C628C8761
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53121C214FA
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8785577E;
	Fri, 17 May 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kIYLngtL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F151C59;
	Fri, 17 May 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953242; cv=none; b=tdkFAJY75DDFloo3ckTLRZ0fqF1VXZK9gMylDqAOrqFeQaeG29oI4dHyBwqlUsD9wfOs9arQkiiqnuC1VnvQaOKWxu2S0SJM2TcB6slNWY+01BN2sycJH71LtgvTRR5ur+inNpkX/6JNJZSDuU3Tf+LOGvDjH+uTEwg1RbZuoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953242; c=relaxed/simple;
	bh=jRB4DFDYIgGJdog/TnNTKHjvMVc/J5rFjPzWCkUQzpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPvmrZiH2XiKvldhjkUzFNQXUVVG4whyhMgrAMKeseB8nB8ic8KJ+oZ0SGjjxSEHwuvabU2tGxV2bOJIExFFCMMe8bQLz9a+LBmjeDXXif/zpg0Zwq5lfXpwUICU4nn/amz9e/h35qqAhi1iu6sWhS76BncDDWNm2NQjwEtsX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kIYLngtL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d4NSt8RefTI8xT6Xm8e0JVcpnTT5ymNkrmyBhHQ984g=; b=kIYLngtLoL2ffYbNAMhv6HONKg
	4mmqTLZ9WVVwTLHprILWTGi5/Qx3fn1ljw8fYqQ1IwygmqEDXwiEEORycT6rxbUFQW0PO1lb5EodD
	ZufYVGfSwKyq5C1nqG5A/JGfooQk19un/fZlg7FUhJqgMP0q7pkj/5o29ZEj4S1jcgdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7xp3-00FZs2-1P; Fri, 17 May 2024 15:40:33 +0200
Date: Fri, 17 May 2024 15:40:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org,
	rkannoth@marvell.com, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v19 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Message-ID: <a11391f3-4bb4-40a1-8060-ed095014ec0e@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-14-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517075302.7653-14-justinlai0215@realtek.com>

On Fri, May 17, 2024 at 03:53:02PM +0800, Justin Lai wrote:
> Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94fddfcec2fb..5ee95a083591 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19296,6 +19296,13 @@ L:	linux-remoteproc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/tty/rpmsg_tty.c
>  
> +RTASE ETHERNET DRIVER
> +M:	Justin Lai <justinlai0215@realtek.com>
> +M:	Larry Chiu <larry.chiu@realtek.com>

There is no indication that Larry Chiu actually did anything with this
driver. There are no Co-developed: etc. Larry needs to become active
to maintain this entry. If there are no emails from this address in
the next few years, the entry will be removed.

Part of being listed as Maintainer is showing you actually know how to
be a Maintainer, know the code, know the processes, give useful
feedback, and so build a level of respect with the community. So
please be active with respect to this.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

