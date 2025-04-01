Return-Path: <netdev+bounces-178623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473CAA77E46
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B323A4648
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AFA2054E9;
	Tue,  1 Apr 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2c6yZ9s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BC0204F6B
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519145; cv=none; b=GBaCs6Vb5e9gJnjIZIvpUl9FSF8I3CAMHMw+2l9Tga2lA2y47IuYZj9zzPqYY9a+0Q8wiJ4K0FErfri+Sm8nhMRmj6NsdtCnPJXKQZYl0bsV+h+VFu1Srtiyj+bL/yBLXVx+OjeI//cetBNUYJ0pFSulHZgpw3K5tRXFGQURsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519145; c=relaxed/simple;
	bh=O5vf2McjcmLv/TIK1qXqPfW0j1K2e3I6sk9BcVURAtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7GD4fVpm7zdW+0mkGNg2EQyGYZw52/ol72lmY+w/JWTlwfkvYAMT+pcWy23TvR40/zTYlUya7SLpbNeSIsNBIkoEd2PfnlbFjQUMn/jOoDWRcwCQEPohfagnQRcJeYQLTbrXj0YlMkjhdOd2WHRFROSQbBXevPdHaQUtCluSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2c6yZ9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E997C4CEE4;
	Tue,  1 Apr 2025 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743519143;
	bh=O5vf2McjcmLv/TIK1qXqPfW0j1K2e3I6sk9BcVURAtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c2c6yZ9s2vNVJK2PMbGMdZ+xrnvEX5PuRZaYkI1frRSgwJsHBVTdfk27GWJNyYA9T
	 XeHP3eZtuIElj6parIYaVu6mPVrU4y+avm+5LI2D9xf+MQBmjeshQ17G4Gr3X261O5
	 0nOYXCN4Zmof0IT3yISoMtSHWn1iwVParEERVo0dwXa/X0mThbbL7fjCBK+5nzpfHR
	 AJqMLoqR1vfIxsKdOP7KDEIXTXIyRxT+pqk3TAfIrd8iUm38SrzMQTMbisOT7F+fmR
	 1sKNGjxz7WjO7CHKjAmEztlFPFNW5HaQthBJo7qeLa+VCqOQAPI3nU8WxW0laMfO58
	 9eYfjNhRZ/TYQ==
Date: Tue, 1 Apr 2025 07:52:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 parav@nvidia.com
Subject: Re: [PATCH net-next v2 2/4] net/mlx5: Expose serial numbers in
 devlink info
Message-ID: <20250401075222.59997a37@kernel.org>
In-Reply-To: <qt22pagi3weqc2mazctajndd5sej6zmvr3q4sq25r2ioe2qaow@parw3mavhvji>
References: <20250320085947.103419-1-jiri@resnulli.us>
	<20250320085947.103419-3-jiri@resnulli.us>
	<20250325044653.52fea697@kernel.org>
	<6mrfruwwp35efgzjjvgqkvjzahsvki6b3sw6uozapl7o5nf6mu@z6t7s7qp6e76>
	<20250331092226.589edb9a@kernel.org>
	<qt22pagi3weqc2mazctajndd5sej6zmvr3q4sq25r2ioe2qaow@parw3mavhvji>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 11:01:44 +0200 Jiri Pirko wrote:
> >But also having two serial numbers makes no sense.  
> 
> They are serial number for different entity:
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
> 
> Why it does not make sense?

Missed the exact put helper is different. Makes sense now!

