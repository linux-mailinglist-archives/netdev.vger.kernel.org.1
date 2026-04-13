Return-Path: <netdev+bounces-277943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED+sNrxR3GmNPQkAu9opvQ
	(envelope-from <netdev+bounces-277943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:15:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC03E6C1F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E07523001FBC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4A20125F;
	Mon, 13 Apr 2026 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IFth8SIF"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532191D516C;
	Mon, 13 Apr 2026 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776046517; cv=none; b=BrX8IeV0Gmv6E/zuKMMoqvi8DG1KZoLWTkcHM9p0Uh5uK9BthpbkdwSIBLhOZKeb6dUi5prwFCMfT4hdopJmdP1fvCijqF8/uv2+FQc88XWv5VZ2aE8DgFq45GGemcZb+qvYt6V5FUEWvQdZwCBp91yV65Cv43d26hjf153oGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776046517; c=relaxed/simple;
	bh=8yvzwUBfTSB+BRkVyCdiF7/SVQYKgA7dpBfCOcYkv/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+Fk0WQKbqMt4OOVVyQNRNWIGGGy+1MsDpyPZ4Tu6cdsnLWDsepCSdq+yN49DeddaJ9lC2xaxvxBTr0NQDg7Gg05UliBdEijR6dc7vkgl8nBmWE7Q9YyrsccDDZX+iU0WyxliynaRbup9KXhlcTDPsKJM4KMdkag1oYp3v7syaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IFth8SIF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1776046506;
	bh=8yvzwUBfTSB+BRkVyCdiF7/SVQYKgA7dpBfCOcYkv/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IFth8SIFufVJS3+5/72HVIAYax0xNahYIjJPqswlL2BZY88LnUVNTGEs0ppdnkYFj
	 Heot7RPle5czk2ivy2L5D/z5TJPpeEuvLtxrsa8TT6Mf8UP35YTgwY0ud6+i9eaTHp
	 MpytATw0N/rk5YS/eHmaWg0jqKF2DZyhDziKdeYdPw1APnlJVYzWEhTkwLNJpatg6b
	 DhoP+JTmo36qilE8LacUt8hN0wEuzydeyDnley5mOUDr0EVW90JQr6ntiL16s2Rhm4
	 QVfauGqdWm9b02ts43jJL/FESX2JQP5o7uedcLND27IGZXzeKkPG+9fyCFQFqTOL1X
	 DhXmjeE5n3Bwg==
Received: from sparky.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E959060984;
	Mon, 13 Apr 2026 10:15:03 +0800 (AWST)
Message-ID: <34340ac20daba31f2cabe20adfe08ca08fb2908d.camel@codeconstruct.com.au>
Subject: Re: [net-next v38] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>, admiyo@os.amperecomputing.com
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 Jonathan.Cameron@huawei.com,  lihuisong@huawei.com
Date: Mon, 13 Apr 2026 10:15:04 +0800
In-Reply-To: <20260410032441.1844450-1-kuba@kernel.org>
References: <20260405180741.1496198-1-admiyo@os.amperecomputing.com>
	 <20260410032441.1844450-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277943-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CBCC03E6C1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adam,

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy_toio(outbox->chan->sh=
mem,=C2=A0 skb->data, skb->len);
>=20
> Is it possible to read out of bounds here if the skb is fragmented?
>=20
> The skb->data pointer only points to the linear portion of the packet, wh=
ile
> skb->len represents the total packet length including page fragments.
> skb_cow_head() does not linearize the packet, so a call to skb_linearize(=
)
> might be needed before copying.

I assume that we should only be seeing linear skbs here, as the driver
does not advertise NETIF_F_FRAGLIST or NETIF_F_SG.

(that said, this could support fragmented skbs quite easily, but that
would be more suitable for a follow-up change)

Cheers,


Jeremy

