Return-Path: <netdev+bounces-301161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bCibLSVeOWq8rAcAu9opvQ
	(envelope-from <netdev+bounces-301161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:09:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 316076B0FDD
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:09:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NUn4r672;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301161-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301161-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C7C302C5FC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6FC3CB2F6;
	Mon, 22 Jun 2026 16:05:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7A30F958
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:05:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144336; cv=none; b=bgA2Zf+1dO2schKGSYy5n3P3KMyR04OeFpPz7QUBvLcL59SkRIXtmCh18+2N6Rk98ByscfRefFWbJUpZ3VE4TSxKTO2IjpDtDmhEUZvGoQv8iiDyt+k7RsEhNzw3+N+ePnWobA5QEJrI3LTgkUHICvI6O0KXYly6CNsOZ4F1eRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144336; c=relaxed/simple;
	bh=ssfirgIUMaaVi0ecKU+Nktzvk4V9t/7fwqQ6uDKRp4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnkjCTN+LWzyJTvhFqv2gblrRyHsZJr6SnHbq2YsP0ehkhr6GhmLBfwsM5rVVzcjBcN2HkeDVQ/wSTO1k17SlYEY6FdrKLSamrxhG1GfXXUrxRxqawLFPZhsDFgA9PY9p5QGs5ymMvNCFc8ZumtbghuEO5z83BNVEdRqx16fCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUn4r672; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9EA1F000E9;
	Mon, 22 Jun 2026 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782144335;
	bh=9X5edC1I7/8/R36h9GJFjpEJhTUPLktGwLtvem0cQF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NUn4r672kuVAaPswq8HMwpzurM04YvW+o3NOu1FouZMIQAEZWeIJxCZD520Of37qj
	 SHQ34hN5Z22ORRZm5z+Pyr1qzxVPVZmX2J7WtMw5TdHfLNl4binGxUO8urLdWUPPSJ
	 g8G+rnpUZhTcmYEGma0/wcNmqmjHtSP51afA/Fi7HKN1fV880D9GZhnaiLnaaHpWSZ
	 2GMAOAkqeZqNgtBBKLN9mvXM/HG3DATODSumR5r6UoxpZs2mtpGkRlsZSv3/GsfpyU
	 dXTKja/yRKavVx7j974x2Ak2qwOj2pqxWbJLNe9uGiC/6+x8Wy4f+KpDFkQhxfOxwj
	 UKjrgBuumWnGQ==
Date: Mon, 22 Jun 2026 09:05:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev
 <netdev@vger.kernel.org>, Riana Tauro <riana.tauro@intel.com>
Subject: Re: building ynl afaics requires updating the UAPI headers first
Message-ID: <20260622090534.2af8ae9e@kernel.org>
In-Reply-To: <cec7685e-df12-4501-b851-9c8f7b8b06cb@leemhuis.info>
References: <ade91456-2f93-442c-b76c-28bd7157f074@leemhuis.info>
	<20260618170605.0e2e4dd4@kernel.org>
	<cec7685e-df12-4501-b851-9c8f7b8b06cb@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301161-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@leemhuis.info,m:donald.hunter@gmail.com,m:netdev@vger.kernel.org,m:riana.tauro@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 316076B0FDD

On Fri, 19 Jun 2026 09:28:47 +0200 Thorsten Leemhuis wrote:
> On 6/19/26 02:06, Jakub Kicinski wrote:
> > On Thu, 18 Jun 2026 15:39:46 +0200 Thorsten Leemhuis wrote:  
> >> DRM_RAS_CMD_CLEAR_ERROR_COUNTER was introduced to mainline yesterday as
> >> ee18d39a087792 ("drm/drm_ras: Add clear-error-counter netlink command to
> >> drm_ras") [v7.1-post].
> >>
> >> I finally looked closer today and noticed how to prevent this: update
> >> the kernel's UAPI files (e.g. the stuff that lives in /usr/include/) on
> >> the builder. Thing is: that's basically impossible to do from a srpm, as
> >> those should not change the build environment and can't even when
> >> working as non-root.
> >> [...]  
> > 
> > Can't repro for some reason, but we probably need something like 
> > commit 46e9b0224475abc to add the explicit include rule.  
> 
> Thx for the pointer. So I guess you mean something like the below,
> which did the trick for me. Will submit this as properly, unless
> someone points out something stupid in it.
> 
> Ciao, Thorsten
> 
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index cc53b2f21c444..43d06ecbae93d 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -14,10 +14,12 @@ UAPI_PATH:=../../../../include/uapi/
>  
>  get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
>  get_hdr_inc2=-D$(1) -D$(2) -include $(UAPI_PATH)/linux/$(3)
> +get_hdr_inc_drm=-D$(1) -include $(UAPI_PATH)/drm/$(2)
>  
>  CFLAGS_dev-energymodel:=$(call get_hdr_inc,_LINUX_DEV_ENERGYMODEL_H,dev_energymodel.h)
>  CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
>  CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
> +CFLAGS_drm_ras:=$(call get_hdr_inc_drm,_LINUX_DRM_RAS_H,drm_ras.h)
>  CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_TYPELIMITS_H,typelimits.h) \
>         $(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
>         $(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \

Looks good, did you send it? Please send it to networking if possible.
I don't have much experience with DRM trees but I don't want this patch
to get stuck somewhere and keep causing issues.

