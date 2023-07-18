Return-Path: <netdev+bounces-18656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6575838F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B51A281396
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D224156CC;
	Tue, 18 Jul 2023 17:34:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7F134BD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D933C433C8;
	Tue, 18 Jul 2023 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689701692;
	bh=gRqK4YQ9SwmOtiWj1frwDfFvpy6S6QoNvpMI5EL4rP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKdno7EYrnRrGF6BIgpk6wjGWU5SJFWTnoWdbXbJqtegpdQhERHFWu/+CmJ6V31I6
	 ZTFvr4dy4oZ8UQjpG4TANXYe+0M6fyGPQeYsaKTnErBBelTlVsLIzGyANsRY/a8Y5c
	 V4ng2bwJrRBuehzaCh/I2Lzvwkdy26E2cC1A/hBk=
Date: Tue, 18 Jul 2023 19:34:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@leemhuis.info, broonie@kernel.org, krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <2023071832-headstone-chafe-5be9@gregkh>
References: <20230718155814.1674087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>

On Tue, Jul 18, 2023 at 08:58:14AM -0700, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Looks good to me, thanks for writing this up:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

