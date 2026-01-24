Return-Path: <netdev+bounces-253064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCDDJi+edGkw8AAAu9opvQ
	(envelope-from <netdev+bounces-253064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:25:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C400D7D3E8
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 973CA300A136
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015672652A4;
	Sat, 24 Jan 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="freSOQkZ"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03413239E8D
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769250345; cv=none; b=Zw8qA64qb/mPnvDSRe+JbWx0KI46l8fzXa2uUZ62D9xNGGf8UIFQwwAw8lMi4uV68q/S03VBcusJoB9XevMKmzxzA+y9yFMzlOZtYsX2DKbNQLiAQbSTTHD01I49b6OPW6RIzWFLw/z7wO9NOCY16xSGoVpEgajgA9SiiS8ocSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769250345; c=relaxed/simple;
	bh=IiAcczMwwovguiLb7lLKzedLwywlNVBhDsNQvelPB0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfR54EKCHN9AAiqSTZJt4F6e7N1/RNs1VJz8y4MGx4XVObUCm6b0IFve1SD6NHA21jcLvBUEF8d7xG6sdanG4Epm+teATCYHTgVmcnkw5NEq1qCcKrLaIblqowSkQuJ+GVfqBIlXrC+Cr6ekVKFIu6Ar1ZyWQrD8mXEFRXVO91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=freSOQkZ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=freSOQkZVucMylTOiHsOyxxE9EEQrKOsPDxJqri4YtWTtBZCHHH2xSmTh0r8tP+dVbmJM3pIBO1EHMTkmzUn6EUg/+evaAgwvq+9TzkuRc+Fls5fhmquDAVcaG86J2hu9A4+fXVtT6geqGUL6e0h1QanrZI9TOgcyVceCY66m9a41xeQuIrHtojFPL87AuTQBfx90tr900ZnkjsS5g1nQHJPa0wo4n68htAFREYwnUXwGATplX6RecN48BdxUm2LJ0w0brqAEFj9CrbxIQIx1J9vIznnnjvT3HndnaVajlAZts1qswzgkom0RYsffNMD+hecNV/OIUSA4bfDDwgk6w==; s=purelymail1; d=purelymail.com; v=1; bh=IiAcczMwwovguiLb7lLKzedLwywlNVBhDsNQvelPB0U=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 323067734;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 24 Jan 2026 10:25:41 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
	(envelope-from <peter@korsgaard.com>)
	id 1vjapo-0000000GHQJ-0ipS;
	Sat, 24 Jan 2026 11:25:40 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org,  linux-usb@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: usb: sr9700: replace magic numbers with
 register bit macros
In-Reply-To: <20260124032248.26807-1-enelsonmoore@gmail.com> (Ethan
	Nelson-Moore's message of "Fri, 23 Jan 2026 19:22:43 -0800")
References: <20260124032248.26807-1-enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 11:25:40 +0100
Message-ID: <87ldhns3x7.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purelymail.com:s=purelymail1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253064-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[korsgaard.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[purelymail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[peter@korsgaard.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purelymail.com:dkim,korsgaard.com:email,dell.be.48ers.dk:mid]
X-Rspamd-Queue-Id: C400D7D3E8
X-Rspamd-Action: no action

>>>>> "Ethan" == Ethan Nelson-Moore <enelsonmoore@gmail.com> writes:

 > The first byte of the Rx frame is a copy of the Rx status register, so
 > 0x40 corresponds to RSR_MF (meaning the frame is multicast). Replace
 > 0x40 with RSR_MF for clarity. (All other bits of the RSR indicate
 > errors. The fact that the driver ignores these errors will be fixed by
 > a later patch.)

 > The first byte of the status URB is a copy of the NSR, so 0x40
 > corresponds to NSR_LINKST. Replace 0x40 with NSR_LINKST for clarity.

 > Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

I don't know the device, but sounds sensible.

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

