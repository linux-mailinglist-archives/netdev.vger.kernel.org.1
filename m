Return-Path: <netdev+bounces-277110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MJQDwn412mrVAgAu9opvQ
	(envelope-from <netdev+bounces-277110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 21:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC393CEF23
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 21:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C965D3019763
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E131D75E;
	Thu,  9 Apr 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk2BzVsq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B730E0D4;
	Thu,  9 Apr 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761412; cv=none; b=MWuurrFHacC35Wl5NdDam/xRd5xLXNSjauUmhewZtafWwL5mNCuXcNJoghJzZ6b+erNr52pydIn7yt1a6kbqduKf9s1Rldz3/rFfgRsCMhP5QipE3pbgusdD+O56zeixQetT+m13b+Rjt9zxDPhAba1mjz0PKDIMzfYLWvrRNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761412; c=relaxed/simple;
	bh=YwOkPrRz58qVrT4iAwNpRE3lExF4h4WkvL4s+eVv7sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNr6xVzjQFFfGK1yB/iZdGA+oQdRbuwxcPScfJuYgsiZetoZdYRqloc8gTIhpLiH5we4eDsLRr8MuN6JIX936sucQV0kywNZ87h04db57mQcWRAVtjEII5+m7C73xbXpXUBOM/eYTJCCwhfeLFnlpyd1VxHvUfZ9u7KZML3c47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk2BzVsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66721C4CEF7;
	Thu,  9 Apr 2026 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775761412;
	bh=YwOkPrRz58qVrT4iAwNpRE3lExF4h4WkvL4s+eVv7sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tk2BzVsq5K66LQj5lSzTXPGxJEwFNDlwXC4Bsh4aDJoNRaO54kTtnBOAaAEOoefYw
	 rPCWOlfSj8qt65VMbfI4vvljNO/PxuVmKM0Bo5tB3t9K6dwqhfUE+y6x/aOUqkfaqr
	 K51mphn1hDtib0tFZUDFsfNo3j3LxaB4yHu87OwlNIwlA7G//UlVNDCiMSI9iytrdx
	 XRaWGxMeyJZ90wv00aiW+2fjMkzk6aCKUVqRq7Fk9CP/6tLnVhGJ1R9EQAAsCd7HDs
	 qEeplxn/S5fdqTUYTrD0A25SF5zUPIDCqx+mMEutKGEfuS5376VtTNxvbgNg99z5cz
	 ao8HcbA3Wrx4A==
Date: Thu, 9 Apr 2026 20:03:28 +0100
From: Simon Horman <horms@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <20260409190328.GS469338@kernel.org>
References: <2026040730-untagged-groin-bbb7@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026040730-untagged-groin-bbb7@gregkh>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277110-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,darknavy.com:email]
X-Rspamd-Queue-Id: CFC393CEF23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 10:45:31AM +0200, Greg Kroah-Hartman wrote:
> There is a lack of much validation of frame size coming from a
> netrom-based device.  While these devices are "trusted" doing some
> sanity checks is good to at least keep the fuzzing tools happy when they
> stumble across this ancient protocol and light up with a range of bug
> reports.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: linux-hams@vger.kernel.org
> Assisted-by: gregkh_clanker_2000
> Reviewed-by: Yizhe Zhuang <yizhe@darknavy.com>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg 2000!

I expect that checking skb->len isn't sufficient here
and pskb_may_pull needs to be used to ensure that
the data is also available in the linear section of the skb.

Also, although I'm all for incremental enhancements,
I do suspect that similar problems exist in the call
chain of these functions.

...

