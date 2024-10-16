Return-Path: <netdev+bounces-136158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE799A09D3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91211F266E0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC70208D6C;
	Wed, 16 Oct 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NB23OE8e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C0208967;
	Wed, 16 Oct 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081814; cv=none; b=MnRf7OXQRQYeAbgSlAGQ/rn8h3VhLgLXRwgFkw/NesuoqKAOKpBts1oDHftWfkuSIJ57rlIeeNNBJ7ZqGmqCnCNGBRnmgyvyJU7m6k83aiqaeFgLMMJy/zaWw1LRir2U57n9R8/gdPi0wqQx+TnW/bK8uE1CCFDYS8pf3397Ubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081814; c=relaxed/simple;
	bh=yfronMD/0sqfo2W00JFpXL5mPjECoj5aRC+oS3N63mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktYIojXQ2V38mbMadBKei/gthZeC0Iq0aPPftdTscwyPj1bLHnd//L37zxVCHiAcrUp9pyZgZ3I1b8Lbx4kAhmfd7wT9fW40MQCBrI/q+15TGr7BBZSHX6GYqI9kckSS1sJtRBott7zN6Zvx+86up0YKGADeeHPM0YeNoCND0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NB23OE8e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VNZ0CnDCnif96FdXN4ThyG+lS+ftdhJNbhPPcNy6QXc=; b=NB23OE8ecI35qBQzMsiWAwzS8I
	Q3DXbhMQ5cZqFFB+tHlV66LdfpBpb5kPNH0C6Z1lW1FWd7OieuaHYyVT+uD3/hao45L2HdnzaIXVW
	zYpX0A0lKs9Cs1ATafGTIPVOBHmWVeBI/QNvNDQwUNPAOc/0TKyMSgMw6Gu6jM6lEi5c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t13AA-00A9Nv-4e; Wed, 16 Oct 2024 14:30:02 +0200
Date: Wed, 16 Oct 2024 14:30:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 4/5][next] uapi: net: arp: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <ac2ea738-09fb-4d03-b91c-d54bcfb893c6@lunn.ch>
References: <cover.1729037131.git.gustavoars@kernel.org>
 <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>

On Tue, Oct 15, 2024 at 06:32:43PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Address the following warnings by changing the type of the middle struct
> members in a couple of composite structs, which are currently causing
> trouble, from `struct sockaddr` to `struct sockaddr_legacy`. Note that
> the latter struct doesn't contain a flexible-array member.
> 
> include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Also, update some related code, accordingly.
> 
> No binary differences are present after these changes.

These are clearly UAPI files. It would be good to state in the commit
message why this is a safe change, at the source level.

Could user space code expect the type struct sockaddr and we are going
to get warnings when struct sockaddr_legacy is found? Have you tried
compiling an old arp binary, one that uses the IOCTL? The netfilter
code also references it:

http://charette.no-ip.com:81/programming/doxygen/netfilter/structarpreq.html

You also need to submit a patch to the man page:

https://man7.org/linux/man-pages/man7/arp.7.html

You might also want to build some Rust code:

https://docs.diesel.rs/master/libc/struct.arpreq.html

I've no idea what Rust does when a C structure has a type change.

	Andrew

