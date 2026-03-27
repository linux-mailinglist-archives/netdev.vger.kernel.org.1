Return-Path: <netdev+bounces-272608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABluKPOlxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:44:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3C346F43
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B9630EDD8C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292F3115B5;
	Fri, 27 Mar 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zMTCFLg0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639030E821;
	Fri, 27 Mar 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625908; cv=none; b=qK3H0C26IwnmyiQgE0I3vSbgUWnnM5FAVZzCKYCJ5gKG1fFo9v+jcDW/cSqdM5M7FbuDS3LS4avxJuHBZOWD62lw+T9FbhW4NrbL7d4Tmrfz82Bk1iPEaMLAJlcBNIkatgSv/PPxvnacYEpxnGgS/W8kUVQ0moJrliI11v7Yt60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625908; c=relaxed/simple;
	bh=pA2EwxkEld2ssemKizAe5hQR2w01KUN4aLJDOVobFxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/2zzXSL8xnqpJleUscTKD0HUCYRxYPaq/wEIa4dXx6Ndfqdr86dLdyX3Li+CvJue9UTUyHYpyK20lXzjJIVRttnIBvt5QSF1sPZnDzFvWEoVM2oGhkmsRbcAFg4/xpskJCp1sFDlzjbECkwOPmTsEaQ6bYGWbQjqu0Bgw5Fxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zMTCFLg0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 557D54E42820;
	Fri, 27 Mar 2026 15:38:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FC8760230;
	Fri, 27 Mar 2026 15:38:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97F3A1045138A;
	Fri, 27 Mar 2026 16:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774625904; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=em5pndcd+UXa90bf0uQRKcc4Na0SqWRPy7T2u1ZT41Q=;
	b=zMTCFLg0YnXCw7FgrqKZSQMfvWaCIWYEbG8Ll6pcQvX3ITyHXKwahZuGxQ1QIXlM+TMz7q
	931qhl9eX9r/oSdBFgAWDch8jVR6BWk2xEm4NHa84bj+4/rAOBaXAE5ZLzfKWSdTUfyBFc
	Qm1/gdhbcTm4f/mMxiK/rjLtmUaifjueyl2KDxpMaHBqqBPrGM/RZVz6ibde2A1LGIY4VZ
	rS4JE9iUbOWb/xLHU3R0DUttaDBdCDCVR/A3WcwUAEl2W72f4isR/2J7MCcfViC2NGYpqT
	2yXJW0bMR6oP74GLRGhqyUPMWSg5KFN5hacUNs74AqGT3e413LjPshPbJmpTnw==
Message-ID: <25661481-7d17-4552-9899-56d1fe9e5bd6@bootlin.com>
Date: Fri, 27 Mar 2026 16:38:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Marek Vasut <marex@nabladev.com>, Vladimir Oltean <olteanv@gmail.com>,
 Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <20260326094211.hdaf4tz7lbjyjznn@skbuf>
 <2848158c-a807-4d26-be87-248d4107c5b4@bootlin.com>
 <80e21085-84b9-4ebd-9a60-1d7acfc1a56b@nabladev.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <80e21085-84b9-4ebd-9a60-1d7acfc1a56b@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272608-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nabladev.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.916];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EF3C346F43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Marek,

On 3/27/26 3:55 PM, Marek Vasut wrote:
> On 3/27/26 3:47 PM, Bastien Curutchet wrote:
> 
> Hello Bastien,
> 
>>> FYI, the driver is in a restructuring process. The ksz88xx_switch_ops
>>> will be split out of the common ksz_switch_ops. This will conflict with
>>> your series, so you should rebase on top of that much larger set.
>>> You can coordinate with Bastien Curutchet to see what is the status:
>>> https://lore.kernel.org/netdev/20260313153849.qkfzv5c2u6fepjku@skbuf
>>
>> Indeed, I'm currently polishing a first iteration for it. I'll send it 
>> ASAP.
> I would argue that this low-loss cable errata is a bugfix, so maybe that 
> should have a priority over restructuring ?

Yes, I'm fine with that.

These three patches aren't big so I shouldn't encounter much difficulty 
to fix the conflicts on my side.


Best regards,
Bastien

