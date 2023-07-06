Return-Path: <netdev+bounces-15831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BE74A14C
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23011C20D94
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC982AD22;
	Thu,  6 Jul 2023 15:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B15A938
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 15:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB303C433C8;
	Thu,  6 Jul 2023 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688658168;
	bh=FqOJ2TD54Li3G9w2UTQoqecRlMKueXh/ogXPRa7YAh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=flQPC0xgvIGnYPDtd/oG3g2C0Y0TnYg9Urf8BXkX7UDs0LYaGuNZvZndAzM/6lVuR
	 uSptrss24MI95M+xGHqfYyJpmt03ipn5HmP+UHfmc+EFesUzb+M0qfTBKy07c0JKhO
	 z5O0fBR7RnI6hx6edU0bTkV9SzWExqoGGmIZmoS9EYqJSRsZC/8PUIL2t1hxe0lZ54
	 Q94Dry59DbaBvf/sd3uVeRIydPcydcldkC7Mk3xd4Rg4QaL2WYU9NxcyTNOu5eQuNx
	 IInBJ74r7zBH6ZpukirqV/0e1FnIV0eH5UEIFHvCmuOu9V2Ow0AT+t/trMuyRiJ8Md
	 b8wtPtJJNdTkA==
Date: Thu, 6 Jul 2023 08:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Sandipan Patra <spatra@nvidia.com>
Subject: Re: [net V2 5/9] net/mlx5: Register a unique thermal zone per
 device
Message-ID: <20230706084246.20704f19@kernel.org>
In-Reply-To: <ZKZaoIw86D1b6EXn@x130>
References: <20230705175757.284614-1-saeed@kernel.org>
	<20230705175757.284614-6-saeed@kernel.org>
	<20230705202026.4afaff91@kernel.org>
	<ZKZaoIw86D1b6EXn@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jul 2023 23:09:36 -0700 Saeed Mahameed wrote:
> >Damn, that's strange. What's the reason you went with thermal zone
> >instead of a hwmon device?  
> 
> hwmon is planned for next release, it will replace the thermal. Internal
> code review is almost done.
> I just wanted to fix this so those who still have old kernel will at least
> enjoy the thermal interface :) ..

I see, makes sense. I thought thermal zone is somehow newer or better
for integrating with fans or who knows what..

