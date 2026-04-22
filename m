Return-Path: <netdev+bounces-280313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPUrL8Rf6GkKJwIAu9opvQ
	(envelope-from <netdev+bounces-280313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:42:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B71442209
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B576A301073B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4131D74B;
	Wed, 22 Apr 2026 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KaFioBzg"
X-Original-To: netdev@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC430F934;
	Wed, 22 Apr 2026 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836542; cv=none; b=lIN7Dpbyl7Nc2opw/MGECyhKqAT8tenPufI8eB/NGHgpRsGsJ0pol/VTSZbRyIjFQ+CwNMEo0gZ9TtTeAwev0Du4j+4JKt9M8hrJEbC+spNzi6eoRg3g0Mt2AD29xwDQR65QxVMrod+Gxj9RsZhd8n4JPXeuRSp4OKm88goNcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836542; c=relaxed/simple;
	bh=IuHHzt4Q7AsQTVMSQh1iItGR2nKMpYGnQsu7gSUH/c4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQKCCocku6NyQOPh4uDiBTRV2/c6DIf+/gjpUaJAWS+k9wzI5FZ8R/LiFoQz/F1/AO8RTei0IXSk6hMnwwLfsXIGqWtSwl6E+Ip6HiaYBqur9zY5PkKB0kzDEdQmSOXOvBBeX9Tk8Ws1xRLrsZDO+XHwtTd1trQXJ26rTujvVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KaFioBzg; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=LYoTaFQjJZPUSyJ5irSiuSmcDT4iSqItHhyvLoqVYF8=; t=1776836538;
	x=1777441338; b=KaFioBzgrQaa2ntQtWO3O5WK+d1rFqADHY8TzJpNKW+IIdZy0lrKBcTGXL1G3
	uFHr4O/RNbIhjbbMbqN+mQt7A3miAL72wBnd3go4pvNan7j5MMj/no/n25jnA08FKAJwMCRThgDsr
	efBOVPwx80iQjBZJGMwhnCPmIqw5f2KSkxFzWeFQ3h2V46T1woXUMxXCFS6BXEMyXY5uJiQjKRuGc
	AYBJXLmRgqnjk0m8w66fUX/MHzWLAGV779eksRsDKtU+UosnmAI7T+NzAMdi8JRCXeQXud2W1IXge
	anYuRDE7Ldgr4mPjV+aieunKLbgT6aXhshaLA1rpNc8m1yjffw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wFQLd-00000003sXq-1hlX; Wed, 22 Apr 2026 07:42:05 +0200
Received: from dynamic-002-242-147-051.2.242.pool.telefonica.de ([2.242.147.51] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wFQLd-00000000xSy-0iz8; Wed, 22 Apr 2026 07:42:05 +0200
Message-ID: <0856a42d87b62d3ab7890c348b1fe9c83e630784.camel@physik.fu-berlin.de>
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>,  Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Wed, 22 Apr 2026 07:42:04 +0200
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
References: 
	<20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fu-berlin.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[fu-berlin.de:s=fub01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280313-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fu-berlin.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glaubitz@physik.fu-berlin.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,physik.fu-berlin.de:mid]
X-Rspamd-Queue-Id: C5B71442209
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Tue, 2026-04-21 at 14:31 -0500, Andrew Lunn wrote:
> These old drivers have not been much of a Maintenance burden until
> recently. Now there are more newbies using AI and fuzzers finding
> issues, resulting in more work for Maintainers. Fixing these old
> drivers make little sense, if it is not clear they have users.
>=20
> These are all ISA and PCMCIA Ethernet devices, mostly from the last
> century, a couple from 2001 or 2002. It seems unlikely they are still
> used. However, remove them one patch at a time so they can be brought
> back if somebody still has the hardware, runs modern kernels and wants
> to take up the roll of driver Maintainer.

They might still be used for retro-computing on various non-x86 computers
such as Alphas, older SPARC systems, PA-RISC and 68000 systems. Please don'=
t
assume that every computer is just an x86 computer.

As for the AI-generated bug reports, I assume this will settle down sooner
or later when reporters realize not every issue is being addressed. Anyone
who is still using this old hardware won't be using them on machines direct=
ly
connected to the internet.

So, why bother? Just ignore those bug reports.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

