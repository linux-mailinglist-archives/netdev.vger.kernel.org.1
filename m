Return-Path: <netdev+bounces-140175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C90B9B569F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E431F22C77
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5D2038A1;
	Tue, 29 Oct 2024 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMG7H5a8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D4201007
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243844; cv=none; b=bbBwWw0Ofehw9sv9R8dgIm8rNP7TrM7c3mTKus8sz1FssJHSWHA8PetflCD5Attl87F8rIOa3WB/hy9FJHK1Szm3cJvI0o18RsfwQOaMhSvtDWxJg/tSA1Zi0LQy3BTuvYowL4fD7mNr5Ho7KnDIZXvBDeYUE558ScPa7MuD2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243844; c=relaxed/simple;
	bh=lEOXk2pCUkMcgv0aefH6fk0pZ7qUlWwu1ps2NCWW3Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKTextQ5lbtbmU2BY5xNRDU7V6ByI3iR+zKMRnixT5GgnrOcaTju9f5Dmz8wy9Ivs7yVRdCyn9gJb9udb6R/p8rF6q8za2Frw5jtv9S7pomoS/XVU7vcNLoWp9Y0Un9cRr3tEr4QJUvwN1Nmc2n+H8AxTmSRdxioLFcRpthGnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMG7H5a8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D311DC4CEE3;
	Tue, 29 Oct 2024 23:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243844;
	bh=lEOXk2pCUkMcgv0aefH6fk0pZ7qUlWwu1ps2NCWW3Gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mMG7H5a8cPLXCItRCo2nckjF9CeZbKHYTfct75JKSXOqduqp0WBvM6tPLFAMw89vZ
	 bGfs/CWsl5G/N2cO808mPUoYB1W8ZE0VR/oCy4Bpq3K9YE6oGNV+7gedNv0Z1Ia+mT
	 8cGWPkOOlv80+S64Yt2loQwwz+vZ5gKpuHkdE8NTRpYdCFUAiEJFVRulu8sjvyudnD
	 VhpH8TpTk28gU7UUA76qpggxfdiwbzXNrIKo7em1aUtR3ytxj6ooP9oHq1L57N5h+W
	 S0o+H0dUL9o4GOh+7obWdAC5bmOLTHEGwVT5VPIZ3OFqz7iFwmUWemf64Pq8QcKfmx
	 YBBnniEYrA0uA==
Date: Tue, 29 Oct 2024 16:17:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH net-next 0/5] net: Improve netns handling in RTNL and
 ip_tunnel
Message-ID: <20241029161722.51b86c71@kernel.org>
In-Reply-To: <20241023023146.372653-1-shaw.leon@gmail.com>
References: <20241023023146.372653-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 10:31:41 +0800 Xiao Liang wrote:
> This patch series includes some netns-related improvements and fixes for
> RTNL and ip_tunnel, to make link creation more intuitive:
> 
>  - Creating link in another net namespace doesn't conflict with link names
>    in current one.
>  - Add a flag in rtnl_ops, to avoid netns change when link-netns is present
>    if possible.
>  - When creating ip tunnel (e.g. GRE) in another netns, use current as
>    link-netns if not specified explicitly.
> 
> So that
> 
>   # modprobe ip_gre netns_atomic=1
>   # ip link add netns ns1 link-netns ns2 tun0 type gre ...

Do you think the netns_atomic module param is really necessary?
I doubt anyone cares about the event popping up in the wrong
name space first.

BTW would be good to have tests for this. At least the behavior
around name / ifindex collisions in different namespaces.
You can possibly extend/re-purpose netns-name.sh for this.

For notifications you could use python and subscribe to the events
using a YNL socket. May be easier than dealing with ip monitor
as a background process. But either way is fine.

