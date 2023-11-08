Return-Path: <netdev+bounces-46675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7B7E5B49
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 17:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CEF7B20E49
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE43317999;
	Wed,  8 Nov 2023 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmoS/Jdq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234832C6D
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 16:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100ACC433C8;
	Wed,  8 Nov 2023 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699461188;
	bh=DNs+hxUozPcAk22MpXBVQKW/WowOe37ObtLphMi+7jU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BmoS/JdqgqBfq73EQSOLmDSQ3mnV3nP8vFMj5D863u9PFdwWBlx4DTSQcQ6zhPItY
	 9iMFP8A8QLSEjvtHsUMr/w511BXwLP1O4EIIKBg3CMqOfUPmMq8lwiyqIoQIYQySFf
	 yJoNr5KhhSJfuhcSOoFF6ABwXLqle9E5uFgNwQ0hjvUrumKKLgTuIp61rSHI0sorbj
	 4CcCaEALdz9cITn1MKcyQrd11P9lTmMBcY5/S3akbq4lA1xDgCnmt9QaIRBzebfhI7
	 Il9jviH7nbUVvNdsxYVtTb7pWcvza6D3okPfGw9nqAXZIWBX6WwTc93vVT3gmB63Nd
	 ZyUKjzDXJ9fyQ==
Date: Wed, 8 Nov 2023 08:33:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Subject: Re: [ANN] netdev development stats for 6.7
Message-ID: <20231108083307.364cfe91@kernel.org>
In-Reply-To: <ff7104c9-6db9-449f-bcb4-6c857798698f@lunn.ch>
References: <20231101162906.59631ffa@kernel.org>
	<ZUt9n0gwZR0kaKdF@Laptop-X1>
	<ff7104c9-6db9-449f-bcb4-6c857798698f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2023 14:19:31 +0100 Andrew Lunn wrote:
> > I just noticed this stats report from Simon. Thanks for your work and
> > sharing. I want to know if there is a way to bind my personal email
> > with my company so my review could increase my company's score :)  

Thanks for asking, the company association is my least favorite part 
of this work, and you gave me an excuse to rant about it :)

> Jonathan Corbet <corbet@lwn.net> maintains a list of email addresses
> to organisations mapping. Let him know who you work for and the next
> cycle you should count to your company.

Yes, unfortunately I do not have access to that list. The LWN list was
compiled with some assurances of the list not being shared. Jon / Greg
understandably did not want to send me the list and break that promise.

So telling Jon won't help me.

Now, CNCF has a similar setup: https://github.com/cncf/gitdm
and they do share their database. So I use that, plus my local hacky
mapping. Unfortunately the CNCF DB is not very up to date for kernel
folks.

Hangbin, according to CNCF you're at Red Hat, which seems sane, and
that's how I count you :)

Now the rant.

Unfortunately I can't handle creating a company/developer DB myself,
because of GDPR etc. I work for a company which takes personal
information very, very seriously.

I brought creating a public DB up at Linux Foundation TAB meetings,
but after some poking there's no movement.

To add insult to injury, if you watch past the end of the recent
(excellent) talk from Jon - https://lwn.net/Articles/949647/ you will
see Jim Zemlin pop up on the stage after Jon finishes, and you will
hear him tout the great "analytics tools" that Linux Foundation
has been working. I think he's talking about this:
https://insights.lfx.linuxfoundation.org/projects/korg/dashboard

It would be great if Linux Foundation helped the community with the
developer/company DB, which is ACTUALLY USEFUL BEFORE WASTING TIME ON
SOME WEB STUFF THAT DOESN'T WORK FOR THE KERNEL.

This makes me so angry.

