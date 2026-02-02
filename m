Return-Path: <netdev+bounces-255871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h8/EOheygGk/AgMAu9opvQ
	(envelope-from <netdev+bounces-255871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 15:17:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444ECD3E7
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63F433019155
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A9A36C0BC;
	Mon,  2 Feb 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IjQ2O+PN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I68JenTY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IjQ2O+PN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I68JenTY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D636AB6F
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041877; cv=none; b=cvMD12br+m9BsO1df1bw+K7cTR63z/YpMh2p28PbAtm32mpV30voZ8Eg4+7Y8m0qGs4xGtcqtmtGwKBxTRJvry9bAlQdX4jA05gLNr1loPLR9yf8oI72aolLU/Q57yn8tHXMOrhjAXTJ+1kbr51FwuzYseXJR5gj5saCI8wIF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041877; c=relaxed/simple;
	bh=a6rNx/vaQXkbJwAcZxQqmsztnSi80JszoLORDA0ouWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYiYNwq009wBQ22dZkxIYV4rLpkDSNX28FHef37DSC5REX9GDntkoAOxygOh5RMZylrjmisIiwbcFkeuPx0JueuvfOvbFmLAKetZWCubBIwXgHw36BMc+dyaAf5TWc7elDJLEZSIvFKxBnFRxoBzI1/zPucfwPRLMnw+xDCugM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IjQ2O+PN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I68JenTY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IjQ2O+PN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I68JenTY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 298AE5BD8D;
	Mon,  2 Feb 2026 14:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770041874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6rNx/vaQXkbJwAcZxQqmsztnSi80JszoLORDA0ouWo=;
	b=IjQ2O+PNcwB/DO80vJqzo6PO3zsFmqs0HJbAx88KnrwCmSj1xWRSvqDAfaqhxg3usX2mR/
	JIFKhqIl59RNawWzK7knfuw0O/R15K9Pp+1qKe6R5H1XeNpLzYeC8Ez/rCv6WcaCFJMnpd
	C4YPdAje1hhFOLGNClOJPGR40fsffNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770041874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6rNx/vaQXkbJwAcZxQqmsztnSi80JszoLORDA0ouWo=;
	b=I68JenTYoDIpChNYW3xySkDNldZPSfb6ceyJYqyh9gXkFR5ibItgwz29qXFthl6xSsub/W
	g+u7SKCZvCBf1vDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770041874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6rNx/vaQXkbJwAcZxQqmsztnSi80JszoLORDA0ouWo=;
	b=IjQ2O+PNcwB/DO80vJqzo6PO3zsFmqs0HJbAx88KnrwCmSj1xWRSvqDAfaqhxg3usX2mR/
	JIFKhqIl59RNawWzK7knfuw0O/R15K9Pp+1qKe6R5H1XeNpLzYeC8Ez/rCv6WcaCFJMnpd
	C4YPdAje1hhFOLGNClOJPGR40fsffNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770041874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6rNx/vaQXkbJwAcZxQqmsztnSi80JszoLORDA0ouWo=;
	b=I68JenTYoDIpChNYW3xySkDNldZPSfb6ceyJYqyh9gXkFR5ibItgwz29qXFthl6xSsub/W
	g+u7SKCZvCBf1vDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF5B03EA62;
	Mon,  2 Feb 2026 14:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ICN8NRGygGlNOwAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Mon, 02 Feb 2026 14:17:53 +0000
Date: Mon, 2 Feb 2026 15:17:26 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: only set speed/duplex to unknown, if
 getting speed failed
Message-ID: <20260202151726.36abe1d0@samweis>
In-Reply-To: <aXylwyr2pV0rZAW3@fedora>
References: <20260130111904.144024-1-tbogendoerfer@suse.de>
	<aXylwyr2pV0rZAW3@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tbogendoerfer@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7444ECD3E7
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 12:36:19 +0000
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Fri, Jan 30, 2026 at 12:19:04PM +0100, Thomas Bogendoerfer wrote:
> > bond_update_speed_duplex() first set speed/duplex to unknown and
> > then asks slave driver for current speed/duplex. Since getting
> > speed/duplex might take longer there is a race, where this false state
> > is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding: =20
>=20
> The patch looks good to me. But based on your description, I don't think
> the fixes tag is correct.

the race is old, but it got visible by that commit. Before=20
bond_update_speed_duplex() was only called on enslaving and when bond
is brought up. Now it could also be called during normal operation and
that's what caught attention by customers.

I'm fine changing the fixes tag to whatever we agree to. So which should
I take ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich

