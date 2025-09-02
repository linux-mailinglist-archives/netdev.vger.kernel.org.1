Return-Path: <netdev+bounces-219299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F471B40EDE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC7A56216C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A32E7F03;
	Tue,  2 Sep 2025 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeSNOBoK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E02DFA2F;
	Tue,  2 Sep 2025 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846243; cv=none; b=kGtY2mVu506/YMhRdM0gRJj70G+ar8yKKKGHkPDumOUjvUWDarkxLFPsZlvshvug9j5NIkHkpBmO8mwpDEziRJeRjYFZJCkwE7TFsXpkQsCin6feXrmalcMH11AnhNiL8Bb6zEjR2/olgahuSZtGnrhqDZjzcebyWbpl7tiizeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846243; c=relaxed/simple;
	bh=SInObWfgBD274u36arsK70XfFqumzX3YKqZGfBOkmpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8AZyAxUh8bAaQkmRD4ndlI4LVqioB0x1YDmvsa9kLAFtXvh80N56DtbCleyB8nHxcQPQ6XzwN/mzBpJzdCz3hEQWkXydyay9UUQWW6MB+AnqCfRiKmaWUZI1PpvjCimvqJzpHWCJCLoX2rfI1nFMrPqYMBPJfrL6msd9NADNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeSNOBoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D24C4CEED;
	Tue,  2 Sep 2025 20:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756846243;
	bh=SInObWfgBD274u36arsK70XfFqumzX3YKqZGfBOkmpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XeSNOBoKAgSM+cyzLCfRo1apIzzkbiZn4beF1G6nPtWHQQy/swvK1eSTPV2xSvar4
	 d/FOEJMnjwIY7V6yEVQ2Ur6NZ2d/R728XcD1P1xCUNNYjR9AZXi1DDgsxQGsLCsjDf
	 pettuLLOAfR6kUSjgXJU2iV0eEZ+9gPO+asPaG5IwvTbtYlKnZYLpUa5v6u6BumMTq
	 /3i6vPc4QZO8lAKScGapmog6LnHxIxwSpn85sRoB63MIfQbASf6iEaxeo0xfo+WDgG
	 tV7mByCLGCWiZ49o+OAkqyZ958JjSGaGGVnPTqbXwkvtPmx1u1xPJEvJTdTRtokgcf
	 vu1eeZbbswMtw==
Date: Tue, 2 Sep 2025 13:50:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier
Message-ID: <20250902135042.5227f232@kernel.org>
In-Reply-To: <2351814.1756842974@famine>
References: <2029487.1756512517@famine>
	<aLcXNO6ginmuiBOw@mini-arch>
	<2351814.1756842974@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Sep 2025 12:56:14 -0700 Jay Vosburgh wrote:
> >> Note: Deliberately omitting a Fixes tag to avoid removing functionality
> >> in older kernels that may be in use.  
> >
> >What about syzbot metadata?
> >
> >Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> 
> 	I can add these and repost in a day or so.

Looks like the other comment from Stan doesn't need a follow up so let
me add these tags when applying.

