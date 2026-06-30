Return-Path: <netdev+bounces-302895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p0JUO0AqQ2oQTAoAu9opvQ
	(envelope-from <netdev+bounces-302895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:30:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636C6DFCAB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:30:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PwDPzkhF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302895-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302895-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82E48303076B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D60371065;
	Tue, 30 Jun 2026 02:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928AE370ACD;
	Tue, 30 Jun 2026 02:30:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786603; cv=none; b=C6A0RBByB8TrbuTIYPO6TiUfPpWR+lJLYpb4WKKUGu8tAH/uvCFVyLQeQTerd8o83odvvVdoeG11x2+JdkDqPqQDwr73mg04HE9U27Mo9llsNzuRhEEAsu2kvg9VcdG7bKhqViKWJ7wXNVrfkVa1Mtcznnc7lIiaG3Z3IpJcYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786603; c=relaxed/simple;
	bh=vGz1xmoOhcMJWflsgQPsykuacz76OA0Jg1PNP/0+0v0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cyy14hqn0meWdR/piBX/0xLFs8IBusyWQQasFt5rQWQ6OFCKofTVvuzObf36oV4NfWK8XmzGOOVd11oLhMqP/4nJ0uHwBCkbdm/aDio2KeNij38fHbLn4NeJHzPCDS834GFUqfKxoA3fJ7u8+NwYVZ8mz7kBKk+X/v1oKJW7qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwDPzkhF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A795A1F000E9;
	Tue, 30 Jun 2026 02:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782786601;
	bh=L++3hzXL4ngc0TFc47tkEmKfA6rLjeJCPXuHbDDNS3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PwDPzkhF1+ViQrC8oR997CWk04zvb6xPVVr3nlUt7lEsfA2Wbhur0lyMiCjgEwtL5
	 xsJb7rKf/nAaOgouF3/zdpCRHuk8scAvRXWCF7dvnlAYVg1FgOHlTpjEZCPWDtUpeJ
	 ph8mqMj5lq5OAhg86KS6/sxEUVXPIHESjuYcHQv1kuf15wV1A5LjcSsHRNUAE9hdTK
	 xNk6M9N5bRdc4sz1PsWtCz2Xs0n4JH23fYLvrlZ95quI0Zwm5ctQEP73n7X8Qx5YpX
	 bLwQlWdojpkFNgvlroQMHoVH/OpHui6ZefXbbksJ2h0x5VgnCi9CDy/KcBAUWV0ujc
	 BDM4z+67YRVBw==
Date: Mon, 29 Jun 2026 19:29:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Cc: Selvamani.Rajagopal@onsemi.com, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Piergiorgio Beruto <pier.beruto@onsemi.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v2 2/2] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Message-ID: <20260629192959.445776c9@kernel.org>
In-Reply-To: <20260626-fix-race-condition-and-crash-v2-2-b6c5c10e604f@onsemi.com>
References: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
	<20260626-fix-race-condition-and-crash-v2-2-b6c5c10e604f@onsemi.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302895-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devnull+Selvamani.Rajagopal.onsemi.com@kernel.org,m:Selvamani.Rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:pier.beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:devnull@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5636C6DFCAB

On Fri, 26 Jun 2026 08:35:19 -0700 Selvamani Rajagopal via B4 Relay
wrote:
> When oversubscribed traffic causes lot of buffer overflow errors,
> probably due to loss of data chunks, driver fails to find a
> data chunk with end_valid bit set, before it runs out of sk buffer
> space. As a result, assert is seen during skb_put.
> 
> Now check is made if tail + len > end, driver abandons the current
> data and starts look for a data chunk with start_valid bit,
> that is a new frame.

This sounds rather scary. The driver seems to have no length
information to confirm it got all the chunks. So if it missed
a middle chunk we will never know? At the very least this seems
like something we should increment rx_error for, not just rx_dropped?

Regarding the patch itself, I'm not clear on why we need to look
for new frame. Will we not notice the start bit immediately and
call oa_tc6_allocate_rx_skb() (if there is indeed a start bit in the
stream?)

So handling skb-already-exists in oa_tc6_allocate_rx_skb() seems
like enough to start a new frame.

Sashiko has another comment:

https://sashiko.dev/#/patchset/20260626-fix-race-condition-and-crash-v2-1-b6c5c10e604f@onsemi.com
-- 
pw-bot: cr

