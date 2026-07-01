Return-Path: <netdev+bounces-303838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dyppKVCBRWo7BQsAu9opvQ
	(envelope-from <netdev+bounces-303838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:06:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDA6F1BC5
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wp.pl header.s=20241105 header.b=BEw+sOu4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303838-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303838-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=wp.pl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A4223013B74
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA38B39BFEF;
	Wed,  1 Jul 2026 21:06:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E295EEB3
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:06:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939979; cv=none; b=JMTyo9nHMAZU8FjKUApQOUi3ljZibCtjQLe+7RbWBGMdCGtyJ5cv+5H9TyByzct0WmoFxCVpSyIsrCAUU3IxNrDDksSexEbpdS/LnEFndqFLtTKYX7/udRqaoM+/C8UT181UtUnfiFZKh3F02RFmBnz22KRlaQESO35bkwIytd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939979; c=relaxed/simple;
	bh=8LYqQzpLG09bfqLEtTjv93/ItDF0KoR263B1JWwqryo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rzzl49N45zTVapp758LvvbGOKyXG8ZaRGxmjViXJTpxBN6L8Eh12ROVyGjBsjghMu+FSgEsf6wvtsglkigL0KkkMB8/Uc0ZCP1nNUBp/mGLPNCQfPZM0Uv6cqJ5Tyg03vw1hngB2WEnkfQ+ZivxRhh8oqurDgnbfzVeC5UeBIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=BEw+sOu4; arc=none smtp.client-ip=212.77.101.10
Received: (wp-smtpd smtp.wp.pl 8947 invoked from network); 1 Jul 2026 23:06:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1782939968; bh=nxIp2ejdqDSCnNtY6qeUSmOQz7mNR1tzuNm8WC9oE+A=;
          h=Subject:To:Cc:From;
          b=BEw+sOu4abFD2lmkpCivxz2cYXGtPpO45S2HhDa3W8+6iqdY4ok0QP/XcBeE4WQ6n
           iQL3Ab8zKCKIHUArI0tKsx0KUWkIzX1Rv+qPmo6GL3XBsWIGDCYV9BfWIOdjH2Sb9j
           x4hRjpMyuEmAEyg0s3K8XLCN3NCXKGDapTH99Q6NkTT/reIQ9auDRvDRM9EsLpAkYA
           Roo2Hwnz3bN+YuvSciIYgERN2cHfe3kBzMLXfbLCVa2GjvjPjbB3+Q3N8gxjz7e6/q
           rc9yRzNKYzLaZDbT8wjLNf9vljuN77b8RkgNwYCCSb7qLSxkNNw0MVIZ5jfybx6lbC
           i76e6m31it3JA==
Received: from 83.5.235.152.ipv4.supernova.orange.pl (HELO [192.168.3.246]) (olek2@wp.pl@[83.5.235.152])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <mail@birger-koblitz.de>; 1 Jul 2026 23:06:08 +0200
Message-ID: <8c0381cc-3612-4ddf-85ed-df09bd0a9dbe@wp.pl>
Date: Wed, 1 Jul 2026 23:06:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8159 firmware
To: Birger Koblitz <mail@birger-koblitz.de>, Andrew Lunn <andrew@lunn.ch>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, hsu.chih.kai@realtek.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
 <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
 <6677d82e-2b8c-4173-ba6d-6743a5059bc1@birger-koblitz.de>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <6677d82e-2b8c-4173-ba6d-6743a5059bc1@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: fb1e7a58e08da6673ff10da37636e03b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8dPM]                               
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:andrew@lunn.ch,m:kernel@jfarr.cc,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303838-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[wp.pl:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,wp.pl:dkim,wp.pl:mid,wp.pl:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03BDA6F1BC5

Hi Birger,
Realtek recently released firmware for the RTL8261C[1]. I expect
the RTL8159 has an RTL8261x PHY built in. Do you know whether
the RTL8159 firmware consists only the PHY firmware?

1. 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/rtl_nic/rtl8261c.bin

Best regards,
Aleksander

