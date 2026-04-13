Return-Path: <netdev+bounces-278195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GJRHWlX3WkFcQkAu9opvQ
	(envelope-from <netdev+bounces-278195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:51:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B80053F33F6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1A13038537
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78A392822;
	Mon, 13 Apr 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQUtGai4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D13914E7;
	Mon, 13 Apr 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113051; cv=none; b=gQvEUX2HuH0+0Oq0c1ZMvdo09OQVnn8WJ+vo6uSfheo0wE8UNslrGjtLXW4mw07pL7Ehrsvpda5ub/p4O36K0OLFF075JTgBzk0xU2YKA8GkjJ3COR1U9xT5IU4comjmewIVpf1re2Aqn/tjsF8FsxQ/FYg5RVPdwOm09tNcBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113051; c=relaxed/simple;
	bh=U5IyLtgvxICgVn9ysihdPvdvaSgqsWTJlktlWq8SFU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLEKImtOD3mzE6bHnDfMpV2Mkd9nNYBohBMdQPRNvBeHUiBB9SuDdnKiCGbg/WEtb5hM51tiB5rIPufjga4nfG5MDC9+PgS3Jt+1EE/MSmL1tJR5iXFIcvZmpu9jmIkLmt1PQtQMih5hbKPvQNyZjlw7rV2w95KNZkHUw6E/vVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQUtGai4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8F6C2BCAF;
	Mon, 13 Apr 2026 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776113050;
	bh=U5IyLtgvxICgVn9ysihdPvdvaSgqsWTJlktlWq8SFU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQUtGai44sUJzQfODiI3zjH+h/gtfdKsrbjEXItDsrZLz7DxIn33Mo7pYVPEOFn0Z
	 EzRNY/H62GzhKEgnEaBr4JREqQsAUbv8VDqUSzq22Kj+wgCxjUeHYH67NuAi9dbN5K
	 8JLj8CWVa9kOSxhOfl2L85wJdFgW01bHZhIa0TGjEw8YQSvnYqe0YhxFqqof4/lbjm
	 Y1yh0EbNVv4rpKCg7lt43cGcJG7+mPCA9R5TC2MWu2YHmfcF4/ge1EE3ylpLoqhz0r
	 sqXV4ooFKGQ9AaHNehIrDW98BQUvuVCGVNxloX3sN6gAmR3v06LHGtTcx2WP0JeQm2
	 QFNXaDkv3dVWg==
Date: Mon, 13 Apr 2026 13:44:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth-next 2026-04-10
Message-ID: <20260413134406.3aa635d2@kernel.org>
In-Reply-To: <CABBYNZLg_Dz9ieQ+ioXf2+Oa+vdL8BMbnt=qOfkONOpNsUZ5qw@mail.gmail.com>
References: <20260410172206.150975-1-luiz.dentz@gmail.com>
	<20260412091614.1786af4e@kernel.org>
	<CABBYNZLg_Dz9ieQ+ioXf2+Oa+vdL8BMbnt=qOfkONOpNsUZ5qw@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B80053F33F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 16:07:55 -0400 Luiz Augusto von Dentz wrote:
> > Two fixes tags are messed up here:
> >
> > Commit: 802446198014 ("Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array")
> >         Fixes tag: Fixes: 4cdd001ff03f ("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >
> > Commit: 28c9cc700e30 ("Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU")
> >         Fixes tag: Fixes: fa768fce4aae ("Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist  
> 
> Would you be able to pull the for-net-next-2026-04-13?

I think so.

