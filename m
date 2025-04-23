Return-Path: <netdev+bounces-185294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C0A99B3B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298A03B61BF
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793EA1EB5E1;
	Wed, 23 Apr 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx2nMaNh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F111EA7CD
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446057; cv=none; b=bnbSgBOyMYHxzqPoDYdrDxNxB+tplHYgNdHHMx4UxLYm50XUEZmKhD8X76wPgl9A4ZDgEz2nQqkyIp/0rEswSRqmmx/8/ljAhFmP4c2gUrSB/06i3kKL4OGa67c3snn7tHCQGgIt87cXgfyJ6ERqP90RccmabBlLmXSBAMXj/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446057; c=relaxed/simple;
	bh=2iYosqhpg+TQLNh/FK7gMDwkAOvljALqlMPOuQTOzQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAR0LAy86WUHJBXe71VZfkTQGLPfkJ3NEbmG0gVZUAFo0XzrWIG2NXfS18S9D4kTz8zTGcwG8h1fIKrqsFxiihDvivgka2L+X7ZG1Z5qYcW8RLbtb4CSjgS+i22WY7r5GUJTmpQaxZjxEHuJ/jiejwFRMc1pp5JdwLCUvdHtWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx2nMaNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D0EC4CEE2;
	Wed, 23 Apr 2025 22:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745446056;
	bh=2iYosqhpg+TQLNh/FK7gMDwkAOvljALqlMPOuQTOzQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mx2nMaNh53zrX9xSlHDUGTelhR1r1qUXfnWx0uM/+SeI0tAq5XY7VMnmcEWLRmeiH
	 MlKFIIfLk+eRL/RFcBuGARDvPbywpUwqprs9Fc6ZTacTT/V4QO6F+Wt+3nxJtTKrlx
	 K8E6cELgRlKMbI8qJD3cV0ljeIu2ENWLSLlBzHds4j1HhKlrm3db3BsiAsFw6k9jVN
	 0IY1ceJQppR1DhZVK2H56jlZwYfLq6bGg5FJuqgyzCj/h94OmZ2XHFg5d375e88DXR
	 0T/BZB9N1VeODm6T3FNQWFU2hui9MPlyTjF279Qm8Uw5UCB25OGIwVXRjB+qEIeCPH
	 M4h36OlVcCEzQ==
Date: Wed, 23 Apr 2025 15:07:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 01/14] devlink: define enum for attr types
 of dynamic attributes
Message-ID: <20250423150735.566b6a52@kernel.org>
In-Reply-To: <ccwchffn6gtsy7ek4dhdqaxlbch4mptjqaqmh43a3rk7uu6dxu@jfua3hr6zxvw>
References: <20250414195959.1375031-1-saeed@kernel.org>
	<20250414195959.1375031-2-saeed@kernel.org>
	<20250416180826.6d536702@kernel.org>
	<bctzge47tevxcbbawe7kvbzlygimyxstqiqpptfc63o67g4slc@jenow3ls7fgz>
	<20250418170803.5afa2ddf@kernel.org>
	<v6p7dcbtka6juf2ibero7ivimuhfbxs37uf5qihjbq4un4bdm6@ofdo34scswqq>
	<20250422075524.3bef2b46@kernel.org>
	<ccwchffn6gtsy7ek4dhdqaxlbch4mptjqaqmh43a3rk7uu6dxu@jfua3hr6zxvw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 13:12:56 +0200 Jiri Pirko wrote:
> >Coincidentally - you added it to the YNL spec but didn't set it for 
> >the attrs that carry the values of the enum.  
> 
> True. Will drop it.

Hm, drop it.. in? I mean you should set:

	enum: your-enum-name

on the param-type and .. fmsg-obj-value-type, I'm guessing?

