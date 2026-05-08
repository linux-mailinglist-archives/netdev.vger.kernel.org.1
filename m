Return-Path: <netdev+bounces-285573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNjzCzpF/WlDZwAAu9opvQ
	(envelope-from <netdev+bounces-285573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:06:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD984F0B18
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424B5301D078
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C437A21FF30;
	Fri,  8 May 2026 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Sm2QI0/i"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073C2F8E8E;
	Fri,  8 May 2026 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778206005; cv=none; b=lBsg5yJp+UxDZ80lejoL6INlPk4I1IEKiCY5rnHmNqGTpokXWTdLvbybQ7i5L5O5QUj0A+cFyYShn1RroC9Wg8H+2YxGDPjXaHHyiwMclPyqH00U7FtOqh0MXA4K+BvQnXD/1eYfW6rI9W/TbTXR2WYa7Zg+iKudvADpJu4cizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778206005; c=relaxed/simple;
	bh=0h/p+5gSo3inJV9RuQjYvBsoHHpEDzLNu1QCe8UZMS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpN1Q1pPvmaa999oa/QrnvMgGwZF9MOVUEjM6h4g4H6mggJQ8HvkIDxGrdqRnFLRGg4UsY9O3DECPeX/yHBMTPHWVsVcS5m7QHuEwoYInHdXY3lpbZBShB1LpHC2FKNdCc8zuaPSa1BR7aS8dRHVNHFTCW+l0i1LAPfVligfato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Sm2QI0/i; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1778205994;
	bh=MOhn4QmebkhShCc1sFnnlHikc6nT9JhWiC3WCJ/X+vk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sm2QI0/ipl97Bmd9AwmmeRXWkDeHq14PqHWfRw81NZDMCnapxBs5bH1ICt8ZkdQdV
	 DEA61J1pLS0EIfj44xUakFeu23LwITwnDsTLGez3mjXsuyjYHCkjjg8KTb4gjaG/Kt
	 JjdGJOxFZAmLYeAa58JA6Ml3SYqKWy82yuYsVfiBYO4d/wwzX1L1wS4Wa8TWhhYxNG
	 jEd3WxEhALtGP8XZeCVXv6JXV5t9X2GGXKmlCUIKY30UYW1CYa9AyHWqhLaLgVZofz
	 puoNgkc9PZ/3k/qeWVG1lz5Jc4ifCBJyE9wCe/I18slGsgfBi5zJwp0e8I9Xy4TA3y
	 efeewA2+fe4GA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CCDCB60007;
	Fri,  8 May 2026 10:06:32 +0800 (AWST)
Message-ID: <eb32969e8972fdda8e1f3a96857a585f5e8769f3.camel@codeconstruct.com.au>
Subject: Re: [net-next v39] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Adam Young	
 <admiyo@os.amperecomputing.com>, Matt Johnston <matt@codeconstruct.com.au>,
  Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Huisong Li <lihuisong@huawei.com>
Date: Fri, 08 May 2026 10:06:32 +0800
In-Reply-To: <3ca74f8c-fa9f-4a26-a54a-90ab4fa652cb@amperemail.onmicrosoft.com>
References: <20260506214327.276069-1-admiyo@os.amperecomputing.com>
	 <04015745fb7223f6d7dc262ae505daf0272586fb.camel@codeconstruct.com.au>
	 <3ca74f8c-fa9f-4a26-a54a-90ab4fa652cb@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8AD984F0B18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285573-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Adam,

> > This reads as if you're not updating stats at all, but you do so in
> > mctp_pcc_tx_prepare(). I don't think this comment is necessary - if
> > you really want to mention this, add a comment on the
> > dev_dstats_tx_add() to indicate why you're calling it early.
>=20
> This comment is in prep for a fairly large change in the PCC layer to
> address it.
>=20
> This statistic should be reported in tx_done, but cannot be done safely=
=20
> yet.=C2=A0 The fix is to get tx_done out of a hard-irq handler. I will su=
bmit=20
> that as a follow on changes to mailbox/pcc.c and mctp-pc.c

That's all good,  especially if there's a fix coming, but my suggestion
still stands - it would make more sense to comment the stats update in
_prepare(), rather than the absence of a stats update in _done().

Cheers,


Jeremy

