Return-Path: <netdev+bounces-108381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DA6923A40
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CA71C2115E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194491534E1;
	Tue,  2 Jul 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewSxBkWq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6F14D703;
	Tue,  2 Jul 2024 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913052; cv=none; b=LHujjw9egdlpnGepMZ+VDemu+ufXID1Ge7pWN5EUmztA5ECYM90UQ985EazrkXYvgBbejuFbsnIkXKIwCR+Q7K348RQT+CEjOXU164DZL6JSTL6ZmuPGKrrB150cG1kCxuXKf+mdQfG3ApNCMi2CjDyGpreGjZDG12X24ETIv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913052; c=relaxed/simple;
	bh=6IhFm7XiKCtMDYQCE5+DANRsbfrYeKSwTDMNKe7dhFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZtQayL9geSEHC1sidylG1rgIdNQfBuzmzy+MhgfFY9UODs2e5RZl/UuHwaSQBH/xtCl0AB3s52brmlhqPh1EIHx1ZZQTHYGN7YSWqeHF9r31zEguzNxC4/4u+rAJLgUpn1XoQeUsIz0HIg9ObvcHFL7tv5fGimu6EHA/F40/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewSxBkWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDC6C116B1;
	Tue,  2 Jul 2024 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719913051;
	bh=6IhFm7XiKCtMDYQCE5+DANRsbfrYeKSwTDMNKe7dhFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewSxBkWqQwRR2hNghlHxCpQgHohQoIuyNT5/XDJW4Wg1a3deRXFVjJCsPbb5DgtTu
	 mDtTRk9oyREPR3IhT+BKNJTaQgUyG/MkQWDf3xQzdzbS/cYEyEUK0XtHJJ9xW1IGmA
	 p0qJkyBJsFpxG/k6RSR7NzOLK/DW/5kUFyyoAkDQd7iki4Zscgn5+Sz4gM2EE5kq94
	 bgIAt2KLLSnll5ansiANUj/aZIuwCO05DAJmF0YncDvFPzu681ygF62Emhklk1Zz/N
	 B1NYQ8SwQVK+REw2YN9b+V16UYvNSQyQKkOWC0MTmDQpygc39kXlvmB8y1x/Mv7s5U
	 pCNAYEzHPophg==
Date: Tue, 2 Jul 2024 10:37:26 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
	echaudro@redhat.com, i.maximets@ovn.org, dev@openvswitch.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 05/10] net: openvswitch: add psample action
Message-ID: <20240702093726.GD598357@kernel.org>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
 <20240630195740.1469727-6-amorenoz@redhat.com>
 <f7to77hvunj.fsf@redhat.com>
 <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=2xmOaMy2DVNfTOkh1sK+NR_gz+bXvKLg9YSp1t_K+sEUzJg@mail.gmail.com>

On Tue, Jul 02, 2024 at 03:05:02AM -0400, Adrián Moreno wrote:
> On Mon, Jul 01, 2024 at 02:23:12PM GMT, Aaron Conole wrote:
> > Adrian Moreno <amorenoz@redhat.com> writes:

...

> > > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c

...

> > > @@ -1299,6 +1304,39 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
> > >  	return 0;
> > >  }
> > >
> > > +#if IS_ENABLED(CONFIG_PSAMPLE)
> > > +static void execute_psample(struct datapath *dp, struct sk_buff *skb,
> > > +			    const struct nlattr *attr)
> > > +{
> > > +	struct psample_group psample_group = {};
> > > +	struct psample_metadata md = {};
> > > +	const struct nlattr *a;
> > > +	int rem;
> > > +
> > > +	nla_for_each_attr(a, nla_data(attr), nla_len(attr), rem) {
> > > +		switch (nla_type(a)) {
> > > +		case OVS_PSAMPLE_ATTR_GROUP:
> > > +			psample_group.group_num = nla_get_u32(a);
> > > +			break;
> > > +
> > > +		case OVS_PSAMPLE_ATTR_COOKIE:
> > > +			md.user_cookie = nla_data(a);
> > > +			md.user_cookie_len = nla_len(a);
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	psample_group.net = ovs_dp_get_net(dp);
> > > +	md.in_ifindex = OVS_CB(skb)->input_vport->dev->ifindex;
> > > +	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> > > +
> > > +	psample_sample_packet(&psample_group, skb, 0, &md);
> > > +}
> > > +#else
> > > +static inline void execute_psample(struct datapath *dp, struct sk_buff *skb,
> > > +				   const struct nlattr *attr) {}
> >
> > I noticed that this got flagged in patchwork since it is 'static inline'
> > while being part of a complete translation unit - but I also see some
> > other places where that has been done.  I guess it should be just
> > 'static' though.  I don't feel very strongly about it.
> >
> 
> We had a bit of discussion about this with Ilya. It seems "static
> inline" is a common pattern around the kernel. The coding style
> documentation says:
> "Generally, inline functions are preferable to macros resembling functions."
> 
> So I think this "inline" is correct but I might be missing something.

Hi Adrián,

TL;DR: Please remove this inline keyword

For Kernel networking code at least it is strongly preferred not
to use inline in .c files unless there is a demonstrable - usually
performance - reason to do so. Rather, it is preferred to let the
compiler decide when to inline such functions. OTOH, the inline
keyword in .h files is fine.

...

