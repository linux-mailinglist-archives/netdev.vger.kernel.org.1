Return-Path: <netdev+bounces-147696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3887C9DB3F1
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD38DB21BD9
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA914F9D6;
	Thu, 28 Nov 2024 08:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8414D456
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783267; cv=none; b=qVHivxZj8UGJSLDdJA/KehstetQMkpOK9xQst/P+cxGEpDDlkkuWIJmH0MHNLdbp1pN7v4IFzYAhokw7ug22Mzp5EiFvupBU5ojnaaqWvmk2bdbliVeF6gCvOxjq8W83Mali0pRv/1cKq2dNdwW2UxsHytWz3Jn/lAr0dwT+Nzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783267; c=relaxed/simple;
	bh=CkhsE/rZw9spgAt5s0YzkZZkXLkpvQ1u/gVwpQ+wcBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXzacL+yBvC4N5Sm7XsBQ6iu9owO8fkVYskXGcJtpQbQMo/8n+2CynswGstFaY8muXvTonuYXQCLvbtqHHcqbHdRPE7IuDVBz3ArK+3kSTMo3kEeVP8Mk9pRQ2Qt3cZEBN0Kgjb11i35QjZpeU+JwQm0EGlID4blTrSQXyUaWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGa57-0002Md-Qn; Thu, 28 Nov 2024 09:41:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGa56-000a9p-2T;
	Thu, 28 Nov 2024 09:41:01 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGa57-002puy-1S;
	Thu, 28 Nov 2024 09:41:01 +0100
Date: Thu, 28 Nov 2024 09:41:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next v1 1/1] ethtool: add support for
 ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Message-ID: <Z0gsnc_t_G2YN_Gy@pengutronix.de>
References: <20241119131054.3317432-1-o.rempel@pengutronix.de>
 <dkfesntoylodx2xm65frikdhm6gslddp6xj2mcidxwbpjtklsv@cwfxiuywrysg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dkfesntoylodx2xm65frikdhm6gslddp6xj2mcidxwbpjtklsv@cwfxiuywrysg>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Nov 25, 2024 at 08:29:30PM +0100, Michal Kubecek wrote:
> On Tue, Nov 19, 2024 at 02:10:54PM +0100, Oleksij Rempel wrote:
> > diff --git a/netlink/desc-ethtool.c b/netlink/desc-ethtool.c
> > index 5c0e1c6f433d..97a994961c8e 100644
> > --- a/netlink/desc-ethtool.c
> > +++ b/netlink/desc-ethtool.c
> > @@ -252,12 +252,14 @@ static const struct pretty_nla_desc __cable_test_result_desc[] = {
> >  	NLATTR_DESC_INVALID(ETHTOOL_A_CABLE_RESULT_UNSPEC),
> >  	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_PAIR),
> >  	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_CODE),
> > +	NLATTR_DESC_U8(ETHTOOL_A_CABLE_RESULT_SRC),
> >  };
> >  
> >  static const struct pretty_nla_desc __cable_test_flength_desc[] = {
> >  	NLATTR_DESC_INVALID(ETHTOOL_A_CABLE_FAULT_LENGTH_UNSPEC),
> >  	NLATTR_DESC_U8(ETHTOOL_A_CABLE_FAULT_LENGTH_PAIR),
> >  	NLATTR_DESC_U32(ETHTOOL_A_CABLE_FAULT_LENGTH_CM),
> > +	NLATTR_DESC_U8(ETHTOOL_A_CABLE_FAULT_LENGTH_SRC),
> >  };
> >  
> >  static const struct pretty_nla_desc __cable_nest_desc[] = {
> 
> AFAICS both new attributes are U32 so that NLATTR_DESC_U32() should be
> used here. Looks good to me otherwise.
> 
> One question: the kernel counterpart seems to be present in 6.12 final,
> is there something that would prevent including this in ethtool 6.12
> (planned to be wrapped up at the end of this week)?

Ah, sorry. I overseen this mail. I do not see anything against it. I'll
resend new version today. 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

