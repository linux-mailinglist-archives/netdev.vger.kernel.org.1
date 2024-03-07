Return-Path: <netdev+bounces-78411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 613D2874FC3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE3CB223F9
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6312B16F;
	Thu,  7 Mar 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuDRSWLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBD129A98
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817319; cv=none; b=nXPMe8Y9ND0nL0D41543WKk9e0BgPVwJmAVjExLa8lImRaFpOSa1tr1seUeqLEP7oNZzPbvwV6IdsjC8ZCppCt7XdVDJJrW+8b/6EDmI8fN9FFYLqZ7UpKkDDjL7LF/FuSMUjE9c9PEOobiv7iczOo1PMMEj5SKgnW04AXG5jVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817319; c=relaxed/simple;
	bh=7kHiuEZYKhCXD6CRLGYZ0sqN70oD17gM4KItIUzyspU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8rqeAHYz871aSgCLyb7pzIVFnL1Wh3fVhzMrxAW052cRiYlzdASFHysh4ALl9pnqUOTGJg04UF1YqFi8r5cDRfYBN45lw6rHC/4KVob3cSM8SAu7X5bYTN5SVVH+A7Dsi07q1Zg2REGnm4eYOgth+dApvAJpFvAo+2vbPyK0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuDRSWLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A100C433F1;
	Thu,  7 Mar 2024 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709817318;
	bh=7kHiuEZYKhCXD6CRLGYZ0sqN70oD17gM4KItIUzyspU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EuDRSWLk6b5eBPN7YIAw9GjOYAijoBNibaW9ALDsnzOje2bCFM/ywt402OoI0cNrq
	 NEBpu+5e5uSsn2GYI2bGZm2FbbibjZh24VdrJfSEsSUAC7u7etoLqdxgLboUzbSuov
	 hO9VAGf0LjHD+J1uM5vku0TgW4LMlTSypGsIhe8FgYtJYI+3OF8veTEiAWvfnSxEQy
	 cGRqlgL2racq0SLwHVQ5CyCRBTyHBRA/PrrZ/SaV5hBus0n1/3NK/pm1Y226+UJTtL
	 fyRq5bneP1hV+Sk4TZVmXJ0FvK7gZnonguYTGMPd1Puul9liLNK75JGMI/QsNDI7sU
	 VvHm7ZUy3V/WQ==
Message-ID: <38c3a946-1f9e-493a-b68c-725b718b6971@kernel.org>
Date: Thu, 7 Mar 2024 15:15:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 09/10] net: ti: icssg-prueth: Modify common
 functions for SR1.0
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
 <20240305114045.388893-10-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240305114045.388893-10-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/03/2024 13:40, Diogo Ivo wrote:
> Some parts of the logic differ only slightly between Silicon Revisions.
> In these cases add the bits that differ to a common function that
> executes those bits conditionally based on the Silicon Revision.
> 
> Based on the work of Roger Quadros, Vignesh Raghavendra and
> Grygorii Strashko in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

