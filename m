Return-Path: <netdev+bounces-307015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vJhiOwGEVGpSmwMAu9opvQ
	(envelope-from <netdev+bounces-307015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F37477D1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:21:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i2AQ7Qq0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307015-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307015-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 273383008A6C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3C37C10C;
	Mon, 13 Jul 2026 06:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F4261B70;
	Mon, 13 Jul 2026 06:21:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923711; cv=none; b=inEjbE6bA6/HtF3sx8jH4ARSjjB2SvM6Bde0nKuGpmlJLzLyyx3gycSM/qo2Ni2xhlnVjvqupK1OQMf7xhto4akqzBbQORL/e06mTA7vzQbrJQKmk9CdITfBMl/8kHozV2LR7RMyZ/HznG351h9o+9YydHLkjzJt3SBN9Syibqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923711; c=relaxed/simple;
	bh=jNDNfyooiOnQ4+cl8linfC1qrE3LXmwVhskMhrutDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm9kX9It3YVnS44ffKp1Qrm/cuxXlPLscnSdT0z8z4CBMtACVDwmUknRIW7cvWJMO7LDmlwkFAFSMbdBW23IWbNOhpLD9OLufmav9Nfr0Z+s61AuCcxWUtJcUx6vXlvWDztpkGViQw+kP0rSW/clV21tEobAF0Ru9BMetQcY33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2AQ7Qq0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A751F000E9;
	Mon, 13 Jul 2026 06:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783923709;
	bh=kaTNv3bKzOu84AByAd/Y5/b77Y1B8vZd+CffeqsQ3tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i2AQ7Qq0KQFRL1idrKsEbe3jRCUAcOwNXf3LPx7/5PnmWw+/y1nB9Bm48XVizpGQQ
	 QdTXNYZLr16kFuTidjdPnOSVWzcciYpTv7ktmXqEyfTgIiOteZZ5Pw5nCkxX4Br/8T
	 PzwHNCY+ZM+1lyPscMKDesbjzAJhD+sHe3xruzf+7Q/wah0wLYkQjJrqHQ3fK5d2qV
	 dWg27f3PkOL5A8rCNZUmQ/pFemAQroIpeMURU6Y2OMS3PrJDEqxDW7rZVAVuSPwYHT
	 tjXd6LU+OnF5w/cnxitI39fbNHe25EMmlJZiR4k6VWmMsn+gu3ZIj4OYnjMGhSeBvT
	 qdNdHeyljBwnQ==
Date: Mon, 13 Jul 2026 08:21:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mikhail Lukianchikov <avermoal@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com, 
	andrew+netdev@lunn.ch, conor+dt@kernel.org, davem@davemloft.net, 
	devicetree@vger.kernel.org, edumazet@google.com, krzk+dt@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, robh@kernel.org
Subject: Re: [PATCH v4] dt-bindings: net: microchip,lan78xx: convert to DT
 schema
Message-ID: <20260713-polite-industrious-herring-2fb6c0@quoll>
References: <20260712113821.12543-1-avermoal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712113821.12543-1-avermoal@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:avermoal@gmail.com,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:andrew+netdev@lunn.ch,m:conor+dt@kernel.org,m:davem@davemloft.net,m:devicetree@vger.kernel.org,m:edumazet@google.com,m:krzk+dt@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:andrew@lunn.ch,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307015-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE9F37477D1

On Sun, Jul 12, 2026 at 05:38:21PM +0600, Mikhail Lukianchikov wrote:
> Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
> documentation from plain text to DT schema.
> 
> Restoring a mistakenly deleted email in MAINTAINERS file and fixing
> microchip,lan7800.yaml.
> 
> Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
> ---
> Changes in v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


