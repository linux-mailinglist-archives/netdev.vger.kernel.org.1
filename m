Return-Path: <netdev+bounces-47198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D37E8C3D
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 20:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7957280E08
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FAC1C2A0;
	Sat, 11 Nov 2023 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug3a1cTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733091C291
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 19:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9099C433C8;
	Sat, 11 Nov 2023 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699729464;
	bh=iYQFwh5+IIpF99lTnlvVJt5beNunYYtggsBe/pgfojo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ug3a1cTmso2Gm6DajGgHAjciWxcmCZW0OIN00/SNgBh4xKYycCcKEz3jGpkRXrJec
	 c3Kqr77Go82mMEeXJOWUhQ4XClNB8Af2M9Yr5IXCCAWz7BLrBnz89viQIlOPpMvoo0
	 aM8juvTGIIVpNuU/gykgFXAvNs2GFbKdu2N6Xb3xHErZIpYXea+H7NjUUZpMAsEEBB
	 WKZVHUxAEv0DzfziSzDOHl1O9WfwnhQsuAgFxQF//Wp087s6sLGq0FRFSgxLpKR6sE
	 XRVZP5OnWOLkHdIThdDtKno+PhfTXYivYVgFFieWaIlPEao+N4XLRVRo8WMGLBAVp5
	 0VTxJqVVPGMXQ==
Date: Sat, 11 Nov 2023 19:04:14 +0000
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCHv3 net-next 02/10] net: bridge: add document for
 IFLA_BRPORT enum
Message-ID: <20231111190414.GC705326@kernel.org>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-3-liuhangbin@gmail.com>
 <20231111190237.GB705326@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111190237.GB705326@kernel.org>

On Sat, Nov 11, 2023 at 07:02:37PM +0000, Simon Horman wrote:
> On Fri, Nov 10, 2023 at 06:15:39PM +0800, Hangbin Liu wrote:
> > Add document for IFLA_BRPORT enum so we can use it in
> > Documentation/networking/bridge.rst.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  include/uapi/linux/if_link.h | 227 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 227 insertions(+)
> > 
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> > index 32d6980b78d1..a196a6e4dafb 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -792,11 +792,238 @@ struct ifla_bridge_id {
> >  	__u8	addr[6]; /* ETH_ALEN */
> >  };
> >  
> > +/**
> > + * DOC: The bridge mode enum defination
> 
> nit: definition.
> 
> Also in patch 2/10.

Sorry, I meant that this is also present in 1/10.

> And fields is misspelt in patch 4/10.
> 
> As flagged by checkpatch --codespell
> 
> ...
> 

