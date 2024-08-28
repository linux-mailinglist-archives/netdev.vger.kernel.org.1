Return-Path: <netdev+bounces-122820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D2962A9B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA37283FC9
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28E1A01C6;
	Wed, 28 Aug 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j54nxX6n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910D19E81F
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856211; cv=none; b=aAUKTVsbwFa0NsuDSHaDmweF3MaRn+5DAGNNjmuF/hlFtaaqZhM82V+3Tv8/+yZ11J3s1U9RYmYarsLEOLOZZNtxLGrLMPCktPqzT3w+1Wh9yJ1x1zt1BMdXf5feccBRGfoe3hO7SnnbRL/1pm+kBmCbvCQq6PxIcWMTsnB0tpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856211; c=relaxed/simple;
	bh=S/YniOTfilMBnWBydcdinRRlDRHPA0YRSWmdwBgoMxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRmoN3eVyY7ERu4G1WoXROg8T5IQYdghRj424Z6Sn6+JQua75fSZ8w79T8k6ernhJDy/DVsxeVqJISXafhf5S/u35XDYy4C/dk123oluRDSMJFp3+Y7NxFL35jLJfoCHbL6x7NVr6ReORmBabgTnXy1UYJNrRfwb+dAo53gYSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j54nxX6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4BCC4CEC7;
	Wed, 28 Aug 2024 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856210;
	bh=S/YniOTfilMBnWBydcdinRRlDRHPA0YRSWmdwBgoMxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j54nxX6nQ+N5hQiKd38JFImgDOBVaMBEmv1cJ1+mm24mXaarkk7o67R/Ec3VW4hta
	 wND84MFzx1cT+WwySoS8BVyuDH6CYuVj3Qhji68gDW740ZTcZsOKXF9sXc3W0Jh9mn
	 Vgd5+yDys4TN8VcIdGM2BOj6lTLjoOKAOSEvXTb/ciCotkNxboR0vPk0TaimTDL6u4
	 JuAa0S8dBeh3cq/NmsF1bKf0TZzAf4t6cpCJl4lAGryfS/ykz4H9tw8Vi8A/TQojQ8
	 NlvuuqPwJgHEltRi/XXtBFTYRm6gbbjjZkbXjoXdKtTyBZD/dRwd50S/Ws9Dfxo7RO
	 7uCTVhLby2xSw==
Date: Wed, 28 Aug 2024 15:43:26 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv4 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <20240828144326.GN1368797@kernel.org>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
 <20240821105003.547460-2-liuhangbin@gmail.com>
 <20240827130619.1a1cd34f@kernel.org>
 <Zs55_Yhu-UXkeihX@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs55_Yhu-UXkeihX@Laptop-X1>

On Wed, Aug 28, 2024 at 09:14:37AM +0800, Hangbin Liu wrote:
> Hi Jakub,
> On Tue, Aug 27, 2024 at 01:06:19PM -0700, Jakub Kicinski wrote:
> > On Wed, 21 Aug 2024 18:50:01 +0800 Hangbin Liu wrote:
> > > +/**
> > > + * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
> > > + *                  caller must hold rcu_read_lock.
> > > + * @xs: pointer to transformer state struct
> > > + **/
> > 
> > in addition to the feedback on v3, nit: document the return value in
> > kdoc for non-void functions
> 
> I already document the return value. Do you want me to change the format like:
> 
> /**
>  * bond_ipsec_dev - Get active device for IPsec offload,
>  *                  caller must hold rcu_read_lock.
>  * @xs: pointer to transformer state struct
>  *
>  * Return the device for ipsec offload, or NULL if not exist.
>  **/

nit-pick: I think that the ./scripts/kernel-doc expects "Return: " or
          "Returns: "

> BTW, The patch now has conflicts with latest net-next, I can do a rebase if
> you want.
> 
> Thanks
> Hangbin
> 

