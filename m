Return-Path: <netdev+bounces-119199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE2C954B0F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252061C221B2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BD1BA863;
	Fri, 16 Aug 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzToxFYx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B211B86F4
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814740; cv=none; b=nv+PPPnwQLl3ORaxx4IjvAdG3lxtb+OIHRC8YLNpDCl9ctnRL6Q+9O8XqCBG2QUz2C96NC9ivcIKukkhGdNrSIyYltAvDzDUQb1xYmycwVlXrkanb85AdrjHUv+ftdyf/4hbIG+hRHh1vhM5UTyXLMEXXYm54VhYHt+IUp3SQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814740; c=relaxed/simple;
	bh=buqIM6cmtz01DOl66zVlmANOy0UktAp60zFZ35ghZYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxGuWLN7uxrJkDGkHGImz1qfz0dVyX61l0TegRdGbJwZFtV9tkt6myknI99CvGIFrd0bTm5SvV7vtw4hEshUuy+tlGeTqviiaXrdQPKxv0goPEgLmIK56Johsfjs+FTHlXFWhtUiruGNWSBowntx7yKp/cqKWnz9chFj2F9THAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzToxFYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8861AC4AF09;
	Fri, 16 Aug 2024 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723814739;
	bh=buqIM6cmtz01DOl66zVlmANOy0UktAp60zFZ35ghZYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzToxFYxDjFDwUAZZ+pKcraqIpnYmsLdYY9HLXzyu0vNcxXsAP+JydbYPL2rbqtZh
	 +k2GUciD7pXbV90L2mfJ/ZRTAElIhqxDH2DzwJpyzlw5QgakzZkWZKiTX51v1J9XkN
	 SABwF16bOdSi0JWd9F0FOIhLYW8HIPvXjHtUwoPOaGI1UZvbGnjW8u4RbzoelpYdea
	 PaAF/LsqdQtPIoYOs9m6/DQW8Z132fNNR35dt6lCXpfsezvfRBrUS/GD40yqDUdU/1
	 ll2S6Uk76bejhyB2iCMYotiq/1PoLCYHvkv/NRsApmoQObK/8E4c3cDwkRvEDMcTfc
	 cgRH7na1xlK0Q==
Date: Fri, 16 Aug 2024 14:25:35 +0100
From: Simon Horman <horms@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
	Guo-Fu Tseng <cooldavid@cooldavid.org>,
	Moon Yeounsu <yyyynoom@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH net 3/4] MAINTAINERS: Add header files to NETWORKING
 sections
Message-ID: <20240816132535.GA1368297@kernel.org>
References: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
 <20240816-net-mnt-v1-3-ef946b47ced4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-net-mnt-v1-3-ef946b47ced4@kernel.org>

On Fri, Aug 16, 2024 at 01:38:02PM +0100, Simon Horman wrote:
> This is part of an effort to assign a section in MAINTAINERS to header
> files that relate to Networking. In this case the files with "net" or
> "skbuff" in their name.
> 
> This patch adds a number of such files to the NETWORKING DRIVERS
> and NETWORKING [GENERAL] sections.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

...

> @@ -15939,14 +15944,31 @@ F:	include/linux/framer/framer-provider.h
>  F:	include/linux/framer/framer.h
>  F:	include/linux/in.h
>  F:	include/linux/indirect_call_wrapper.h
> +F:	include/linux/inet.h
> +F:	include/linux/inet_diag.h
>  F:	include/linux/net.h
> +F:	include/linux/netdev_features.h
>  F:	include/linux/netdevice.h
> +F:	include/linux/netlink.h
> +F:	include/linux/netpoll.h
> +F:	include/linux/rtnetlink.h
> +F:	include/linux/seq_file_net.h
>  F:	include/linux/skbuff.h
> +F:	include/linux/skbuff_ref.h
>  F:	include/net/
> +F:	include/uapi/linux/genetlink.h
> +F:	include/uapi/linux/hsr_netlink.h
>  F:	include/uapi/linux/in.h
> +F:	include/uapi/linux/inet_diag.h
> +F:	include/uapi/linux/nbd-netlink.h
>  F:	include/uapi/linux/net.h
>  F:	include/uapi/linux/net_namespace.h
> +F:	include/uapi/linux/net_shaper.h

Sorry, net_shaper.h doesn't exist upstream, but must have in my local
tree when I prepared this. I'll send a v2 in due course.

...

-- 
pw-bot: cr

