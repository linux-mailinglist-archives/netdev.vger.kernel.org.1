Return-Path: <netdev+bounces-21971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA65765802
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C015E1C215FA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236E17AD0;
	Thu, 27 Jul 2023 15:49:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D44D1FA8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 15:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66301C433C9;
	Thu, 27 Jul 2023 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690472992;
	bh=iai8Dl1aZsshs+BYkCfB+zSQzXKojFXc8NGFY9536+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UR2a0/eGLPKam4rWnuFcFWycmApBEJQ5EKOIks8Xj7MFTa0PmR3B/YsU/iEC68vlY
	 yO/eWxOqPLucS5jbhdrF8O9ED9ZZfrytlvhOj4E+aiU9thnNehCfI60l0AfzuUenfG
	 aImFx7+d9Eegd/JrsyKSANBu/6JLGOCyLfYNGRo1O0wFQn+a8niZ9PPfdG6/QbjFZh
	 44BgpK7YVEYYIHBqtdehGGiaYAbAlBkwJUhe1Ptvi0ATRj15JUAojSorMbfVGDxrpG
	 rGbkEIEIk2LLu6ntEcNz2CyRX/TRkriE/NDpoJ/ManaiTF7zen7eaDQMW5e7uYyeEA
	 Viiz66wEaFTQA==
Date: Thu, 27 Jul 2023 08:49:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 saeedm@nvidia.com, tariqt@nvidia.com, ecree@solarflare.com, andrew@lunn.ch,
 davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
 bhutchings@solarflare.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [net 0/2] rxfh with custom RSS fixes
Message-ID: <20230727084951.1e4d3279@kernel.org>
In-Reply-To: <f565a8d6-e3b8-96d1-a7ac-212c64c60b1c@gmail.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
	<b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
	<20230724150815.494ae294@kernel.org>
	<f565a8d6-e3b8-96d1-a7ac-212c64c60b1c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 09:40:24 +0100 Edward Cree wrote:
> More generally the status of my RSS work is that I've been umming
>  and ahhing about that mutex you didn't like (I still think it's
>  the Right Thing) so I've not made much progress with it.

I had a look at the code again, and I don't think the mutex is a deal
breaker. More of an aesthetic thing, so to speak. If you strongly
prefer to keep the mutex that's fine.

