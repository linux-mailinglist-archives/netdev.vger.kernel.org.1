Return-Path: <netdev+bounces-90085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4198ACB89
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348D41F2398C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF681465B3;
	Mon, 22 Apr 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek74AD6W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7911465B0
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783572; cv=none; b=GYH0xUt4A+fmMycijpC6cpxSDOhBOiMDDlSv23Ap4T1FJo9AF6og7gqFYDwFb4I6+R5Gzt+Zi1nV/JlRuK/LvrbVpNH4CyMO3iKlfDsG6cCwNngf+6Z1lRLRFUvMl7URGmJSydkgTbmA9D0RydgrcKlnbutUF5aeEKRkzIiCaQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783572; c=relaxed/simple;
	bh=1p9dN9HGyRnh6FNMJMHLYFOMqCNJyVlRMdNicikYM7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6mV/GJYEN9ksJkTwCty3LH3tgWkmvvX/rvzXHiX5jA6Ulfdbu+1wvgGIJDJLO9sECqd7ciU+rdABfW5xLuz1MUnMCNuw+dkaViOR3/7+VzQ2x23AbxWJ/cU1ma6VzGhtTHuw+Ckl8s9FXa5baHi5xeExLrkW988JR2piaF2RV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek74AD6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBD7C113CC;
	Mon, 22 Apr 2024 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713783571;
	bh=1p9dN9HGyRnh6FNMJMHLYFOMqCNJyVlRMdNicikYM7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ek74AD6W4SAMRR94/ykIS3Oh8v34oQJAiUhV9AL8lXFDWIgQmHlhrbpi7z7Bh04lM
	 bgYZR6qwAeKu14SmwhUT4iCV71eDGXeleACEee+HJQcNtgicvS3hzerUbVsyF4kWeT
	 BYsaTRg/baMxyyLn4AbrCksK9iKVqdt8TN2s0TiSAqPNajHkJJu1/FKIdZRyV0S19i
	 zj6yOIDMZ5NfYtNnFQY0mTPY2bIUFZIQ2OKqgj23Kosxi+l3yBxjw56oF/KQzuVwmW
	 tKFiOaPLh9rJGpo2Q5Jk3u3Ktpgvb33rE/s2I6cDwOlbAuNrTYKkXMC2XKXBTZAJbe
	 +pXoxxO2+JkDg==
Date: Mon, 22 Apr 2024 11:57:56 +0100
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
Message-ID: <20240422105756.GC42092@kernel.org>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
 <20240419-lan743x-confirm-v1-4-2a087617a3e5@kernel.org>
 <20240420192424.42z2aztt73grdvsj@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420192424.42z2aztt73grdvsj@DEN-DL-M70577>

On Sat, Apr 20, 2024 at 07:24:24PM +0000, Daniel Machon wrote:
> Hi Simon,
> 
> > -/* Convert validation error code into tc extact error message */
> > +/* Convert validation error code into tc exact error message */
> 
> This seems wrong. I bet it refers to the 'netlink_ext_ack' struct. So
> the fix should be 'extack' instead.
> 
> >  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule)
> >  {
> >         switch (vrule->exterr) {
> > diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > index 56874f2adbba..d6c3e90745a7 100644
> > --- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > @@ -238,7 +238,7 @@ const struct vcap_set *vcap_keyfieldset(struct vcap_control *vctrl,
> >  /* Copy to host byte order */
> >  void vcap_netbytes_copy(u8 *dst, u8 *src, int count);
> > 
> > -/* Convert validation error code into tc extact error message */
> > +/* Convert validation error code into tc exact error message */
> 
> Same here.

Thanks Daniel,

Silly me. I'll drop these changes in v2.

> >  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule);
> 
> The other fixes seems correct.
> 
> /Daniel
> 

