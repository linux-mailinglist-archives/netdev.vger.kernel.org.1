Return-Path: <netdev+bounces-270796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC4gCWzEwWlTWQQAu9opvQ
	(envelope-from <netdev+bounces-270796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:53:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C13632FE992
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A9CB3005797
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB2381AE9;
	Mon, 23 Mar 2026 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrdjgjFj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EF36DA16;
	Mon, 23 Mar 2026 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306112; cv=none; b=ng3IVLwDsSa4l1EcR+quxXzBFhErv01QZylLtlMZ6v0qBaKp3eawowd9gx89xPHDB4ptOO4/3bMCy+wJiXO6Udv5a0Is1VYenNEOJQRHef4/YLaGmhxzPneXvrWWS4UORgB2TVt0eAbuFdHWnFESBknkvS2vHJl6eIjgxukaCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306112; c=relaxed/simple;
	bh=0d/AQWSZncGkSMd4RQqlpd8/Vh0YIMtfYCgI8TmwZ84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHUgy58vASrdOE0zR4w7ryrc89YJl/GZhOnyXDV9nJVYM5clQAIhHZYoKaK+IdwWVx8vgCAG4JXZHzeJG+3BgChPs7d21ckB3WpiLKGXpNhOBAE+iVbYBwbuZZOc3nLcLTZGL1Cz+wbkal0QBIwLeoiiHuaOymMMdLKqsMurovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrdjgjFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85922C4CEF7;
	Mon, 23 Mar 2026 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774306111;
	bh=0d/AQWSZncGkSMd4RQqlpd8/Vh0YIMtfYCgI8TmwZ84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KrdjgjFjYq5Hes5RJTvcXNXk++HmpbauD72BDmjrDtCEZ7BdWouaCJeiKmV/SwISd
	 Dcvk+sWaMt+fjmY0tlSFW7td63+yUItn9e1wKkuOmuOfZSxPYDk3II5b5KR+zyVGeK
	 2Nru46BMVeT5UyA8SHHALTkwRf2RL7GvHHbwBmGUlPlPeiZVY5K27gX/QQNrYS3SiI
	 2mXc1xdIfYw3nbTuCsKD9wUcxoQjZLT2HRdUxxBNvSXeo+vQxx6/3c3hZDqIOFiDXg
	 c/m4VcV6PrLX04mQPvhckvaVmY4iInGSubOx58iN980+DAdWec2CYBfvHFun+tv/3U
	 GimJ6Mo6h16Eg==
Date: Mon, 23 Mar 2026 15:48:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, Arkadiusz
 Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, Petr
 Oros <poros@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
Message-ID: <20260323154825.1a2320c4@kernel.org>
In-Reply-To: <7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
References: <20260320105915.149068-1-ivecera@redhat.com>
	<20260320105915.149068-4-ivecera@redhat.com>
	<964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
	<7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270796-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C13632FE992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 14:48:01 +0100 Ivan Vecera wrote:
> On 3/20/26 1:21 PM, Guenter Roeck wrote:
> > On 3/20/26 03:59, Ivan Vecera wrote:  
> >> Expose measured input reference frequencies via the hwmon interface
> >> using custom sysfs attributes (freqN_input and freqN_label) since
> >> hwmon has no native frequency sensor type. The frequency values are
> >> read from the cached measurements updated by the periodic work thread.
> >>
> >> Cache the device ready state in struct zl3073x_dev so that
> >> freq_input_show() can return -ENODATA without an I2C access when
> >> the device firmware is not configured.
> >>
> >> Signed-off-by: Ivan Vecera <ivecera@redhat.com>  
> > 
> > "frequency" is not a hardware monitoring attribute. I understand that it is
> > convenient to report it as one, and that other drivers implement it as 
> > well,
> > but that doesn't change that.
> > 
> > I understand that the code lives outside the hardware monitoring 
> > subsystem and is
> > thus not in control of its maintainers, so you can essentially do 
> > whatever you want,
> > even if it is wrong. That doesn't change the fact that it is wrong.
> > 
> > However, do _not_ try to add it into the official list of hardware 
> > monitoring
> > attributes. I would NACK that.
> 
> Understood. I recognize that frequency falls outside the strict scope of
> hardware monitoring and does not belong in the official hwmon ABI.
> 
> I'm using it here as a convenient way to expose these specific driver
> metrics, but I hear you loud and clear. I will absolutely not propose
> adding frequency to the official list of hwmon attributes or
> documentation.
> 
> Thank you for your time and for reviewing the patch.

Guenter, should this be a debugfs interface, then?

Also an hwmon noob question - isn't it better for the monitoring
interface to report frequency error / instability in this case
instead of absolute value? Or do you not know the expected freq?

