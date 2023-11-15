Return-Path: <netdev+bounces-47925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082F67EBF69
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DB61C20A1F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70DA6119;
	Wed, 15 Nov 2023 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiDcn7Al"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AA5699;
	Wed, 15 Nov 2023 09:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7179C433C8;
	Wed, 15 Nov 2023 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700040361;
	bh=ola6mLeFQVzgiULaIACvGqnS+C3L1wIoI8gY9SqISgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiDcn7AltpXq7ukQh9imyz7mZQCIcvC6TXdBYmfF3fGQldRFIVH/U6OgC4woct8cc
	 Ra8MO0czJba4N3KTWUYEjb44qLzxkywKmjal6PfmtT+nWU59nqPND1aSgxoXzEpDOq
	 yYLmQrqSiMDaXheIQjictvL16ZrAYctzD7kEtTbdmb/SLVm9XgZShqx7oZy2POiYPT
	 /hTvHttCRq1t1/kRhhF/j4ORP0NiXkAcfyxf6Opi5OVBLPR47eEiiuPzO/wtfTFz/T
	 Cr8wzrR87myRlhy9mXJ+O/FCkgLTkZj4eUJNKGrETdagFXYfkuaIsxBD2idjOCAKqg
	 MvYclJwk/XzsA==
Date: Wed, 15 Nov 2023 09:25:57 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
	sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v3 0/8] bpf_redirect_peer fixes
Message-ID: <20231115092557.GJ74656@kernel.org>
References: <20231114004220.6495-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114004220.6495-1-daniel@iogearbox.net>

On Tue, Nov 14, 2023 at 01:42:12AM +0100, Daniel Borkmann wrote:
> This fixes bpf_redirect_peer stats accounting for veth and netkit,
> and adds tstats in the first place for the latter. Utilise indirect
> call wrapper for bpf_redirect_peer, and improve test coverage of the
> latter also for netkit devices. Details in the patches, thanks!
> 
> The series was targeted at bpf originally, and is done here as well,
> so it can trigger BPF CI. Jakub, if you think directly going via net
> is better since the majority of the diff touches net anyway, that is
> fine, too.
> 
> Thanks!
> 
> v2 -> v3:
>   - Add kdoc for pcpu_stat_type (Simon)
>   - Reject invalid type value in netdev_do_alloc_pcpu_stats (Simon)

Thanks Daniel,

this is not a full review, but do confirm the changes above.

>   - Add Reviewed-by tags from list

...

