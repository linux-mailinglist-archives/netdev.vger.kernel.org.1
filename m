Return-Path: <netdev+bounces-199485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9CFAE07AC
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD47A2D79
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBB2248BD;
	Thu, 19 Jun 2025 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k64cr5gf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344720468E
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340751; cv=none; b=TXWUcxnL2GLyC+tCIyQW15r9MInOGpott/OOPAFeCF3AU9HTCe8dLn9s3S2jqw8XVAVbrARt2MruIUwf9wcwG5/Yj3ROgSO12nagNwu38cgAv3G4CYzxiMr5HgkCvQ0UCpEBAAmn9ZUKULzZq3xhAyvuGwraT8yGydwvA+Vmct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340751; c=relaxed/simple;
	bh=bNRAVlPwwpX1wXmJIaEHOslWBMrvUHzTCBJlUBoAXw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHKu2wbdm5uRZ9mholpemudJnsY3yKOsWEzuQWv3LmDGGj1wc2svZ4cEpoq+O9ty7Kvf2cBg6KWch9E7kus4kDM7mY2ZMWt+47C5VGrN3n3fziagv4ZYt7PzPIpy50nLupIYoqnNEGhtju6v5dizQ+Ghb0bzVXgO+tlJLn/WW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k64cr5gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BA5C4CEEA;
	Thu, 19 Jun 2025 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750340750;
	bh=bNRAVlPwwpX1wXmJIaEHOslWBMrvUHzTCBJlUBoAXw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k64cr5gfli1D0YIVjNMBAr+xp22Ilk/7DM4lNHEtnql3dp9QVcjwOupmLwbGjHCWD
	 zRcDbs0EKbpnnIzL+zM9T/hdn1JCFRSN4Z7jkYo34c0FbZE96Z4qhqcimA4RDmC3kf
	 0sAx6xauTIEk9GtxVrgYglEhFTMgbp0G3ufDd1FGPArMs1+ltTIvKk4ei1uTjmTHxl
	 XCwr3faTMMTVc0QIgyfbsHsEUe8SguE+uFDe5KvDydCB5vHnzVr6k8pDpxvAzhpQyo
	 /WQM1+fw8AnKV2fhVB9/6kRDP5zYddByC48SNckDm835ydj47JT/dXB+dfo9Vrtemz
	 DY3vw3BVOxRxA==
Date: Thu, 19 Jun 2025 14:45:47 +0100
From: Simon Horman <horms@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ip6_tunnel: enable to change proto of fb tunnels
Message-ID: <20250619134547.GS1699@horms.kernel.org>
References: <20250617160126.1093435-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617160126.1093435-1-nicolas.dichtel@6wind.com>

On Tue, Jun 17, 2025 at 06:01:25PM +0200, Nicolas Dichtel wrote:
> This is possible via the ioctl API:
> > ip -6 tunnel change ip6tnl0 mode any
> 
> Let's align the netlink API:
> > ip link set ip6tnl0 type ip6tnl mode any
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Thanks,

Looking over the code, I agree that this is supported by the ioctl
interface. And, for consistency, I think it makes sense for the netlink
interface to do so too.

Reviewed-by: Simon Horman <horms@kernel.org>

