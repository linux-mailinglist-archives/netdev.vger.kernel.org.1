Return-Path: <netdev+bounces-283301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BzbD/gk9WnbIwIAu9opvQ
	(envelope-from <netdev+bounces-283301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 00:11:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D144AFED5
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 00:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F200C30059B3
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688CC36A030;
	Fri,  1 May 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VKeGXH6F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AD213E89;
	Fri,  1 May 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673461; cv=none; b=QBTgi/O9WxQQYs8iPAfS/8BGRY5PKEOgW0Yr16UqlDle/0YQvvNqBsz24kbXwfMSS5s4CzS11EZ0XM4lGT03QRaQ6ByxSC/sHvRG5Oew4q0UjDplR7yX76/cDlwMKzneqosX9qoVhecMkA7LVCxO+2D718dzPdP2P35Le3WiLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673461; c=relaxed/simple;
	bh=3IaLyiO5x+rZAfS8rheBjcIu2vFsTjednPq+6k/x2ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRquqYA+bjj/8MJZXB98kbjEegOr7GFrHf2HLQe6Dr49A7vdOJeXWfSu4JvvkTAdbNKH9Afw8OfJceeVDmdhd5VvEPogewZGk3KjJa/D8kxr7N/nJQqXRp5UQUox9eSDDjifi++20FcVyfnI1mP/1yyKwEd2nxI99uJ7c/oCvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VKeGXH6F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MSeDz1CqyVYoGdRYLuuFR3j0br3pqM/UHRg4vW/japI=; b=VKeGXH6Fo6cmo/VrLatAk7a60/
	1yqB6HYwWj2O6iV2nMLvPF35q3AQw7BNqAxiQ8CrGMQ9J/zqZ1kqfIyHQ06f8Hc3RBXsuRCkQcL8K
	+36OK7TmnfIkRJDiVw+bbyr6WgJZP0uxBAe6vGpgCurrxZThXcimc9ZDOCG3U3q6pd+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIw4P-000tGE-UE; Sat, 02 May 2026 00:10:49 +0200
Date: Sat, 2 May 2026 00:10:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.eckerman.ext@ericsson.com
Subject: Re: Re: [PATCH net-next v2 1/2] mv88e6xxx: Refactor 6352's serdes
 functions
Message-ID: <8f2a1956-5cd9-4267-8035-b81024148a9d@lunn.ch>
References: <1a57e151-7fff-41c7-9616-20237c27e935@lunn.ch>
 <20260501210036.1675100-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501210036.1675100-1-fidan.aliyeva.ext@ericsson.com>
X-Rspamd-Queue-Id: C1D144AFED5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,ericsson.com];
	TAGGED_FROM(0.00)[bounces-283301-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

> I wanted to make those functions generic and not introduce new functions
> other than 6321_serdes_get_lane. However, those functions cannot be
> generalised the obvious way because they run with reg_lock already taken
> which would cause deadlock in mv88e6352_serdes_get_lane function.

Ah, the scratch register. None of the other serdes_get_lane()
functions need to read a register. O.K.

So we don't expect the scratch register to change at runtime do we?

Nope, the value in it is read during reset. After that, it does not
matter what happens to the pin, the value in the scratch register is
fixed. So maybe read it during mv88e6xxx_setup_port() and store the
value in struct mv88e6xxx_port?

      Andrew

