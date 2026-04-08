Return-Path: <netdev+bounces-276306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCIfDKb81Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:58:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8703B7CDA
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30BFC3008740
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB81736CE1B;
	Wed,  8 Apr 2026 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jjglMfJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7536C5B6;
	Wed,  8 Apr 2026 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631500; cv=none; b=HNtkgSI7Y/Ir1RU/k2POaRM15VuxKTqyc5zFRktEP7s3acGBR30G4X9gFWc7OnR/tngxNBplfHJQatuLdI+alaMxDDV1UP+tOSKdYO1raIxKIQPzVWqaepKHSRllBPbhZgz+JTDwpYvtegSPSYP/B9cJCOWAQmHb15jz1psMk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631500; c=relaxed/simple;
	bh=0IrRK8YwlyROKJQt/Qh5eg8d2zgWpn5ILP2DB/PPcgg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FrQ4vurUsbCvA2pzmcYUcUGcdJGtgwSxRBIhPRMgjOD7QZubUbs3wVUct76d6ebyY2ee3uXb63skvi1V2KTq4RZY0Jz9tBwAw15ue66bwHUCRinBH6kdFQRoWCl8X+jZ1kZ1VvebQ/sS9KOjIkm1p8bGWZFOpzm8fCoh6Z0OrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jjglMfJK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D19CA26FD;
	Wed,  8 Apr 2026 08:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775631490; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=khNBRC2qw+U03XwkT37jdHOG44KmP5+Y7D60THK3eOY=;
	b=jjglMfJKIUsdRrgR+F5I9NJuu+EWfjLf+CqFm6e+NmwJJ/cMCtgRjAeaFoeAewTJBDQqNX
	/kRT7APJPfDsW5HmZzlmAP2xDcmNzjn2njO+BJQOWRvPXbgP3KLz+REnNstGHVWyNh6DmS
	t/pzlwqnrJCyrG9i63fr3QFkf0lEXrghfN05LBdcA5ociiEDI8njadGD0tDbNASURMZFeH
	n9ShF/MZ+1qPoEB0L9SRPfjPMqiVHoP2R5k8RJ6pEjiCyADUY3Wvzof+l2YxfaZSDHChZR
	2SxYpuBNN9eV0wqpCEEiKxoz4Q1HrE/vqh0wg7oALPSaLZ9KsuXeVbY4bHe2bw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Apr 2026 08:58:06 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Justin Chen
 <justin.chen@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next v2] net: bcmasp: Switch to page pool for RX path
In-Reply-To: <20260408001813.635679-1-florian.fainelli@broadcom.com>
References: <20260408001813.635679-1-florian.fainelli@broadcom.com>
Message-ID: <96637c0a0c3d20f43abf9769d5cdcf39@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-276306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,arndb.de,blochl.de,gmail.com,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 7E8703B7CDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 8.4.2026 02:18, Florian Fainelli wrote:
> This shows an improvement of 1.9% in reducing the CPU cycles and data
> cache misses.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
> 
> - addressed Nicolai's comments by setting the .netdev and .napi members
>   and dropped the useless comment and .dma_dir initialization

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

