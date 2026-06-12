Return-Path: <netdev+bounces-298811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C7GLDAKSLGoaTAQAu9opvQ
	(envelope-from <netdev+bounces-298811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:10:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B85067D029
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BalNfR+P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298811-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298811-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27FA53183DF5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52C39656D;
	Fri, 12 Jun 2026 23:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980C37AA99;
	Fri, 12 Jun 2026 23:10:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305854; cv=none; b=suaotCtmtLgOghH1jkQUDq4due96kEAZtMd6zWzITikAiIpGnHO8zHpS2SJIL20Cq8KiRKL4mAPpp/XWefcUdt0Huvj1jqEE4FJBRmOu1ODdC69avj58ggwn+HBoctwPI/QK1/Cn4NnxOy9yW4FjgDyr9IHCtIN+d10JP2krcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305854; c=relaxed/simple;
	bh=owbNvnrYCanQAn9ZLd1/8iPxIPYaPz0E54tizm1FXhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Amr7evqbjf7tZfbSn7JbymIW0osSPcjI88e8D7Mpjkfe0t5PXGnPSVlxZrrm5OAYLr1OgcvA3UHoE5qzmFNJbBBZefKEnzxL6MH0+uO2wiquHQ3tiz3S9979I8ITjyGsTG+eAnSnXMFmu3w/QTXftUfG9q2bPUDzVzqpkSbyJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BalNfR+P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BC91F000E9;
	Fri, 12 Jun 2026 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781305853;
	bh=cxBR9HLfeEgeqLzp1jpM8Z3Rj7wdz+EEYvZpSqY6yT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BalNfR+Pd/9WHDKBqU9Q0EpoMTAoS4TOuwqUYmncVpyfFpZZ9+vjR0zqjxW/4f/Mm
	 Yr6pp/jLE8Z6xE2Di+rF0caZ6tLTZJ1wDwiz/xG1XvgbtfFHbVXVC9Pj1w3S6zvHX+
	 8qY6kH0Kj8eXGBh5sJW7Vlk6jbZi9/e9fFtY5CKWz3eixURVS04y/ID5l9sj643oM4
	 n/bnJZ7GOaznAd6I/oE0nYg3uQfJ+13meqr5n0qkLsKKy+04OV9n0Qe3PcJpFIH/5A
	 OvSqxemxzdQi4yCYXt+J9odIjxCiOj9wQllvPe8Dieb34NMmX/qF2t3rL0szR80RfE
	 B9AkVZy4dGnHw==
Date: Fri, 12 Jun 2026 16:10:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] atm: fix use-after-free in sigd_put_skb()
Message-ID: <20260612161051.2d4df09b@kernel.org>
In-Reply-To: <20260609162107.2865310-2-bestswngs@gmail.com>
References: <20260609162107.2865310-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298811-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lists.sourceforge.net,vger.kernel.org,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:3chas3@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B85067D029

On Wed, 10 Jun 2026 00:21:08 +0800 Weiming Shi wrote:
> sigd_put_skb() delivers a signalling message to the daemon socket named
> by the global @sigd pointer, ending in a call to sk_data_ready(). It
> reads @sigd with no synchronisation, so it can race with a close of the
> daemon socket: sigd_close() clears @sigd and the socket is then torn
> down and freed.

Hm, we intend to only retain the portions of the ATM stack which are
still used in PPPoATM and ADSL. I don't believe the signaling stuff 
is used there. I will post a patch to delete this code.
-- 
pw-bot: nap

