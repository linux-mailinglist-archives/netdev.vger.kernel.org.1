Return-Path: <netdev+bounces-294904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pp/cKtSKIGqH4wAAu9opvQ
	(envelope-from <netdev+bounces-294904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:13:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E99863B0FC
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:13:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DrWtfiYX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294904-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294904-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD6D5301AF29
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7D14028D3;
	Wed,  3 Jun 2026 20:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871B36EAA4;
	Wed,  3 Jun 2026 20:13:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517582; cv=none; b=bi8bkpdIvL5um99v2LZFdOMOO3Nb5hBKvxPKSeYhDdabJABrtjSW5+EoKb9S6f6Y9QpKnf6qUI1DXKOvYBAXVaO6tuednkDwPC3uF2j3vhPpHoA5fVoijbCS4PdEQRU6d0DZpG2JstMxcLeKHqxZxVgBgKc8tOQE5aCWYWdWQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517582; c=relaxed/simple;
	bh=4+/OU53/6DRgcz/edi9bWr3r3BpBMEf3EXK6HlN6lf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCqVjsEeprfSfrTBD5gnWj6UOn8YhsMWVWsaaMmahwb4i/1FY0l4xIqkGmCjYVPAYdM3nEWKUA0c5hKHLG5sDmFv80/+Em3oK/Bw3drI46aP2724v+zoF1MMNgeIJpElSAPsy+E7AIgl9Ytos4nYN1bTvhYjoTTLRkZv6+PbxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrWtfiYX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D699E1F00893;
	Wed,  3 Jun 2026 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780517581;
	bh=K+i1Df9kDuRQYRCGNe45rGQ4fhycJKRABdpgHeJsQ3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DrWtfiYXbxD8LvRhGspq1jE5xmfswNcODFItdabPAQsOuopeYhDiwUbPiIbUSzhyi
	 7O7JNSvll49Gcci/uFJRzSDhivH+ULbC5k2azczF85p9aGZsV07pcJ3jWEitpUXjcc
	 nzhwMJ9z8XuH3FchXrlj+OURDXaK7MfTEgJIKRyM9ExIkpOrVQzNnk59lkgIp1XThf
	 +9bQCFoj/6dM+pkOySd2t8sTk1Y8uLa2tSjFFAIBGYZdUUwz68/SqDTbdp9F9QAv2P
	 4Uw6AS/3NB50p7gEO69MT3gLnIqxtx/nVARnvfuzi2opLVOkJO0pfkBkKShzLom/sU
	 aWxj/ZjDia3Lg==
Date: Wed, 3 Jun 2026 13:13:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 johannes@sipsolutions.net, corbet@lwn.net, skhan@linuxfoundation.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: exclude driver and netdevsim bugs
Message-ID: <20260603131300.42490f65@kernel.org>
In-Reply-To: <a0f191f4-3c09-4919-bc79-0b716d1ecc6f@lunn.ch>
References: <20260603162943.2406080-1-kuba@kernel.org>
	<a0f191f4-3c09-4919-bc79-0b716d1ecc6f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294904-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:johannes@sipsolutions.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:workflows@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E99863B0FC

On Wed, 3 Jun 2026 21:25:02 +0200 Andrew Lunn wrote:
> > +Additionally, netdev does not consider bugs to be ``net``-worthy
> > +if they fulfill **all** of the following criteria:
> > + - bug is in a hardware device driver;
> > + - bug is either a missing error handling or is part of the error handling flow;
> > + - bug was discovered by a static analysis / AI tool;
> > + - bug was triggered/observed only with kernel changes or fault injection.
> > +Fixes for such bugs should default to ``net-next`` and should **not** contain
> > +a Fixes tag. Networking or driver maintainers may redirect such fixes to ``net``
> > +at their discretion if they consider the condition to be relevant enough.  
> 
> I would also stress what the stable rules say:
> 
> 	It must either fix a real bug that bothers people or ...
> 
> Many of the bug fixes we are currently getting don't meet this
> criteria, so are net-next material.

I decided to leave that out in the end because it's a bit too open
to interpretation for my mind.

