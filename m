Return-Path: <netdev+bounces-290086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOEoMqgRDmrw5wUAu9opvQ
	(envelope-from <netdev+bounces-290086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B082598E74
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A97F330022FF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84435F8C9;
	Wed, 20 May 2026 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvG3fYnW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72135B63D;
	Wed, 20 May 2026 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306917; cv=none; b=ZueIE1Umq8rnT5QaoS8QDW5PqlFtpayGKXRSinDb1Bxord6548F2QOyleeXalmZ5i4aagYyBngE+Vz//t/de1oEGabSmXxbtFIlD1lDfO1qt7GwX9UbxQPZcYLqpJ8S2uxNO3pjs11HmH9xYJ6xFwOdGPrPV7sPa/5ziRnr0XqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306917; c=relaxed/simple;
	bh=ePlwtNrV8bm5af17CJA+hA03UVVUnZNvV6Gj4Csh34w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyF58eo2l5pzOhJDKPW7p456ohnZiE9Yb0pVC23mfpMQjHeTQYlrVnUOps+LYROZQXFfc/t6HsYjefdcrqxxEEa5Rj56d6GOFkohuKM0erKXMtbaOSa02bDmGt/86vczIeJIVVLf+MWvcNucitkK2ONXtXvb6d+d6kT9JNEASaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvG3fYnW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9901C1F00893;
	Wed, 20 May 2026 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779306915;
	bh=RxqIxFG1IxAKAgegLj7Mzo2smFWW4Wovzg0Vzth+yOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gvG3fYnW6Y4GsW5195iIcSiXJU1+0oPs5SvDo+mc55KmvGxSPaS4DFpLF6Nq3pVXo
	 i/TwWejnUp5GoBhF2fhGnMGQ0a6hlShS5M7jK720BACUhhdm1I73qVbEdulMdZN0gJ
	 etbetJyiXyX49tNLv7nGAwZf7l7kl5KQSXsrCee5wgm59FE9DUfcyc9DZQlJNa1Cg9
	 gMBhPm21dVv5A0rtSaw02BMwE9w174OarCQYDmh8SSymGXECjP744gtwVSsVDTU4RF
	 9vt06p7O/3kL2csNUZlMURxZ8iAgBmDBmThdRLCtS65s3doC+AO7yd3Oixtll/2WEZ
	 8uW2MKIoqHmug==
Date: Wed, 20 May 2026 21:55:10 +0200
From: Michael Grzeschik <mgr@kernel.org>
To: netdev@vger.kernel.org
Cc: Markus Schneider-Pargmann <mail@markussp.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update address for Michael Grzeschik
Message-ID: <ag4RnvXbAoITkwth@pengutronix.de>
References: <20260426-maintainer-v1-1-d74d2f4343f7@kernel.org>
 <DICBWQ0WBG05.1D9181KHYC61C@markussp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DICBWQ0WBG05.1D9181KHYC61C@markussp.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290086-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6B082598E74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gentle ping to ask if anyone is picking this up?

On Thu, May 07, 2026 at 11:15:17AM +0200, Markus Schneider-Pargmann wrote:
> On Sun Apr 26, 2026 at 12:20 AM CEST, Michael Grzeschik wrote:
> > Since I am moving from Pengutronix update my email address for the
> > ARCNET subsystems to point to my kernel.org address.
> >
> > Also update .mailmap.
> >
> > Signed-off-by: Michael Grzeschik <mgr@kernel.org>
> 
> Acked-by: Markus Schneider-Pargmann <mail@markussp.com>
> 
> > ---
> >  .mailmap    | 2 ++
> >  MAINTAINERS | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/.mailmap b/.mailmap
> > index 34acd34bbf9bf..7b01246851705 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -579,6 +579,8 @@ Mayuresh Janorkar <mayur@ti.com>
> >  Md Sadre Alam <quic_mdalam@quicinc.com> <mdalam@codeaurora.org>
> >  Miaoqing Pan <quic_miaoqing@quicinc.com> <miaoqing@codeaurora.org>
> >  Michael Buesch <m@bues.ch>
> > +Michal Grzeschik <mgr@kernel.org> <m.grzeschik@pengutronix.de>
> > +Michal Grzeschik <mgr@kernel.org> <mgr@pengutronix.de>
> >  Michael Riesch <michael.riesch@collabora.com> <michael.riesch@wolfvision.net>
> >  Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
> >  Michel Dänzer <michel@tungstengraphics.com>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2fb1c75afd163..48b601d36b846 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2058,7 +2058,7 @@ F:	Documentation/devicetree/bindings/display/snps,arcpgu.txt
> >  F:	drivers/gpu/drm/tiny/arcpgu.c
> >  
> >  ARCNET NETWORK LAYER
> > -M:	Michael Grzeschik <m.grzeschik@pengutronix.de>
> > +M:	Michael Grzeschik <mgr@kernel.org>
> >  L:	netdev@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/net/arcnet/
> >
> > ---
> > base-commit: 897d54018cc9aa97fd1529ca08a53b429d05a566
> > change-id: 20260426-maintainer-eecd046c4a87
> >
> > Best regards,
> 



