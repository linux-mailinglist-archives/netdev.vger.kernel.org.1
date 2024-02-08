Return-Path: <netdev+bounces-70335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0157184E6B9
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E901F29F84
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83DA127B6A;
	Thu,  8 Feb 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3Jlwune"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD18127B55;
	Thu,  8 Feb 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413170; cv=none; b=g9PLWZaSDDzT/+rKruAvKS4EeupY/WiHHCD3C/BuasXzgtMZTyKqFsFT3qutVJYXHkbPpnEoM9XGf2WwkasegE849bYAYzDWMDCm/7oaYQlg7CCcZw4G9MC7nGQDShhpAEvz7SmT4YjjL6PN3doHqta62FAUp9o6d1iwjkowoTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413170; c=relaxed/simple;
	bh=RMHXhee+EKsjbCO8kxQOehhJzu4DfanOp53f7KtNCnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiUOi6eXxVEaZWCtoz5j+xofIdDeAk0JhFKqvp4IkFyypP1qBc8FjU7t0dgYhcUbDLgsQQrovlvuYVGVfZe1re3Wx55X8U/uXPITw+FXPXuDpNNf7dcqFhq379pMDOEXMFzyySru2c+hJqnOytCRLXXhvL0/Fk3OvP+xvZTY6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3Jlwune; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B106BC433F1;
	Thu,  8 Feb 2024 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707413169;
	bh=RMHXhee+EKsjbCO8kxQOehhJzu4DfanOp53f7KtNCnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z3JlwunewmfhhvYhJVni6pjFAiAM+CRhW7DTGyyWotKPTaYOzrwGyiF7BX8+KVrhX
	 uLXUcCi6Y+6jArt3XdBxi/4j9cP17u1fzdzCFVN/ixj4eFHBU5SinAl7+t7jCDGUlT
	 +T8eWUtGanEi0mB+kPdqqIWNIAh3MAWAzTfQKTGKXiwtzJb5v3h3/F/IRT09V9MNwd
	 MUI1H4idZOSpAsOOh/l1ULEIi3xymiWTe5Vw/Nb/+xLsa9YcPI8I8i4BymKjepGjkp
	 7l23zQWEZKKPgMz0XErw151utORw4sxTbQxQU2N6v4k+Ub8X/7TeHFGHXaknefSi9x
	 zqLwYAF1o376w==
Date: Thu, 8 Feb 2024 09:26:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] bridge tests (was: net-next is OPEN)
Message-ID: <20240208092608.3765b222@kernel.org>
In-Reply-To: <ZcT_iSwnYmORF-8A@shredder>
References: <ZbedgjUqh8cGGcs3@shredder>
	<ZbeeKFke4bQ_NCFd@shredder>
	<20240129070057.62d3f18d@kernel.org>
	<ZbfZwZrqdBieYvPi@shredder>
	<20240129091810.0af6b81a@kernel.org>
	<ZbpJ5s6Lcl5SS3ck@shredder>
	<20240131080137.50870aa4@kernel.org>
	<Zbugr2V8cYdMlSrx@shredder>
	<20240201073025.04cc760f@kernel.org>
	<20240201161619.0d248e4e@kernel.org>
	<ZcT_iSwnYmORF-8A@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 18:21:29 +0200 Ido Schimmel wrote:
> On Thu, Feb 01, 2024 at 04:16:19PM -0800, Jakub Kicinski wrote:
> > On Thu, 1 Feb 2024 07:30:25 -0800 Jakub Kicinski wrote:  
> > > Ah, ugh, sorry for the misdirection, you're right.  
> > 
> > Confirmed, with the SUID cleared test-bridge-neigh-suppress-sh now
> > passes on everything with the exception of metal+debug kernel.  
> 
> I'm sorry for bothering you with this, 

No worries at all :)

> but I checked today's logs and it
> seems there is a similar problem with arping:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/456561/8-test-bridge-neigh-suppress-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-net/results/456562/6-test-bridge-neigh-suppress-sh/stdout
> 
> And according to this log the ndisc6 problem resurfaced:
> https://netdev-3.bots.linux.dev/vmksft-net/results/456382/6-test-bridge-neigh-suppress-sh/stdout

It seems pretty faily:

https://netdev.bots.linux.dev/flakes.html?br-cnt=80&tn-needle=bridge-neigh&min-flip=0

I guess the short green streak does coincide with the fix, tho. Hm.

> Any chance that something in the OS changed since last week?

My memory is bad so I started keeping a log:

https://docs.google.com/spreadsheets/d/1mFnt91SKtA9ENIUfY0v2UmZSXJzmvsa4oqha4t6JVBs/edit?pli=1#gid=338019672

But it's not the suid:

$ find tools/fs/ -perm -4000
$ ll $(find tools/fs/ -name arping)
-rwxr-xr-x. 1 virtme virtme 79360 Jan 29 14:38 tools/fs/usr/bin/arping
$ ll $(find tools/fs/ -name ndisc6)
-rwxr-xr-x. 1 virtme virtme 53840 Jan 29 14:36 tools/fs/usr/bin/ndisc6

And it occasionally blips to "pass" so can't be completely broken env.

I run the test now with VERBOSE=1 and -q removed from arping and ndisc6:
https://netdev-3.bots.linux.dev/vmksft-net/test_bridge_neigh_suppress/

It just says: Received 0 response(s) :(

Repro is 100%, LMK if you'd like me to try with some custom diff on
top..

