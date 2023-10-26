Return-Path: <netdev+bounces-44346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5A7D79C1
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CB3B20F5C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C715B1;
	Thu, 26 Oct 2023 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plv9c2Kg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698717CB
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE37C433C8;
	Thu, 26 Oct 2023 00:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698281065;
	bh=k2UHN6SEYLowHuZLdVQI1WPzArEG1bxZxBClOnJPLzE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Plv9c2Kg60XnUwpi6M/ZPcxruYlfvhGmcXmmDIWjx9z70bPmLJmvW9EaMlo9dpCMV
	 9G7FeO3hULgOzVv5LGmFqV/gNPG9AV69f8XIsG7En5z7LEwRMH1nOHs2o33iCyZbCH
	 riVCmDisLS/RBdJiDc6DJOsxLe6f+wDiFWG93UMgON7MqKob0oKBDYbPygN9QhrrON
	 sF7ONpxGaUlJxUptLptYrYY1U+bTAejmH/MndtQG+6L6n9q26+vLrePO5L4KhW9Het
	 3d0Z1wKqs64RcSWMQDR3JaEZOLB1ynYCa3dLNNuSXfUnqE7oebBcg6D+/lnstBW/qR
	 Rz1XlFdEDooag==
Message-ID: <baee0cc3-55d0-4d4a-bbd6-17506fd31e24@kernel.org>
Date: Wed, 25 Oct 2023 18:44:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] Documentation: networking: explain what
 happens if temp_prefered_lft is too small or too large
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 jbohac@suse.cz, benoit.boissinot@ens-lyon.org, davem@davemloft.net,
 hideaki.yoshifuji@miraclelinux.com, pabeni@redhat.com, kuba@kernel.org
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
 <20231024212312.299370-5-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231024212312.299370-5-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/23 3:23 PM, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



