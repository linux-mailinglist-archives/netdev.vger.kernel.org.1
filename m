Return-Path: <netdev+bounces-256311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCqJJLsCgmmYNgMAu9opvQ
	(envelope-from <netdev+bounces-256311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:14:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C11DA705
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016413018BC7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7F3A4F48;
	Tue,  3 Feb 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Klqos8dg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpyNwm7G"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019093A1D0C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127778; cv=none; b=uAv2AsL6PQN2XYDi+Z1/GJ3Ae/LdUVJRx6sKGztndeiXkSkXRiwv98FED4Xxi2YXa2h0gVA8/yCIMKVKjOEVWfLaXlOKYwigkf0NbUnc3hgsjcHv50kMI38VNIdOfpjMioFKIjdrTdS/M7A+kATkm+WnWDrJ6AuCqCvLL5ONUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127778; c=relaxed/simple;
	bh=3nnTWDwj5NjRfT3T9Wc43R8aCAhi4vhZEIGpoOzlK/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHkeBCMjAS0Gt9uXoFLrWxCYDEUS6TdqalRDSDSTTemSRqzuzTPsENZ5U1b74NTKGdxNWRwC6aV9L6mq8N02RmrcbTP64WD72vXzC56NTO9uCABmiqKpOEx1HdD7z4ErubK7OSuKH9V1+eHq+Mx/g9B0llZfWJD6g0vfVyBtxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Klqos8dg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpyNwm7G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Feb 2026 15:09:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770127775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nnTWDwj5NjRfT3T9Wc43R8aCAhi4vhZEIGpoOzlK/Q=;
	b=Klqos8dgPSEgwqnOWGNxn4WtuiwC1syi9KEsegcQlfGrm9hOqDeZfzlFVOjqzcOZ2RoKuH
	vdE5dn145FpAHsD8DXyasyZ82M3BnhvOoe424w9xaNbuDj55rchfdgNPsCuv7ukeLUR2mk
	lRP1FBND1PcDWcVxtu1VH0wfIhxUe11wSa/LXJvAn6vHvWjZoqTSS5x4pL0UcphsgP59pC
	KKTHhuZzm1ykKDyBcn/8by6nThWF0HJhKbLujUG9Zi2JkotNN46EqxALUiUPKnaLeDlIrp
	9zuN2rYgTqaVZrPUOpUVOYgawuLvQeuIZV4EBwM7ehxq5LNnUDBsuAVZaE1RVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770127775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nnTWDwj5NjRfT3T9Wc43R8aCAhi4vhZEIGpoOzlK/Q=;
	b=zpyNwm7GjBFB9gT5N7uUrSWYlH8vo7d8PYfG1gMG5neZef+Yi6+nAQnM9BAbn6qMXiPRr6
	3/RG8T/BmRFQoMDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@kernel.org, mingo@kernel.org,
	matttbe@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net
Subject: Re: [PATCH net-next v3 0/8] hsr: Implement more robust duplicate
 discard algorithm
Message-ID: <20260203140934.zBi8LZvd@linutronix.de>
References: <cover.1770041682.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1770041682.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: E9C11DA705
X-Rspamd-Action: no action

On 2026-02-02 15:19:16 [+0100], Felix Maurer wrote:
> The duplicate discard algorithms for PRP and HSR do not work reliably
> with certain link faults. Especially with packet loss on one link, the
> duplicate discard algorithms drop valid packets. For a more thorough
> description see patches 4 (for PRP) and 6 (for HSR).
>=20
=E2=80=A6

All good, thanks.

Sebastian

