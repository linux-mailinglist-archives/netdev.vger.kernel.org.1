Return-Path: <netdev+bounces-292644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMf5DMUWGGoAdAgAu9opvQ
	(envelope-from <netdev+bounces-292644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:19:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DD5F07C0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05F3E31A045B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1853A5E97;
	Thu, 28 May 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LulWM921"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2739A067
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962959; cv=none; b=QGt5EmhGtuI61bl0hbrByd2FuXqNTnM40srUUCc4FPTuB9fXffQRxbpM1BZ+9m1ny0pPLO2FoRPl4mmVX5BILFfvUY4bxz5uTwEu/sweT1aUU+tR632dwQ0+d+0ZINDL2MiquaCetu6fkrEHYY4uq31e2qv9r2koatt0RNVO4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962959; c=relaxed/simple;
	bh=O5ns5xt0BC4PLkK1MHjyGauCuTgvbrR/+fFISjyS3dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY6SmaEWkBfX9wmCswqW0L89rza+Rr+pcL9XDATjbMLLU8rkFK8fl9BoO4Vnm3nTv5H5S/3xLfVHB8CgRxBkVUBOt8xv2SipgGYiE2hnb7xC3CVxjCb72Pcq02pigbU1w05yqToVhBXUsaefs2B/u/wOAYToalbhMIbqNDYlNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LulWM921; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED891F000E9;
	Thu, 28 May 2026 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779962958;
	bh=mXTcwOAxYCyeWUNvCluJGYFYmCjEQFu3Xz6J5KO3OCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LulWM921MeRbNQtw0y9fCJUcdUcT3z2gceurOxdgGEhcUsdKSqokqrpPIeRQ5raM5
	 pCCQA9V48uTEpZnv+3EL+GZ9g1YmmrtC9EEs0kXX9gioN9qqu/Mv+K71ouoaUvOq3l
	 TgshLq87W8ZuALUuep1w8TyYcnG/vG/7uhun3JnnyseokvJSBuPpTUU23x60QHcaVn
	 OMg0j+JizsoL9gOhgtcQKl7bgNxcIkRBcO+BDKg91+lifdnsOWiyvnWq0zVwiM2kXg
	 WLx8poGGsTWriYm/E0apkoTPgM83EjfvMUfmFcleggK8lhhTiDphFTZ0WEt9cW5sJK
	 J6XtQYDRmMSHg==
Date: Thu, 28 May 2026 11:09:12 +0100
From: Simon Horman <horms@kernel.org>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Yan, Zheng" <zheng.z.yan@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Behera, VIVEK" <vivek.behera@siemens.com>,
	"Ertman, David M" <david.m.ertman@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net 1/1] igb: Return state in pm_runtime_idle instead of
 power-down
Message-ID: <20260528100912.GQ2256768@horms.kernel.org>
References: <20260505101141.2657169-1-felix.moessbauer@siemens.com>
 <20260508095659.GM15617@horms.kernel.org>
 <1c72678bab1eeca51b7f849a6f85999995b646f3.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c72678bab1eeca51b7f849a6f85999995b646f3.camel@siemens.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,siemens.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-292644-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,siemens.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 881DD5F07C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:53:53AM +0000, MOESSBAUER, Felix wrote:
> On Fri, 2026-05-08 at 10:56 +0100, Simon Horman wrote:
> > + David Ertman, Sasha Neftin, Heiner Kallweit
> > 
> > On Tue, May 05, 2026 at 12:11:34PM +0200, Felix Moessbauer wrote:
> > > The PM runtime_idle API expects to get an indication if the device can
> > > be powered down. Instead of returning the appropriate state, we
> > > currently directly power down the device (if not active) and return
> > > that the device is busy.
> > > 
> > > We change this by making the function side-effect free and just return
> > > the state.
> > > 
> > > Fixes: 749ab2cd12704 ("igb: add basic runtime PM support")
> > > Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> > > ---
> > >  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > > index ce91dda00ec0e..e8ab0b506a104 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -9652,7 +9652,7 @@ static int igb_runtime_idle(struct device *dev)
> > >  	struct igb_adapter *adapter = netdev_priv(netdev);
> > >  
> > >  	if (!igb_has_link(adapter))
> > > -		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);
> > > +		return 0;
> > >  
> > >  	return -EBUSY;
> > >  }
> > 
> > Hi Felix,
> > 
> > I am not sure this is the right approach, are you seeing a behavioural
> > problem?
> 
> I don't see a behavioral issue, but a clear API violation. That's why I
> also added a fixes tag.
> 
> > 
> > 
> > This pattern seems to also be present in at least e1000e, igc and r8169.
> > 
> > The igb and e1000e implementations seem to have co-evolved [1][2],
> > possibly in conjunction with OOT versions of each driver.
> > The igc implementation came later, perhaps copying e1000e or igb [3].
> 
> I'm fine with also changing the other drivers, however I'm not able to
> test these (except for e1000e).
> 
> > 
> > The git log for r8169 seems to provide a justification for why that
> > driver users this approach [4].
> > 
> >     - Let the idle notification check whether we can suspend and let it
> >       schedule the suspend. This way we don't need to have calls to
> >       pm_schedule_suspend in different places.
> 
> To me it still is a bit vague, why it was implemented like that. By
> implementing it as done prior to my change, we have pm_schedule_suspend
> in multiple places (along with a hard-coded delay of 5 secs).
> 
> > 
> > While the current e1000e implementation seems to address some reliability
> > issues [1], although it's not entirely clear to me how that relates to the
> > issue at hand.
> 
> I don't think that this relates, but I also found the igb_runtime_idle
> inconsistency while debugging why setting the mac addr on an igb nic
> without cable attached (no carrier) fails on some systems.
> 
> IOW: What I propose here is a drive-by fix based on me reading the code
> and the PM API.

Thanks,

I understand your position wrt API violation. But given the history of this
code, both in igb and other Intel drivers, I think we need some insight
from people familiar with this code regarding what is going on here.

> 
> Best regards,
> Felix
> 
> > 
> >     Fix issues with:
> >     RuntimePM causing the device to repeatedly flip between suspend and resume
> >     with the interface administratively downed.
> >     Having RuntimePM enabled interfering with the functionality of Energy
> >     Efficient Ethernet.
> > 
> >     Added checks to disallow functions that should not be executed if the
> >     device is currently runtime suspended
> > 
> >     Make runtime_idle callback to use same deterministic behavior as the igb
> >     driver.
> > 
> > [1] 63eb48f151b5 ("e1000e Refactor of Runtime Power Management")
> >     Fri Feb 14 07:16:46 2014 +0000
> > [2] 749ab2cd1270 ("igb: add basic runtime PM support")
> >     Wed Jan 4 20:23:37 2012 +0000
> > [3] 9513d2a5dc7f ("igc: Add legacy power management support")
> >     Thu Nov 14 09:54:46 2019 +020
> > [4] a92a08499b1f ("r8169: improve runtime pm in general and suspend unused ports")
> >     Mon Jan 8 21:39:13 2018 +0100

