Return-Path: <netdev+bounces-69540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D484B9C5
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7EC1C20AB4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2CD1339A1;
	Tue,  6 Feb 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUGEurW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958113342F
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233809; cv=none; b=meDP28rHGsS1HkLA/Hiha5T8Mnv09WWagmdZfJRzhNKCanvjjJaoAGZNNodZg8wf5YTk564BVgns8N473yUn61g/C4rJPP0a/wGikE6YDwvWqx7xj2AgayPOk/h97/CgQABwLj1xcu+dP85cW6JR4hSv+jMRdncwFg38mDfVwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233809; c=relaxed/simple;
	bh=S0CeLYVdh+zl47w5UfLAbMsITly6fE758nIT+apcz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5IrbGDTcKyiNkrFF2iOwB5IlQsjAkk5fBD4LSnVfZ42U6vgWLOzvBn3NYuYvM2ErAZjklIrMtG6vEpJVNIskY+Nx8Aiv/iP+TA12b80dFPNvtmF6sj2uxCsMMtP5C1rqYAojzUkfhyQfxKHFyKTFeXXZVqjNGrJhn1COOqcM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUGEurW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5E2C433C7;
	Tue,  6 Feb 2024 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233809;
	bh=S0CeLYVdh+zl47w5UfLAbMsITly6fE758nIT+apcz9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUGEurW5uUHUsq+IiecfVHF1+syi2QctPaCbOYdipqhqzWmiGOE6XLxUQ5xQCMOp5
	 WenCL/1joZRh3qWRHMNH8qO77CjQEd+SaC79iBitojGnpi1qb8FBJE1Vfy5qJgs36d
	 cEUGHH0kL0FqiLh7r/+FmkHRYq744s9Zb1FNXF+KZz3oAZR9ESVslwYhthhkh51FwI
	 Av0WnsktR/4LOftZvwkVij51eWvH78y5PqnIcaTkAfMtAQchixZpWRRM98v5zN/ES1
	 WnIDSit0eViWqj/zSLLVbIp1Qg/Oq28JMNdoWIlUc3mhs7G6aXuKiQiTeRB0WcbNJc
	 /VC/udb8fnWXQ==
Date: Tue, 6 Feb 2024 15:35:15 +0000
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net] selftests: bonding: fix macvlan2's namespace name
Message-ID: <20240206153515.GE1104779@kernel.org>
References: <20240204083828.1511334-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204083828.1511334-1-liuhangbin@gmail.com>

On Sun, Feb 04, 2024 at 04:38:28PM +0800, Hangbin Liu wrote:
> The m2's ns name should be m2-xxxxxx, not m1.
> 
> Fixes: 246af950b940 ("selftests: bonding: add macvlan over bond testing")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Hi Hangbin Liu,

I agree this is a nice change.
But it is not clear to me that this is fixing a bug.

> ---
>  tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> index dc99e4ac262e..969bf9af1b94 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> @@ -7,7 +7,7 @@ lib_dir=$(dirname "$0")
>  source ${lib_dir}/bond_topo_2d1c.sh
>  
>  m1_ns="m1-$(mktemp -u XXXXXX)"
> -m2_ns="m1-$(mktemp -u XXXXXX)"
> +m2_ns="m2-$(mktemp -u XXXXXX)"
>  m1_ip4="192.0.2.11"
>  m1_ip6="2001:db8::11"
>  m2_ip4="192.0.2.12"
> -- 
> 2.43.0
> 
> 

