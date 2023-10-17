Return-Path: <netdev+bounces-41805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9977CBECD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944CDB21007
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9693F4CE;
	Tue, 17 Oct 2023 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsU6RJai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B9838FB3;
	Tue, 17 Oct 2023 09:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02222C433C8;
	Tue, 17 Oct 2023 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697534298;
	bh=qpijEw30yO3I2i4Uh+AxUics0aVeq+2voohpeVVfsx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsU6RJai9l9r7EFx/ChKj/t66QnpD+1dy54G4HcVFW82W+w/XQz6Wxid4JblCIvn6
	 W8PdyT2DOmlVHTCnx6+irc9SIUuVn5MD08vbq9FspQXJQ6zy4qZiDieAYNQTpjQL/y
	 W1J6d3JGLUqmR+hwojyvnlZY5a0lrpILlr+st0jet7OCi8XU5FEuEI48Jedw5vXYOg
	 enRIxZPxktpgBGJgZTTY3a7wdwDo7wXs9uD1j3x6/hsexQ4TPmpACkWaVQ5/8/Av1P
	 PPV67ivkYVaitTao93HKq1EbE8f+twnBKBtNQ6WctaJNQDJ7dxBJxnLMHOrwAe1FG0
	 RZWNSBQVBYkGw==
Date: Tue, 17 Oct 2023 11:18:14 +0200
From: Simon Horman <horms@kernel.org>
To: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc: Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <20231017091814.GS1751252@kernel.org>
References: <20231015133558.GA5489@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015133558.GA5489@ubuntu>

On Sun, Oct 15, 2023 at 06:35:58AM -0700, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> CHECK: Prefer using the BIT macro
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>

Hi Nandha,

I am assuming that checkpatch clean ups are acceptable, perhaps
even desired, in staging. So this patch seems appropriate to me.

I do, however, see a lot more potential uses of BIT() in qlge.h.
Could you take a second look?

...

