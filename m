Return-Path: <netdev+bounces-62291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91964826724
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 02:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60DFB20D61
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 01:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69E800;
	Mon,  8 Jan 2024 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8YTaR3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD7EA8
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 01:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1FFC433C8;
	Mon,  8 Jan 2024 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704678233;
	bh=NNQVdZBuF6w/FLQJ+lydBGRKuCKt3iCxOclxnwL83iA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=j8YTaR3XOdMqs1hEQ4RJaADtoq0Ds56oFuG715BkNRxFT9yZ9CGJTJQqGRm+QNwce
	 QJ1QwsGTvFqs+6kLQCCFOqboWzLRNAVQPS+5xT0WRdU7PI06k52/KWJ1GiUnSXC4w/
	 EDg09RHEHdFlmbbJdaheNnhB4lIQHnaTzqBZmUW8fukGQzEopUZRD5o+21/WzfdNi1
	 iN5aHLizT5s6NBcRgucOKMR8DxSRLYLfe4wASISqTdHzVg6g1IGhiZTFqm64Np7FfZ
	 dtYMmsdT8mPT5WP5gtDdWkbKBk4MTtUtLSsAtM+QnhKzAIQs1+8BFvCn25EpWcbNHr
	 qRVH9RuHGb8xg==
Message-ID: <1da3f41b-62cd-422e-8afc-5cccfccce2cf@kernel.org>
Date: Sun, 7 Jan 2024 18:43:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ss: add option to suppress queue columns
Content-Language: en-US
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 netdev@vger.kernel.org
References: <20231227134409.12694-1-cgzones@googlemail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231227134409.12694-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/27/23 6:44 AM, Christian Göttsche wrote:
> Add a new option `-Q/--no-queues` to ss(8) to suppress the two standard
> columns Send-Q and Recv-Q.  This helps to keep the output steady for
> monitoring purposes (like listening sockets).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  man/man8/ss.8 |  3 +++
>  misc/ss.c     | 24 +++++++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 

does not apply to iproute2-next.

--
pw-bot: cr


