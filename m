Return-Path: <netdev+bounces-293104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DACAnSDGWobxQgAu9opvQ
	(envelope-from <netdev+bounces-293104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:15:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66894602200
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649673012E8C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1123C1985;
	Fri, 29 May 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="L7vcY5tq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED683C1413
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056608; cv=none; b=dQA6uqkiM6DI5lSySRTOhUXK8ZP3wAXQHVWNQ9DBPbd4Q0shCcdSJmLeIuccCZXXYc5v3N18C9LUhzzi8iunnqAPqfIMYy/t9oXfiQq5gAskUb8ihL9+UM73+ZFVXlDDbrMu+TmGodsGiMVCbGVcKL5Q+r1aHuphENgNxYZN8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056608; c=relaxed/simple;
	bh=3YLhyxuQXmTr+WorJy/HTx2Zqzg40vIRkZOe86U6GfU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLBYA9vmiIVdsPPhGaQy00LiI1ZIeM77DWT5I+FiR677sEqrjN1xjQekcbHEa8+J4p7qz9AFnGrFPkunPGE36BUu7lkAQw6xoESOfGBRIlqGrmoCv5GPlM3Z/XVmQMhAkbdyCQcepQtYFje7RR62mL3klhez1pWouXFqHgqmZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=L7vcY5tq; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1780056604; x=1780315804;
	bh=Rnv85ZuxMtfba21o+Dbot0KoC97dOaoOLejFG58HcJE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L7vcY5tqQUjpacSlgRzBDOQmBLFxocQDWPRh5Qj8Z8LrsqIpdqw6mbJstjpg+ZUDC
	 9zRrcU3awOk8I+fEkndorsMH7LxsgjAkSFQEkTPD4GkvraHD5Opal4MXZ/Voa9zzde
	 IxIHEM/uHVwddAC5ac7E/DAxNRFmhbV/Sb3k/iVxdfw7sCJNzOhTMdAKWPDb/KMdcO
	 scodt404EzTvYRsY1re8eTNvEzJPh/VnRJpM5gMlBWET1j93k6EcoZf/Xdgb9SKjOv
	 mUHax5bteNOYG/eqGNnQkq6EaUHixABCqlnZg8XmFsVOAgDKUCKUDoYThzWMpy/6AC
	 uBSA9rGAS1MJg==
Date: Fri, 29 May 2026 12:10:01 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] doc/netlink: rt-link: fix binary attributes marked as strings
Message-ID: <82W9THErDh2VM03WNf6uSwlZnjw6464YlsKe1DfKeoHgmIwy54P6k6CcI9o4nnCwjQ5msCeno7-tt1qCR_xxN7SzdbOtervSzndYQ4WKp5w=@protonmail.com>
In-Reply-To: <20260528173435.368d8267@kernel.org>
References: <20260526230321.594068-1-one-d-wide@protonmail.com> <20260528173435.368d8267@kernel.org>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 5d26df8262d8a59b887d131fa4ed74f59a414bec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293104-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[protonmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 66894602200
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Friday, May 29th, 2026 at 00:34, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 26 May 2026 23:04:56 +0000 Remy D. Farley wrote:
> > These link-attrs attributes were previously marked as strings:
> >
> > - wireless - struct iw_event
> > - protinfo - a nest of ifla6-attrs or linkinfo-brport-attrs
> > - cost, priority - unused
>=20
> >        -
> >          name: cost
> > -        type: string
> > +        type: binary
>=20
> =09type: unused
>=20
> is a thing, should we use it instead of binary?


Yeah, this looks more useful. The neighboring rt-route seems to prefer
"type: binary", but I guess that's just an omission.

|       -
|         name: mp-algo  # not used
|         type: binary


> IIRC it's expected to never exist in messages but to still output
> an entry into uAPI, which I think matches the situation here.


If_link uapi header isn't generated, so no changes there.


>=20
> Sorry, should have looked closer at v1.

