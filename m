Return-Path: <netdev+bounces-271315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CfdFP8Dw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:37:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24F31CE62
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 460E23026079
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DA299AAB;
	Tue, 24 Mar 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byEhI6Uv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9C35838E;
	Tue, 24 Mar 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388216; cv=none; b=rismi5CAxEZcRlF30FyKH9mZsrRlk9eM8kymM6WRLQfta//caBjukbrBGPn/+5IL4/5589+eUaD9jQ3GwMUmWswP3ydBfDy72Mr25h1/B+K/+cTCo2jfdg83OnwhXPM2yVuvjGeDsEp4jNvBNyrFuWn9qOiJFiB6j+Z3dYkH3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388216; c=relaxed/simple;
	bh=8ghUnBBVxBJ7ck76EO+UtIcQyZsizBJb6Z7wn0+pkGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruBm8eOg0Rk6uE4RIynOxVHBPjxewMUqD54izKmBATrItg2Nhg3MGC8INSvaq3VswVAMSU9cqS1Vs7K2uwUIqr+U10gyd7cvYZ93lPiLycS7qkzmx6K27z/ifig3I3xslNXa8kRNtfB624VpQaZqHEe6ISjXm8v6QL4o45Rx/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byEhI6Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1472C19424;
	Tue, 24 Mar 2026 21:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774388216;
	bh=8ghUnBBVxBJ7ck76EO+UtIcQyZsizBJb6Z7wn0+pkGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=byEhI6Uv3OQMf5idcmrN4ZfWfSU6p3OiQuBzoz2HMFxIYv0P4NQw4vADTyEVUETvJ
	 6fT9TZA69gZ7Em3XSyyx0lYP68tm2HC52UqRIszLD76Uxv0pvJ249PiMLb+4Bq/LvR
	 /hjJOgqIIoI+t+MHkd/mjjKPYyN1oeJBu4jYDycz1YkYhIvLWKDwD79cIulBWS/Hd8
	 H/f2gQWAJPPrUJ01jwpHI78VeWoRxYgn8Hwxr6xZyYw2Y1mEBB35sVCjCAg/Rhnpmd
	 3rIP+Ant1ddu91OH2uaFRsqFD4P2YSKOKr2KQpVWnPUpgdeq6vThiotB/zzpD6IpNt
	 vaeiRBO454x2Q==
Date: Tue, 24 Mar 2026 14:36:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Arkadiusz
 Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, Petr
 Oros <poros@redhat.com>, Simon Horman <horms@kernel.org>, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
Message-ID: <20260324143654.4dcec5a0@kernel.org>
In-Reply-To: <8486ce6e-ad2a-493d-b734-b40e8db9213e@redhat.com>
References: <20260320105915.149068-1-ivecera@redhat.com>
	<20260320105915.149068-4-ivecera@redhat.com>
	<964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
	<7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
	<20260323154825.1a2320c4@kernel.org>
	<50a1671c-9901-426a-97ed-bf36400fe9a7@roeck-us.net>
	<6f1e98b3-4b86-4b7f-8c91-d8d5721aeb25@redhat.com>
	<8486ce6e-ad2a-493d-b734-b40e8db9213e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271315-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B24F31CE62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 13:59:19 +0100 Ivan Vecera wrote:
> >> In the hardware monitoring world one would have min/max attributes and
> >> one or more alarm attributes. I never heard about the idea of reporting
> >> deviations, and for typical hardware monitoring attributes it does not
> >> really make sense. What would be a "deviation" of a temperature/
> >> voltage/current/power/humidity sensor ? Such attributes typically have
> >> an operational range, and they are allowed and even expected to
> >> fluctuate within that range.  
> > 
> > Ivan, my take on all the above is that using the HWmon interface here is
> > stretching it too much. I think it would be better to move debugfs
> > and/or netlink events.  
> 
> I'd rather avoid debugfs... My proposal is to expose absolute measured
> frequency attribute of dpll-pin and follow phase-offset-monitor
> functionality:
> 
> So:
> * add real-frequency attribute to dpll pin
> * add real-frequency-monitor attribute dpll device
> * user will be able to enable/disable monitoring by enabling/disabling
>    real-frequency-monitor feature (similarly to phase-offset-monitor)
> 
> Thoughts?

I don't have a strong opinion. IDK where to draw the line between DPLL
and "random functionality some devices may have". We have 3 DPLL
maintainers, let's see what their majority opinion is..

