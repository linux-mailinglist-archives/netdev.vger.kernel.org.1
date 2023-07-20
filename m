Return-Path: <netdev+bounces-19664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67BC75B9B2
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17768281F92
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8931BE8E;
	Thu, 20 Jul 2023 21:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864D1BE88
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F57DC433C8;
	Thu, 20 Jul 2023 21:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689889368;
	bh=++9KJC+95Badpi6e4Z9Qi6JrsvpaaCgM0iDxU+I098I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVmzzdHX1ozGOZytAVhUTJfYl3Buw8THkakySyOsv4RCOGIB5ibhd3iuOD4pJPMFZ
	 vapReJq02teqjwMVyVfNlZQ3fPRsz9b0BAMT0zSYQBs4bNVMdG14tQ37AsD2umLWbY
	 8gNDeFd6abktON2QerTzT/07eQnGb4TUtfmOxUpPdHPLiUXsD1mOOYIU+ibR9JRQMe
	 BhzdDegv2D9xpJRL0NIH2g/SdRRZksFW78Ibr8H+M5IghsnieyhtcSQLtTW6NBgXKT
	 pa0VOJlFlqY5o4m4VbOfZY0VlXISo5YQ2nTzExS6A0gFL+bMZ9PCfWQbCWJoFQC6x7
	 YYekiguikaBuw==
Date: Thu, 20 Jul 2023 14:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: corbet@lwn.net, Andrew Lunn <andrew@lunn.ch>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mark
 Brown <broonie@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux@leemhuis.info,
 kvalo@kernel.org, benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of
 small time maintainers
Message-ID: <20230720144246.7e3507d1@kernel.org>
In-Reply-To: <50164116-9d12-698d-f552-96b52c718749@gmail.com>
References: <20230719183225.1827100-1-kuba@kernel.org>
	<50164116-9d12-698d-f552-96b52c718749@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 19:23:56 +0100 Edward Cree wrote:
> Does this apply even to "checkpatch cleanup patch spam", where other patches
>  sprayed from the same source (perhaps against other drivers) have already
>  been nacked as worthless churn? 

For networking you can check patchwork, if it's already marked
as rejected or such - there's no need to respond.

> I've generally been assuming I can ignore those, do I need to make
> sure to explicitly respond with typically a repeat of what's already
> been said elsewhere?

Repeating the same thing over and over is sadly a part of being
a maintainer, tho.

