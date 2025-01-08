Return-Path: <netdev+bounces-156450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B89A06764
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FFA18893B3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE77204694;
	Wed,  8 Jan 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFsyIgjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896BD15E8B
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372674; cv=none; b=DkQWtyQQPyYGk4Er9miGfrfCse+jON09+l4nYBjgyvkBGbRJgCssS0ASqh9kBlZDUiffum8yEFw2VhC3pBaEXFikJpEkDjPIBp7/e5YUYFv3kYJbVyWfKT33nv3xJpVNt0R91PNnnYqbX3HBAD/q+p4FvRDUCqQsa7BMs25TuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372674; c=relaxed/simple;
	bh=WqBYx5q2bQU48WQm5RKZDJz0CRstrHCMzqqa4E/fJQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrBflvRCRnCYpfdIpgNKT4v14LdTXXZbaP5S9y3RAYlFZOCRdt4Npxmb+GteJ7i/dvoAqjQvtZgsPco0/CkCmg6WY+o1PW37AySvrfX7FYdMK7IQTq/Iw30xnNPbDDgf0Ppw/WTI9/TlpjKUioZK41Wx5AwZAxKbfYWHH2SFEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFsyIgjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12413C4CEDF;
	Wed,  8 Jan 2025 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372674;
	bh=WqBYx5q2bQU48WQm5RKZDJz0CRstrHCMzqqa4E/fJQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vFsyIgjSlA8Fre2c2/J7QXHbXRy5XPFXGlm41BERUZhd0cbyaXkNsitTBc+RlCQ08
	 UfOYyIh9u0wcDglmInuq3uPdcu/Lr0R05bskkmXIPCH+0KLbSFY7KRY9kYC9sDcMRg
	 y8Jhtyr29ajiu82ssk5MVmp1JRUcTj5UTrAA0VaynUTteyTTWivqDayFgGB1oIgE4p
	 N+Jqek4+yw9KC1K12C4pgNo8Nxqs4mPNlECojUGceH8YWcZyBbKdvDY345XhBQNhSM
	 sQ2zm+so/79LBsifTGlcMRop+gi+cBmCWbm5CpUnLRiF3WngZqpx7fiplyzIM0GLKI
	 dcOmaYR/mFfCQ==
Date: Wed, 8 Jan 2025 13:44:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Fertser <fercerpav@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, Potin Lai
 <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>,
 sam@mendozajonas.com, fr0st61te@gmail.com
Subject: Re: [PATCH net v2] Revert "net/ncsi: change from
 ndo_set_mac_address to dev_set_mac_address"
Message-ID: <20250108134433.2e3978fd@kernel.org>
In-Reply-To: <Z37eu/758pzGSGzO@home.paul.comp>
References: <20250108192346.2646627-1-kuba@kernel.org>
	<Z37eu/758pzGSGzO@home.paul.comp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 23:23:23 +0300 Paul Fertser wrote:
> > Original posting by Potin Lai:
> >   https://lore.kernel.org/20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com  
> 
> Unfortunately I wasn't on CC and missed that. Can we fix this proper
> way please, do we have few more days?

Sure thing, we need it in the tree early next week, so probably on
the list by Friday so that folks have a chance to review.

> If I get it right dev_set_mac_address() just isn't meant to be ever
> called from a softirq (and NCSI here is special in getting a MAC
> address update from a "network" frame so that happens in
> net_rx_action() context). So postponing the actual processing of this
> reply looks like the way to go, right?

I think so. Only trickiness I can think of is the ordering of the work
vs admin setting the address from user space. Do venture a patch,
I don't know enough about NC-SI.. :(

