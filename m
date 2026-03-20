Return-Path: <netdev+bounces-270052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFgnOkSmvWm4/wIAu9opvQ
	(envelope-from <netdev+bounces-270052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:55:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED02E0914
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BCE8304F5F0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E2D353EF2;
	Fri, 20 Mar 2026 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YD+TfJQR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E38353EE3
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035917; cv=none; b=t7JawKPL+vxsmIPvtnGe7CWmMuHP+5NtrTlWnXbyFeZbGcWNs4TgNusAvtX/0cjklG1RuxG7z7U5h8jEMbU/kHDtnXL54cGM/0gn4REEHDr4Urzaf7vK7Vwkpk1Ntr88eTqrlZuR6Xcez/pibK2RJ/heh46UuN2S8A+LQYzTxtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035917; c=relaxed/simple;
	bh=5JNoRIZLe4Ou2jrOMB2xOmTayt+1L7Wmmb3lHWPbiaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNMvegg49MQO0FQyJHLkkCeNWiOSQA/ziDN8MspsV4gST3OvjQvu2EiiRe41j3N/JTKjAYKEzzvz91VhgRPpk9wlhfqyxuhlCTuyD2PfkZOoxd6vgRR+s8R+gv1UPifsPuoEmb/1oraHbtFVi6wYRBgP9vBjJoKiZ79aZ4XywQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YD+TfJQR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A4E744E42756;
	Fri, 20 Mar 2026 19:45:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70AD8600E0;
	Fri, 20 Mar 2026 19:45:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 270C910450CC8;
	Fri, 20 Mar 2026 20:44:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774035905; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BuJW3TBVNL5rt2a/+qn2HmhsvlFQt1It2fxtCdI3ujE=;
	b=YD+TfJQRAhpGsUsFY1kh5fdIAAF9CqyXudXNquKWNdbwBpGhMPzoelzjG3+WgIx5XNsL7R
	jsrKax+pF5ksGNfZTGtnPriCmgokA2WESmtTDLD5saZ86cMGE6mY0T0v0IKHJjm+oT4iC5
	VIlyiZmCWSO5Ht7EblUn8yoZeiy/9aZTxdZXshMUwpHVNZtlqz83MSRq369qjm/GU2EaET
	Wsibnb/r2t+MO1DwsDOTcmrRV6LYILCF6ynf3EmEAKmXw8wZGWho3hXuLdWZFJjAkP0+zQ
	Y/UZ3xIPm1CuqpmSs0iQ7LNDzMyC1idDAB2iD7uzaaYs0J4mrGohaPPPYS9HcA==
Message-ID: <5bfb0ca5-1618-48af-824f-07bbf7c35e9a@bootlin.com>
Date: Fri, 20 Mar 2026 20:44:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: stmmac: cleanup stmmac_xmit()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <ab15_JvLGFtUH_3x@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270052-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91ED02E0914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rusell,

On 20/03/2026 17:46, Russell King (Oracle) wrote:
> This series continues on from part 2 of the descriptor cleanups, making
> stmmac_xmit() more readable.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 103 +++++++++++-----------
>  1 file changed, 52 insertions(+), 51 deletions(-)
> 

Tested the entire series on Socfpga, no regressions found, and perfs are
the same as before so for the series,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


