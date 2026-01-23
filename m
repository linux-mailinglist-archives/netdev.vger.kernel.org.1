Return-Path: <netdev+bounces-252569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GM5Eny+cmljpAAAu9opvQ
	(envelope-from <netdev+bounces-252569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3C6EBB6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7338C3006463
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E56D314D04;
	Fri, 23 Jan 2026 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CA7x56d9"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA563093BD;
	Fri, 23 Jan 2026 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769127543; cv=none; b=kC4yrw09WGXTWFtNosFNzma1Ma5hWc7VSaWE8sMsLJii+SNQp/BEdM89qfQyeTJjc/zVFYj69WSuSJTpdLn0pKvu7fxJXSg3aXYHfGYPn30bUBkPkZhN5nt9xZ0qsq81uc9BAkRhUOVdtYOpMnnL2dd5vnjzyVPMb6NfTKJg0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769127543; c=relaxed/simple;
	bh=KUeXhNzOOc6EB/KFia+l9G+THdY7qBNpcTgLS5/FbNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X5mZP6lfh9N17nCfb6SpfNLmH74XhESdCOsd7h0hJ3qAtJ7HUArPPRi2hQYeGhlAYi+YzMPf+GuWHgtuzOJjhJziHOl7ID7zYV3aa6JiQsoddxapoHuiFDJZfNoLqCG3OytkaozeHgpVYWiRnY/+6Ac9FyFqZWCW53+zEaWkTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CA7x56d9; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1769127525;
	bh=KUeXhNzOOc6EB/KFia+l9G+THdY7qBNpcTgLS5/FbNM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CA7x56d9wpIc/XQbnugF4IJDkU1kZ6nMAX4X4bit/wj3zHv6XM/lHC42jIHG63zsu
	 gphYtPz8oePEpl54Dn94oQcRDMfRYYbmkP7Or/X2Ebctg1TiJwv8O/HtLjmINzWIEx
	 5sSDW7pI78TENaYKqcfIKA0CESxDwgAT+ryfaJTo3ubWsgWhWTuiiJ0jxL14uvoPnh
	 SOiTKutrRtMkGMDenGq8sYLetfY8aqE/Fp8EcLN7Pp814Kqm84D7p6fyCCg0oxb20P
	 QK5T4qkigzls1rw5p7sAiVVxhPm4SFHV/UGAQld8gZ9AsVlWzpjhPAqwJjJlSl+Rkk
	 k5c6zJwbCCykw==
Received: from [138.44.248.196] (unknown [138.44.248.196])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 763FD7C8E7;
	Fri, 23 Jan 2026 08:18:43 +0800 (AWST)
Message-ID: <9fa316a1a4b16e9f4e1601beeebc5a5e42232dca.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 3/4] mctp i2c: Enable SMBus ARP discovery
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Matt Johnston
 <matt@codeconstruct.com.au>,  linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Jan 2026 11:18:42 +1100
In-Reply-To: <20260122080526.4fe83a3a@kernel.org>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
	 <20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
	 <d681a9d5-ff37-45a0-8398-3e770052177e@redhat.com>
	 <20260122080526.4fe83a3a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252569-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Queue-Id: 0DA3C6EBB6
X-Rspamd-Action: no action

Hi Heikki and Jakub,

> +1 I don't wanna speak for Jeremy and Matt but with their Ack, and
> assuming there's no dependency in net-next I think i2c tree may
> be the easiest path?

Yes, given this is more i2c- than net-related, I would be fine for the
changes to go via the i2c tree there. Staging the core via i2c and then
(subsequently) this one via net would also work, but seems to be
overkill for a minor change to the net driver.

I have some overall comments on the i2c side though, I'll follow up with
those separately.

Cheers,


Jeremy

