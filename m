Return-Path: <netdev+bounces-40461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4EE7C7723
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C890928144B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CACC3B2AB;
	Thu, 12 Oct 2023 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZocO850"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABE28E16;
	Thu, 12 Oct 2023 19:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDC0C433C8;
	Thu, 12 Oct 2023 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697139968;
	bh=Hb8YWFSOkX0NCFe664tfyCaUwbxDGI6uksbPYrW075k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZocO850l59r8X57kjE5ZHEhxS1ourUskkUlbF9XsHMaxFYfv7tk1JfGUIilQ95Fm
	 OhT1xN/ZJw+n7cLMGtmRZ7BZynxXKq1JSfN26i+yT3m1yAxRtbCZ/E7aHhpuxNh1+O
	 iZr9TxNVSICEyrmyiII3/f34h+0qIM72vwFfOaKClFKF0BR6hfWLCEmY2YGXDe4rDm
	 46t5P4lPwm75/s1ZQLQsxzNerThKAs0wWIFCEBlIVREWghjP6K9H6MbtSbWrU0JFEO
	 TvK6dJgsOTMm/VBvksJJ8x6WBFNuAEzY0X0GQ55+axRVirzOFdYJQ7X7cxha/5ZOfm
	 TWBAkonvsJMjQ==
Date: Thu, 12 Oct 2023 12:46:07 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: simplify mlx5_set_driver_version string
 assignments
Message-ID: <ZShM/7mNuBhFTqrm@x130>
References: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-v1-1-90fa39998bb2@google.com>
 <202310111433.9BCCADED@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202310111433.9BCCADED@keescook>

On 11 Oct 14:34, Kees Cook wrote:
>On Wed, Oct 11, 2023 at 09:29:57PM +0000, Justin Stitt wrote:
>> In total, just assigning this version string takes:
>> (1) strncpy()'s
>> (5) strlen()'s
>> (3) strncat()'s
>> (1) snprintf()'s
>> (4) max_t()'s
>>
>> Moreover, `strncpy` is deprecated [1] and `strncat` really shouldn't be
>> used either [2]. With this in mind, let's simply use a single
>> `snprintf`.
>
>Yes, please! readability++
>
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://elixir.bootlin.com/linux/v6.6-rc5/source/include/linux/fortify-string.h#L448 [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Cc: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
>Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to net-next-mlx5.


