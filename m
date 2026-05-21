Return-Path: <netdev+bounces-290535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANZFNLw9D2ocIQYAu9opvQ
	(envelope-from <netdev+bounces-290535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB75AA01F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17F3532C013B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF6C35AC16;
	Thu, 21 May 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDn4m9UH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6A35676D;
	Thu, 21 May 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377225; cv=none; b=cnBcqHrr3gChh8sQT4xklScWD9RvnCosi8jWCVe7AF2c5SMnTyQJnA7hQPpXeTEOfgMBelD7wdEQFx+5sdO+uS7iXvLD/wXu2ZZsDwPAnQMo1EaYSCP49rgKY3PFjH5pXpeS/YYjbwIFkMGS+P+EBmTXf7k+AhLEUobg67XEqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377225; c=relaxed/simple;
	bh=t3MB2dT888WzKr+4v/7evtWQkQVbGao4c3jS/Wo5p84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DATn3vdJCQb4O6hTtQkvDG24KyIY1shLDNW1C2erEw9W6RqVwSxZX1bm/hcQn0RoIJXMgt9HgplAWAkQowV/4Toa0y5FEslZS0Wu9xlYeBRisahgdkvCPJzf54LlRTn50kVK3tgY1SP60WbjtveZLZadTOQtspTB5H3uhVvBYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDn4m9UH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98A51F000E9;
	Thu, 21 May 2026 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377224;
	bh=t3MB2dT888WzKr+4v/7evtWQkQVbGao4c3jS/Wo5p84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lDn4m9UHiR5bSYmGAkg64Xd2jUY8N0clJz+Yy556FWh3R0SPoyp4tSN3wJ+Qcf51D
	 33em4FlkEUfQyRx8dFQfmLOI/las1Q1jNEd1YXqKtp+bxWX4RxLq1n71yjWmn814f9
	 gg+LZLgazzD6tdm2ehGHl4xwHmbF04+u3ko1gPIu+hMpndx6Ou4AQ2E7XgLJt3pYvQ
	 1kgaFjGNu8BdnZ4lm0dhIee9coqkC/23iyMY0y1V8ncF3R8YjSJZStEKAEESZAwC5f
	 AH6YvFlNsL0ZR3VqdSaKih4MUvRd55cKGU6OYtpQBWBfiRrSkEyt0ZExKZcooRuEPB
	 7WjhfKKK1dO4A==
Date: Thu, 21 May 2026 08:27:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make
 some fixes
Message-ID: <20260521082703.2991393f@kernel.org>
In-Reply-To: <e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
	<e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290535-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EABB75AA01F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 14:17:08 +0200 Andrew Lunn wrote:
> The problem with these sorts of patches is that they often break
> stuff. This driver has been stable for a long time. Do we care about
> coding style issues enough that we are happy to possibly break it? Do
> we want to spend time on debugging it? Probably more time than it took
> to fix the checkpatch issues?

The way I look at it, Maciej is the maintainer and has access to HW.
If we have to keep this driver it's better to modernize it a bit.
If nothing else it shows the maintainer is willing to put in the effort.

