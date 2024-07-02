Return-Path: <netdev+bounces-108452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB5923DEB
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F101F213BF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B537158DD1;
	Tue,  2 Jul 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t43vsudw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAD823DE;
	Tue,  2 Jul 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923586; cv=none; b=VIGSy0HWFnSx0k93ZFugT2ViKNVxeQcMBoVg0HUbsIYCmlyGSAB9qVKzKJEAp3WWQo2HSrAb4KOusk9J4AdMQZfpyKWopc/sJk94OumVyPzEKOdGK6ZjMzKYf6s9uhtLHUDQO5fhbQTKRsOBPFvnnSO5PdUO+t01LtUM8hk09RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923586; c=relaxed/simple;
	bh=UMNRPPt9PhJsy6/LjEyPtPY6Zn6NcX2Hd5gZp8FqghM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2/Mv6M4wVMOOGS0xvLgZm82UoUCwST0eKyquD8iSznGUhqh33zzPrSPemW9FU//yqSr3BmmroHswRS+NrDMcZsBa09H9BL9f21AOMAANEwLG6zLiv02rBQe/BZczikIQpICHYyPF4g85cI4HAiVDyfGf41BiSDb24O7VvGdTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t43vsudw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B173FC116B1;
	Tue,  2 Jul 2024 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719923585;
	bh=UMNRPPt9PhJsy6/LjEyPtPY6Zn6NcX2Hd5gZp8FqghM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t43vsudw8dFkFnBRaBykTZItXK48dv+SfbBqmMoxaiV5RjvZrpo/rYX2Xtal8WNGg
	 i0DQn2RkEySDY2lIGLwPMEoIMJ695Z5i3MtOe2mW25efGe2isLwbnFaujByjnNTFwm
	 UQsbfQkZlxFC/CiQ357VPmUlTmbQBJ7PN2b4XMVPrtlIkaWYunqqg1B3RH8Rypna01
	 drEOlyKUQCVZu2JT06WUuUxeFYXp1/21kgqrGTIMF0CHYI+TcLwEL6FT79VZ7HZg8U
	 gvNEXbD/1aSRtX+58d3CZR8d0mIq+9x9OFhwjBc9/956j+QCDWIYFVvg22GTwij92H
	 De8W2kRKuGZrw==
Date: Tue, 2 Jul 2024 13:33:01 +0100
From: Simon Horman <horms@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org, Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v7 05/10] net: openvswitch: add
 psample action
Message-ID: <20240702123301.GH598357@kernel.org>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
 <20240630195740.1469727-6-amorenoz@redhat.com>
 <f7to77hvunj.fsf@redhat.com>
 <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
 <20240702093726.GD598357@kernel.org>
 <447c0d2a-f7cf-4c34-b5d5-96ca6fffa6b0@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <447c0d2a-f7cf-4c34-b5d5-96ca6fffa6b0@ovn.org>

On Tue, Jul 02, 2024 at 11:53:01AM +0200, Ilya Maximets wrote:
> On 7/2/24 11:37, Simon Horman wrote:
> > On Tue, Jul 02, 2024 at 03:05:02AM -0400, Adrián Moreno wrote:
> >> On Mon, Jul 01, 2024 at 02:23:12PM GMT, Aaron Conole wrote:
> >>> Adrian Moreno <amorenoz@redhat.com> writes:
> > 
> > ...
> > 
> >>>> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > 
> > ...
> > 
> >>>> @@ -1299,6 +1304,39 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
> >>>>  	return 0;
> >>>>  }
> >>>>
> >>>> +#if IS_ENABLED(CONFIG_PSAMPLE)
> >>>> +static void execute_psample(struct datapath *dp, struct sk_buff *skb,
> >>>> +			    const struct nlattr *attr)
> >>>> +{
> >>>> +	struct psample_group psample_group = {};
> >>>> +	struct psample_metadata md = {};
> >>>> +	const struct nlattr *a;
> >>>> +	int rem;
> >>>> +
> >>>> +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
> >>>> +		switch (nla_type(a)) {
> >>>> +		case OVS_PSAMPLE_ATTR_GROUP:
> >>>> +			psample_group.group_num = nla_get_u32(a);
> >>>> +			break;
> >>>> +
> >>>> +		case OVS_PSAMPLE_ATTR_COOKIE:
> >>>> +			md.user_cookie = nla_data(a);
> >>>> +			md.user_cookie_len = nla_len(a);
> >>>> +			break;
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>> +	psample_group.net = ovs_dp_get_net(dp);
> >>>> +	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
> >>>> +	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> >>>> +
> >>>> +	psample_sample_packet(&psample_group, skb, 0, &md);
> >>>> +}
> >>>> +#else
> >>>> +static inline void execute_psample(struct datapath *dp, struct sk_buff *skb,
> >>>> +				   const struct nlattr *attr) {}
> >>>
> >>> I noticed that this got flagged in patchwork since it is 'static inline'
> >>> while being part of a complete translation unit - but I also see some
> >>> other places where that has been done.  I guess it should be just
> >>> 'static' though.  I don't feel very strongly about it.
> >>>
> >>
> >> We had a bit of discussion about this with Ilya. It seems "static
> >> inline" is a common pattern around the kernel. The coding style
> >> documentation says:
> >> "Generally, inline functions are preferable to macros resembling functions."
> >>
> >> So I think this "inline" is correct but I might be missing something.
> > 
> > Hi Adrián,
> > 
> > TL;DR: Please remove this inline keyword
> > 
> > For Kernel networking code at least it is strongly preferred not
> > to use inline in .c files unless there is a demonstrable - usually
> > performance - reason to do so. Rather, it is preferred to let the
> > compiler decide when to inline such functions. OTOH, the inline
> > keyword in .h files is fine.
> 
> FWIW, the main reason for 'inline' here is not performance, but silencing
> compiler's potential 'maybe unused' warnings:
> 
>  Function-like macros with unused parameters should be replaced by static
>  inline functions to avoid the issue of unused variables
> 
> I think, the rule for static inline functions in .c files is at odds with
> the 'Conditional Compilation' section of coding style.  The section does
> recommend to avoid conditional function declaration in .c files, but I'm not
> sure it is reasonable to export internal static functions for that reason.
> 
> In this particular case we can either define a macro, which is discouraged
> by the coding style:
> 
>  Generally, inline functions are preferable to macros resembling functions.
> 
> Or create a static inline function, that is against rule of no static
> inline functions in .c files.
> 
> Or create a simple static function and mark all the arguments as unused,
> which kind of compliant to the coding style, but the least pretty.

Hi Ilya,

I guess I would lean towards the last option.
But in any case, thanks for pointing out that this is complex:
I had not realised that when I wrote my previous email.

