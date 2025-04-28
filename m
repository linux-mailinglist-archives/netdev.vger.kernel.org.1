Return-Path: <netdev+bounces-186523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D7EA9F822
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E075C17A9CE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFE2951C3;
	Mon, 28 Apr 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXwAPnc1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB82279904
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863973; cv=none; b=SW6cllHY2EBGfC3TbkQOJNjWfVlvp/bLmlLl4gYImamMQ7opchxkWx+U4jjavh7vJQzWsWPzFspRW+NLHWu5dgcYWDfJErB2yTWD67IzVo//PslZkuilByy09PwyvMBFzsPZPi30juDmZdfDFGky15xP/bvH5NHeS37Rkeohqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863973; c=relaxed/simple;
	bh=dMjKYi0ro+I4f60r42WHLp2NqV/zPGQeCJR+kpez6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV9CJyXcL5A0lsJ74YYEcgqOFIyFY3DmV26wPMVzU/nlfY4BKjvpF6GmoxSGe3oRwTGf4rU9xUWWOAcDchvpw3c28ExxjwjGeR3gj5w+boEjIdS8YVvKqkgiSLluVmFW6KIP6xBMFUXvyTFSUjWHdsvMxo2RYUEcHY85eztb4Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXwAPnc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009F4C4CEE4;
	Mon, 28 Apr 2025 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745863973;
	bh=dMjKYi0ro+I4f60r42WHLp2NqV/zPGQeCJR+kpez6cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mXwAPnc1+mt7AAnSq+UKxDlDDlsmx7LXmLB8i2nP3UZAqdkYPtIkQSL80L3JKUXy8
	 zLzfdL3BDwwwn1IHjSASJoO7F6yDEuutVEjP+uZW2kZJpp3bwlI23oe74CZxngG68Y
	 9d4RFzaVgBgad50ousPD2LeoSG5rxe9x10x6sSACwl3Dc21yHegQeiLO+Jdc54XX3m
	 CQ0sIRkPXcryGXQ6VqX5nTfwwIlGubup3XNi7vm/ItBf55iZ+bBpc4rIdME2OOUFVP
	 S7neRzq8boeEY7asoxMhgTJRLcanMt+Z5PBV8A8vDygkqGKAhdn57qZrLzzFVjjNS/
	 5IfVkeBWknT4A==
Date: Mon, 28 Apr 2025 11:12:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250428111252.62d4309c@kernel.org>
In-Reply-To: <fx7b7ztzrkvf7dnktqnnzudlrb3jxydqzv2fijeibk7c6cq3xb@hxreseqvu2d2>
References: <o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
	<20250418172015.7176c3c0@kernel.org>
	<5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
	<20250422080238.00cbc3dc@kernel.org>
	<25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
	<20250423151745.0b5a8e77@kernel.org>
	<3kjuqbqtgfvklja3hmz55uh3pmlzruynih3lfainmnwzsog4hz@x7x74s2c36vx>
	<20250424150629.7fbf2d3b@kernel.org>
	<kxyjur2elo3h2jkajuckkqg3fklnkmdewhch2npqnti6mylw6f@snsjaotsbdy2>
	<20250425134529.549f2cda@kernel.org>
	<fx7b7ztzrkvf7dnktqnnzudlrb3jxydqzv2fijeibk7c6cq3xb@hxreseqvu2d2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 18:28:24 +0200 Jiri Pirko wrote:
> >You just need to find a better place to expose the client side.  
> 
> Okay. Why exactly you find it wrong to put it under devlink dev info?
> I mean, to me it is perfect fit. It is basically another serial number,
> uniqueue identification of devlink device.
> 
> If other place is better fit, I don't see it.

devlink instance should represent the device, not a PF / port;
and then having the attribute on the instance does not fit
an eswitch controller with 2 PFs connected.

> Do you have some ideas?

Either subsystem specific (like a netdev attr) or not subsystem
specific (bus dev attr, so PCI). Forcing every endpoint to expose
a devlink instance just for one attribute is too much of a hack.

