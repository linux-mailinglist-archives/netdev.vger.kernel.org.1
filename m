Return-Path: <netdev+bounces-280417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Jo9NojF6Gl+QAIAu9opvQ
	(envelope-from <netdev+bounces-280417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:56:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B44464D2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D80D3028830
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628873E8676;
	Wed, 22 Apr 2026 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JT4MU7Mn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9D3D1CD4;
	Wed, 22 Apr 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862256; cv=none; b=rUWuaYL28WTN/q3GVAUpz9by3a8nyja6adAJxXCKmflZXUmZyY3r0cDvcelZv7zzjUnw55bnGRQfm9aTH5gJLxeyQSJpVnCDSG3Peo4/ivD+QJh7KIj13/Eolb2uy72GnWpObNUx0IJ4Nb5aM0IPbjByK2czpeSl7igozv8bhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862256; c=relaxed/simple;
	bh=Fgj6xtcADYBiMOCmjmwMUsvpQWp1JAxbkSX6keLfX9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpcopXB2HgFnc54t6HVQSTa9Wh6hr4QPXg+6+EZGEvt2R8GRkmdAi6hnppoadbZ/KVQtoQmVm2pP3APRblLN71rjP4GH+es1J/YdYarzDP44JQPdF+GRIA8FRzWTKqI1ZVjD8BY1j9AJDf886VeLRftQTBEnBMkCzQcgTuCgVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JT4MU7Mn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yvBLQ3Qq3dOR+X4ePHZ/PQRix44xFL2TY/QPkI/uQF0=; b=JT4MU7Mn/vFoS4+ilrzuuIwoNb
	WFwbvtsK9uizD6w77N+TIwyXs95XWlrr7NxmJYdb+2b5eU6toFtYBWZpkYTR5+ajjCko2tmpdvgKB
	wfJSFHmgragW193BKmpIFHwHp6h6EHLs7IcbVZFHp2s+yB8Y7ABnWEgcb9s9yNq9E+bA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFX2U-00H21R-KX; Wed, 22 Apr 2026 14:50:46 +0200
Date: Wed, 22 Apr 2026 14:50:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Palmer <daniel@0x0f.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net 06/18] drivers: net: amd: Remove hplance and mvme147
Message-ID: <f902909f-7eb9-4b7a-bb01-82f680cfe695@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <20260421-v7-0-0-net-next-driver-removal-v1-v1-6-69517c689d1f@lunn.ch>
 <CAFr9PXk=3md2oVDqFbmQLNiVMkRr32pHMPNSeskdTpM-1huB=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXk=3md2oVDqFbmQLNiVMkRr32pHMPNSeskdTpM-1huB=A@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280417-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E9B44464D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 06:38:28AM +0900, Daniel Palmer wrote:
> Hi Andrew,
> 
> On Wed, 22 Apr 2026 at 04:39, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > These drivers use the 7990 core with wrappers for the HP300 and
> > Motorola MVME147 SBC circa 1998. It is unlikely they are used with a
> > modern kernel.
> 
> I have an MVME147 blinking away running mainline using the mvme147 driver.
> I think some of these need to be CC'd to the specific arch lists so
> the few people using them get a chance to pipe up.

That is part of the problem. No MAINTAINERs entry. so
./scripts/get_maintainers.py does not add an Cc: to the list.

> I think I'm the last person to have touched the mvme147, I don't mind
> being a maintainer for it.

Please submit an entry for MAINTAINERs.

I will drop this patch.

  Andrew

