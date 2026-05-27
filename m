Return-Path: <netdev+bounces-292024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAxrGY1BFmrnjwcAu9opvQ
	(envelope-from <netdev+bounces-292024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:57:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79B5DE16E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3257130254EF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875402C2349;
	Wed, 27 May 2026 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPeE/ijE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6A29AAF3
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843466; cv=none; b=P4PEDiVal37AJzl5yJLJBxJoqqigs3wfEP1PFCjG3Pz5xjNRQl3FiOw5559TBgGhHlqy3XIDIzg0cZaauTJUFSHI7NJS2n8ANmaAERNWzKt5eIoffB/kzORlMuHvbOrzKrxFC7vkzNNtE4QH37SuitWxnhklZWRfF/QrxElZDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843466; c=relaxed/simple;
	bh=Ua0jpCFfzvX/x4/8UlATlrhnxOnB2uX9oYKkrDnSA3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A43fDtOKdMSZDmiLobUQbrsdcYgmv8hA8mHfi3qNIN3GCDIx7wDKsPL14GtbqQBAAWUlQbKdh+60VCt2W/6l5fcI+A8HdYV15qKqTlKv/aEdmYd/+oDwT9sr48Hy4o6vYmRssE3a+31JhT23QY012ViTAdQEfvlyvPbxHn0oW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPeE/ijE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C0C1F000E9;
	Wed, 27 May 2026 00:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843464;
	bh=f9Giwrnm5cCdPTFlTA8IEMAvzo50RfsELEwHdiipVtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iPeE/ijEcF7v2GgVTptXB0MDrPDKe6K46iCe6etc50qQE352dnsDqhwgOOKeupLT8
	 HiSZPOdqs5UDm2HXwo1JH3lpo9cHfKzkQHl2tHYBmCDCHbRkFs3tCMwWgytQUXgPA/
	 x2AW/2OukfuIgn5+TFAro08z1lcSnOhIasfa9B1xP6F8NmSRhVDajKASTzZkttiNIO
	 WIXKyCTBS86A2S5X2P4v6hiT414Dz3CjHyAbz2izsbWtRh2kLuOG4cpoxPSCG3UC81
	 lr7+iPfE/bQ4dD9SEznVI86ALd2AFWpaHoDmjry5SE8LhXfwB40MLfXnjWsLU61QSw
	 RJhGyXcYrJIYw==
Date: Tue, 26 May 2026 17:57:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Adams <linux@cmadams.net>
Cc: netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Fernando
 Fernandez Mancera <fmancera@suse.de>, Ido Schimmel <idosch@idosch.org>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260526175743.1f2c3761@kernel.org>
In-Reply-To: <20260521135310.GC977@cmadams.net>
References: <20260521135310.GC977@cmadams.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292024-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CF79B5DE16E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 08:53:10 -0500 Chris Adams wrote:
> My normal use of my desktop system (Fedora 43) is to suspend at night
> and wake in the morning, and then immediately SSH to my remote server,
> where I stay logged in.  I use NetworkManager and have ipv6.ip6-privacy
> set to prefer-temp-addr, and SSH configured to use SSH keepalives.
> 
> When I upgraded to kernel 7.0, I started having an issue with this - my
> SSH session gets dropped, usually several times, in the first hour or
> so, then I usually don't have any problem the rest of the day.  If I run
> an IPv4 session at the same time, that seems to be fine, so I don't
> think it's a network issue (I know that dual-stack doesn't always take
> the same path).
> 
> What seems to be happening is that privacy addresses are removed while
> the SSH session is still using them, before the timeout even.  I wrote a
> script to watch public v6 addresses being added and removed, and this is
> what I've seen so far today (the number at the end is the valid_lft
> seconds), with the public prefix masked:
> 
> 2026-05-21 07:39:17 removed xx::f4f/128 4673
> 2026-05-21 07:39:20 added xx::f4f/128 5400
> 2026-05-21 07:41:20 removed xx:3e8c:f8ff:fe60:1d5a/64 4922
> 2026-05-21 07:41:20 removed xx:7cb1:c518:1be0:d81d/64 4922
> 2026-05-21 07:41:23 added xx:3e8c:f8ff:fe60:1d5a/64 5398
> 2026-05-21 07:41:23 added xx:596a:f6f5:67b2:1d8f/64 5398
> 2026-05-21 08:14:43 added xx:fac3:61f6:ad18:d712/64 4987
> 2026-05-21 08:14:43 removed xx:596a:f6f5:67b2:1d8f/64 4991
> 2026-05-21 08:30:26 added xx:84b4:244e:bb14:94fd/64 5398
> 2026-05-21 08:30:26 removed xx:fac3:61f6:ad18:d712/64 5120
> 
> I woke the system at 07:39:08 and SSHed at 07:39:39, which used the d81d
> source address.  That dropped in 2 minutes and I reconnected, which used
> the 1d8f address.  That dropped at 08:14:43, I didn't notice right away,
> I reconnected at 08:31:28 which used the 94fd address.

Hi! Adding more people to CC. Do you know if you upgraded from 6.18 
or 6.19?

Would you be able to try testing with some commits reverted?
On a quick look the candidates would be:

cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
c7dc5b522882 ("ipv6: clean up routes when manually removing address with a lifetime")

Less likely:
5023479627e3 ("ipv6: Switch to higher-level SHA-1 functions")
9e371b0ba7f5 ("ipv6: addrconf: reduce default temp_valid_lft to 2 days")
6af51e9f3133 ("ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions expire.")

