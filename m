Return-Path: <netdev+bounces-283744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJWbJKlU+GmWtAIAu9opvQ
	(envelope-from <netdev+bounces-283744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:11:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E14B9F40
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701B23037D48
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D65317147;
	Mon,  4 May 2026 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="y1OD8nvw"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456D1A6813;
	Mon,  4 May 2026 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882048; cv=none; b=IGCi2KCBIQgQXeoPd/kyj+shOG0fWXiMJqeHpbAEKV1ksMDDUv/WgCy65ANdE8Xsmph1htwfVUSYAQyYzQfCW+aiERS/FDz9C3mCIwvCNFbJKuUxL0DXp5haC4JRA0Aievn0H/37s9xXEKeVLurcLNg+Uz4MnjTwmwgol3wjtc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882048; c=relaxed/simple;
	bh=/ySm2GSC256UejaFDh9o8iAtUN0e8MIgoiclCYOBLu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8iRw9URGzpa9IiqIshJ0K0swa64vRLNuzFCIK1aJzq6L4IRSG23fsc9n3AT3qQiVr7TqabofHyusA7ZNBHxftmKc8H8ID1T7LUA1KtYpjjU5DLnvgPe/1NXDgyzgG00XG/K6YlYT3arL4yAjJSu8JykC6V4EkX9+saD8tqpcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=y1OD8nvw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A8F0D20523;
	Mon,  4 May 2026 10:07:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWS4lVTzzt2z; Mon,  4 May 2026 10:07:24 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1BAA520189;
	Mon,  4 May 2026 10:07:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1BAA520189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777882044;
	bh=WqYGuxjucXrHJ0Dq6+nT5loOtJOd3KfRcJxkTNr7i4w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=y1OD8nvw23RHitMCv2EQzclQMcfPgYICvRaf2qNM6BN+LdU1a4w79d70kiLMO9Fs9
	 Y6SsBOpyDqvc8s6yZxlBV5GDEDfK7xVBvJzHfzM3A8/Sa5XIceMUMnIMWeE8st2Blc
	 g0wXeefyKcgGsl+3PKNyqoSEiKssCRHtheOxSwvNVsmmjY0aQOhv7rWFd8BNM+LuXv
	 l4jj3yozjEQ2rcpmlzSG6ucWNNT3gkaQwNmYW/qWN/kIP+xocFWxOKZODgPkSJKhr6
	 moC+D/UKY4S7z+l2ttez+71MVH53wCZD8V9vCUfFjm90HhIzgD0fHNc3+nO86N4idE
	 pxfKi9yLQ488Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 10:07:23 +0200
Received: (nullmailer pid 2946509 invoked by uid 1000);
	Mon, 04 May 2026 08:07:23 -0000
Date: Mon, 4 May 2026 10:07:23 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec-next v3] xfrm: cleanup error path in
 xfrm_add_policy()
Message-ID: <afhTu5oRIoWN-V3l@secunet.com>
References: <20260414020947.65905-1-kartikey406@gmail.com>
 <CADhLXY7C8SAw1SehHmko6JpCqGXCDindcsDbVi0EBsbcsHbW_A@mail.gmail.com>
 <afG0TLg68svCz3G1@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afG0TLg68svCz3G1@secunet.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: F22E14B9F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283744-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

On Wed, Apr 29, 2026 at 09:33:32AM +0200, Steffen Klassert wrote:
> On Wed, Apr 29, 2026 at 07:31:40AM +0530, Deepanshu Kartikey wrote:
> > On Tue, Apr 14, 2026 at 7:39 AM Deepanshu Kartikey
> > <kartikey406@gmail.com> wrote:
> > >
> > > Replace the open-coded manual cleanup in the error path of
> > > xfrm_add_policy() with xfrm_policy_destroy(), which already
> > > handles all the necessary cleanup internally. This is consistent
> > > with how xfrm_policy_construct() handles its own error paths.
> > >
> > > The walk.dead flag must be set before calling xfrm_policy_destroy()
> > > as required by BUG_ON(!policy->walk.dead).
> > >
> > > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > > ---
> > > v3:
> > >   - Changed prefix to ipsec-next as this is a cleanup
> > >   - Dropped syzbot references as suggested by Sabrina Dubroca
> > > v2:
> > >   - Reworded commit message to reflect cleanup rather than bugfix
> > >     as suggested by Sabrina Dubroca
> > >   - Removed incorrect Fixes: and Closes: tags
> > >   - Corrected subject prefix to PATCH ipsec
> > > ---
> > >  net/xfrm/xfrm_user.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > > index d56450f61669..ae144d1e4a65 100644
> > > --- a/net/xfrm/xfrm_user.c
> > > +++ b/net/xfrm/xfrm_user.c
> > > @@ -2267,9 +2267,8 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
> > >
> > >         if (err) {
> > >                 xfrm_dev_policy_delete(xp);
> > > -               xfrm_dev_policy_free(xp);
> > > -               security_xfrm_policy_free(xp->security);
> > > -               kfree(xp);
> > > +               xp->walk.dead = 1;
> > > +               xfrm_policy_destroy(xp);
> > >                 return err;
> > >         }
> > >
> > > --
> > > 2.43.0
> > >
> > Gentle ping on this patch . Please let me know the status of this patch.
> > If anything is required from my side
> 
> Your patch was submitted during the merge window. The net-next
> and ipsec-next trees don't accept patches during this period.
> 
> The merge window ended last Sunday with the release of 7.1-rc1.
> I prepared the ipsec-next tree for the new development cycle
> yesterday. I'll consider your patch now.

Now applied to ipsec-next, thanks Deepanshu!

