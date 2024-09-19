Return-Path: <netdev+bounces-128983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE97E97CB4D
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3F41F2391A
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9071A01A1;
	Thu, 19 Sep 2024 15:04:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08619DF52
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758291; cv=none; b=qxSJVJDeNunlQ91e1hFPkZaJrrq1etmzxxEj3u5HWmt44CiXB5PhdBnlheC0w1sxq+8Z1JjZyuK6Xg7fFyxKoWIAjLRDQCKaakw3nmZYbHQ/aukf29YpoKuEu/dboKmM0NvGctLzeHOSy9n+J6k4Vi5Ln8uiNh02waty5sbbP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758291; c=relaxed/simple;
	bh=QmnW+STDstbxWaFd83vvKlfwB1woJUniQ11eNnzdNR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I883eaJtkWXwf8nQzWC6yRMFN8jZcQkgg0VLYd3a9LXqhm5SpPMyx+RStW5PjdIx1/PInhY8vx0cGygVHLMXHMV0KXgcDF7WwyBUn7Pl4ljmA/mDnPi3QYmyySmtZC+pS91Rmzuv8uxFLKEPVzXXMHZ2KsYiXivB2vaWRCRix5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1srIhv-0004dD-Ob; Thu, 19 Sep 2024 17:04:35 +0200
Date: Thu, 19 Sep 2024 17:04:35 +0200
From: Florian Westphal <fw@strlen.de>
To: Simon Horman <horms@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au, steffen.klassert@secunet.com
Subject: Re: [PATCH ipsec] xfrm: policy: remove last remnants of pernet
 inexact list
Message-ID: <20240919150435.GA8107@breakpoint.cc>
References: <20240918091251.21202-1-fw@strlen.de>
 <20240919143831.GE1571683@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240919143831.GE1571683@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Simon Horman <horms@kernel.org> wrote:
> On Wed, Sep 18, 2024 at 11:12:49AM +0200, Florian Westphal wrote:
> > xfrm_net still contained the no-longer-used inexact policy list heads,
> > remove them.
> >=20
> > Fixes: a54ad727f745 ("xfrm: policy: remove remaining use of inexact lis=
t")
> > Signed-off-by: Florian Westphal <fw@strlen.de>
>=20
> Hi Florian,
>=20
> I am wondering if this is intended for ipsec-next rather than ipsec.
> As I see build failures, due to other instances of policy_inexact
> when it is applied to the latter but not the former.

a54ad727f745 is in net.git, so ipsec.git needs a refresh.
I don't think there is a need to defer this for another 3 months.

