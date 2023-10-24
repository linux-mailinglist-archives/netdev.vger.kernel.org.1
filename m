Return-Path: <netdev+bounces-43912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816217D55BA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF7F281B1F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E636AEE;
	Tue, 24 Oct 2023 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123735884
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:20:50 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A9C3C2A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:20:32 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qvJCg-00011d-1o; Tue, 24 Oct 2023 17:20:22 +0200
Date: Tue, 24 Oct 2023 17:20:22 +0200
From: Florian Westphal <fw@strlen.de>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Florian Westphal <fw@strlen.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>, devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH ipsec-next] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
Message-ID: <20231024152022.GC29201@breakpoint.cc>
References: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b604dc470c708e1e70c954f1513e4b461531e7cc.1698136108.git.antony.antony@secunet.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Antony Antony <antony.antony@secunet.com> wrote:
> The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
> in 2004 [2], has remained inactive and obsolete for an extended period.
> 
> This mode was originally defined in an early version of an IETF draft
> [1] from 2001. By the time it was integrated into the kernel in 2004 [2],
> it had already been replaced by UDP_ENCAP_ESPINUDP [3] in later
> versions of draft-ietf-ipsec-udp-encaps, particularly in version 06.
> 
> Over time, UDP_ENCAP_ESPINUDP_NON_IKE has lost its relevance, with no
> known use cases.
> 
> With this commit, we remove support for UDP_ENCAP_ESPINUDP_NON_IKE,
> simplifying the code base and eliminating unnecessary complexity.
> 
> References:
> [1] https://datatracker.ietf.org/doc/html/draft-ietf-ipsec-udp-encaps-00.txt
> 
> [2] Commit that added UDP_ENCAP_ESPINUDP_NON_IKE to the Linux historic
>     repository.
> 
>     Author: Andreas Gruenbacher <agruen@suse.de>
>     Date: Fri Apr 9 01:47:47 2004 -0700
> 
>    [IPSEC]: Support draft-ietf-ipsec-udp-encaps-00/01, some ipec impls need it.
> 
> [3] Commit that added UDP_ENCAP_ESPINUDP to the Linux historic
>     repository.
> 
>     Author: Derek Atkins <derek@ihtfp.com>
>     Date: Wed Apr 2 13:21:02 2003 -0800
> 
>     [IPSEC]: Implement UDP Encapsulation framework.
> 
> Should I leave the '#define UDP_ENCAP_ESPINUDP_NON_IKE' in the uapi/linux/udp.h?
> since it is a chnage to ABI?

Yes, but you can add e.g. append "(obsolete)" or "(not supported
anymore)" or something like that to the trailing comment.

And you could wrap it in "#ifndef __KERNEL__" to have build breakage
if anytning in the kernel tries to make use of it.

Patch LGTM.

