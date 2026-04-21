Return-Path: <netdev+bounces-280250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HnQ6EMTj52lXCQIAu9opvQ
	(envelope-from <netdev+bounces-280250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:53:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB543F90A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A02253043D73
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B503DD50D;
	Tue, 21 Apr 2026 20:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from winds.org (winds.org [68.75.195.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0562F284693;
	Tue, 21 Apr 2026 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.75.195.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776804799; cv=none; b=V7KRisv04vHnvRFFCn4SA7KCpTnwPXVTW/2p/qa0htLUAg9XTLgusCUf1yGJbIQGR2is4yUhwquU9gMj/HVdu1Wy7qewXVGHvCv/yiLoDK1n5iCMLIdY0+IQgXzR0rGYJrNIuc8D8d2O54OzGuOk3lxwA01BoaYY1rHa1OkEmyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776804799; c=relaxed/simple;
	bh=QoFZGLINUdvi6hni0vd5/nD8B8jGX/+CNG7TXvDoxS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SchCJpNtSyo25c23VGWrwpibVdrXi1JNic9dlvteJG829LLgAGqq8sM6mtW1pvexFFphdFJti2nrRMPgCQ9IcrGbMfryoWGcyNagg8xwN3RBma8JK+JfIVBTa36SW+3LfNWJl0sAQm/rWE0draSh6jukjKkRAdnRimH4++7gfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org; spf=pass smtp.mailfrom=winds.org; arc=none smtp.client-ip=68.75.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=winds.org
Received: by winds.org (Postfix, from userid 100)
	id 1F55B8F95F82; Tue, 21 Apr 2026 16:44:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by winds.org (Postfix) with ESMTP id 1E49A13369000;
	Tue, 21 Apr 2026 16:44:11 -0400 (EDT)
Date: Tue, 21 Apr 2026 16:44:11 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Andrew Lunn <andrew@lunn.ch>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
Message-ID: <71d319ef-cd49-e8a8-70dd-cf0763ac6305@winds.org>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[winds.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gandalf@winds.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.982];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AADB543F90A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026, Andrew Lunn wrote:

> These old drivers have not been much of a Maintenance burden until
> recently. Now there are more newbies using AI and fuzzers finding
> issues, resulting in more work for Maintainers. Fixing these old
> drivers make little sense, if it is not clear they have users.
>
>      drivers: net: 3com: 3c59x: Remove this driver

Hi Andrew,

I happen to still use this driver on several hundred industrial PC
installations that were outfitted with 3com 3C905-B & CX cards 15+ years ago.
The old hardware still runs, therefore those cards haven't needed to be
replaced. I keep these systems up to date with the latest Linux kernel roughly
once per year.

I understand the maintenance burden, but I would be delighted to continue
receiving bug fixes for this driver via the mainline Linux kernel if you are
still willing to continue to support it.

Thanks and best regards,
  -Byron


