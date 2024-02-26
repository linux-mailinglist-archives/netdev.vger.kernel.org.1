Return-Path: <netdev+bounces-75030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3E867C71
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C926B29465F
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5612CD83;
	Mon, 26 Feb 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfwS3AVG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47560DC6;
	Mon, 26 Feb 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966109; cv=none; b=SRDOofeVwi/Fz2eohYGWXi9T/mHOnZ/yIX/pm854ar8jezgGZo07miqcnAzNqZcPzY9SYc/gpwCFdlxm5NqvsGo5vVQ4RuRllHii7rPL2lefUmL5Yj5lAWHct4XEEyMHtL+IkaKPy2OPoMsbobkTEVU/2Am7a4eCIzBZejggdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966109; c=relaxed/simple;
	bh=TBcPD0LiF4Ta/LAWQUOaW1Bzs0XKAIO3UtxBPZmhSCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP7W+z3jto40JdrsdvECjBs6LTpC64yvx7KB6IBBQgGcd+6BTu4dfiIQVOZEJpFH8Xp4Ws2SaplN2M9AAbOZpA917bNKeXh1DwLDXhsR9QGa4GiJ4sNcocGkNrT0Lm+6O0rp5YvyM0oeLii26QPwQvQ9RvZNRGenZeDPGeS8JDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfwS3AVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5ECC433C7;
	Mon, 26 Feb 2024 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966109;
	bh=TBcPD0LiF4Ta/LAWQUOaW1Bzs0XKAIO3UtxBPZmhSCE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cfwS3AVGyDk9cwQGgcUr5wo93F5HwFmgSTtUjh5LvJLwOA2olSE4sKBqb4Xt4FL53
	 ddb7+Pgz2pWhl0SlqWEE+hDP7zG/D9Hb0CW/5gafRvNk7arKgJ05azCC7hqNp0tWEX
	 wxR/caxRt4KBSXTuyFL6aT3bRkoOdKma0vx2eRTaloWxfGiQ6luyfXn6GpAo0xnowF
	 gazK6bBNB0xIIoWLTZ3g2yUBIZcGAGauqCbM/k90sqtYuy9IXu8gV89XKRfmUQbT/4
	 fRQPIil8JoqBc3pyLsIrLPwrwEB2Av+Uj8xUILIPpUz1G97w2q0mREM3SdM+aOh9LM
	 cBvLspv5OnJgA==
Message-ID: <7b03fe64-abe0-4a3c-9a23-1dbed465ed37@kernel.org>
Date: Mon, 26 Feb 2024 18:48:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/10] dt-bindings: net: Add support for AM65x
 SR1.0 in ICSSG
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-2-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240221152421.112324-2-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/02/2024 17:24, Diogo Ivo wrote:
> Silicon Revision 1.0 of the AM65x came with a slightly different ICSSG
> support: Only 2 PRUs per slice are available and instead 2 additional
> DMA channels are used for management purposes. We have no restrictions
> on specified PRUs, but the DMA channels need to be adjusted.
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

