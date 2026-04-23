Return-Path: <netdev+bounces-280882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEVGNgiX6mnY1AIAu9opvQ
	(envelope-from <netdev+bounces-280882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:02:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE79458080
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2ECA3005176
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3DC33DEF2;
	Thu, 23 Apr 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nICZytuC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C11F1932;
	Thu, 23 Apr 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981761; cv=none; b=herrVonBIAIaHt6ujP5XTtYFcjNTk+FL6hXH5NDWkDjwgcbDz3FtLrzv7qs2DZhmLni7VBhBtBdRfxxtO3GgFEtiIz3fzivoXEdzKlvdcBKbdIOMKm4hTdyYx8GbvEX6NI7GnrT15r3o0vsCL6pA+WI9J1/ZWc5d6Owkt3M235c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981761; c=relaxed/simple;
	bh=iesPwsztrmjzqui51g0i4ZUJjHRh01BEx/nK4WBofiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfS0ADj0l8IkFp/FFk1gJOjhE5Kk4tbhSlKeS2AZl+O+NQaeqcuVkpEFvnOCBOnHboVf1m+NE/a5m8bR8Z+3D1KVQdz9uCSE9zg/d8qWGRKHWAMQt4egvIc0M9stAJDp8IM8sJVYc9EYsY5Ajybq4LrhBkIdPsBSRNwWZJsM6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nICZytuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E931FC2BCAF;
	Thu, 23 Apr 2026 22:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776981761;
	bh=iesPwsztrmjzqui51g0i4ZUJjHRh01BEx/nK4WBofiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nICZytuCKFQx1NjUGnK00MlvMZ6BTkRxWuArGYeg7uSAoyotoI5/n4t5tcrHYpN5E
	 X8GHApH6zuetYq6cytvOKH8mh3lUPOlm/zyXh+nsvfKowVoc09bNmUIZqmFh+xc2ig
	 AEpr9ftRmvzoQJrUt0gbv2fzKbvdFTgQhbn8WZ8Jqvtx6hcmc2R0cVyo1j1SJEwJvD
	 0rtpedsKqqsFQTse7FsMeb8gzXK7EsoKsGiZ3ZfOZMaV1/vQ7qh3iWXfSsN+aJIDGJ
	 dP2a1MaJ6DXgdShAvpMDtlLnm46sNF+D4bgElxfEICpjqQJo8qmNhBhI2AebrByk8R
	 cgtgFUn1MgGyQ==
Date: Thu, 23 Apr 2026 15:02:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Daniel Palmer <daniel@0x0f.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andrew Lunn <andrew@lunn.ch>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Paolo Abeni	 <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet	 <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Fritscher	 <michael@fritscher.net>,
 Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-m68k
 <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH net v2 10/15] drivers: net: cirrus: mac89x0: Remove this
 driver
Message-ID: <20260423150240.07c350a2@kernel.org>
In-Reply-To: <aee0393e2a2bd5a5d0bf8aee758122633e54aa06.camel@physik.fu-berlin.de>
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
	<20260422-v7-0-0-net-next-driver-removal-v1-v2-10-08a5b59784d5@lunn.ch>
	<CAMuHMdV-vF6sTvAi8kKzxGwZ9YUSBO1Qta5PDCRbA0zr-LEp_w@mail.gmail.com>
	<c0c80113af470b265650405fa24deefe2d82ea24.camel@physik.fu-berlin.de>
	<CAFr9PXnECog56b+Jq9TBohhQ4oBB3hGV1pHj6OstOSLqkOpcTQ@mail.gmail.com>
	<aee0393e2a2bd5a5d0bf8aee758122633e54aa06.camel@physik.fu-berlin.de>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280882-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAE79458080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 11:28:11 +0200 John Paul Adrian Glaubitz wrote:
> > > Retrocomputing still is not well regarded by some maintainers, it seems :-(.  
> > 
> > I've found bugs in drivers by plugging those things into exotic
> > hardware like my Amiga 4000 and Ultra5 [0].
> > So, it's not totally pointless. And having a shader capable Amiga[1]
> > is pretty cool.  
> 
> Not only that. Those exotic architectures also help iron out generic kernel
> bugs and give new maintainers an possibility to get their feet wet.
> 
> > Sad to see fun stuff getting pushed out by basically spam bots. :(  
> 
> It's not so much pushed out by spam bots but by the commercialization of the
> Linux kernel. Many developers think that the sole purpose of the Linux kernel
> is to run on modern commodity hardware.

Please send that MAINTAINERS patch to designate yourselves
as maintainers (like Daniel already did for another driver).
This is the ideal outcome.

We want to be welcoming in the community. But being a part
of the community means participating in _work_.

