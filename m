Return-Path: <netdev+bounces-21660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D0B764213
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0431A1C21470
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762E198B4;
	Wed, 26 Jul 2023 22:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF751BF1F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 22:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21570C433C7;
	Wed, 26 Jul 2023 22:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690410209;
	bh=Z/dFAh3lRG1WxFSsUnDdUp06VKTszUch8bHVoOEDo+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mFGqt3m39tBkQ8uL2zgnmYWppVWNNWZoDPsT/V4ytmRD3IyRV6x1OB1K3ciRofNXJ
	 vMvPAUNWBaYwqae9UlIRqFJpBS0ssHClzxjpyzBe0YnLF6+mylCbrlStlBI0xcEzH0
	 Oey+dVS/KvjgWT5SNqO36Fi9doV+VTpzRL461xeew6CBaba8Z4TULZcs/I5fA1wce0
	 472EeiSwzo6mudxFN1j5XdhsVoOyjpxEG9gqUyhaF2q287x2sOtL8O0FiDFLaN10CH
	 7pfvw9lW6n3/jjOCHEokcfeF7a9BZ54dEPB5jqunel4zq8b8JVGD2BCpo+7SV14vuu
	 6rze+dCRTvcpg==
Date: Wed, 26 Jul 2023 15:23:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/3] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <20230726152328.3b0a3d81@kernel.org>
In-Reply-To: <CAD4GDZw=CoHXbTn_AR1h2YUnn92K_JVj+ACAKH670PWRrJ+_pA@mail.gmail.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
	<20230725162205.27526-3-donald.hunter@gmail.com>
	<20230726143709.791169dd@kernel.org>
	<CAD4GDZw=CoHXbTn_AR1h2YUnn92K_JVj+ACAKH670PWRrJ+_pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 23:01:12 +0100 Donald Hunter wrote:
> > and store them in YnlFamily to self.nlproto or self.protocol
> > or some such.  
> 
> Ack. Just a note that I have been wondering about refactoring this
> from "YnlFamily is a Spec" to "Ynl has n Specs" so that we could do
> multi spec notification handling. If we did this, then passing a
> SpecContext around would look more natural maybe.

Ynl with multiple specs is doable from the technical standpoint,
I think the API to expose from such a library may be a bigger challenge.
And I'm not sure if it's worth the complexity in practice.

> > I applied the series on top of Arkadiusz's fixes and this line throws
> > an "as_struct takes 2 arguments, 3 given" exception.  
> 
> Ah, my bad. Looks like I missed a fix for that from the patchset.

FWIW I ended up merging the fixes to net, but they should be in
net-next by tomorrow afternoon.

