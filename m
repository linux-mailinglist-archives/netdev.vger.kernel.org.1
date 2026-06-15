Return-Path: <netdev+bounces-299550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i/tSIl0wMGrAPgUAu9opvQ
	(envelope-from <netdev+bounces-299550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:03:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D2688A70
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:03:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cfVxI7cA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299550-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299550-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 691833010664
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C5411694;
	Mon, 15 Jun 2026 17:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21840BCB4
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:03:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542996; cv=none; b=Zw8zTEzBXWLqr1Z8bdRDFbISKasviwmuHyEefAaEC44KgPnrNcFMkIE/MRo/7Zj5cIQNQpisPqreozrTGf2Dlt0DaE34pdkN22XUnO8UXJozXxPVyleo1cvm8EmVJ9hVisP2e24ORMOsIgiMhesHZNfcCjlcZ46v7DRUs/8Rukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542996; c=relaxed/simple;
	bh=LAgvsSm3zzqRfeDR3s6aovrUPB0zCYjdsBCcI5YcP3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpImvO8WXfFnqypO/7S3GBXBckJ+nW/K5QJ7CHbPxRri5/CzM1crWAK+PQ2V+IIsUpwEYbn2cAeZ/8ZGcNJPW3PamkoJvn8bMO/P0CFr3Lel/bt1OolfEwiM1K1/jYi2w+TnARbI9OINz+3MDUPAaH/QSvXYlbU8HqH1G1WaxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfVxI7cA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A291F000E9;
	Mon, 15 Jun 2026 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542995;
	bh=70BwY3I21eHyg17tKNpV4qCjvxJJIO4kpu4m+7Jt95w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cfVxI7cAHV5UUyEavpMlQmAhnBqMJUDlaNON8fGTha5pYFnf82AP4yWPk/nImiQR/
	 L3ObrcjwJO9C6WV3djG51zkdV2e88dhQmKXQnCnxSiDpK7hYWFs3GGsEMe2Z+6gage
	 2U8WC8mfYDhRY6SSfKQ/tBzZ8SjThFmf8gRiheIhIBf5RCBiBXZlVbdimwctvjt2/r
	 j6OsVezVhqHnU1XPPSEQTS4nudLX+n1ur8BXgSDchJku/38RIHmnr4hRWznRr74vwF
	 3ee4rHfhI7T7ai0KkFU4jXh6W/PRkcKuyO4/sUx/g46icE1LePp45oONizkKcQvbQf
	 devCyZJf85J7A==
Date: Mon, 15 Jun 2026 10:03:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v4 0/5] ionic: Expose more port stats to
 ethtool
Message-ID: <20260615100314.1c0caac4@kernel.org>
In-Reply-To: <4f6de4ed-c687-4d1b-86fd-1c8e63e08fb3@amd.com>
References: <20260610061830.51037-1-eric.joyner@amd.com>
	<20260613165323.4df246d9@kernel.org>
	<4f6de4ed-c687-4d1b-86fd-1c8e63e08fb3@amd.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299550-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eric.joyner@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 296D2688A70

On Sat, 13 Jun 2026 18:34:23 -0700 Eric Joyner wrote:
> I could add the overflow and reset handling (I was working on it for a v5), but
> to me, it didn't seem like it was worth the effort to modify the stat from
> firmware instead of continuing to use the existing driver-calculated stat. It
> wasn't really a "can I do this" question but more "is it worth doing this?"
> 
> To start, it didn't seem like there was a specific standard that the API
> expected; it looked like "copy straight from the adapter if you can, or just
> calculate something if you can't". It's hard to tell what the actual
> expectations for the interface outside of the struct comment since there aren't
> many drivers using it. The Mellanox and Broadcom driver stat handlers just read
> the link down count straight from hardware (though I don't know if those stats
> get reset on driver load or reboot and we're the outlier in the way our firmware
> behaves). The Intel drivers are similar to what we do now in the ionic driver,
> and they just count the link down events that the driver detects, but I know
> that they don't expose a link down count from the hardware.  What we do now
> seems good enough for that purpose? It's bigger than 16 bits and gets reset on
> driver load, so why add more code to handle something that this seems to do well
> enough?
> 
> But, I also still want the raw firmware stat because the firmware has a
> different lifetime than the driver, and so it will count link down events while
> the driver isn't loaded or in a state to receive link events. But since maybe
> that's only useful for debugging, it belongs in debugfs instead? I just thought
> drivers could more or less put what they want in `ethtool -S` output, so that
> seemed like an okay place to put it.

I sent a patch to delete this incorrect stat ASAP. Feel free to add it
to ethtool -S under a name that clearly indicates that it's _not_ the
phy down count in the next cycle.

