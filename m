Return-Path: <netdev+bounces-293318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP/wFxunGmp96QgAu9opvQ
	(envelope-from <netdev+bounces-293318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:00:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3BD60BC37
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C90EB3047400
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB523998B4;
	Sat, 30 May 2026 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdU6//Z+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018939903E;
	Sat, 30 May 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131606; cv=none; b=ljx4nqRh4BzMa/x9LxDE0cDa1SBBeiz+JbJypkwGGcrvAHcdwAhIL6dzzFx16s4YaW5QDS0stdgScns4tLtuYADOsxOcZ+4VfJptxHS5I8buWJRC93hSK8nswueBq1V0sEX20QGnXcHS+OF3yrUWObZj59mwQ9Ik1vEroS2B900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131606; c=relaxed/simple;
	bh=MvjbpLL71y4+zQOMwBan4Qo2vQ2xV2sLjWehOAPUvU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ/KuAUsxMn+3Vw+PaEWsip18bKkZkCjc7ELnANiFjBzhfM0h4/cjlF50Snv9MHnaH3EAGDIPSQkg6Ymlf0XA4Spl5UuTTLjqemxKkV42LcjGrlCE6Cn1cZGKzhy72xMpd9sVOE3ogmVqYygGJLh5MhXsy5g9OCYtSVnZQ1sjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdU6//Z+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7211F00893;
	Sat, 30 May 2026 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780131605;
	bh=tCkX3zxuOePO0xgl/G8aJ7qh6MFUTVrX80ZM3bIG+OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GdU6//Z+InKdr3nS5pCmM0VXPaeXMoPCJGpasxqDehk4RXaOch2MjM+Oqxm24yL2s
	 R73IgTCRm3kwkkt4a0Y7Lv1gsJza8WgaSfne+tdu55hBTffBh7h5qH5yLTgv5YThUf
	 pSrNz/A9Uq5xqRtoxUbCF9vJRn/kWKjViAQHTLjDugd4CX/qN2pCn/KIRPwdEt11WH
	 k01M2Oe1ivhaL3RPXjTMYr1IrbOJa16MWmo51agXg5nnOAszJ8f3v3YppioITOKSnm
	 AVNHLVSNcKfXtJ7Nyp8UyHn67/Kk+9BjKm0LsD+CSsR0CG2FmGqelwwUXXysm1YpSq
	 Fe2clWneEKoBQ==
Date: Sat, 30 May 2026 11:00:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 13/14] dt-bindings: net: add onsemi's S2500
Message-ID: <20260530-adventurous-venerable-buffalo-edd6d4@quoll>
References: <CY8PR02MB92494D02A1209BC9BC72EAC883162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92494D02A1209BC9BC72EAC883162@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293318-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,onsemi.com:email]
X-Rspamd-Queue-Id: CB3BD60BC37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 06:41:35PM +0000, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi S2500 IEEE 802.3cg
> compliant Ethernet transceiver device.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  .../devicetree/bindings/net/onnn,s2500.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/onnn,s2500.yaml

Where is the rest of patches? Where is any changelog or cover letter? I
downloaded entire thread and there is nothing.

Best regards,
Krzysztof


