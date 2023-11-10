Return-Path: <netdev+bounces-47127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D157E7E27
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662CEB20C1F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAEC219FE;
	Fri, 10 Nov 2023 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A34D4Kg3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD24208A8
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 17:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01DEC433C7;
	Fri, 10 Nov 2023 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699637517;
	bh=9S4+7npXA7Vr3v5S6ByF8ht9SKpSkLnhmp75JHaFpDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A34D4Kg3ovovfu7SLkzb/2JvAWSCHLPdy5z5OH0rZ35L8xuVt5DuDqHtxuHZ4jG7A
	 KaXeUhfeT2wqmwhVsk0+/yalpiapqEU6zGSQNa5FzJqZveevon0j0nlFOEWrWH6QHD
	 6+0gtoNzyM1/g1sZU58GjtIUmQZr1ZNI0iBz0i35MsZe80hlGm7Sy9mXrSX0lA7PO1
	 TYwbPPvf38XUZWow2Pv59xd9vaxG1wxLZBn2ZNC+UKiwt9gZazeta6Z765kC5j6kKN
	 XuG1JQpi3sJ4V0sPFtAUDF77WyGHd80sTJArqvjV3F09DmhqLj46uu62+EqJNZ7IHX
	 oQok3IuJFQEVQ==
Date: Fri, 10 Nov 2023 17:31:51 +0000
From: Simon Horman <horms@kernel.org>
To: Johnathan Mantey <johnathanx.mantey@intel.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ncsi: Revert NCSI link loss/gain commit
Message-ID: <20231110173151.GA649059@kernel.org>
References: <20231109205137.819392-1-johnathanx.mantey@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109205137.819392-1-johnathanx.mantey@intel.com>

On Thu, Nov 09, 2023 at 12:51:37PM -0800, Johnathan Mantey wrote:
> The NCSI commit
> ncsi: Propagate carrier gain/loss events to the NCSI controller
> introduced unwanted behavior.
> 
> The intent for the commit was to be able to detect carrier loss/gain
> for just the NIC connected to the BMC. The unwanted effect is a
> carrier loss for auxiliary paths also causes the BMC to lose
> carrier. The BMC never regains carrier despite the secondary NIC
> regaining a link.
> 
> This change, when merged, needs to be backported to stable kernels.
> 5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable
> 
> Fixes: 3780bb29311e ncsi: Propagate carrier gain/loss events to the
> CC: stable@vger.kernel.org
> Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>

Hi Johnathan,

thanks for your patch.
Some minor feedback from my side.

1. The correct format for the tag above is:

   Fixes: 3780bb29311e ("ncsi: Propagate carrier gain/loss events to the NCSI controller")

2. I think it is usual to format the subject and commit messages for
   revert commits a bit like this:

   Subject: [PATCH net vX] Revert "ncsi: Propagate carrier gain/loss events to the NCSI controller"

   This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.

   The cited commit introduced unwanted behavior.

   The intent for the commit was to be able to detect carrier loss/gain
   for just the NIC connected to the BMC. The unwanted effect is a
   carrier loss for auxiliary paths also causes the BMC to lose
   carrier. The BMC never regains carrier despite the secondary NIC
   regaining a link.

   ...

