Return-Path: <netdev+bounces-42687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633657CFD20
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF402B20C44
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95941805D;
	Thu, 19 Oct 2023 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBlfZeKj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF70225A3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A9CC433C7;
	Thu, 19 Oct 2023 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697726560;
	bh=gn8f0lL/c50dlaUtn0M4/uha7RqskTVC3QDEAjTmYtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IBlfZeKj0ZEARoRcytYVE9gadpv1rPmLE4txHPWtP9AhEtGgruo0+zmCV9WyYb5rx
	 aGKg4aTjS9RZ0zwcXf5M7bg3mqIYWghj8IFs+EJDeue4WC3f6KOt2GvEoEHd9KoEoH
	 VvTRx7k4I0ia0xKM0AT8SJRqnNwl+9hq0Wgg+cmHBKIl8T40hEpctksfYBaRTLWGk+
	 TFcF/OdSWwoEYTlkoEr2nBEuFusUDej8Md4dTv5srofzCu44i2Z5FpJ7qoQGB51ZI6
	 A4dhEf5v0VbdKSRfOuNMbGC4CElFB1uKeqj/Nl0RnQ0qp/9YPN1OKQYy8l0LOK5D5o
	 HUo6JV7tWuvHg==
Date: Thu, 19 Oct 2023 07:42:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Coiby Xu <coiby.xu@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shannon
 Nelson <shannon.nelson@amd.com>, Michael Chan <michael.chan@broadcom.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, George Cherian
 <george.cherian@marvell.com>, Danielle Ratson <danieller@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Ariel Elior
 <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>, Igor Russkikh
 <irusskikh@marvell.com>, Brett Creeley <brett.creeley@amd.com>, Sunil
 Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Ido Schimmel
 <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Eran Ben Elisha
 <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>, Leon Romanovsky
 <leon@kernel.org>, linux-kernel@vger.kernel.org, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Subject: Re: [PATCH net-next v2 10/11] staging: qlge: devlink health: use
 retained error fmsg API
Message-ID: <20231019074237.7ef255d7@kernel.org>
In-Reply-To: <ZTE884nkvAxKy2G3@d3>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
	<20231017105341.415466-11-przemyslaw.kitszel@intel.com>
	<20231017181543.70a75b82@kernel.org>
	<ZTE884nkvAxKy2G3@d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 10:28:03 -0400 Benjamin Poirier wrote:
> > Humpf. Unrelated to the set, when did qlge grow devlink support?!
> > 
> > Coiby, do you still use this HW?
> > 
> > It looks like the driver was moved to staging on account of being
> > old and unused, and expecting that we'll delete it. Clearly that's
> > not the case if people are adding devlink support, so should we
> > move it back?  
> 
> AFAIK this was done by Coiby as an exercise in kernel programming.
> Improving the debugging dump facilities was one of the tasks in the TODO
> file.
> 
> I moved the driver to staging because it had many problems and it had
> been abandoned by the vendor. There might be some qlge users left but is
> that reason enough to move the driver back to drivers/net/
> if there is no one who is interested in doing more than checkpatch
> fixes on the driver?

Staging is usually an area for code entering the kernel, not leaving.
We should either suffer with it under drivers/net/ or delete it,
as you say, nobody is working on significant improvements so having 
the driver in staging is serving no purpose.

How about we delete it completely, and if someone complains bring 
it back under drivers/net ?

