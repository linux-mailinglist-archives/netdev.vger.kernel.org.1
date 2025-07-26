Return-Path: <netdev+bounces-210254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB4B127DB
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5B1AA82F6
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7BDDAB;
	Sat, 26 Jul 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7CMdyoy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318F2E3700;
	Sat, 26 Jul 2025 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488655; cv=none; b=GeT5i4Euprbs9IEoDfmMeJiq39pWXnDpa1QGEtqw73VCs9/tm4+fgPa8O5iif4DVf1fQ7NtmrkCNtIk1hjUD96Qvzx6QLmhujBoqkbQD/xDVF5UqPSbjPSB/gU2n9WfhFCUzGRIkHEfvjPEFcgCIjd0wfFSLi33LSujtTBwGb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488655; c=relaxed/simple;
	bh=J9IMu+WunD+yege/P47CSY0QSujcshUb6CrnDYfBf1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9Gas4YnCGr1kNz0mYxIbqW22DoAM6FKC3A1tNTBFp0sa8hAuT/th1Cg4MH8vj/ZmYMMsfJFtS3Mc9+2VP/I2E3X28cMYIwdXIw/3k3cLsdWlcZcAv0eiwatuEVRQG2xzgOFr6mHHCXpCkFE/B2lJpVDbWQUcHPsR90Z1cqHUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7CMdyoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9A4C4CEE7;
	Sat, 26 Jul 2025 00:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753488654;
	bh=J9IMu+WunD+yege/P47CSY0QSujcshUb6CrnDYfBf1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e7CMdyoyjVQdvHxO9D6awDuQ1vBdJaiWIAaEWDvPacblIHi2DWLzSJKSn9ZYp2cPw
	 XkqKHzowIAf1NHXYDyKqjR/uU7HFBZu1NCC6DNoSatIHvzZrnlY0pl22djFbOI8wln
	 A87+VI+Ua2E/MT1hcdgd3gTXwfrljgWR3qq0PlAQ1zWswn6+ad6+L7UozjSiguxpWe
	 lptoLMHLRq0wUW11wLXmMlm/V5mkby4BEbRpfxKq34bh/Z1rOBvZT/0o7m9GWBSxiA
	 ckUm2YZ9r01Pc8XRumuYuKNqIZW3sZw32fJLRdvu6Mr4xZkWyC902R+xfIK0geRMzZ
	 OBsO35qalNlFw==
Date: Fri, 25 Jul 2025 17:10:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vivek.Pernamitta@quicinc.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Manivannan Sadhasivam <mani@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>, Vivek Pernamitta
 <quic_vpernami@quicinc.com>
Subject: Re: [PATCH 2/4] net: mhi : Add support to enable ethernet interface
Message-ID: <20250725171053.03c0c44d@kernel.org>
In-Reply-To: <20250724-b4-eth_us-v1-2-4dff04a9a128@quicinc.com>
References: <20250724-b4-eth_us-v1-0-4dff04a9a128@quicinc.com>
	<20250724-b4-eth_us-v1-2-4dff04a9a128@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 19:21:18 +0530 Vivek.Pernamitta@quicinc.com wrote:
>  	ndev = alloc_netdev(sizeof(struct mhi_net_dev), netname,
> -			    NET_NAME_PREDICTABLE, mhi_net_setup);
> +			    NET_NAME_PREDICTABLE, info->ethernet_if ?
> +			    mhi_ethernet_setup : mhi_net_setup);

Similar story, if it's an Ethernet device is should be called eth%d
and user space can name it whatever it wants based on the full sysfs
attribute set.

For n-th time in our history we discover that having the kernel create
"predictable" names always falls short, sigh.

