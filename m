Return-Path: <netdev+bounces-288604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIuACI9BCGrCggMAu9opvQ
	(envelope-from <netdev+bounces-288604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:06:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA2155B062
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08D1130146A3
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715F3B2FFD;
	Sat, 16 May 2026 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl+SAExw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CC2264C0;
	Sat, 16 May 2026 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778925961; cv=none; b=iA+8CVzhLHkZXIZq/SbXgvw32G15X5g+YSPady7GgR2qHrLpeKi49MAF2ESLXsWp03IqPnfsDHx8PVQ3rQSSo+Ar+ltdW5IMWZ6vrpF8BUAtc/1qUGKwF2lhbAazkMnt7GYyPdcnYvQ9nJEJm/PRr3wpOgIAZ+kb9CdBXNjDDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778925961; c=relaxed/simple;
	bh=zzqeK95hTYx0BeQC9HkJYH2MZSDaxW1Sst5I12aZS8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9gih9BFP6hasNxXOj8C4D/EaWiPlMnhH+DUDRLPqzzLu3AB5x7Dyjn39pPLI+As7x9JwZzja9EGNssFEOefH9dgX+wq0ZCq2Cy6aCH2NKWB+yHnd2exGcQaZjy/yAXnn3Gfpu4RHjSkukUmPjjAhRVrzJZT5maPX8MUT0Q0ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl+SAExw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC533C19425;
	Sat, 16 May 2026 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778925961;
	bh=zzqeK95hTYx0BeQC9HkJYH2MZSDaxW1Sst5I12aZS8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nl+SAExwSQSfDU8ai8zVSsfZjhUga/M45aHGPA2IdZ8FZ6tMlZAMKJObcuYtJQJJf
	 54G5dyrEB/lcj0zQb+Chykp8sn7JkcR5e/9adXd0VvM1qG8/KQQZuu2Stfp0rw5mlB
	 cgthjvfyeguRCpdq8gSlCVK22LumwvR42DZ3gqFXYaByB+T3C7A/HFrHw6QxFUOkU9
	 QZVT+5Mb30LlywC282PywqnJyeWDKNHYQYb2A5pi0v3D1q/mm7OWuvnQWm5MLlxQ02
	 V/GIZTPXe8vNjlNKB17QK+JBhqgHsc88oT2WZoqxt1HAzTbwFtxzOJ5tOAQ7tSRsi4
	 KZajgKclIQ+sg==
Date: Sat, 16 May 2026 12:05:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Message-ID: <20260516-unbiased-warthog-from-valhalla-2e59a1@quoll>
References: <CY8PR02MB924916514D414B698DEB9A1883042@CY8PR02MB9249.namprd02.prod.outlook.com>
 <ab821805-49dd-4b55-a77d-0f25e0247bff@kernel.org>
 <50e77863-4445-406a-a535-eb620d6fc1b2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50e77863-4445-406a-a535-eb620d6fc1b2@lunn.ch>
X-Rspamd-Queue-Id: 8CA2155B062
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288604-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 09:06:08PM +0200, Andrew Lunn wrote:
> On Fri, May 15, 2026 at 06:15:50PM +0200, Krzysztof Kozlowski wrote:
> > On 15/05/2026 18:13, Selvamani Rajagopal wrote:
> > > According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> > > specification, interrupt type is active low, level triggered interrupt.
> > > 
> > > Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY")
> > 
> > Drop, there is no bug here. That is only an example. Otherwise explain
> > how does this bug affect anything.
> 
> There is a tendency for DT developers to just copy/paste the example,
> and not really engage brain. So if the example is wrong, the .dts file
> will be wrong.

Which still is not a fix here. The DTS will be wrong. The code here has
zero impact currently, it is just an example without impact on
dt_bindings_check or any other actual process, thus any fixes tag is not
applicable.

You can as well remove the flag or write there 0.

Best regards,
Krzysztof


