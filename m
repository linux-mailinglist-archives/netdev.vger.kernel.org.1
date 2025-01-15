Return-Path: <netdev+bounces-158658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C516A12E14
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7E1889A67
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3300A1DACB8;
	Wed, 15 Jan 2025 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVSU6PHR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803114B959;
	Wed, 15 Jan 2025 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736978791; cv=none; b=b+opEFiG5B2NKW2o9QxvCp2VUiCzmjgc9Se1U6TWnG0zVOWJUsMpaxEQ0jftYVJO4vYZc/5WVicdQ2PuhYW6Q4hglunBR2yYiyTrjEiXp/ZiGUVxOncIgB9QT9eDlcHZRw+GDLNaKJ/XajNTZJds15lP6fFuf7pNWfdYnLWMB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736978791; c=relaxed/simple;
	bh=OrqNIeP5Lsyj0QQbwXP6V6pMaJ3YCATIJ7eT3LsJKjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6P3j+LuFmgMfJI4ynacHK39CsQzXSLS88HgCih/ZMwqyEminTbtKymJEYgo7dTG9NDvkjYlVx0+oLcxiMgq0trtOoAutDR+d9u7H8ZuDdT6I0OzJVzRtBzoEkWOcFkRt33Fv92M4PHhCUewpTt4FHwYdjm9xQKWDx7ik9CW1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVSU6PHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8C8C4CED1;
	Wed, 15 Jan 2025 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736978790;
	bh=OrqNIeP5Lsyj0QQbwXP6V6pMaJ3YCATIJ7eT3LsJKjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVSU6PHRIDStXuNKnHl2KTyfrHshzJEZShltiqasWXphcmY5a9+nupHRYSsDGASgX
	 kWFIKZ29qq1Fi4qfjTZlQ3sbyS77iCrSU+pIMqUQVKW4mRGVsDU9HoNyhZw+i/g4p9
	 HNw0n9QWcLgjnMiKAdp1YjQdJgSaXnyzwHSK0sDG3T3ErDqVODVYcStboqRNCnv59l
	 Tn+QCotMBhpycvQrKgS4/Zx1RicI8ZGVygB8bWJfUtCkIHXPEV/t23VP477kGD8l9P
	 rn57XY6MIQqoXm6yY5atramIWE9xDWLXH+oiyqbwT3GqZuYARmhJGkYXFTvjdBVVdJ
	 DCerY39s2kFIQ==
Date: Wed, 15 Jan 2025 14:06:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yeking@Red54.com
Cc: arnd@arndb.de, davem@davemloft.net, edumazet@google.com,
 gregkh@linuxfoundation.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, prarit@redhat.com,
 vkuznets@redhat.com
Subject: Re: [PATCH net v2] net: appletalk: Drop aarp_send_probe_phase1()
Message-ID: <20250115140629.1c37c8a2@kernel.org>
In-Reply-To: <tencent_EE9140075A979E58EBB03FA7E7DEF6831F07@qq.com>
References: <20250110182435.6b811abe@kernel.org>
	<tencent_EE9140075A979E58EBB03FA7E7DEF6831F07@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 09:44:51 +0000 Yeking@Red54.com wrote:
>  void aarp_probe_network(struct atalk_iface *atif)
>  {
> -	if (atif->dev->type == ARPHRD_LOCALTLK ||
> -	    atif->dev->type == ARPHRD_PPP)
> -		aarp_send_probe_phase1(atif);
> -	else {
> +	if (atif->dev->type != ARPHRD_LOCALTLK &&
> +	    atif->dev->type != ARPHRD_PPP) {
>  		unsigned int count;

You assert this is our only option, so why leave the if () around 
at all?

nit: subject prefix should be "PATCH net-next v2"
-- 
pw-bot: cr

