Return-Path: <netdev+bounces-224186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D02B81EA7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357707B8FA9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D91C3BFC;
	Wed, 17 Sep 2025 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD1FJCNp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE3D10F1;
	Wed, 17 Sep 2025 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143954; cv=none; b=iiVRKFYvpDWYBmSQIhQ/3PfuPMi/J1woOBJ4QW/ygzhm+/kecFnVeTwHRzZYA5fOEAvaEI6bQbQKWkwWws4xvE+ywpuoqKkgaRGPxcjzF50fQ+TT1tXX57HZoYxA+iPsK9ruuTi+b5uBSYgWCna+tyjyOjDmn3jnUCNwBolMrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143954; c=relaxed/simple;
	bh=2hX6h0lZi6Wvimj0InNgEZYJuaAotowTDFW8fY0ZYi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKU9UfcsJZlrLB7FnoKV0V4Ya0IrmZaIkQoA0HIvI++IZhgN3uO7IXjw0/nRFQwO4PkTCsbpwLEnovJB5t6fDIYgSYv0YVbirObwhuWqCVVrJHqWJlseGoZ/I4qjWb7vIt40hEVlhOj0abluPZX72I6Wf3MvB+5fHd6R/qm9bvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD1FJCNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6EEC4CEE7;
	Wed, 17 Sep 2025 21:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758143954;
	bh=2hX6h0lZi6Wvimj0InNgEZYJuaAotowTDFW8fY0ZYi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZD1FJCNpKn9xWANveD4AS6EmPXZFEpw7jlIGhgK4rilzcrgLC1jInQGIz+azQjvHP
	 MCpXKR1a/ph8hoHB8YzUP1H+IUOCxCNPXzQ4iBUixHYprRbz4TdaGVQzryWSLDa97v
	 FMMREQoLBH7T7wsiqZwIC8XnvaGcrKJeJV0YHct8H13TAknPLPjvQunW7MT0jYpSau
	 z89wOoPrjtkCkjO8BbUegUaClOfK+pXnhrHKfHyU1IxLQhxp4Qdoj9zvv2xPxdaETS
	 eIO5i59siokBOQZ4JuHSLLZvhE7f/LNQvgbp2M4rl/taAxE4bw9Fh9E1mPwxRxjT2C
	 gVwR9t9xM/ujA==
Date: Wed, 17 Sep 2025 14:19:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v3 0/5] net: pse-pd: pd692x0: Add permanent
 configuration management support
Message-ID: <20250917141912.314ea89b@kernel.org>
In-Reply-To: <20250917114655.6ed579eb@kmaincent-XPS-13-7390>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
	<20250916165440.3d4e498a@kernel.org>
	<20250917114655.6ed579eb@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 11:46:55 +0200 Kory Maincent wrote:
> > On Mon, 15 Sep 2025 19:06:25 +0200 Kory Maincent wrote:  
> > > This patch series introduces a new devlink-conf uAPI to manage device
> > > configuration stored in non-volatile memory. This provides a standardized
> > > interface for devices that need to persist configuration changes across
> > > reboots. The uAPI is designed to be generic and can be used by any device
> > > driver that manages persistent configuration storage.
> > > 
> > > The permanent configuration allows settings to persist across device
> > > resets and power cycles, providing better control over PSE behavior
> > > in production environments.    
> > 
> > I'm still unclear on the technical justification for this.
> > "There's a tool in another project which does it this way"
> > is not usually sufficient upstream. For better or worse we
> > like to re-implement things from first principles.
> > 
> > Could you succinctly explain why "saving config" can't be implemented
> > by some user space dumping out ethtool configuration, saving it under
> > /etc, and using that config after reboot. A'la iptables-save /
> > iptables-restore?  
> 
> I think the only reason to save the config in the NVM instead of the userspace
> is to improve boot time. As Oleksij described:
> > I can confirm a field case from industrial/medical gear. Closed system,
> > several modules on SPE, PoDL for power. Requirement: power the PDs as
> > early as possible, even before Linux. The box boots faster if power-up
> > and Linux init run in parallel. In this setup the power-on state is
> > pre-designed by the product team and should not be changed by Linux at
> > runtime.  
> 
> He told me that he also had added support for switches in Barebox for the
> same reason, the boot time. I don't know if it is a reasonable reason to add it
> in Linux.

Right, subjectively I focused on the last sentence of Oleksij's reply.
I vote we leave it out for now.

