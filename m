Return-Path: <netdev+bounces-230616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB6BEBE82
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE4B404E94
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C02D77EA;
	Fri, 17 Oct 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHj+kWXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868132D73B0
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739454; cv=none; b=jUZ8jsoCLoWRwxPKCNQzcT4JA0lxuNQi4pSC0nkk8zL10KlIolZN5k3k3PjDqXoR3cMmeYv8X/X3uxPS+/wIhYmNBS1dmuncvFie2iCpKS4j+7KnQwTgPZGb28COzHfh/1fti6ntA+oGldKkaurRXPGKcByGhEB+li5cuj6a1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739454; c=relaxed/simple;
	bh=xIQglZDH8+lKsOKTP5qV9J3uyEBNRqBua9EweTt03gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWMHOaKLByj/U/R/pLDlsc2AyJ2yM7u++2pTgJYy2PbOZnBFT4dX0j7W5WH221k48uaOgDBwfhR6Fp8+dvx3vAwa+OquVq0Kv4sAMtoQyTD9zbnEsTKKto7GshF9Z8s3r1EYo46F3XI1+/BBXGTOUz/8RTgm/dyTbWWQYComKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHj+kWXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0179C4CEE7;
	Fri, 17 Oct 2025 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760739454;
	bh=xIQglZDH8+lKsOKTP5qV9J3uyEBNRqBua9EweTt03gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LHj+kWXQpBwbjLxfEc1A3jxUJ+i0RKYtXU9/7zm0h3uyFw47Z0gnzQgr4h9MugLBX
	 z8XP6nqaaT6mQdoVUsk/p0Xz91OhhY3XmZOlLGj/GhPFSPjJheNgSoJ2PQhYJiv+ZN
	 DtVSqaLfHF+79VkXwD58qmAVF0QeevqpjW1Lznw+1OxEmo4tkZ2dmHVFqUF2lzYIOH
	 nC5+9Y19Xg2owQw8ISJRHEwAx30meNfWdRhQKNEAzvQ1T0Zio4ESqZTD2tdVBdSiOj
	 sC5zBBVKyCHLAo28GEAnQypQ2oVX9pafyu3cRynLMqMGguT+FexTRxj1x8rhP+Ryes
	 RFstqE8Cx7Szw==
Date: Fri, 17 Oct 2025 15:17:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Jan Vaclav <jvaclav@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/hsr: add interlink to fill_info output
Message-ID: <20251017151733.785c138a@kernel.org>
In-Reply-To: <6f9742f5-8889-449d-8354-572d2f8a711b@suse.de>
References: <20251015101001.25670-2-jvaclav@redhat.com>
	<20251016155731.47569d75@kernel.org>
	<6f9742f5-8889-449d-8354-572d2f8a711b@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 12:17:21 +0200 Fernando Fernandez Mancera wrote:
> On 10/17/25 12:57 AM, Jakub Kicinski wrote:
> > On Wed, 15 Oct 2025 12:10:02 +0200 Jan Vaclav wrote:  
> >> Currently, it is possible to configure the interlink port, but no
> >> way to read it back from userspace.
> >> 
> >> Add it to the output of hsr_fill_info(), so it can be read from
> >> userspace, for example:
> >> 
> >> $ ip -d link show hsr0 12: hsr0: <BROADCAST,MULTICAST> mtu ... ... 
> >> hsr slave1 veth0 slave2 veth1 interlink veth2 ...  
> > 
> > Not entirely cleat at a glance how this driver deals with the slaves
> > or interlink being in a different netns, but I guess that's a pre-
> > existing problem..
> >   
> 
> FTR, I just did a quick round of testing and it handles it correctly. 
> When moving a port to a different netns it notifies NETDEV_UNREGISTER - 
> net/hsr/hsr_main.c handles the notification removing the port from the 
> list. If the port list is empty, removes the hsr link.
> 
> All good or at least as I would expect.

Did you try to make the slave/interlink be in a different namespace
when HSR interface is created? It should be possible with the right
combination of NEWLINK attributes, and that's the config I was
particularly concerned about..

