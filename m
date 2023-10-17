Return-Path: <netdev+bounces-41969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69827CC76D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD3328107E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B25450C2;
	Tue, 17 Oct 2023 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0fCTElf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81ECEBE
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914D1C433C8;
	Tue, 17 Oct 2023 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697556380;
	bh=6c9g+TsbNLPgQESWrmr2fOIsVB5tfJx/lE+QaNHkWkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0fCTElf6Op4uqTcgXFqUTD1JmmUcWlep46ulGMHEZKW8ukh9HdjEbNOi7mVtOqBN
	 Myx02rKPSHYd70LV6XfCSUDq9JSgUfOpbIEsaT9LU+dEorDfZWxW+hgIPJNP2h6XKG
	 N+6r09diVSN+pEU8D2TzoA8rA4dRQg8hQwf8CrWk7lDS1fhHustRuKBt3WNzWDAq5t
	 /P+lLp0b9R6EBDw5IGw8yFO8hE1HA9i3tkgjpyXDoqoUc4OIcect88iqY9yEDyzI+r
	 CQOoHKA8kZnQ3VmPkU+46TbiJZjO7FCbijxsiheLX3BgHja8knyXh9GjMmYTclqJ9b
	 fiMpPaDORRnhA==
Date: Tue, 17 Oct 2023 08:26:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Zink <j.zink@pengutronix.de>
Cc: Simon Horman <horms@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Kurt Kanzenbach
 <kurt@linutronix.de>, patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next 2/5] net: stmmac: fix PPS capture input index
Message-ID: <20231017082618.4558ad06@kernel.org>
In-Reply-To: <004d6ce9-7d15-4944-b31c-c9e628e7483a@pengutronix.de>
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
	<20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
	<20231014144428.GA1386676@kernel.org>
	<004d6ce9-7d15-4944-b31c-c9e628e7483a@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 11:12:53 +0200 Johannes Zink wrote:
> > If it is a bug fix then it should probably be targeted at 'net',
> > creating a dependency for the remainder of this series.
> > 
> > On the other hand, if it is not a bug fix then perhaps it is best to
> > update the subject and drop the Fixes tag.  
> 
> I added the fixes-Tag in order to make code archeology easier, but as it may 
> trigger picks to stable branches (which is not required imho), I have no 
> objections to dropping it for a v2.

Would be good to clarify what impact on device operation the problem
has. How would end user notice the problem?
Does it mean snapshots were always or never enabled, previously?

Note that if you submit this fix for net today it will still make it 
to -rc7 and net-next by tomorrow, so no major delay. We merge the trees
on Thursday, usually.

