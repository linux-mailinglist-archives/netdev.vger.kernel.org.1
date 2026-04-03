Return-Path: <netdev+bounces-274837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAjgEt8Yz2mTswYAu9opvQ
	(envelope-from <netdev+bounces-274837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C760390109
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 835773031673
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7352FF672;
	Fri,  3 Apr 2026 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="U9IwP8Bs"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BFF267AF2;
	Fri,  3 Apr 2026 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179843; cv=none; b=m/O77oo9zBaKDrGiitKrXp21XOdN5ADSrvuek66/D/rYcHDwRo3BL5y+g/8IPKOc6lyuaTbT5J1uuw9YgowI6xys2Y2PVrr5OqndWbfpUGPdbvNVnl6agQUItVwiDviHwnmQeP58Oead2yDut5n7VssY58tBgkHfjh5iTLtgtbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179843; c=relaxed/simple;
	bh=41rbI9tkBVftkufnKoICZNnUcRvfF15AvzqYvyk2F5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A72vq0ATm3ou2ZLfpXjyCm9Da4sf2wvD7Sc6/m2m1G0jznXJW3iY3Cx+XYLNWiNzwqnEj/IFkKF+r+1vI+szK1hEnJd/+9Y8g/fuGiDZBYkdhGqRJdPwqPn0hjF33rGtu84U7SDID6SWASWnRo/8IVAv1XRn3rNM/DZuWfQO3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=U9IwP8Bs; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1775179837;
	bh=41rbI9tkBVftkufnKoICZNnUcRvfF15AvzqYvyk2F5c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U9IwP8BsfYfgTSLZiSEKhsawLtQrMX18FSW8DtxFyF6G2yX1oFBkZ71hnfq3/LIXR
	 8HnzpIWMxuEU1UI1+3Nv27fqNj+GQeZnGBACYzj04gbLxCs0sUCuR/bzMZQ+EZFftj
	 k9HUCZ6eBu2yDxJslbdkK+9XeCJIBHL8cDfqwiIUi6bIALnDzAtcr+wTbe1i08+8lY
	 x9vlAu7Ylo+KfK7shd4Te01SJ1UKla8RMHq6z7N/8C8SN/RIPKg1nBzxQwNrRici02
	 hXmRbuxd8sRYWIIRH6o5zAkbvQXTAtWOQIoiMJGJfFjiMsKSfHBjBtuk2rH5PbcfZZ
	 IUXbWgGPYdx9A==
Received: from sparky.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 391C660C8D;
	Fri,  3 Apr 2026 09:30:35 +0800 (AWST)
Message-ID: <13161369c80209db129c45b6d45fe121f86ad6ad.camel@codeconstruct.com.au>
Subject: Re: [net-next v36] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Adam Young
 <admiyo@os.amperecomputing.com>, Matt Johnston <matt@codeconstruct.com.au>,
  Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Fri, 03 Apr 2026 09:30:34 +0800
In-Reply-To: <0eb9a307-78fb-4a4c-9e63-fb53295b6f4b@amperemail.onmicrosoft.com>
References: <20260330175455.1189845-1-admiyo@os.amperecomputing.com>
	 <4349e9f1668e443f49f193e1ab69cef669941c61.camel@codeconstruct.com.au>
	 <0eb9a307-78fb-4a4c-9e63-fb53295b6f4b@amperemail.onmicrosoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274837-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4C760390109
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adam,

> > On the latter, could you expand on what happens on close? Does the PCC
> > channel end up calling tx_done() on each pending TX during the channel
> > free? I'm not familiar with the PCC paths, but it doesn't look like it
> > (or the mailbox core) has a case to deal with this on free.
> >=20
> > Maybe I am missing something, but could this leak skbs?
>=20
> Yes, it could, but since they are held by another subsystem, and there=
=20
> is no way to access them, it is safer to leak than to free. The Ring=20
> Buffer in the Mailbox layer is not accessable from the MCTP Client.=C2=A0=
=20
> Additionally, there is no way to force a flush of ring buffer.

Sure, but it looks like the messages are essentially lost on
free; a re-bind will clear the mailbox channel's msg buf.

Without a mechanism to purge the message queue on free, it looks like
the only leak-less way to handle this is to keep track of the pending
skbs manually.

> There is a potential for this kind of leak even if we were to transfer=
=20
> the data out of SKB:=C2=A0 the two options are to either leave it in the =
ring=20
> buffer or risk a use-after-free event.

Neither of those are good.

Where is the use-after-free here? Once the pcc_mbox_free_channel()
returns, the pending message buf seems to be forgotten, and so I can't
see how any pending skb gets referenced.

> Bringing the link back up would immediately send the=20
> remaining skbs and cause them to be free, so they are not frozen in=20
> perpetuity with no chance of being sent.

Same here - the mbox message queue looks to be reset on client bind, so
it appears that they wouldn't get sent?

If you do need to track the skbs yourself, that could be fairly simple:
keep a sk_buff_head of pending skbs, remove from the list on tx
completion, and skb_queue_purge on ndo_close.

> Whether the backend could handle this is a different story.

A cancellation callback would be handy, yeah.

Cheers,


Jeremy

