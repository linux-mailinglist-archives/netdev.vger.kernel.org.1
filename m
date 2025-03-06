Return-Path: <netdev+bounces-172570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685BA556C0
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C2C17708C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A7211712;
	Thu,  6 Mar 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2GAwopM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332AC78F45
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289574; cv=none; b=h/NfRj+QElE8Jh+49yvWRjk4V0vPZI2NAlj/Gw0FxDx0VXtmTnnN3FGcy9eqiKapjnfKaCLmyRlbqyRrVx599wZimKRCJrqZ8sxm1/1eChBCsjS99Be5FCyaL1CJzCCcA4u1zOKwEpuh0xVUXH01rBV/eFkqJlPBeARUnJC7fTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289574; c=relaxed/simple;
	bh=PSKti5y2X8x6NuSIIvuOVcGXol0OdrghrjXzV+l6iJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvLouDv0w4k2oHLL8Rmr/8dumTYLtNaQWuvjchd5A4w6kXeysOOmRASlAhHCACnkHX7RFhi0XLlQIsbtk5vH/eFAQtx6gIjmN5+65FVfDqvwcAbXYSIARBD1etrlhWKbrbLYKlfS+C/nl/IhXDWrF0Z/YXrCTenAHwGA23e1GCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2GAwopM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2136C4CEE4;
	Thu,  6 Mar 2025 19:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741289573;
	bh=PSKti5y2X8x6NuSIIvuOVcGXol0OdrghrjXzV+l6iJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2GAwopMzhKFyXpO5zRmEgbZbkxeaHlNB/PtcdG49CJdDQ8JY2aqOOxRmR6G6pcKQ
	 JS+Lc7gRGZw4SWpwBfe/HTFr2gVmWyDcpB33hvZ9wShwF7zZb6Cb7hFJG8m7z5sFHN
	 0mrltTXaWpIEFULIaik8O8fbPnVi4Asye9D1oH2eXV2fLZYgoqCdc/wQOUBt7kaYZK
	 Bt94/7+/CJa0jqGLJwc3PSVdOikHBLROJMmJ4zf2Upjc3qZsM6RiwET9d/5kk7OPxa
	 JWsZZmsKUcygpCNkOqruU5rww2IcvHtTRhRFQW8W5VsO7QwKOSbjl6a8HEfJiejSd3
	 Axe/gYpuLPIOQ==
Date: Thu, 6 Mar 2025 11:32:52 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <Z8n4ZNtnHgF1GB8Z@x130>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250305183016.413bda40@kernel.org>

On 05 Mar 18:30, Jakub Kicinski wrote:
>On Wed, 5 Mar 2025 20:55:15 +0200 Tariq Toukan wrote:
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>
>Too late, take it via your tree, please.
>You need to respond within 24h or take the patches.
>

I thought it was 48h.. I remember the rule since David Miller's era.
Maintainers should provide feedback within 48hrs of posting.

I agree with the policy but 24hr is really pushing it..


