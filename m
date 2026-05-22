Return-Path: <netdev+bounces-290961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O+7C6XtEGrlfgYAu9opvQ
	(envelope-from <netdev+bounces-290961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:58:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B4C5BBA2E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32B583003481
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F33932C3;
	Fri, 22 May 2026 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlOfNPrc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209238D6AD;
	Fri, 22 May 2026 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494303; cv=none; b=TwkqsZwfTdEbSY8LqrmAbiEGaM1NbHv0z+iibXMiS6YAEDhBf0WxSIu1+/7E5elRgJEXQJJ6ZoFSkFsCAO0C0I2puG2fHbzKZqrR+t5diKVfNllu9s83Wv+ichnEpurTzunJ3lxDpo60MKhWFj2MjjxeooIteApz08JxunIFTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494303; c=relaxed/simple;
	bh=brQup3uzoVSTciLB4KM72wyoJIE1Okg5dZ7B754vboY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1nT0jHSrOkHOSF3wUQIvBrNv8GG86QjwHrqOkCEXLaYeJCnA72RXurNFsjFyDHp5cBOrthVAZ5WvuJo2zZmRap5B16a7vjo6tazIl/RoyixZfWwrcYGrSpXJwQhGeQftvpNUAFzdpIj2dDzxUa0Q4dpC13oXYOO6IotIP+kQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlOfNPrc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A91E1F000E9;
	Fri, 22 May 2026 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779494301;
	bh=YVFRXy8GPhaOYTDXf0ot4kZNFo8f5iA0Ix5mvjPR5MI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jlOfNPrcpKxcUgYfIpewHpiSotZIbmpK9wQmS5Nr5/OYcUJXxra2f/rIYi3UtKIhc
	 37tIF/77l8fwnIkUlOLzRIi84xv/p/7FRnYJOAAJrtSrF4+/hox8iu03l8WlCW7C3R
	 EVvrvUH0+XBeQQYGRGJ4sjbNXwJyCEMPOWkvbM83HwBUF3zYi8NwIr5XvwATKS8CbX
	 cjhreQvjlxdH2QbpkogZWwmtA8xH4hW+LNrmZFfWEoK3++HcfJelRgg9TpXDscXZQn
	 m4EQeEPGUJMpHb8QyMo0Sg4VwHA/PsdPgNNOQtT1HksR4NuOfkIkew7jPwNROm8QBP
	 zC9Zs1GtraJdQ==
Date: Fri, 22 May 2026 16:58:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <20260522165820.04839729@kernel.org>
In-Reply-To: <ahCtsVA1VhYmhZq-@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-10-6bd70e329df6@kernel.org>
	<20260520085934.54AD01F00894@smtp.kernel.org>
	<ag2t4eVe4DcfU2yZ@lore-desk>
	<20260522112514.1ad6e947@kicinski-fedora-PF5CM1Y0>
	<ahCtsVA1VhYmhZq-@lore-desk>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290961-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 25B4C5BBA2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 21:25:37 +0200 Lorenzo Bianconi wrote:
> - What happens when device tree does not provide MAC addresses for two or
>   more same-side GDM interfaces?
>   - This is the same comment reported in [0].
>     Since the hw exposes just a single register (REG_FE_LAN_MAC_H or
>     REG_FE_WAN_MAC_H) for the LAN/WAN mac address MSBs, we need to
>     require all the interfaces configured as LAN or WAN to share the
>     mac address MSBs and the user needs to select the new mac address
>     observing this limitation.
>     Please note this limitation is only valid if multiple net_devices
>     are configured as LAN (or WAN). Since in the current codebase we
>     do not support multiple interfaces configured as LAN or WAN, we are
>     not introducing any regression.
>     I do not think selecting a "base" for the mac address is helpful
>     if the user does not provide the mac address via the DTS or NVME
>     (as suggested by sashiko) since it will not help us if the mac
>     addresses configured via DTS are "wrong" (if they do not respect
>     the limitation described above).  What do you think?

If the MACs are not provided something is obviously wrong with the
device. We should try to provide enough functionality for the user
to be able to troubleshoot. For an AP perhaps that means SSH / remote
logs? So switching/routing doesn't have to work, I'd think. 

Will the user be able to log in when REG_FE_LAN_MAC_H does not match
the MAC of a port?

