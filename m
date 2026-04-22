Return-Path: <netdev+bounces-280294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCStIJA66GlfHQIAu9opvQ
	(envelope-from <netdev+bounces-280294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:03:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE4441AF3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 666CD30143EC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D1739EF20;
	Wed, 22 Apr 2026 03:03:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from winds.org (winds.org [68.75.195.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DC239D6D7;
	Wed, 22 Apr 2026 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.75.195.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827016; cv=none; b=IbOy/hvr+yQ85OlSeGKqKTRlA2W4LIInJ7ZMM8lQWYtdsIsnsJic2phrEZPAbB8U0XAvJ16iQbPeGjQoIVC5/y82C8Wl4QULRW98Sa54RuUdQC9Fu3bgHuyzVlPgZHiD6VFbAnlcjfqUxe2zLXnWosVMYEyoJyfsu1TYEzUWby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827016; c=relaxed/simple;
	bh=c7Fvc4+5bu+8SHjEzFP+TF+KORUrQ3V1mUVaVQ+MT1Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lHvXwVQjgjPKLiDdqV3JX1pqcNqZzK87XjC9bcLGuJvqmFcF8p39NOVlcGJAI6HwDyxE+zhPFZg+37Yjj8iTT2dogjjVkF8vgI7TIYMIQmweO71IiwJ0v+mYqw4RQihlD2mbmSPxdufN3RkkNKnhUeolALqg6v3UPBHN7vqKL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org; spf=pass smtp.mailfrom=winds.org; arc=none smtp.client-ip=68.75.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=winds.org
Received: by winds.org (Postfix, from userid 100)
	id C38A48F95F81; Tue, 21 Apr 2026 23:03:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by winds.org (Postfix) with ESMTP id C26F513369000;
	Tue, 21 Apr 2026 23:03:28 -0400 (EDT)
Date: Tue, 21 Apr 2026 23:03:28 -0400 (EDT)
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
In-Reply-To: <e056d348-4560-4df3-85c4-e29393b004e9@lunn.ch>
Message-ID: <9a0bc592-fb74-f646-1752-4359c0ac31a2@polinggroup.com>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch> <71d319ef-cd49-e8a8-70dd-cf0763ac6305@winds.org> <e056d348-4560-4df3-85c4-e29393b004e9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=us-ascii
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280294-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[winds.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gandalf@winds.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.715];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 43AE4441AF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026, Andrew Lunn wrote:
>
> Could you live with v6.18, which has an expected EOL of December 2028?
> If you are only updating once per year, security is not an issue, you
> just want stability.

I could for the time being, but this hasn't worked for me in the past. Usually
what happens is the PC breaks down, and the customer swaps in a new
backplane+SBC and moves all their PCI cards over. I then find I need to update
the kernel just to get the Intel DRM to work properly on the new CPU. Some of
these systems were installed back in the Linux 2.6 era, so I've gone through
several "Intel DRM not working" steps ever since CPUs started getting
integrated graphics. 2028 will come fast.

One thing worth mentioning though--these 3com cards are all PCI. They still
work perfectly fine on the newest hardware. Your subject says you're dropping
old ISA and PCMCIA support, so I don't fully understand why you included 3c59x
in the mix. Phoronix picked up this patch
(https://www.phoronix.com/news/Linux-Old-Network-AI), and according to the
comments, there are still people who use these cards (3c905s were very popular
back in the day). Would you be willing to leave this driver in mainline?

> However, just because a driver has gone from HEAD, it does not really
> prevent us from taking patches for stable. But we Maintainers want to
> avoid doing the triage work, figuring out good from bad.
>
> We have not discussed it as a Maintainer team, but one thing which
> might work is we add a entry for 3c59x.c in MAINTAINERS, in stable,
> pointing to you. You can then validate patches, and tell us if they
> are O.K. to queue for stable.

I'm sorry, but I already have enough going on to take up another maintainer
role. However, I thought Greg had some rule in place that said the stable
branches don't get any patches applied unless they also hit mainline. Is there
some exception for drivers in stable that don't exist in mainline anymore?

Thanks,
  -Byron


