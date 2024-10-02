Return-Path: <netdev+bounces-131249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEAA98DC25
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A59DB2866D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6841D1F53;
	Wed,  2 Oct 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r17oRAK1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DB1474BC;
	Wed,  2 Oct 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879517; cv=none; b=t5sYSG08Lhv2tXRczjaXsLMtv8PNoKraSucToJcID06/GolBCdORr42GOUwx7KJFXQEvpvo8pvO3KAfmJDkt2+VOdXImWdeEoD7p2F/uLIRZq/pBXvJFZvIRyFAo2CwKlLyx9AP/OJDrMIIdLawMvWIIiGYjttgPATpUTNuLI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879517; c=relaxed/simple;
	bh=TzXJCdWdRWwVvx33ZcTVl3SwsLMpe/mn3P3Ch+XmJvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/1i+J2LhUtt/ZuClD7kR97rsJFI9GjFIwc84enXjs6LU7E+fFuZzns4898r1eC17P7tL8RvuUEEzwXF8gYCRCtwXNUGf+GFsTGfIR2gUmxv3xDJU0t+emGY8grGPPLBVELat9lWC9/Ek6k+iEdkSPDvzpcDf160dG9GWhOpoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r17oRAK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A2EC4CEC2;
	Wed,  2 Oct 2024 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727879517;
	bh=TzXJCdWdRWwVvx33ZcTVl3SwsLMpe/mn3P3Ch+XmJvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r17oRAK1v2El3f/VHzjHBLnkzn/zUWpOcz+H40nO25eIUnFkx7lYgO5PLgmjbqiC9
	 gJEDVd1ptAMeF0euL4ObietQcVitSm7HPNEWS/YPs7RKRCDHVMMXnlV3u92AZ2sVEq
	 L+TydGy5d2kZve7BNmFdF5/ZR7zitQAHeJthhWDoYKRnE5EMXdhaSavb1mMz+NuLtH
	 czCw9r8SjO/u6CIsufxnr+FyK5vD9sbYtVYit/0pWS43HM2n9hG3YonEwfSDEO7Z0+
	 vajJ5mMacblFfqulP5idB4ROcOmupoGrr/aG1QL2kT97Z0dGKJEbqVjTEHGvjhi8MC
	 M9kib2u0paCGw==
Date: Wed, 2 Oct 2024 07:31:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Simon Horman <horms@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, thomas.petazzoni@bootlin.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net: pse-pd: tps23881: Fix boolean evaluation
 for bitmask checks
Message-ID: <20241002073156.447d06c4@kernel.org>
In-Reply-To: <20241002145302.701e74d8@kmaincent-XPS-13-7390>
References: <20241002102340.233424-1-kory.maincent@bootlin.com>
	<20241002052431.77df5c0c@kernel.org>
	<20241002052732.1c0b37eb@kernel.org>
	<20241002145302.701e74d8@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 14:53:02 +0200 Kory Maincent wrote:
> On Wed, 2 Oct 2024 05:27:32 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Wed, 2 Oct 2024 05:24:31 -0700 Jakub Kicinski wrote:  
> > > On Wed,  2 Oct 2024 12:23:40 +0200 Kory Maincent wrote:    
> > > > In the case of 4-pair PoE, this led to incorrect enabled and
> > > > delivering status values.      
> > > 
> > > Could you elaborate? The patch looks like a noop I must be missing some
> > > key aspect..    
> > 
> > Reading the discussion on v1 it seems you're doing this to be safe,
> > because there was a problem with x &= val & MASK; elsewhere.
> > If that's the case, please resend to net-next and make it clear it's
> > not a fix.  
> 
> Indeed it fixes this issue.

Is "this" here the &= issue or the sentence from the commit message?

> Why do you prefer to have it on net-next instead of a net? We agreed with
> Oleksij that it's where it should land. Do we have missed something?

The patch is a noop, AFAICT. Are you saying it changes how the code
behaves? 

The patch only coverts cases which are 

	ena = val & MASK;

the automatic type conversion will turn this into:

	ena = bool(val & MASK);
which is the same as:
	ena = !!(val & MASK);

The problem you were seeing earlier was that:

	ena &= val & MASK;

will be converted to:

	ena = ena & (val & MASK);

and that is:

	ena = bool(int(ena) & (val & MASK));
                   ^^^

IOW ena gets promoted to int for the & operation.
This problem does not occur with simple assignment.

