Return-Path: <netdev+bounces-295764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6sioK6+hImr6bAEAu9opvQ
	(envelope-from <netdev+bounces-295764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:15:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA4647389
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:15:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=aa108F2B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295764-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295764-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B8C930CCF38
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E123F1AA1;
	Fri,  5 Jun 2026 10:08:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73672378D9C;
	Fri,  5 Jun 2026 10:08:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654122; cv=none; b=N6tt1YCEiGG6FAnY5KKi99sfBDH2bXVOgqosz7ohkhINseJK3pekbEsMwYjRqVKkkdiXz/uczICyK4M9EJH7xx2UIK4BMZqktJsZPq8HEolmnVsQ1ZIEvCRVf4iKsasm91oo+8IZvFeU5/CTH2Ua3ghHusTGYUGHJeUlVYKg+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654122; c=relaxed/simple;
	bh=lkXo0ekrqfpmrZot/3+CAawtKmUr4MDr2Sq/OMy2bVs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Zt6ys/1Y3+hPXmbsdNeVr+ZStpvxuxAExm9C6CfCRAPwoWwv8Y/JFOc38oMKgt5ehT/nXWkvwnfpvBF5Pf06nhmGHLh01Wny3073L2x8ZicRjUZKL0kJPGqWkUNC3gJstD/nz8TrnhLiLt/zwWkMMvH7uJn0uvOeGwmEIfLBn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=aa108F2B; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0FEDA002F;
	Fri,  5 Jun 2026 12:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780654115; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cPJxATtzRqN1mbowQ/WBc4NP6HJk5fkBbkprFlvxGBc=;
	b=aa108F2BcRZiug4lbaTuoT7Njs4MJgfjjOpUhTNTGzeRZ243sLgbCKY5F3eG2wLjJYKYtr
	r3miKdDBfslu0/ueuVI2MBvLr8Exo70UrHdreQhNmYdT73q4efbVl/2Lb7lM1uj4sNp94J
	cAh/msO+1DC5ADtDw+fmQWcB3VlEdg2Jm0HaLjntnX7jrc2OcJZFIXrTtKm3EKdDs96QAS
	lZYj8Qfp1rGApbeiPpMkauvIzSahStqy09zxbH4m8ENgAwYJVEh+UKmiSIGdkM4bH3Y1Y0
	1p4H+arT+G5oPkS4p0EmgJnk0sCrTlUBTJA1Jhxq3+w68lvjkIgXE7gm89NrEg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 12:08:32 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, =?UTF-8?Q?=E9=A1=BE=E6=99=93=E5=86=9B?=
 <freddy_gu@realsil.com.cn>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
In-Reply-To: <2ef7327934824882a33e43eaca58d923@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-5-javen_xu@realsil.com.cn>
 <b2b2d485db137d26e3838116560f6d59@tipi-net.de>
 <2ef7327934824882a33e43eaca58d923@realsil.com.cn>
Message-ID: <d40ed770fc9067ea6a51e2cc5d80f551@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295764-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17FA4647389

Hi Javen

On 5.6.2026 11:58, Javen wrote:

> [...]

> For RTL8261C_CG, the patches will not be lost after resume or 
> soft_reset. They only need to be downloaded again after a power cycle 
> or a hardware reset.
> So the fw_loaded flag is intended to avoid reloading the same 
> parameters multiple times during the PHY device lifetime.

Thanks for the clarification, makes sense.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

> [...]

Regards,
Nicolai

