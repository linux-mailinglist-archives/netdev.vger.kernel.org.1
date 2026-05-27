Return-Path: <netdev+bounces-292040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Os+C3FJFmqUkQcAu9opvQ
	(envelope-from <netdev+bounces-292040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:31:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4F5DE3E4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28EAC3009B10
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723A0270EC3;
	Wed, 27 May 2026 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs1o9Ree"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F071FC10C
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845486; cv=none; b=hdgkCdia/uV5YxsXuG3XYcP5tTgz/oMGw6vPQISwaivOTfVeFmX8+msi7L7USqFHENIZozn5Kwkzh7lQoe1WQs6N/GOQw2HZ+W0emZONBIsd+7rYTu83dnDA338EOOcfMA2gJNglh2IL7TUV5AmDGNwVsku0UGD0cyUJ4pe+3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845486; c=relaxed/simple;
	bh=hXXLUda/fifR+BteeAViVSobkEgeQFmGHS1PxB/A3hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CErZAxS2MjEVsWgkI0p0Vzu0D6+47dLTqGmfzco0ENG6iavC/bmHngEtt+ZqVB/y7VgySrXZeyBeIhaWI2dZtLR206PPjJQvL/B55VAJsGFpTS2dw6eilkqed9I0DDGqf7xezpv67Ocne2u3AzENsTdCLTfTgLXlsJTo1hv4hkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs1o9Ree; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327D81F000E9;
	Wed, 27 May 2026 01:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845483;
	bh=q7hx76CuE1HlQQmJtkeIk43zXQJcWk5CXtiULiiQKsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fs1o9ReeM+23W4SOunQxrtc3lW9oAL+o9Xydj004t9utaysJCigLfkRFekklSUbih
	 t6sNK0lGU83cya5gGBbNxHG+f/umJnhw0qW8mY/a+xzlM7oh34BzAC2Qbe7JvSBElk
	 c1ynHeOWJKH4At1vSqXrvRgx31IOxJ1aEzrSW0PBJ/cRWu/ZTvh11E7aKP7mK/zmuB
	 nOnLUUjd9bHKkNj460JeoLNH7xGOZfcVJzVwPg717Cem1EAJRxKVp/R+cpab63ujx+
	 V3WPiY5ayQcOvBkvIX+Voz8YU6l1vtAmDFbqCYgyMPEPFo2OBLTVQADQ1jI8ngxeX8
	 w5OEebfR0Knvg==
Date: Tue, 26 May 2026 18:31:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Adams <linux@cmadams.net>
Cc: netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Fernando
 Fernandez Mancera <fmancera@suse.de>, Ido Schimmel <idosch@idosch.org>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260526183122.348e44e7@kernel.org>
In-Reply-To: <20260527010641.GA21073@cmadams.net>
References: <20260521135310.GC977@cmadams.net>
	<20260526175743.1f2c3761@kernel.org>
	<20260527010641.GA21073@cmadams.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292040-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 84A4F5DE3E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 20:06:41 -0500 Chris Adams wrote:
> > Hi! Adding more people to CC. Do you know if you upgraded from 6.18 
> > or 6.19?  
> 
> It was 6.19 to 7.0.
> 
> > Would you be able to try testing with some commits reverted?
> > On a quick look the candidates would be:
> > 
> > cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")  
> 
> It's this one.

Phew, the second one was mine :)

> I figured out that it happens after stopping a VM (and I usually
> start/stop a VM for a bit in the morning, which is why it happened more
> than once).  So I set up a VM with a nested VM, running up-to-date
> Fedora 44, and then was able to bisect pretty easily, and it landed on
> this commit.
> 
> Fedora is using NetworkManager, and IIRC NM does some part of privacy
> address management (right?).  NM didn't change, so maybe this commit is
> confusing something in NM?

Sounds plausible, pretty sure we knew this commit was risky to begin
with, but we had no direct proof that it'd break real life users.

Revert is the right course of action here. Would you be willing/able
to send the revert with your problem description and a Fixes tag
pointing to the reverted commit?

