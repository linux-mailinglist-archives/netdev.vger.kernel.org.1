Return-Path: <netdev+bounces-123694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C649662F4
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E686281462
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8440C199FA4;
	Fri, 30 Aug 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh0HTR+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6426ACB;
	Fri, 30 Aug 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024660; cv=none; b=dcML4JrLdv3TgpML02ClQpjv/jXAMiPWfC2MKtJmst2UGSCqV2/5e7/tB4/g3hE3ltZlNQQW5IG5608Z3ioojC5mrF56qwRllvEghRCUiD8ylZe428MlMR6nLJtkP1Zb2dApMGUg4F6jyiil4XW7SGoJau0C5z8l8/HwGCvAhB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024660; c=relaxed/simple;
	bh=oJucHVRWjx7mdVqEAGQglD/Sr3s9T6GGaCFWYrvJ6Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OudvilJt/7LZHf4M7CDCLnn8CyaxaGMIWlj650Gxac8RvZK9imNWHMhK8G2YB5pCkJUbhsG6QvBC1ubabtkR7yfffNAZOX8YIseNkBwYBUJavcAJUZq3C/SlLOYL1Q4xBLn4j6DW9B/WA3vknjxhKGuZUjVvelc23x5euuZ0nKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh0HTR+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A82C4CEC2;
	Fri, 30 Aug 2024 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024659;
	bh=oJucHVRWjx7mdVqEAGQglD/Sr3s9T6GGaCFWYrvJ6Tk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mh0HTR+6NVBnUEHiXQz8C3CXNPN0bbtSAZjUrndQz1am+bUFG6uCo0wKSHFfzAcK+
	 PNc/NtF0NTMAAtkkjoYbOW13SnZaFwqgXgs/CqRgQ68VadfMKMGBBFceSzRzruYseh
	 hclfhxxwI4O2uT2X9UYGU0reFOR0ULRfA6q/OoLHIv+czLI4aMbPKverLwh2dZut90
	 9uA2Be/8X9PRdVGAmgGrp0sy/mov0MShbOzYv+78eq28UxSPUmPbNF8N1VvM0iLGLv
	 R234z+l5dl+/IeGN2ot2r+/jLT+idU+DoUk78EK+sHCuzLL88mb9qEls/mdllj3mKL
	 esb4vg4c0IteQ==
Message-ID: <77c34234-f7cd-41ce-be0a-9750c2d6066a@kernel.org>
Date: Fri, 30 Aug 2024 16:30:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: ti: icssg-prueth: Add multicast
 filtering support in HSR mode
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-6-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240828091901.3120935-6-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/08/2024 12:19, MD Danish Anwar wrote:
> Add support for multicast filtering in HSR mode
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

