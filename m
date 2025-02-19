Return-Path: <netdev+bounces-167803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59644A3C64A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D045189A282
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7581F3D56;
	Wed, 19 Feb 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbJtf8Oq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759511B415B
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986588; cv=none; b=ZG15r8DnMC3LnTH8EJGG4hOC6oy9LuLqfL3Nfgu66t3TSmEr2IwLx+BX/05zjN9d4M9HdHQjvlc7Wgfz7fgqBn5+iuMf6deFUJU+eAa3eD/ZcGj2xi0YDcoMf1wQwRUAtxkmfYduTH+EjCg4jW+hq6Cn9UAtNwBTmQ5ns6WIy5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986588; c=relaxed/simple;
	bh=ZdE91ZJezPzzbSi9krBTq4tLzcAVMP/LGMdlA8cysiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss6VA6Wj/sMnDlbL95Ad14sAcgmkBg0Nzj8mFTLpaOlxBUD6kyp/OrhuQwb37c421w2WwgcyzIjws+G88CpfmtH2MfxpHC67ntaAVnJESuNliRf7RaAA3x3AAJjD3d08umINF34jG+TEPfD5JUdkKv1uUasWRWLKnhXbXCgMl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbJtf8Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F68C4CED1;
	Wed, 19 Feb 2025 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986587;
	bh=ZdE91ZJezPzzbSi9krBTq4tLzcAVMP/LGMdlA8cysiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LbJtf8Oqt3gN+V5ocNHtis9g8lP7of7P6JgrEJBQPIHSRvGdJ39Dxky3BQXY0SY/X
	 I9DcOackHkIoszpQUb5YzUaraqlf/R+I/6YevftAVE+8G/dz/8O03Yi4xCPZB+BdmI
	 Kd4t550d44BhPNQPoGTLM/QGUxfZMeIzcQkS6VWb2ewfALY5gS1jy+vn32u3sykOnz
	 LN1S7kSn18PClEA7KnrDiTqakV/81jLElwZZfT1WZN3b0mIn5K2e3FLLVcxLuNpgI9
	 EuA+ZtT6AdMuC4cpJOzJ533Ywkix8zV3e3u1Dwz6ACYwDLygPHtTG+AlAvYMC9HXhi
	 ZGGcGXW34Xf7w==
Date: Wed, 19 Feb 2025 09:36:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Saeed Mahameed
 <saeed@kernel.org>
Subject: Re: [PATCH net-next v4 10/12] net: dummy: add dummy shaper API
Message-ID: <20250219093626.08cbe243@kernel.org>
In-Reply-To: <Z7VkiOkRxL3vOL0G@mini-arch>
References: <20250218020948.160643-1-sdf@fomichev.me>
	<20250218020948.160643-11-sdf@fomichev.me>
	<20250218190940.62592c97@kernel.org>
	<Z7VkiOkRxL3vOL0G@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 20:56:40 -0800 Stanislav Fomichev wrote:
> On 02/18, Jakub Kicinski wrote:
> > On Mon, 17 Feb 2025 18:09:46 -0800 Stanislav Fomichev wrote:  
> > > A lot of selftests are using dummy module, convert it to netdev
> > > instance lock to expand the test coverage.  
> > 
> > I think the next version should be ready for merging.
> > What should we do with this patch?
> > Can we add a bool inside struct net_device to opt-in
> > for the ndo locking, without having to declare empty
> > ops? I think more drivers could benefit from it that way.  
> 
> Awesome, will drop this patch and add another one with a bool opt-in!
> 
> LMK if you prefer other name or a better comment:
> 
> @@ -2456,6 +2456,12 @@ struct net_device {
>          */
>         bool                    up;
> 
> +       /**
> +        * @request_ops_lock: request the core to run all @netdev_ops and
> +        * @ethtool_ops under the @lock.
> +        */
> +       bool                    request_ops_lock;
> +
>         /**
>          * @lock: netdev-scope lock, protects a small selection of fields.
>          * Should always be taken using netdev_lock() / netdev_unlock() helpers.
> 

Sure, SGTM

