Return-Path: <netdev+bounces-291962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA2CCRkcFmq2hgcAu9opvQ
	(envelope-from <netdev+bounces-291962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:18:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 803DF5DD26D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092AC301AD36
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5041A3C3BF6;
	Tue, 26 May 2026 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMQ4QJ9P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293F355F2A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833878; cv=none; b=Us6whlI3FRTDIxcWNzCaluIEUeAI78avMvQND0zJr1yaW0JID3Vnmj7I912QsXe1jo9TWdfg+nUb1QsR0xEk+cIFLd/uRCLSQCLJuBIsKxk9BbtBnbyw258GnBhSvAQ1YwicWhFil5Vykcdd8U2XKyzflObQLGxXzXILJzeL8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833878; c=relaxed/simple;
	bh=sO/QfME8yPF5zF10RJ9dek2yuHdzaZbHktvXvp7Rbmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVXZ3FY7WiFWucZ6OT8g3abD7R761bjbQrd304JyG1Jjs+0/hZG9ic3vkcl9GDO4iWqJZ4kzXUeZwENUwpWjTFkWRN4GWodQihRugmQ9B2bWI4dI9BIFIlgjPtEtSGWBWe/xkxmsXDKYt47CVUesGz2Dn+AJbNj59JzM1ayKgsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMQ4QJ9P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866C61F000E9;
	Tue, 26 May 2026 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779833876;
	bh=IOVvB/1ifL08mB+puOXObPElfVzRmwSi7IMUhhhJwiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aMQ4QJ9P4V2Hg1UnkkzqlvCohvGM4Rm7KdLKa+uuwb3IQqAYeUkWv/2Su5Iwo6q0X
	 oVWuDajNxgzlMeTMDWVQIKrUScx4kNZ+A5qMP370YPxhURZAoa7gfAKHLg6eCda4Vp
	 hBFLAWTSRIvxCn5YXxQszt1330U60EW0JY1nzq+a1+AKtC29rH05Rj4bG1f/21XuuO
	 rVjVJ6WGJeXFvgC0WMqE3Ye7DmpBBlAjEAKfv6XsQW0n4bNU2HGIjmoCSuclgjAzui
	 Ql/f/N0YtbnKSGfhL3FEz3Rrw6hy4ZkX+mZ8dN3uBzKB/FRVE8qB4ULpmZI/DRI/Ma
	 Kir13gFBw8V0g==
Date: Tue, 26 May 2026 15:17:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v6 net-next 3/3] selftests:net: Implement ptp4l sync
 test using netdevsim
Message-ID: <20260526151755.06ba2041@kernel.org>
In-Reply-To: <f10b3ddd-d403-48d3-ad0c-25b0e2d9d64d@machnikowski.net>
References: <20260513094520.325693-1-maciek@machnikowski.net>
	<20260513094520.325693-4-maciek@machnikowski.net>
	<20260518174209.41e2e039@kernel.org>
	<f10b3ddd-d403-48d3-ad0c-25b0e2d9d64d@machnikowski.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-291962-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 803DF5DD26D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 17:10:46 +0200 Maciek Machnikowski wrote:
> >> +# By default, it:
> >> +# - Creates two netdevsim instances in separate namespaces
> >> +# - Assigns IPv4 addresses and links them together
> >> +# - Uses those interfaces as leader/follower endpoints for ptp4l
> >> +# Optional: --leader and --follower override endpoints with existing
> >> +# interfaces. Each argument can be either "ifname" (initial netns) or
> >> +# "netns:ifname". Both options must be provided together.  
> > 
> > Please use the existing DrvEpEnv infra!?  
> 
> It exists in the tools/testing/selftest/drivers/net and this script is
> in tools/testing/selftest/net. I can either keep  the self-contained
> test only, or move the script to the drivers/net - which one is preferred?

I assume you are adding the CLI --leader and --follower options to run
this against a real device, not netdevsim. In this case of course the
test should live under tools/testing/selftest/drivers/net

