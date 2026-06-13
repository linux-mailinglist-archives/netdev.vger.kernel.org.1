Return-Path: <netdev+bounces-298899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id exMmMInQLGqlWgQAu9opvQ
	(envelope-from <netdev+bounces-298899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:37:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16B67D9F2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:37:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=temperror ("DNS error when getting key") header.d=padl.com header.s=default header.b=sLpoyB3B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298899-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298899-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=temperror reason="SPF/DKIM temp error" header.from=padl.com (policy=temperror);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736AB303FDD2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B49B3890EF;
	Sat, 13 Jun 2026 03:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E93630AD;
	Sat, 13 Jun 2026 03:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781321857; cv=none; b=EahNrpzunOf4QhityEtYBEaYAlasI0Y4XPxmhpWqqpnQonobG6xqHNPAZ7uwf6gbkpid2GH1iVKLo3NdQV5uw7vmXgUsmr2B9rRzvIevz29QXrvHPXRu9HlCBBS9fZWsUoG4HYku38aserdUpCsUw8AVQtwi1WlVaiQC5E9DPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781321857; c=relaxed/simple;
	bh=Qz5j3NYVF0nrsmWvtdLPQIxAXyH2cm4x7IGMZTXf4FU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=B5nQ1Z8rBH+jSn262owbUGIGKa+dGueYlPY8GAmravVb5+ccN/5qejmwdZmuUbn+1bmBVcqm+EweF3S1sAXWQbLx7lI+boxz+qObkYCM887I/HdTdoKxeAUgEg/izAiizWBKS4veM+JGTsTaeVjM6qD60SsdLJkbHQD1yWjQMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=sLpoyB3B; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 348F5600B3;
	Fri, 12 Jun 2026 23:37:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1781321847; bh=Qz5j3NYVF0nrsmWvtdLPQIxAXyH2cm4x7IGMZTXf4FU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=sLpoyB3BhbWi7Byp4FtewSSxO4+l9Kl8jkRn9gJpo9IRN2juwVIfqhmn7PqQmkjdX
	 iruBp/Yp4S5jvPG1XaUXRrAkargZCQ2LX4SaSiRIq3zABUBrO7Vw0JBM/ch0pCoT4B
	 OLlW3yAlDLA1jRCA8+Gd7uNrR/d9C4Lo6GpxHjW4paci/hyp3Tbx6rvPFot7NtdIuZ
	 TANzBsJwujKhRQK6ZjvtI9sqUMvwAFjqK4LTXktGpjxZkKHmFpxkKdU5ewSGfg144H
	 Pm0YQ/4z6PE/nbbS6WSjlydLnJg3yyl8qZAPyZOOStO5EM349zyQT8fxIZIdKAcG6O
	 GP/9Cqpy7uZCw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next v7 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260612153656.4c5b8c62@kernel.org>
Date: Sat, 13 Jun 2026 13:37:08 +1000
Cc: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>,
 cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E7B1B5A-ACE1-4488-A600-96FAD88D070E@padl.com>
References: <20260609-net-next-mv88e6xxx-cbs-v7-0-7d5d732df545@luminex.be>
 <20260609-net-next-mv88e6xxx-cbs-v7-2-7d5d732df545@luminex.be>
 <20260612153656.4c5b8c62@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+cedric.jehasse.luminex.be@kernel.org,m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kabel@kernel.org,m:cedric.jehasse@gmail.com,m:kuba@kernel.org,m:devnull@kernel.org,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[padl.com:?];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_DNSFAIL(0.00)[padl.com : SPF/DKIM temp error,reject];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cedric.jehasse.luminex.be];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[padl.com:s=default];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,padl.com:mid,padl.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA16B67D9F2

> Are DSA ports multi-queue? I would have expected a DSA driver to
> offload PRIO not MQPRIO.

(Noting that the example did not offload the MQPRIO Qdisc =E2=80=93)

Some Marvell switches do have multiple TX queues, but a flexible mapping =
from PCP/DSCP values is configurable only on ingress. Cedric has a =
separate patch to do this via DCB APP for PCP. These mappings are global =
on the 6352 family and per-port on the 6390.

On egress, one can use the switch chips=E2=80=99 AVB support, but this =
limits the number of TCs to three (corresponding to SR class A, B, and =
=E2=80=98legacy=E2=80=99 traffic). I have a submitted MQPRIO offload =
patch that does this. This matches how MQPRIO and CBS are used on end =
station NICs, but is not flexible enough to support an arbitrary number =
of TCs. Because of this, offloading PRIO may be cleaner.

Luke=

