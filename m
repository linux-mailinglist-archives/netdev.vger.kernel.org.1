Return-Path: <netdev+bounces-90992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E7F8B0D7F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D785B21377
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302C15EFA2;
	Wed, 24 Apr 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9SABrMb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4FB15D5A5
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970877; cv=none; b=OK9KI2q2RQhA237i2iqMZFk7dZX4HUUISs28tRPTcyKRvCkctzMEi8OUuPYDVVWNxBWZ50LnsKbncFskbtRXGmcK6MoXdcQzuiuQneqwnbe1ygOLzmMAXvxVHyr0Mo2xHqwG2yT5XjhS3+bD2lU0X0zz80r4yKx0Y6LDO9cAgnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970877; c=relaxed/simple;
	bh=4YXfv5lqCAUcfMB5t+fOCcrGW9badPRJMRygflAgOOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5ly50Us3htv+BXLx8XtAaKCc7XG7sLgUp8LWGwFo+X3SD6Ej6TatlP37shbmC7O+jTvQB3IKcva3/gwthTW6W+tlFaPDlrZz5KFcYfApRmuqM67FazF7WdsEX01bbPRQ1MGOM6XBoymUUKYsNfZInqqshY0J6p4x76fcvxp+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9SABrMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090A8C113CD;
	Wed, 24 Apr 2024 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970876;
	bh=4YXfv5lqCAUcfMB5t+fOCcrGW9badPRJMRygflAgOOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9SABrMb7zJqLBKULymwu8vicegkSboVvUmce/TtA45HANww2y2OHZyc+7TvwGORe
	 4m4ESChpC+CiI5J8zb1W5VIqmjsksSTs1VyoIuYesyvVw6+h63usuAjH/WTWcALxse
	 1sKKvQnuJWTVePrPkcXZ9X/wacsbiBAr02LAdY/rZsU7eotNVNaR9L6g8GL7UXJcYR
	 6CxckSH7y83cMd6+5e0vW4A0d8pjZ+SP97SyELBnTmx6wNgdyjf72r+3ISRM1z3OOM
	 ptJJDZNdYRr9ssdxlCZys9lwZ/GaujqI3Q1kEn2u1XWxAsV5f2oMQ1RNbTj42GpkXp
	 lgRbdL6PNCIkQ==
Date: Wed, 24 Apr 2024 15:59:41 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 4/4] net: sparx5: Correct spelling in comments
Message-ID: <20240424145941.GL42092@kernel.org>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
 <20240419-lan743x-confirm-v1-4-2a087617a3e5@kernel.org>
 <20240420192424.42z2aztt73grdvsj@DEN-DL-M70577>
 <20240422105756.GC42092@kernel.org>
 <20240423112915.5cmqvmvwfwutahky@DEN-DL-M70577>
 <20240423135417.GT42092@kernel.org>
 <20240423161849.GW42092@kernel.org>
 <20240423192930.okhvbvlao6ke3pkl@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423192930.okhvbvlao6ke3pkl@DEN-DL-M70577>

On Tue, Apr 23, 2024 at 07:29:30PM +0000, Daniel Machon wrote:
> > On Tue, Apr 23, 2024 at 02:54:17PM +0100, Simon Horman wrote:
> > > On Tue, Apr 23, 2024 at 11:29:15AM +0000, Daniel Machon wrote:
> > > > > > Hi Simon,
> > > > > >
> > > > > > > -/* Convert validation error code into tc extact error message */
> > > > > > > +/* Convert validation error code into tc exact error message */
> > > > > >
> > > > > > This seems wrong. I bet it refers to the 'netlink_ext_ack' struct. So
> > > > > > the fix should be 'extack' instead.
> > > > > >
> > > > > > >  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule)
> > > > > > >  {
> > > > > > >         switch (vrule->exterr) {
> > > > > > > diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > > > index 56874f2adbba..d6c3e90745a7 100644
> > > > > > > --- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > > > +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > > > @@ -238,7 +238,7 @@ const struct vcap_set *vcap_keyfieldset(struct vcap_control *vctrl,
> > > > > > >  /* Copy to host byte order */
> > > > > > >  void vcap_netbytes_copy(u8 *dst, u8 *src, int count);
> > > > > > >
> > > > > > > -/* Convert validation error code into tc extact error message */
> > > > > > > +/* Convert validation error code into tc exact error message */
> > > > > >
> > > > > > Same here.
> > > > >
> > > > > Thanks Daniel,
> > > > >
> > > > > Silly me. I'll drop these changes in v2.
> > > >
> > > > No reason to drop them just change it to 'extack' :-)
> > >
> > > Thanks, will do.
> > 
> > Sorry, I am somehow confused.
> > 
> > Do you mean like this?
> > 
> > /* Convert validation error code into extact error message */
> > 
> > Or just leave things unchanged?
> > 
> > /* Convert validation error code into tc extact error message */
> 
> Should be:
> 
>   /* Convert validation error code into tc extack error message */
> 
> So the misspelling was real, just the fix was extack and not exact.

Thanks, I see it now.

