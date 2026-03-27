Return-Path: <netdev+bounces-272505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBZQMChnxmnnJgUAu9opvQ
	(envelope-from <netdev+bounces-272505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:16:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2319934336D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CB73303E3BB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62393E5EE8;
	Fri, 27 Mar 2026 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x2LrWzb6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC9315D46;
	Fri, 27 Mar 2026 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609676; cv=none; b=I3GZ9bZNbq/cr45kAzke35LzLTtKLHnCKuf+lqy+If3LRKQ5gR4ORulOPxOjzW6YX/i04TELMnM9m68KgoMXcYjKEJ5/EYeVUQ1zzEn2KuJCHS4Z9r0gucWHjTk8h4kHd4p9x3MfVl17jtpAftDBwYWdiFazJ1hmQJeagepmdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609676; c=relaxed/simple;
	bh=X7+MSwRLL32PrKY1RmX3TkO6F/2E8YzLL2YkG7lfk48=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9/L3dsjeaHAe/29Lh2JIi517Ebl2tJVPzXoPEGI7E9wujIumQeN1xFD2oSLstbcB1pbWLIIe2XsuK/TknS8DoMO0ga0vU5ZvbjbScy9tyuMTQqNj4iLIphooKwfbmmMUbXsW4ezm279zyQSUygrr6YOQl3dtkqKpKII+R/MVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x2LrWzb6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774609672; x=1806145672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X7+MSwRLL32PrKY1RmX3TkO6F/2E8YzLL2YkG7lfk48=;
  b=x2LrWzb6dIWahEibaqQhgfi8NovYc8mxcPqG86SiNS8boJrA7xHUVR7V
   dk3Kum4K8Ps1nC4B9SFhw07pRgMnVKmTWaD40/RxxPlXENBqzaeUHpgwu
   E8x6EHbfnVO4ucU+sjJCb6tt+83vGnL8PsgwVkFc+jjFQG8671eLa4wHi
   BHxrmYog77qfIEGXTK9W8bE/vfbnbES8mvJWIzmQmkqoFs3ydU3+YYYep
   LBhhN0bS6q8DnkZEu0d9Xq4Wy1shOca+1No57em2ZoPEoVky4eG4fZRTm
   zVRIHKIKixH5UiPMZEs0t8a97bqOm2qLHyfYAXvDhsxbT5T/vtsuAJBwz
   A==;
X-CSE-ConnectionGUID: x2neiTdjQO65w24S27r6nA==
X-CSE-MsgGUID: DN5Z1Fr4R52TqPmX0f8tDQ==
X-IronPort-AV: E=Sophos;i="6.23,144,1770620400"; 
   d="scan'208";a="55302100"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2026 04:07:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 27 Mar 2026 04:07:24 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 27 Mar 2026 04:07:21 -0700
Date: Fri, 27 Mar 2026 12:07:20 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Arnd
 Bergmann <arnd@arndb.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Message-ID: <20260327110720.une422vpf7pas4tg@DEN-DL-M70577>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
 <20260323155204.0321db13@bootlin.com>
 <20260323172640.2669232d@bootlin.com>
 <20260323194059.jjphkep4teq5rzbc@DEN-DL-M70577.microsemi.net>
 <20260324090752.0799acb1@bootlin.com>
 <20260326154833.jp6rx5x2rlpmwrg3@DEN-DL-M70577>
 <20260327113337.0368eea3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327113337.0368eea3@bootlin.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,arndb.de,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272505-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2319934336D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hervé,

> Hi Daniel,
> 
> On Thu, 26 Mar 2026 16:48:33 +0100
> Daniel Machon <daniel.machon@microchip.com> wrote:
> 
> ...
> 
> >
> > As I remembered, doing rmmod on the lan966x_switch followed by modprobe
> > lan966x_switch works fine. This is because neither the switch core, nor the FDMA
> > engine is reset, so they remain in sync.
> >
> > When the lan966x_pci module is removed and reloaded (what you did), the DT
> > overlay is re-applied, which causes the reset controller
> > (reset-microchip-sparx5) to re-probe. During probe, it performs a GCB soft reset
> > that resets the switch core, but protects the CPU domain from the reset. The
> > FDMA engine is part of the CPU domain, so it is not reset.
> >
> > This leaves the switch core in a reset state while the FDMA
> > retains state from the previous driver instance. When the switch driver
> > subsequently probes and activates the FDMA channels, the two are out of
> > sync, and the FDMA immediately reports extraction errors.
> >
> > Theres actually an FDMA register called NRESET that resets the FDMA controller
> > state. Calling this in the FDMA init path causes traffic to work correctly on
> > lan966x_pci reload, but it does not get rid of the FDMA splats you posted above.
> > They get queued up between the switch core reset, in the reset controller, and
> > the FDMA enabling. I tried different approaches to drain or flush queues, but
> > they wont go away entirely.
> >
> > The only thing that seems to work consistently is to *not* do the soft reset in
> > the reset controller for the PCI path. The soft reset is actually the problem:
> > it only resets the switch core while protecting the CPU domain (including FDMA),
> > causing a desync.
> >
> > A simple fix could be (in reset-microchip-sparx5.c):
> >
> > +static bool mchp_reset_is_pci(struct device *dev)
> > +{
> > +     for (dev = dev->parent; dev; dev = dev->parent) {
> > +             if (dev_is_pci(dev))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> >
> > -     /* Issue the reset very early, our actual reset callback is a noop. */
> > -     err = sparx5_switch_reset(ctx);
> > -     if (err)
> > -             return err;
> > +     /* Issue the reset very early, our actual reset callback is a noop.
> > +      *
> > +      * On the PCI path, skip the reset. The endpoint is already in
> > +      * power-on reset state on the first probe. On subsequent probes
> > +      * (after driver reload), resetting the switch core while the FDMA
> > +      * retains state (CPU domain is protected from the soft reset)
> > +      * causes the two to go out of sync, leading to FDMA extraction
> > +      * errors.
> > +      */
> > +     if (!mchp_reset_is_pci(&pdev->dev)) {
> > +             err = sparx5_switch_reset(ctx);
> > +             if (err)
> > +                     return err;
> > +     }
> >
> > Could you test it and see if it helps the problem on your side.
> >
> 
> I have tested it on my ARM and x86 system. It fixes the lan966x_pci module
> unloading / reloading issue.
> 
> However an other regression is present. After a reboot, without power
> off/on, the board is not working (tested on both my ARM and x86 systems).
> 
> According to your explanation, this makes sense.
> 
> IMHO, the problem is that we cannot make the assumption that "The endpoint
> is already in power-on reset state on the first probe". That's not true
> when you just call the reboot command.
> 
> Best regards,
> Hervé

Again, thanks for testing.

Agreed, that makes sense.

I will continue experimenting with the FDMA reset and see if I can do an FDMA
reset on switch driver probe, while not getting any intermediate FDMA errors.
After spring break, that is :)

/Daniel



