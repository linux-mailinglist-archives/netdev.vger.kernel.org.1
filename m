Return-Path: <netdev+bounces-261064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMl0BTxGn2nvZgQAu9opvQ
	(envelope-from <netdev+bounces-261064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:58:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731D119C7E0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48B82304B39D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D332E7635;
	Wed, 25 Feb 2026 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw1yJ7Hf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39082253A1;
	Wed, 25 Feb 2026 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045879; cv=none; b=EO3L44R9kZqSep9AgWut/zUuyoILCHx7s2/Bjg5vn/tgUNzMucFcO6mq2V9/JJI8QZI0KeMFZYccsZXiUmcpb2VTZM3dB5OURlfjSWBzeyS3LUlaDfAVYFkQ5dPd06LrMVLikAhGsihkKeyGGRbgr6DD5D95J5rAFkLbaRSWdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045879; c=relaxed/simple;
	bh=l5gB3iAdS9ntmky3SUwEOwG40yvJv+izzXVfIxZweGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks3B0MMNENvb99VTdS6QXg/EBlV1RYr+Ho9uFUghNVx9/40ZiXqkKE9Vo2nVMQBdhz4kQuN3f0sej6PV7AE4xoUPD3tNgi3i+CplqGwADhonAriKq3eOWrHK9O0tGiLdJjS5/fWG/b8fBry3gxIcUE7lAHukTpf4gbfaeYWPxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw1yJ7Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D03C116D0;
	Wed, 25 Feb 2026 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045878;
	bh=l5gB3iAdS9ntmky3SUwEOwG40yvJv+izzXVfIxZweGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aw1yJ7HfPoVSmAHKwULKkz3nW60igD4YilDw6x6WxMNPz5pohC3esQX3rSAzebNPU
	 XwRNY9oB5hTjIQ+g8BRICzEYWEtepLOo6Idx8j/GxbXlckv5dIhkPKpEx+43P4Y+8r
	 9X4HBl/i48mPDk+BVA+zELDlfYa0SCnr40+m7bmzs0DUxafXcOj75HC7S9QATFK3V4
	 q4G4tu+l5fmaI1IkHONA+m4U5vo7qaWIbfz6TfJjzA6N2Km/EDdO87EVvNGpi74CJa
	 GiPD1a5lpyrgnDHTtvAV+/uu2feQDBk0S8PmbLgVCuimRwHx0LNLDyEmdaoIiwF9CB
	 T0l1x5X6y8HeA==
Date: Wed, 25 Feb 2026 18:57:55 +0000
From: Simon Horman <horms@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] nfc: pn533: properly drop the usb interface
 reference on disconnect
Message-ID: <aZ9GMy5PyfpncXmf@horms.kernel.org>
References: <2026022329-flashing-ought-7573@gregkh>
 <aZ1sjK3LwiLDt4F2@horms.kernel.org>
 <2026022536-douche-concert-544a@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022536-douche-concert-544a@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261064-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 731D119C7E0
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:31:12AM -0800, Greg Kroah-Hartman wrote:
> On Tue, Feb 24, 2026 at 09:17:00AM +0000, Simon Horman wrote:
> > On Mon, Feb 23, 2026 at 12:28:30PM +0100, Greg Kroah-Hartman wrote:
> > > When the device is disconnected from the driver, there is a "dangling"
> > > reference count on the usb interface that was grabbed in the probe
> > > callback.  Fix this up by properly dropping the reference after we are
> > > done with it.
> > > 
> > > Cc: stable <stable@kernel.org>
> > > Assisted-by: gkh_clanker_2000
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Hi Greg,
> > 
> > As a fix, a Fixes tag seems appropriate.
> > This seems to have been there since the beginning, so perhaps this one:
> > 
> > Fixes: c46ee38620a2 ("NFC: pn533: add NXP pn533 nfc device driver")
> 
> Fair enough, I don't normally add Fixes: tags for my stuff as it's me
> doing the backports to stable kernels once they hit Linus's tree :)

Understood. For review of Networking patches it is something we look out
for, which is the main reason I flagged it. But I take your point about
you being the consumer of those tags.

> 
> > That notwithstanding, this looks good to me.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> thanks for the review!
> 
> greg k-h
> 

