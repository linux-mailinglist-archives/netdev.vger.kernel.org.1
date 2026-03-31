Return-Path: <netdev+bounces-273599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEGLKYu3y2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:01:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 359543693C3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8BF9301912A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38333D8909;
	Tue, 31 Mar 2026 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="tdO9rq5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2933A7836;
	Tue, 31 Mar 2026 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958342; cv=none; b=EyD8E+9ihw1exzi8yLPtubHh+0wwurd8MDsUMoGiGAFjyHcTEBU4DhSygZuUU80uqOpnPvV6xqbcsJs9QKN8heuAiJMHJJd3V+UVAqChpLe0jXj/gWeCptMCJzkjPx1NicUbdor/7UYnADRPKBQPv2g9nxCm1iordUny4dxg6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958342; c=relaxed/simple;
	bh=gTTSaOWE824UPhobKypiOi8eXMlQrv2CjgD8/p8SKX4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=J+FYIKTDyrkRKmQzJSscW1WlcGoviO9xRXs9MplNjGKMEAml+KdwaAHROfNtzxZYo957WJwOgrJjaYIsS6YG8s0EUcFmoCWX06dfNrROEG9qXHznovZFnVyU2azsz1Lb376LoUalN/cPvQewl7ywFQBtGfOQE2gvLo/IKMK5Zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=tdO9rq5W; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD81EA56FC;
	Tue, 31 Mar 2026 13:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774958336; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QCfXsdJi5wGllcj48KyH40YLNO5PN/6+4FBGIDXGp4s=;
	b=tdO9rq5Wj2of9pNYe6SrnSI2WKsNFq+cv0wwEd+KNsF804YHZl9LbuTbDnqnuK9ovqxEGs
	eGNIAGUEshYwDhp3wYI/prSAS437Rwv7wBuA7Y5Y4phEpq7dmTybHcR8EivYXr/kkm9AIG
	MLaouuNvRSkiT8p7w3/BL2iPernVD4Vtaq0GYvQIy++H0qjnpIvGlCMqg3YXI7aLc3wFVr
	wmzPsXHX2ZEXLdW1Db1Mw9RcrocMJlBiBbniRhr8osilt0UiHivSh+PrPHR6LdQ0mnWX1Y
	/eVlQNF4YbG5Eqww9TyMWh5lEU9JXKWz9Dfx9ZF3+VbPBWnGvertJ6TWaJddrg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2026 13:58:55 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: phy: microchip: enable downshift by default
 on LAN88xx
In-Reply-To: <acuwvoydmJusuj9x@shell.armlinux.org.uk>
References: <20260330224630.579937-1-nb@tipi-net.de>
 <20260330224630.579937-3-nb@tipi-net.de>
 <acuwvoydmJusuj9x@shell.armlinux.org.uk>
Message-ID: <a7e4a17ed0ae027ee6ebfd5f79f7c85c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,raspberrypi.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: 359543693C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 31.3.2026 13:32, Russell King (Oracle) wrote:
> On Tue, Mar 31, 2026 at 12:46:27AM +0200, Nicolai Buchwitz wrote:
>> Enable auto-downshift from 1000BASE-T to 100BASE-TX after 2 failed
>> auto-negotiation attempts by default. This ensures that links with
>> faulty or missing cable pairs (C and D) fall back to 100Mbps without
>> requiring userspace configuration.
>> 
>> Users can override or disable downshift at runtime:
>> 
>>   ethtool --set-phy-tunable eth0 downshift off
>> 
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> I'm slightly concerned by this commit. ->config_init() is called when
> the netdev attaches the PHY, and also during the resume path - and it's
> the second one which I believe is a problem here.
> 
> If the user has configured the downshift, it is reasonable for the user
> to expect the setting to be preserved over a suspend/resume. However,
> by placing this code in ->config_init(), you will overwrite the user's
> setting when the system resumes.

You have a valid point. Looking at other drivers, Marvell has the
same issue: m88e1112_config_init() unconditionally sets downshift to 3
on every config_init call.

I see two options:

1. Save the user's setting in the driver's priv struct and restore it
in config_init instead of blindly applying the default.

2. Handle it generically in the PHY core, saving/restoring tunable
state across suspend/resume for all drivers.

I'd lean towards (1) to keep this series simple. (2) could be a
follow-up that fixes Marvell and others too. What do you think?

Thanks

Nicolai

