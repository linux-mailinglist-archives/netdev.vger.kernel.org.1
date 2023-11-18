Return-Path: <netdev+bounces-48941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B887F019B
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 18:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458C1B2097D
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B61A70F;
	Sat, 18 Nov 2023 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxPFRvNx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F818E3A
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 17:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7B6C433C7;
	Sat, 18 Nov 2023 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700329527;
	bh=aLxmi9CxPGy18gVLg17JzI8A+bke4+qKGNRvmR5Otv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UxPFRvNxzytQqCOPqp9yVSLO56dXb4YUEDF9p4yj+i5eBxrd8O2i7bfVPBL5+XYP0
	 Jcb43rpidRAfDUTLkyH/EVfHEGoMq57o+YFc4InL8SRjCSwJnN4VGCGSpI+h1C+V5M
	 Ek+387fXdBcgJnW4BUZ1X2mgeXcAasl578ay800+Wy2o6Nk5P5tyUzmqyo0ojiYoJH
	 yN9S5POFa0fwkAW98OFp+RrVvUK2vwOVi0YLUYVkjTbWZQ7Z38GAxzRtB9I11DKJdg
	 HQLN3lGgFHWIJg5nZ1Wh1TCpuP/jh3tSLvl8fsbEic3avOLHurr0optbIO2s2+1CHX
	 G2IqB4Ul+2iGA==
Date: Sat, 18 Nov 2023 09:45:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Florian Westphal <fw@strlen.de>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld
 <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: bridge: add document for IFLA_BR
 enum
Message-ID: <20231118094525.75a88d09@kernel.org>
In-Reply-To: <20231117093145.1563511-2-liuhangbin@gmail.com>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
	<20231117093145.1563511-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 17:31:36 +0800 Hangbin Liu wrote:
> Add document for IFLA_BR enum so we can use it in
> Documentation/networking/bridge.rst.

Did you consider writing a YAML spec instead?

It's unlikely to be usable today with YNL due to all the classic
netlink vs genetlink differences, but Breno is working on rendering 
the specs in documentation:

https://lore.kernel.org/all/20231113202936.242308-1-leitao@debian.org/

so in terms of just documenting attributes it may be good enough.
It may possibly be nice to have that documentation folder as "one 
stop shop" for all of netlink?

Absolutely no strong preference on my side, just wanted to make
sure you're aware of that work.

