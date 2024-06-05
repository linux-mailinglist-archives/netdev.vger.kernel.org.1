Return-Path: <netdev+bounces-101159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC58FD85B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F062873B3
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA8F15FA78;
	Wed,  5 Jun 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhE/tMOy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933D15F321
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622574; cv=none; b=eQMbYsazwKn9uRrDLvCr1tvmfnrjQzNv3Q5oEnKHzhVnzN3U/t6btyEnRfkz7HzdKjLKYVZlocRn4jFB4/htq98Nf9dn+tFJWzS0ZdKMG7zmqb5xode8aQkJbjb4xpdX6500Y+6NcdeXL2U4tlE6QvIS9OfJWV5/qYujNJ1QjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622574; c=relaxed/simple;
	bh=MUpamB4qWjNAd5x4v79TjtqOfZYdrDfDfna2FhBboAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGEBoTuaM6+NzkodLxjZbEUatciO5cj4O03me4KcEeTV1WuWyYUpnpVAFw9VfQXBO7o2VI86NUPMbspcgGqkvoH3t9IzfWQF4ZJiYmatoeWbILuzHuTGX1XkT78emec2ASQz5auJNg2xAluGSikNRV4wRJE1tFF2Fr7Xo48ih7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhE/tMOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A21BC2BD11;
	Wed,  5 Jun 2024 21:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717622573;
	bh=MUpamB4qWjNAd5x4v79TjtqOfZYdrDfDfna2FhBboAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PhE/tMOyhv2Jg1vp7mdabMLgFP/afx7nuk4tBM/KCm45CfDFkqghqlPt5ylgD5qHi
	 eaakqMLTDotI6/sR/KLCFCMWAH+cxsnYP5tEKGXsgKvb8zLkDfLmnLpuBnwix19qAH
	 D/bjXB7BsyfQ6p/nQRr45BmGmm4bdUDs99URXlzQamMjru9MVGK8E5kanTDkxUtcXi
	 HZxK2gOySTpCbVwc5FLjsu72YzsVxLOj5BegJGK1wPImWom7HJod67vl3/Ljy+44z5
	 q4ZD+GppWSyvcs52eCwXSZbFR8UshOClhZeI4bPNGiXRMEVOZqRdojOK+BXNvQ7Lcm
	 cn7zsG7QreTPw==
Date: Wed, 5 Jun 2024 14:22:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: namespaced vsock
Message-ID: <20240605142252.466c3af4@kernel.org>
In-Reply-To: <myowlo6xpjrhbawt6sptwcqktm34zbfnsxzyo5eahcbspitwzq@ypssm5pe6q7m>
References: <20240605075744.149fbf05@kernel.org>
	<myowlo6xpjrhbawt6sptwcqktm34zbfnsxzyo5eahcbspitwzq@ypssm5pe6q7m>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 18:00:25 +0200 Stefano Garzarella wrote:
> On Wed, Jun 05, 2024 at 07:57:44AM GMT, Jakub Kicinski wrote:
>> I found you patches from 2020 adding netns support to vsock.
>> I got an internal ping from someone trying to run VMMs inside
>> containers. Any plans on pushing that work forward? Is there
>> a reason you stopped, or just EBUSY?
> 
> IIRC nothing too difficult to solve, but as you guessed more EBUSY ;-)
> 
> Maybe the more laborious one is somehow exporting a netdev interface 
> into the guest to assign the device to a netns. But I hadn't tried to 
> see if that was feasible yet. I have some notes here:
> https://gitlab.com/vsock/vsock/-/issues/2
> 
> I've been planning to take it up several times but haven't found time 
> for now, if there's anyone interested I'm happy to share information and 
> help with review and feedback. Otherwise I try to allocate some time, 
> but I can't promise anything in the short term.

Makes sense, thanks for the info!

> Do you have time or anyone interested in continuing the work?

Depending on the priority compared to other work, as usual :(

There was a small chance you'd say "I'm planning to do it next month"
and I wouldn't have to worry at all, so I thought I'd ask ;)

