Return-Path: <netdev+bounces-167942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19651A3CEF9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EDC3A5839
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C53597B;
	Thu, 20 Feb 2025 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6xjXoLU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295B2862B7
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017214; cv=none; b=QLKo56HH9HnZUzdE31kSkd9dbJkHPu8+ix6xppneSNResv+ifuI7kG16lBJpyv9xuvhKwuFWdixjpiLQAKiugB3T//EVtG6QWIqG985RaeCKZKQ5967K6Zu8w+vtBb3sXi/ZhsB/FC3vdT4ATffcK7r7YY7YIemI2p09sVtkLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017214; c=relaxed/simple;
	bh=EgBVo6RhWMthFB+iS+hJogXI/CaL4DpuWPIXar+k6Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIaPpnPNidBiGZWiw70fikzbpM49UaUMmPpgTU3CUxXBbFa7NzwnUh9Lrqyu1X9LNgL2ohwtX/pUIIyVZ88sv0HxAFtK4L/GJvDxW5baCqM7bamzZYyMD6QSx1FgxIhTZIUzjLGv7x0qffuTNXqHsdB0mn7nv1FhzkAL5Rmz6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6xjXoLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A9FC4CED1;
	Thu, 20 Feb 2025 02:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740017212;
	bh=EgBVo6RhWMthFB+iS+hJogXI/CaL4DpuWPIXar+k6Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S6xjXoLUpWXK7RxE098FTqZiEyWwABqwy11BtNe8AGQdbyk2/FyMLvNunXJd7S4Ev
	 rz7DC1Ia8/Umaj4uHJbBwQzhZS36a5dCynw2stcQkIFhkreFaga++/GAklJXyP5vJH
	 +k5mhM3xuZ4UBBlqfnw1FUjrfXBN9y7/NbQqpV+D/uqZhoJ28UDduAlVb0uwgEoB1c
	 U/Ix4qc42O1VwHcvXvgCHKBbvdRYKGGQW1oqutMbPdNeN8kg0A0jpYPHqqcBPXzaBl
	 otryvF/MmGmz+Lc4l0mOP3wCixc83GAT0F1r74Lx/pJXgwDjO+I73p8MyZRpWBI46m
	 ZK6ErJLlZSj+A==
Date: Wed, 19 Feb 2025 18:06:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Joe Damato <jdamato@fastly.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Gerhard Engleder <gerhard@engleder-embedded.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
Message-ID: <20250219180651.0ea6f33d@kernel.org>
In-Reply-To: <878qq22xk3.fsf@kurt.kurt.home>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
	<Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>
	<878qq22xk3.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 08:39:08 +0100 Kurt Kanzenbach wrote:
> > My comment from the previous series still stands, which simply that
> > I have no idea if the maintainers will accept changes using this API
> > or prefer to wait until Stanislav's work [1] is completed to remove
> > the RTNL requirement from this API altogether.  
> 
> I'd rather consider patch #2 a bugfix to restore the busy polling with
> XDP/ZC. After commit 5ef44b3cb43b ("xsk: Bring back busy polling
> support") it is a requirement to implement this API.
> 
> The maintainers didn't speak up on v1, so i went along and sent v2.
> 
> @Jakub: What's your preference? Would you accept this series or rather
> like to wait for Stanislav's work to be finished?

No strong preference. If rtnl_lock is not causing any issues 
in this driver, the we can merge as is. I haven't followed 
the past discussions, tho.

