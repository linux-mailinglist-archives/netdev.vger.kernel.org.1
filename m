Return-Path: <netdev+bounces-49722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058507F338A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D424282D24
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3F55A0FB;
	Tue, 21 Nov 2023 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7As298P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38205A0F5
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 16:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE15C433C7;
	Tue, 21 Nov 2023 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700583688;
	bh=38rGyaBLkkS2IxZuHD2369kpK+4LqQOUrzStCrgakeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7As298PDUtwO9tF5Mh+nFMn9RddBX6AakUkfSV41l5XXkSDMZ6nKOvqhgT5i4mTf
	 h99U2mOCsFDammc04441z2Z6jxxQzO6i5Lyexqu6DMd9C0ZI0Ar6v+qSToYZs3qv/P
	 zN/IgYjT2m4hAhtuoEvNoPGuVT4V5iXC8ZkZoQvThIVTDKw9fKU4ylWL0EHU4j34QO
	 jHonn1XCGnWoijv9VK8xuNbvzAOth8eHWiIKl+ifOi438UTb9WTqorCvbaZ/rXWPrb
	 ov9pBa4v/7fupxQjjPzC4XeyqbZe3kHPcAEI27zfmJBOYvfyihnifcPsnLfArvFjmn
	 S2T+5mip41biw==
Date: Tue, 21 Nov 2023 08:21:27 -0800
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
Message-ID: <20231121082127.62a3a478@kernel.org>
In-Reply-To: <ZVwj3kb/3BdvKblG@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
	<20231117093145.1563511-2-liuhangbin@gmail.com>
	<20231118094525.75a88d09@kernel.org>
	<ZVwj3kb/3BdvKblG@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:28:30 +0800 Hangbin Liu wrote:
> Thanks for this info. Will the YAML spec be build by the document team?
> I'd prefer all the doc shows in https://www.kernel.org/doc/html/latest/
> so users could find the doc easily.

That's the plan, it will render under ${base}/networking/netlink_spec/

> It would be good if there is an example in Documentation/netlink/specs/ (when
> the patch applied) so I can take as a reference :)

All the operations, attributes etc in the spec accept a "doc" property.
The html output is just a rendering of those doc strings.
So the existing specs are already kind of examples, although they don't
have doc strings in very many places so the output looks a bit empty :(

