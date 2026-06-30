Return-Path: <netdev+bounces-303280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w3+lKsrhQ2rqkwoAu9opvQ
	(envelope-from <netdev+bounces-303280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:33:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123A6E5F9A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:33:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l9gR71D9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303280-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545583119648
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1433E5A20;
	Tue, 30 Jun 2026 15:29:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFB3E1732
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:29:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833358; cv=none; b=tiJOJbVaHaNgB6UeAJxtPjjAaOBOejQHUSsp4z8gLaBvghwdCAHbDXNk/dm5G66ZUCgqjnrgRfHEyTEd2qxrjJ9Cfs0SJDvBSR4b+gscwcZ8S/q6nNpImW17wPl+61ibN7K4zPlqeAZPfrRbYVeOVYnBcR2KYUCnOtfD41Sx5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833358; c=relaxed/simple;
	bh=WQRlvOCE1auyNFN25FfdvwAf8yTgJGPbfJqgPD3mkZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8896pTfqafjxFIB9JQBnsSECskZcBYUzwD9XOX2DQZy0O69hyAzkCQ8CRABXzgVInrXCDC0BGcNfguuGoNn/GaPGdd+Bilf2owpCjH4z24DFngQuh3tfy3n1nIBuylt7keE8NEF4nVxlEk+V2SrwY/MFIrhwDRtKpD//nJK0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9gR71D9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555631F00ADE
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782833355;
	bh=WQRlvOCE1auyNFN25FfdvwAf8yTgJGPbfJqgPD3mkZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l9gR71D9A6uav7d5RvE8QcK9rQeFL2y3W1qche7RQUI9lOP2HhOU7uzwnleAUzXDc
	 H5xzmFMe3gMPOEwSRZqy9u/bJQjUvWcKmo2ID//e3KXWnM2A5FwCLI5whSjBhSYTN+
	 lcwp6M4pno6s8K0fCEvGVh96vBQegwRBPEzKykcKZpHhUMXr+KFvm07eaUZKm3Yk5h
	 rLhaA+01Q0wiv1qrc3JC2BBJBOUCPHTRJ+lpBNpelvyEolCVdX1OkgTdQ3rkdxZZSI
	 wJ3JrwmjqDTYwedbN/JY8gACsAP0ZLdFuRAO47jIJUuO9anmhtrPaBcm63E6d2+4D5
	 Puuc2/AUqIJzg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c127a694ccbso262617166b.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:29:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoM1oVtlIUDKmaCO6VCTYDaMNUAlFojA3dhw9gc99ph7UDODNjA9s+xDwpL0VmSAo8mJETI82k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7nTIFgwmwbMslnyBiIT5Kz8BZAGsSUA0lV9xqITLLyWG5dFl
	soM3Awe0FaAwj0Riq3cyqxS3DmLrnxnaT3IZFR5mOOBVWbUqyYOGMcKUqmXaA2xfgow3i+4z+PC
	dplARoQinm+OuByRo4ai9HcgLDVpNRw==
X-Received: by 2002:a05:6938:a08a:20b0:c12:7e9f:5ae3 with SMTP id
 a640c23a62f3a-c12872a34b4mr141132866b.15.1782833353756; Tue, 30 Jun 2026
 08:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
 <20260614-s2500-mac-phy-support-v5-14-89874b72f725@onsemi.com>
 <20260615041056.GA1426553-robh@kernel.org> <CYYPR02MB9828308552BBC60427E8EF2283E82@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To: <CYYPR02MB9828308552BBC60427E8EF2283E82@CYYPR02MB9828.namprd02.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Jun 2026 10:29:02 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+H5qSep2+Wd6i+pir0fK8NDAdPj=7Ka7+qoG82QZeFqg@mail.gmail.com>
X-Gm-Features: AVVi8CcE2u2osQeWDN_q0N5A5Le8-51ZMka5QYUjnRlp7Tx6YdkygDNIGVndh54
Message-ID: <CAL_Jsq+H5qSep2+Wd6i+pir0fK8NDAdPj=7Ka7+qoG82QZeFqg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S2500
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Richard Cochran <richardcochran@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray <jerry.ray@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303280-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,onsemi.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3123A6E5F9A

On Mon, Jun 29, 2026 at 12:07=E2=80=AFPM Selvamani Rajagopal
<Selvamani.Rajagopal@onsemi.com> wrote:
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Sunday, June 14, 2026 9:11 PM
> > To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> > Subject: Re: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S=
2500
> >
> >
> >
> > And you are missing tags from prior versions. It is your responsibility
> > to add them.
>
> I added the prior version's link under each version. Somehow "b4 prep --s=
how-revision" command doesn't pickup the older
> versions. It shows v4 and v5 correctly as the emails containing patches w=
ere sent in a threaded manner.
>
> But with v1,v2,v3, as each patch was sent through individual email (with =
proper subject line, of course) using outlook.
> I don't know if there is a way to fix this.

While links to prior versions is nice, tags means Reviewed-by,
Acked-by, etc. lines. If you get those on version N, then you have to
add them on version N+1 and later unless there are significant changes
that nullify them. However, you don't need to send another version
only to add tags. The tools will pickup tags from the current version.

The only advice for outlook is don't use it. It is incapable of
following maillist etiquette.

Rob

