Return-Path: <netdev+bounces-22637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231C76864A
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0676E2817B5
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A15DDC1;
	Sun, 30 Jul 2023 15:47:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047220EE
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 15:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EECBC433C7;
	Sun, 30 Jul 2023 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690732056;
	bh=E6KrOtThtakCof/8dGEFLeJ2MibaXGNFTSPJLGTxfA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3ojT8uN+CBSuNnBg1UHdaGIx2/J2+Ryrudg6QHogELDJuZ5qiyIafJbx1PJxILG2
	 MWfxCb36RA5RB67Yka4F/ZPJJ4OmmgiFg3Yxbfvif922Y4C8XAnSiQ9QhFmnW+yg/t
	 0XbJ0EHvJSL1Ny4197/TlEehJi6a9szlkMjSuNAh7YjzTwiLIcB0cYm/6neK2+JciB
	 0YnjlrUZ8e83W8FIS4gVGdnfZMVBv+r9S0eDVXxc8QaNp96gFoDVlZMzXJ0HExw+xv
	 v3W65AVxQj8b3CGFyLMl12xkNRfNJT9uLHtVJ7I0XfdjMaji6MTKZ3Ihn3u8cUbA4M
	 FBZTcp3xh9gKA==
Date: Sun, 30 Jul 2023 17:47:32 +0200
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com, Andy Moreton <andy.moreton@amd.com>
Subject: Re: [PATCH net] sfc: fix field-spanning memcpy in selftest
Message-ID: <ZMaGFBBC1wvqPttB@kernel.org>
References: <20230728165528.59070-1-edward.cree@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728165528.59070-1-edward.cree@amd.com>

On Fri, Jul 28, 2023 at 05:55:28PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Add a struct_group for the whole packet body so we can copy it in one
>  go without triggering FORTIFY_SOURCE complaints.
> 
> Fixes: cf60ed469629 ("sfc: use padding to fix alignment in loopback test")
> Fixes: 30c24dd87f3f ("sfc: siena: use padding to fix alignment in loopback test")
> Fixes: 1186c6b31ee1 ("sfc: falcon: use padding to fix alignment in loopback test")
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>
> Tested-by: Andy Moreton <andy.moreton@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


