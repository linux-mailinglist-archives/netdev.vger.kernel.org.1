Return-Path: <netdev+bounces-54484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DDF8073F2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6392281E3B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE13D98C;
	Wed,  6 Dec 2023 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ro/bRRwO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04437182C3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 15:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E993DC433C9;
	Wed,  6 Dec 2023 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701877643;
	bh=MrNgRiYa9MAcWug7NSrquxYR6x57hudTb4cvkZDbmPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ro/bRRwOO+94JLkbJreebvw6kzsLXzH273lFl8owBLz/0qKxATZ0YD8ffzRNas+VV
	 mzNASWXVLIzxByTT9T1mvE/+c+IYox12jtXy8GyTPHBeRvtiwrbDkEMPQ3rKRRLsnO
	 A69ymnBP1Je81RnuIbNfaxQ12msOVQneig9gQmhOqcXGj/oJvSrsFyBWsqh5UbfF/B
	 zNxrJ9FSYlOZDJMT34eu8b9I28y8LCjhUXCNjJ+IraHjpSpcUjT/nLza5IZKBX+EGS
	 M1jVjfQCb7Hz5acbgXGhWqaJTzLAXoyDY8gyanoObj1X6Gl+JRIjz1bqLYsYNWm7k1
	 MeyLDE78g6PcA==
Date: Wed, 6 Dec 2023 07:47:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231206074721.2eb68abc@kernel.org>
In-Reply-To: <20231206-sacrament-cadmium-4cc02374d163@spud>
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
	<20231124192407.7a8eea2c@kernel.org>
	<20231206-sacrament-cadmium-4cc02374d163@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 12:04:33 +0000 Conor Dooley wrote:
> It's taken me longer than I would like to get back to this, sorry.
> I tried pulling the tag today and I think there's been a mistake - the
> tagged commit is the merge commit into net, not the commit adding the
> firmware loader change:
> 
> commit 53775da0b4768cd7e603d7ac1ad706c383c6f61e (tag: firmware_loader-add-upload-error, korg-kuba/firmware_loader)
> Merge: 3a767b482cac a066f906ba39
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Fri Nov 24 18:09:19 2023 -0800
> 
>     Merge branch 'firmware_loader'
> 
> commit a066f906ba396ab00d4af19fc5fad42b2605582a
> Author: Kory Maincent <kory.maincent@bootlin.com>
> Date:   Wed Nov 22 14:52:43 2023 +0100
> 
>     firmware_loader: Expand Firmware upload error codes with firmware invalid error
> 
> I'm going to merge in a066f906ba39 ("firmware_loader: Expand Firmware
> upload error codes with firmware invalid error") so that I don't end
> up with a bunch of netdev stuff in my tree.
> 
> Have I missed something?

You're right, looks like I tagged the wrong thing.
Merging a066f906ba39 will work, sorry!

