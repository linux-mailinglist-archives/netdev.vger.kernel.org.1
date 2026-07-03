Return-Path: <netdev+bounces-304530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lhaPAFy1R2pldwAAu9opvQ
	(envelope-from <netdev+bounces-304530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:13:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1F702B79
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:12:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=0U6BXOu6;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304530-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304530-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5173F307CEEF
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0B3D3D1D;
	Fri,  3 Jul 2026 12:54:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885D1253340
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 12:54:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083250; cv=none; b=nKvaG3RMOZo+epTavH2d4rDEIul98ZTkOB7Ey7zYqbwNc6gia243ILb7yGYfbbdRJtzoaFZ02jNxkzKTFl6pTuX3nzGPWPl8eoaYFxh1HK6EOhkF5ePbid7k/dGXBt2ZYZFosy5JfVhX/rezELdQnBxm2FyfBgsHCeRMZcUSXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083250; c=relaxed/simple;
	bh=dP4keFqcGIcVxoOluJS1CYQ6CA55rLPGoADd2TXq/VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5R33PiIhJBO1GXWUmHhvznLK9UVPdIgxaUXqNuV5IdVPGulxyJhbs8dA9oJHaenSyzwYtZe4QaW0RpDwZA5QPpY4fDJHgTOh9+SxanzNM2E+Yz/cHqoSIeJccZ8DCnbV94Ap1AjG1e8BocprWlkqHCseacSscEM6ijvUOEspfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0U6BXOu6; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2B2FE4E40C68;
	Fri,  3 Jul 2026 12:54:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAE4F60300;
	Fri,  3 Jul 2026 12:53:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD365104C959A;
	Fri,  3 Jul 2026 14:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783083239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=H0+4/bDzyyuZHOvz9wvuQdiXal71eINzazokI7lhRE8=;
	b=0U6BXOu6ixgZYen+TxOzjAnNiLE2Qsx2Sjud9hJINrfUJ9ph15zE1zptVrqpenSmbXrcOn
	OxY1ZQKbB/TDtNrTbV+i39OI36E6jletRIBaBQ7KtX6rdIZ5467zKSxSWOPMwmSFNJ++6b
	b+Y7Wga9WbnFuynfmjz3wDPUJt9pllTu8X0+KF3kwS+ofAAwuXOSTIckwnZDC7+pBG+0bp
	sxIKErBBa2iGofJ2d3Bq8cL1/XDnbFd3djAZhW39RCif3kVcbEqTgME8A1qfS/YLBuDswo
	yyMfwvX7oUeCN/2Q5YoVspkvZO9Rzs86O6bF+71dqz7WY8aMXu7i+66Zdqjo/A==
Message-ID: <48978897-2349-49bb-8c0c-35ffd05681c6@bootlin.com>
Date: Fri, 3 Jul 2026 14:53:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
To: Siddaraju DH <siddaraju.dh@intel.com>, Michal Kubecek <mkubecek@suse.cz>,
 Andrew Lunn <andrew@lunn.ch>, kuba@kernel.org, netdev@vger.kernel.org
Cc: Shubham Das <Shubham.Das@intel.com>,
 Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
 Vijay Srinivasan <vijay.srinivasan@intel.com>,
 Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
 Niklas Damberg <niklas.damberg@ericsson.com>,
 Jonas Wirandi <jonas.wirandi@ericsson.com>,
 Siddaraju DH <siddarajudh@gmail.com>
References: <20260703100537.1109838-1-siddaraju.dh@intel.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260703100537.1109838-1-siddaraju.dh@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-304530-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:siddaraju.dh@intel.com,m:mkubecek@suse.cz,m:andrew@lunn.ch,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:Shubham.Das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,ericsson.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65E1F702B79

Hi

On 7/3/26 12:05, Siddaraju DH wrote:
> Add comment to clarify the physical media 10000baseCR follows.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.
> 
> Link: https://lore.kernel.org/r/SN7PR11MB69003D33489DB1D6B17EF72A9AF52@SN7PR11MB6900.namprd11.prod.outlook.com
> 
> Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



