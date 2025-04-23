Return-Path: <netdev+bounces-185298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B51AA99B5E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C107AF3AA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B238A20766E;
	Wed, 23 Apr 2025 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMEDfEBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22A205AD0
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446666; cv=none; b=sTP1Bqo2FloLd0i4n1r2QP6MQkTEPZV4yTBxtS018Q9VTCx8/pedRHfcvIfnm9fz6m7wdLhQzG7k+NpaD1+vUtpzmkO/jfDVUt4qiLXyXpc+lXOIDdodd5+dn8eUWGyAWDhVitCu3ycTTzUqEFsLWSzXZW8FaV8wBwc5OjEWKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446666; c=relaxed/simple;
	bh=SS97nWn4q2LvF/GBzO3N76WT5f/w9w88acg4fr3HcCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISgGSrdteVnXgDd0xT4x3einVXTj+8SkjZrmtTMn5aNlvVYU9QAPFSg6Rja8leyuZtACuE+v4IrQbbz26nkA1+ge84MBPcqBCLj945WEM8whmbdrxrOyGRHCPIuyIjfBA7X6E7Dmy2BtUWDgWoDG8zUfQfdPaJtQt+1H9obr74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMEDfEBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B6DC4CEEB;
	Wed, 23 Apr 2025 22:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745446666;
	bh=SS97nWn4q2LvF/GBzO3N76WT5f/w9w88acg4fr3HcCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qMEDfEBL6BQwpE73tQxS+DjY4I2le93wPYVknOkrI+rMP7gLUdVQYwZl2zqaAT+xS
	 FcEVHxZC95oUa7SCbAX5mlDMLgZneQGJs+TSsydLNXL+pz64lIaJEoaM5TMuaJ34B7
	 9kMmgLbIUgvV8f2evSpojo4/8aF5rIz/9LsjE6xFjrhoahoT2krshH5UhHDVpsSfqu
	 Baw69NSmTouiuCTw6dTR76m7beIADHyd+jvqpGIuzyxblgZnpyAxjX4dXv8VEvfFdh
	 DXE0inzT7O7P0nvMYisXVNGl0jyQBhVOcDzispVfuuA+ONdycZ/2bstnCoxeJAep2y
	 T1en78HGrwENw==
Date: Wed, 23 Apr 2025 15:17:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250423151745.0b5a8e77@kernel.org>
In-Reply-To: <25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
References: <20250416214133.10582-1-jiri@resnulli.us>
	<20250416214133.10582-3-jiri@resnulli.us>
	<20250417183822.4c72fc8e@kernel.org>
	<o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
	<20250418172015.7176c3c0@kernel.org>
	<5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
	<20250422080238.00cbc3dc@kernel.org>
	<25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 13:23:46 +0200 Jiri Pirko wrote:
> >Because you don't have a PF port for local PF.
> >
> >The information you want to convey is which of the PF ports is "local".
> >I believe we discussed this >5 years ago when I was trying to solve
> >this exact problem for the NFP.  
> 
> If you instantiate a VF devlink instance, you would also like to see
> "local" VF port? Does not make any sense to me honestly.
> 
> Why PF needs to have "local" PF port, isn't it a bit like Uroboros? The
> PF devlink instance exists, the ports are links to other entities.
> What's the reason to have a like to itself?

Neither do VF devlink instances in the first place.

> >The topology information belongs on the ports, not the main instance.  
> 
> It's not a topology information. It's an entity property. Take VF for
> example. VF also exposes FunctionUID under devlink info, same as PF.
> There is no port instance under VF devlink instance. Same for SF.
> Do you want to create dummy ports here just to have the "local" link?
> 
> I have to be missing something, the drawing as I see it fits 100%.

Very hard to understand where you're coming from since you haven't
explained why the user has to suddenly care about this new property
you're adding.

