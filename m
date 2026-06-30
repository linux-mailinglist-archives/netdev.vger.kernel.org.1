Return-Path: <netdev+bounces-302893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GcnVAvcmQ2rfSQoAu9opvQ
	(envelope-from <netdev+bounces-302893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:16:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F716DFBBA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:16:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NoyTmhfZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302893-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302893-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F3A53005741
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10883248F64;
	Tue, 30 Jun 2026 02:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F621E098;
	Tue, 30 Jun 2026 02:15:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785756; cv=none; b=K20mKficjrtMZjEv8GHCEQz0gQS02OY+rAV9hQR24SU44ZyDvpQN4BzeN42meFhXgy5mLQ4f0BpR/uam/ROS+s8sAtPJ90fy7AaAum1s51cRL296AhuAVZRL542TbH2IMlCPYX2i0J+S5i0rWO9bgi+dbawjc4SlhnOY3wNaqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785756; c=relaxed/simple;
	bh=m+MxjZF7DIYbp1NRXgJX0dvCxIvrked17cofwHG1bv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bus9FrrhDOrM5tvE+SpLA1mRuBYUAZ6YSVKAPpZUU9rMst5fLMvGtZlvsIxYz6m/i0Owa8lyTqTLLc/vOCMosOxehaqOnwWBoP1MwnEsOU7MgAI3HRWrOkM57zsEXT/1GOOCJcPRQzcqPsZ50bgZuPqy0kCPaBVMGTpWfx2psKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoyTmhfZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398B41F000E9;
	Tue, 30 Jun 2026 02:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782785754;
	bh=m+MxjZF7DIYbp1NRXgJX0dvCxIvrked17cofwHG1bv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NoyTmhfZ1ctskO3qRIQNSiqcyAknsKoP46OAnWIHyiR53FSnlBv4o4puMd/BgVo2P
	 aKD4tT68hEEMpLGBcbg4lRK4J/f7GbJ5oOc2pO1eOpLEiZqNHzo8+WizwIjZ6bFr+e
	 DWSddJKx/wKHfzQHDp+oB8vm9Wfel0Z/vIcnOAo3r4cqKaYqKz0gt1lwBmJI9vq6FN
	 PATwsrgF21xYZQhpclrDpNStiGvdTm9o3amSUGDaLMoYwRDeXoF6VTUiPpYZkSpGcU
	 S4LoOAarksgGquBi8C/k7whMBD9C20vJFzNX3cbNjGPqRnXijLExp4GM0huwj+Shai
	 jWJgEShf2/X5A==
Date: Mon, 29 Jun 2026 19:15:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Cc: Selvamani.Rajagopal@onsemi.com, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v2 1/2] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Message-ID: <20260629191553.0a305168@kernel.org>
In-Reply-To: <20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
	<20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302893-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+Selvamani.Rajagopal.onsemi.com@kernel.org,m:Selvamani.Rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:pier.beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,Selvamani.Rajagopal.onsemi.com];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43F716DFBBA

On Fri, 26 Jun 2026 08:35:18 -0700 Selvamani Rajagopal via B4 Relay
wrote:
> Threaded IRQ uses waiting_tx_skb. Transmit path also uses
> this pointer without any mutual exclusion protection. As a
> result, it might leak skb buffer, particularly threaded IRQ
> runs in the middle of tranmsmit path, near skb_linearize.

Can you say more ? only xmit sets waiting_tx_skb, the IRQ
clears it. So why is IRQ racing with xmit leading to drops?

