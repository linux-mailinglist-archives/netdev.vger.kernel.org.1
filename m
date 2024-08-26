Return-Path: <netdev+bounces-122045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B995FA8D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C44282517
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75B19925B;
	Mon, 26 Aug 2024 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjpD7Gma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF9194AEF;
	Mon, 26 Aug 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703806; cv=none; b=YrQyse1yDuzAR9o9B54IB4R1ZSWK6DV7bQ0Oh0lHr+FIWivcEpAhYxUldlKYXn2Tvm5C39hGL8mMYL05SMaO8Cc2W1iNrlnywbelXBrxeSDPQlPJ6zQPV1ZSLXxsvglwg2YrKX26E5ARfik32s7tSWJXCanGBXwSxUnWyj764W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703806; c=relaxed/simple;
	bh=L3bK6BpLXd46wksh02/AMkGz4G9cO87HEzLfASgUxZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuGxwxweO62ibzlKqXmUTN51ScAraeDfxAydarDsRSL0byM8zp0NGRhbP3dkwSb7ZcX+/woCtWEMYCiTHA5SPTmM8ovD0bN74xFNaxpD3ZHQKK4X74bJGBqvjs9olA0Mo9o2WMSgCMcfFCuCy5VgdVpqdMQ20VDSLwC+2vZ0ZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjpD7Gma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD25CC8B7B7;
	Mon, 26 Aug 2024 20:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724703805;
	bh=L3bK6BpLXd46wksh02/AMkGz4G9cO87HEzLfASgUxZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bjpD7GmadzAfml40vB6FOmHLSX6y6Yjs0VSY5XlxwcrfFrRN0/dKu0NlZjIm02057
	 mGOasYjHBDALSRgucyhLj0aLKCGXJyveZs01JFW5M5v+IeOLA9GL43RMMT3V/gduHn
	 n9H2+R+thzJw/Bt/Kla8Masy+UZ/6sGWgIoQZFRndDUIlQIDeBuAEvX02+5YIJVrGd
	 yPpPtJ6LbXMHCHA1jgh2yuNQQ5rOvzdXjrEjIy4W1VZVRH5QEIADFAPjpe4iCForDX
	 RuTIhl3IjA0da0Mkz6Ckl2Xe6axJFXFLdg+MdmuIRlFoElmMFZMyHxcpX7Sb+0Xdhy
	 5jS091F7oTOcg==
Date: Mon, 26 Aug 2024 13:23:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra
 <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] qlcnic: make read-only const array key static
Message-ID: <20240826132324.14572112@kernel.org>
In-Reply-To: <20240822211028.643682-1-colin.i.king@gmail.com>
References: <20240822211028.643682-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 22:10:28 +0100 Colin Ian King wrote:
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> index bcef8ab715bf..5a91e9f9c408 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
> @@ -2045,9 +2045,11 @@ int qlcnic_83xx_config_rss(struct qlcnic_adapter *adapter, int enable)
>  	int err;
>  	u32 word;
>  	struct qlcnic_cmd_args cmd;
> -	const u64 key[] = { 0xbeac01fa6a42b73bULL, 0x8030f20c77cb2da3ULL,
> -			    0xae7b30b4d0ca2bcbULL, 0x43a38fb04167253dULL,
> -			    0x255b0ec26d5a56daULL };
> +	static const u64 key[] = {
> +		0xbeac01fa6a42b73bULL, 0x8030f20c77cb2da3ULL,
> +		0xae7b30b4d0ca2bcbULL, 0x43a38fb04167253dULL,
> +		0x255b0ec26d5a56daULL
> +	};

Move it up, please, reverse xmas tree
-- 
pw-bot: cr

