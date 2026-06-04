Return-Path: <netdev+bounces-295408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kwxGDNPUIWp1PQEAu9opvQ
	(envelope-from <netdev+bounces-295408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:41:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7957A642F9B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:41:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=hGq+2h5d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295408-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295408-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C9C3014549
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693083B9D84;
	Thu,  4 Jun 2026 19:39:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979D1A6831;
	Thu,  4 Jun 2026 19:39:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601980; cv=none; b=C4YBJb5ukmGbn79Xnk3L1KLpO5EwWUSxDXrzYeHCT1VT1WqmxtTL8jehHqgHOPeJcgTjK50G3NCLzLL5b8uY3SsTdcBOI13P91uzmi+EDsxGuqtkzCPg5Rexzf7NzFd7u6L8emcNl2LyPygVk2q0QiIUOjjrGPxV/OUv9hzDGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601980; c=relaxed/simple;
	bh=SgnaSwpfBIjjH4vQoz0VwPwIvkSJTMOSRXTx7l08r58=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ghB8IIKq6yLOqUpcAgJf/86mAz0cZng5ptAC7YVRcxIUG9MKQoBQHg5gHrgO7HJNIBzVQmbTM3ZZp+AH68tiLQIKXMbDSE0Ax+n5WWrQXrC/4jBD7Jf0hm1lILSCWt5V6a0JnW4lpho7uCmO0blItueArOUgYyimhUEHRJ0OOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hGq+2h5d; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12467A03DB;
	Thu,  4 Jun 2026 21:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780601967; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ufGEIrrwjnWBCIxsmHUZezk4P+J4iUPqzcuaIUudHJA=;
	b=hGq+2h5d6Hrx2ZITpsu4SuD9waLx5X7iivZ+jRPJOEvSIbhDJUW+3VBHgO3Henbt3Oa5/C
	qE46C+4pZ336LOZOrqWdCEUdFg4Y9Ig0UVW3yKFA87UBim9xKhxfSFQP4uAQjLV2c7/WGm
	mvqSFIPhCsbU44qml/1iT5lMzOty7VzYZR9upZeahgxhetKPavYVSrKE3I6V/CS2BuUQFy
	8ApvrG1y+DAcQd6E8rt07aeMrHr2qFbbuvIem2j18eHt3d5qBp3M1y65qbuNRsIVZvkYz+
	pRc4G98am5jqpy4Gqooa1NWOPODgX2OkP73HSit1gF7sj5GBUCGvQyAJfwuNnA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 21:39:23 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, bhargava.marreddy@broadcom.com,
 fmancera@suse.de, markus@blochl.de, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: convert RX path to page_pool
In-Reply-To: <20260604173205.3989025-3-horms@kernel.org>
References: <20260602094248.4130712-1-nb@tipi-net.de>
 <20260604173205.3989025-3-horms@kernel.org>
Message-ID: <2373b19cef00246c737f687685f0ead7@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:justin.chen@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:vikas.gupta@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:bhargava.marreddy@broadcom.com,m:fmancera@suse.de,m:markus@blochl.de,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-295408-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,suse.de,blochl.de,arndb.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7957A642F9B

Hi Simon

On 4.6.2026 19:32, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/

Thanks, I will have a look and respond individually per addressed 
feedback.

Out of interest, how does this sashiko instance differs from 
sashiko.dev?
The later doesn't flag anything in its review [1], so I'm just curious 
what
I might can add to my local pre checks.

[1] 
https://sashiko.dev/#/patchset/20260602094248.4130712-1-nb%40tipi-net.de

> [...]

Regards,
Nicolai

