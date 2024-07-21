Return-Path: <netdev+bounces-112315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC293846C
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 13:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C3B1C2084A
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7C54657;
	Sun, 21 Jul 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAjdaxh/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C2EEA9
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721560383; cv=none; b=u4mXlWFm6P0GsDSWE41T4APRjPmotzRWPbtBd/H9xuo5/ojZuSJMBNOVayLpm8Aed4FkC7TEBj1Zsllk0ET7wtM2NO25sluvyfquylBYLT5mm4y5gL4pTusDdPvW4I26Z/3D4nR1DPXAh3oR2JV5MS+yCZGZYAeyQ+TVPazk5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721560383; c=relaxed/simple;
	bh=G6cOPB+KBxo56wsOhn9rAt+ZnxMNBvnJZL52wCV3QKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4INllb2jysUww4QRTXV3gnyzPN+9azsXE3iFKKYW09SMs0I0RsIENxAcA8BXTp4xZoDqJU8278oKhK1v0QhspilalkRuzwhPC49XPWLE5BuhPiVPMoMd1Eyp7IslLnjbw1bsUz1T75JVNeKug9TOoI3ep+ntZ9xpzmJWli3rKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAjdaxh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC208C116B1;
	Sun, 21 Jul 2024 11:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721560383;
	bh=G6cOPB+KBxo56wsOhn9rAt+ZnxMNBvnJZL52wCV3QKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAjdaxh/xvcVurWPVG1c1R5lqSMNjLGKRbfHTiANf1qon1kn3cuN4ntDRWzyDFcye
	 LNKne2MNcyqPnRj7JP0klZPdBXrc3R16vFcv9d+CFPQSSMwSNEp0fcN6iW7nBj/VxC
	 8fmBitXq0IRshQYw3W0wT7sLF0+5zwOfoWjoTRHU68Dg1kgJBL3I5fJbMc8CTDp9m3
	 k0nRcKRFJq/1w3k7W/VeiQWoCX/onSeVInt6EJ43C9KgxhW1qFrSmJPd/OwKUNjhg1
	 474/Ac1ShJ+3JNHOV4uyWrqjfYFz/xb2IRKxVziHLZEMSzEKHdsecC7bDesIBRKuI2
	 w3RPoE0idi/jw==
Date: Sun, 21 Jul 2024 12:12:56 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	lorenzo.bianconi83@gmail.com, dan.carpenter@linaro.org
Subject: Re: [PATCH net] net: airoha: Fix MBI_RX_AGE_SEL_MASK definition
Message-ID: <20240721111256.GE715661@kernel.org>
References: <d27d0465be1bff3369e886e5f10c4d37fefc4934.1721419930.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27d0465be1bff3369e886e5f10c4d37fefc4934.1721419930.git.lorenzo@kernel.org>

On Fri, Jul 19, 2024 at 10:38:31PM +0200, Lorenzo Bianconi wrote:
> Fix copy-paste error in MBI_RX_AGE_SEL_MASK macro definition
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


