Return-Path: <netdev+bounces-23193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A256A76B497
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6221C20E85
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07321502;
	Tue,  1 Aug 2023 12:18:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F91F952
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA79C433C8;
	Tue,  1 Aug 2023 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690892301;
	bh=Jb1z9FR5Q1cU/0RxUfTXEmfvwIAJ9/kZTqpOUqYdcBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aipGLyU1Np14E1CLmyuLo9GLhKcshQyQgb+JtkQtOkeLykoMrKcuzYVIi8MU0f+qW
	 vpHO0SoUIM+aWw6QxJI/vNwaAx31jAn4T0EiPhHnulqQiOg1q47EvaJVnMvaPBrSvG
	 mxCciiGTdL9FHy9RrXINH9k3Y5w4HG6M9VzVw4diYQu2w7uEqhf/FdhylDQUKnJytA
	 MQ/DRx6+PkGkfxr/uztdL7wJoEJp0lM1sDy5sjf2+v9WPIE3hT64ssZlfLP42dkYM/
	 IcMLTo7hwtseQa3FTUMOSHcDMC/Tqc6orscoriFwFspkzdogueCKLfX0O16SuHwOc9
	 kSMgrc2Hi2LqQ==
Date: Tue, 1 Aug 2023 14:18:17 +0200
From: Simon Horman <horms@kernel.org>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linyunsheng@huawei.com, hawk@kernel.org,
	ilias.apalodimas@linaro.org, daniel@iogearbox.net, ast@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2 1/2] net: veth: Page pool creation error
 handling for existing pools only
Message-ID: <ZMj4CdJe7m25OlGj@kernel.org>
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801061932.10335-1-liangchen.linux@gmail.com>

On Tue, Aug 01, 2023 at 02:19:31PM +0800, Liang Chen wrote:
> The failure handling procedure destroys page pools for all queues,
> including those that haven't had their page pool created yet. this patch
> introduces necessary adjustments to prevent potential risks and
> inconsistency with the error handling behavior.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

I wonder if this should this have a fixes tag and be targeted at 'net' as a
bugfix?

