Return-Path: <netdev+bounces-78408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14B874F67
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 13:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8814D283C3A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7A12BF26;
	Thu,  7 Mar 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z19VvAoE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0793412BF12
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815707; cv=none; b=fkdgUHonUlv8Tp9ycC/TddA8Ezqj3TKbsm8IFAbeY487khhQz9JzSUVkDJs8Tf+vXl3jdnCa3ddber9mlV4G6Vk2jWE9pqYHfjMlY54n3plVwK3t6pijV/DWoPJ+NhrAaEASsPit67vLB5Xk0LdsNJy53JFwPiwQST4wQGx+Yuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815707; c=relaxed/simple;
	bh=kCnpMXVtWWR7YkCW1NXcN7rFmS3SMgCGRZ4QWNeAxT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzewjIsWKlIIbmnYWg391szk2isssr4VYNcK3QvKNyEGYEwX9dhYLEbMnynz9oWfA6p00/Rlsb3TXK0fTSG6KCDmJmXP7TWA0+D0u7eDYM3dWqqkVh5pce/8yCSGFTUN8a0uI7SeuK8V6LHUld7SBuXRu0wZMDSo11hd+1/4krA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z19VvAoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E0EC433C7;
	Thu,  7 Mar 2024 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815705;
	bh=kCnpMXVtWWR7YkCW1NXcN7rFmS3SMgCGRZ4QWNeAxT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z19VvAoEoB22QjzpbeRKBUjwsJ6rqhEn485Au/XXzbFGJz0M5Up1OMUnufebwv996
	 NAi5oL3Rb7yCsucGoyw0cXnNzG6XtPyniZWBRya7tNuXzmBBtketCJ3dclQ3pjFZED
	 qX+iqRBCor0ms4RaL7pImuWYsR6dTFhbfZVCTBPxpUpScKRf+X5vV5123MCTAgFFIu
	 AB9k8yp+QrSSxD1JaB/6ppPJVri9KCe1l7cO/bMtfFCmRtv9RpmBKbEfb4by7MVo09
	 3R4RHCr+74YJ/ULFx7HNbiTpRVm7Too3EngUBy7tHfzm8lRnk1fehxH48+7Df1tlLe
	 EjVw8PxZnFX2Q==
Message-ID: <286349b6-bcc9-4382-a4d0-29170cea1017@kernel.org>
Date: Thu, 7 Mar 2024 14:48:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 04/10] net: ti: icssg-prueth: Add
 SR1.0-specific configuration bits
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
 <20240305114045.388893-5-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240305114045.388893-5-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/03/2024 13:40, Diogo Ivo wrote:
> Define the firmware configuration structure and commands needed to
> communicate with SR1.0 firmware, as well as SR1.0 buffer information
> where it differs from SR2.0.
> 
> Based on the work of Roger Quadros, Murali Karicheri and
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

