Return-Path: <netdev+bounces-253995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEvcDXEVeWl3vAEAu9opvQ
	(envelope-from <netdev+bounces-253995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F91E9A179
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92053047E43
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE7336EA84;
	Tue, 27 Jan 2026 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N+Uzl4TN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098F328634
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542982; cv=none; b=kR8qi1icSN7wIwIgHEjwmcfvUNEXzKIwunYKSfsZF5ppkL5vXS6JO0Fjm42Pdkff0Y89BbP3HK4j95BJq6hzExB/KTDJge4ElGquhDsMcV5K2XWvBRr+hlFqN69qcSEwzjslXyFGcfT2m1Uyyj3eOqCoxb/gABStvat5bOUXUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542982; c=relaxed/simple;
	bh=QlhRnv6CvnlLIZN4fQ0n6DM2cafHm0mTorbkIfkFL6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/H1JM9uuPmA+H3bO/tcyG+YAPcQHm5aT5cLKw7JDNHja31xMywWRyPKH15Vj4dwhXcEPW25q1hP1Wm1rNsqEUrmN8cwO3WmdN89ZsB91lj0nDH9RZnhEhOxnNwXHVBUz6GV1a+MH5rbxqoPcRwk/4YajsrFCWMPAcFDR2p6nPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N+Uzl4TN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 85E684E422D8;
	Tue, 27 Jan 2026 19:42:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D558606F5;
	Tue, 27 Jan 2026 19:42:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82722119A8805;
	Tue, 27 Jan 2026 20:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769542976; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LxODmhj+aDB7JQCnHOyVi0D4FK4/h5N30z7wT+UWL6M=;
	b=N+Uzl4TNibP5tniqoiBH0ceWqofhIdCIffbXamfIqUN7Znw7fPEZpa9YrswlVMrhTCVevV
	ATfnSAW727/axlGF0xacqo5ZjKFOcqYyBQnOFVGvtVC2XXZ/1tZAQIesiCVGPEv1pkWcXg
	usNgGFdjVcxacTeEtSKtEa2IJaFW6ut/1u5WryzKEIsddRt+nMT1OVU0gGyVRGKzOgrAdT
	xbmolJiFSd4kTBOWoV1PLYgbYaoG8C7XJ9F39komUK1Fj4IK/NlrwNxC0CucjN/PXOX14f
	DE6h/1Wjql0qbgJccq+/64JO0PjE50ENStLzMxJS7hwXUMX0m4TRmJE2afBdwg==
Message-ID: <30d79989-749a-4d4b-993a-18f3e0bc786c@bootlin.com>
Date: Tue, 27 Jan 2026 20:42:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/8] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-1-652e021aae86@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260127-ksz8463-ptp-v4-1-652e021aae86@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8F91E9A179
X-Rspamd-Action: no action

Hi,

On 27/01/2026 10:06, Bastien Curutchet (Schneider Electric) wrote:
> KSZ8463's interrupt scheme differs from the others KSZ swicthes. Its
> global interrupt handling is done through an 'enable irq' register
> instead of a 'mask irq' one, so the bit logic to enable/disable
> interrupt is reversed. Also its interrupts registers are 16-bits
> registers and don't have the same address.
> 
> Add ksz8463-specific global interrupt setup function that still relies
> on the ksz_irq_common_setup().
> Add a check on the device type in the irq_chip operations to adjust the
> bit logic for KSZ8463
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


