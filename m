Return-Path: <netdev+bounces-90576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD278AE8BE
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60741F231EA
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DC5136E15;
	Tue, 23 Apr 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU4uptBk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61E136E01
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880463; cv=none; b=WdHQ0XF8ISmH9PIhbz1S1BHwvoML/mncjxQAbsG7/vgxGSfHLWxm15vdRy4EKYRzBEgND5nfyxKAR00bsLbxMBJdihu6fm0lx93sq/KxMMtX6Dr34Z7oEV/H60QURhUi3kdNq0jY7uYWIlmriJNVyfNpJkcU7AWr4dn54yLpaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880463; c=relaxed/simple;
	bh=20Ann+MDcHVkR/9kjIdPZQOMlvufURQKHIlP71UWnxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9U+IAiQ6Gm3QHiYXA1J2f/HZtEbQSZtMaWT0cDWo5xjuHSMheQV/zCyjFuT9Opu4xea3aqHrM4tFYASge4gBEX5luC5YOdtCJdX0QIyf5sW72oAYIYmzrgvk+r1ZgRwOdS6xWfYU0N5ufalMigSob38ru6RBelAmLfOzGmym9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU4uptBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F652C116B1;
	Tue, 23 Apr 2024 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880463;
	bh=20Ann+MDcHVkR/9kjIdPZQOMlvufURQKHIlP71UWnxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DU4uptBkqYbrTG8I3GN6IV5mOILqb5wCdgujfzDgD/eWX6jjutZpE+UDlYWy3rT5N
	 rKir8AF4Cg4gOurPM8ScvGUbIsyzMQnGzn9Dqfa7WRGXiJAT1UzVoBwfDoO82XpqNg
	 lHdXjMzAC9PRM8PYPzkxcDft23RPcwLD/Czcnm2yssvSJ9E+ZhCDroAGWjAC034sWK
	 hguR0KxAzy4zCO/LTibgkSYQEln7M2Yo3QenVeSSpKVJAcb/7GKauvyA5pGDgKYw/Z
	 i3bCfMLcSGLmo5TAOKfhs9BktVVcv/1sC+N6EjJ+8m3mXET1XuKs9nJUg+EllrV7gK
	 Q7wm7UAhgMpzA==
Date: Tue, 23 Apr 2024 14:54:17 +0100
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
Message-ID: <20240423135417.GT42092@kernel.org>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
 <20240419-lan743x-confirm-v1-4-2a087617a3e5@kernel.org>
 <20240420192424.42z2aztt73grdvsj@DEN-DL-M70577>
 <20240422105756.GC42092@kernel.org>
 <20240423112915.5cmqvmvwfwutahky@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423112915.5cmqvmvwfwutahky@DEN-DL-M70577>

On Tue, Apr 23, 2024 at 11:29:15AM +0000, Daniel Machon wrote:
> > > Hi Simon,
> > >
> > > > -/* Convert validation error code into tc extact error message */
> > > > +/* Convert validation error code into tc exact error message */
> > >
> > > This seems wrong. I bet it refers to the 'netlink_ext_ack' struct. So
> > > the fix should be 'extack' instead.
> > >
> > > >  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule)
> > > >  {
> > > >         switch (vrule->exterr) {
> > > > diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > index 56874f2adbba..d6c3e90745a7 100644
> > > > --- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > @@ -238,7 +238,7 @@ const struct vcap_set *vcap_keyfieldset(struct vcap_control *vctrl,
> > > >  /* Copy to host byte order */
> > > >  void vcap_netbytes_copy(u8 *dst, u8 *src, int count);
> > > >
> > > > -/* Convert validation error code into tc extact error message */
> > > > +/* Convert validation error code into tc exact error message */
> > >
> > > Same here.
> > 
> > Thanks Daniel,
> > 
> > Silly me. I'll drop these changes in v2.
> 
> No reason to drop them just change it to 'extack' :-)

Thanks, will do.

