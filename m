Return-Path: <netdev+bounces-57573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D25881370B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD63281A82
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76E63DC2;
	Thu, 14 Dec 2023 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N38mbHY8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81760BB1
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 16:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF70AC433C7;
	Thu, 14 Dec 2023 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702572982;
	bh=yjwkkXa5tuGvS9a0eNyxBFMujXN9+g3AYXJEgo5VxVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N38mbHY8lHwLQXkL1DGHhOJK9wrHe0FLRetzqnx6bdKtAl84ugUYhu03yz5JN1LDa
	 80t4MVB1VXStpMMzoJ8L7+cnTG7/a+TMh1Aru/DgSvK9Jg5ztrpEurgS54n9wMcaxb
	 CZ5PzNkTuK2bAqv0wK/FfN9YXlquMMqrGSCAPkbgKAePinpntGCBVnOQCnHLIMIhb/
	 WiDiz1W6uyGYgvRqt6nZm0Dp6wPy4G4S1LZW6CGEbmfsFE/JX37VAKzVZodGzPVMIr
	 1nliqdBr5NReDEwMTmB+q3zbLinXISNZlXCGWW24K6D7X5PoGKdiIpc2Ir2TCC5K98
	 PzcI9LN8G82LQ==
Date: Thu, 14 Dec 2023 16:56:18 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com,
	linux-net-drivers@amd.com, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com,
	Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: Re: [PATCH net-next 7/7] sfc: add debugfs node for filter table
 contents
Message-ID: <20231214165618.GM5817@kernel.org>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
 <20231211191734.GQ5817@kernel.org>
 <38eabc7c-e84b-77af-1ec4-f487154eb408@gmail.com>
 <b9456284-432d-2254-0af2-1dedeca0183d@gmail.com>
 <20231212081944.2480f57b@kernel.org>
 <6258c258-b1c2-0856-aff7-cca33be15bf6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6258c258-b1c2-0856-aff7-cca33be15bf6@gmail.com>

On Wed, Dec 13, 2023 at 12:15:04PM +0000, Edward Cree wrote:
> On 12/12/2023 16:19, Jakub Kicinski wrote:
> > On Tue, 12 Dec 2023 15:14:17 +0000 Edward Cree wrote:
> >> I will update the commit message to call out and explain this; I
> >>  believe the code is actually fine.
> > 
> > Fair point, second time in a ~month we see this sort of false positive.
> > I'll throw [^\\]$ at the end of the regex to try to avoid matching stuff
> > that's most likely a macro.
> 
> Sounds good, thanks.
> 
> > This one looks legit tho:
> > 
> > +void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec) {}
> 
> Yep, that one's real, will be fixed in v2.
> And this time I'll actually build-test with CONFIG_DEBUG_FS=n,
>  which I forgot to do with v1 (sorry).

Thanks, and sorry for the false positives.
Also, I like coffee :)

> 
> -ed

