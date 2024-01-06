Return-Path: <netdev+bounces-62169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE682607F
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 17:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022C21F21DC9
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A627846F;
	Sat,  6 Jan 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGz0hoVi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129179C0
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 16:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C982C433C7;
	Sat,  6 Jan 2024 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704557296;
	bh=LJGY83bemsW4LVQAe/5yyv1HZA/hfLQXEaHL8ph/Eu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bGz0hoVivJKQ6DsyvRmNCYka9EsUkvIm5EOlq1Y/qRCzjpFc0U19Am9+4COb2kZ4Y
	 Jf7OklMwlgslFCTzU/GgVHXscZQwQo98+8OB/QUDTj7Ym4epa5T1mF8AwZA03LOlV+
	 xyYf7LkTIaT20PDw7JNURdu4FCoKL3BRu72jJIvs2ClliMgg4nCA14nYK2MLn9+KdY
	 uoYeSznocm2TzonmloX2UO1I/309V4STYml4Waqzs2kLOZ23Q61MnjtTs68DC1/oCu
	 6dP+H81Wzdjkyapjr4ugApqyn3qDP2LsaBBjgdKkT5IRUOCOwhjZ/LxMprnv4PdPrg
	 +mFWqhAk0O1Bg==
Message-ID: <c62f656c-9c9e-405e-ba5d-739789b4e9d5@kernel.org>
Date: Sat, 6 Jan 2024 09:08:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] fib: rules: remove repeated assignment in
 fib_nl2rule
Content-Language: en-US
To: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240105065634.529045-1-shaozhengchao@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240105065634.529045-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/24 11:56 PM, Zhengchao Shao wrote:
> In fib_nl2rule(), 'err' variable has been set to -EINVAL during
> declaration, and no need to set the 'err' variable to -EINVAL again.
> So, remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/core/fib_rules.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



