Return-Path: <netdev+bounces-149957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46CB9E832A
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61EE1650A0
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8C1B960;
	Sun,  8 Dec 2024 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlY5HEZ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D222C6E8;
	Sun,  8 Dec 2024 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733625679; cv=none; b=Adw08lvH6w7nKHGbGuqXmLfR3hWh0bnLXZxFu0QbDJm/1GyxbI/S9IOXEHygc0pj1m/x6IeHhUrxM4jIGDn+9Cn4R8ZF5Mqiew1gdTz6E21pdsCVWLBVutWUyY4jSvelcYrta6RXRwLVZI0xKBEWn0CEhx+9vpBTYN43gQ+oWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733625679; c=relaxed/simple;
	bh=cuSBYLZSLuOzhNh5PpSSHcTfcMTle0+dccMUL5XVxTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvEm0gH8Vu9qa1+jgoT6UTqRJPrD0ej4FaIEQIp2fhJDnUCJ+h1BAmOU/eP/OBTrC0GxTTyT+hmAcB80VWW3iF8mAe8M8YWpJIzKpVAOTivdfLCXvdLvRnpIDzixALAPwWbt+MEUhhCvO5aRxm5vD591Qy45MzukOQyH/WbS6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlY5HEZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A4CC4CECD;
	Sun,  8 Dec 2024 02:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733625679;
	bh=cuSBYLZSLuOzhNh5PpSSHcTfcMTle0+dccMUL5XVxTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tlY5HEZ0F+63zCGjbA5acwUyHAvS3GDgVD2G9wFr3ZGKtAIAhXppINeL2JJJt0gKi
	 +u8JSzg8XONjs97irbXbWSktzQZufJXqkTuu98lTHWK2XaFAUXzXXjL9KU9FmhE/MG
	 BY1iWdwnBSRjDdDDAnuFN/roXV0pN94GEI5X2MRriAfuaoHBvKjDoAgJWkCApNmBGt
	 zK72tzTbvNq7ZuwTiCrbmpQFU3e7yCXMnTWkuRmFz0BQ2MYNMiu+2RIp+0RrRa+Ta8
	 XlavohMJwU6caidYDxJALegEpq6wFNIfaXysy//FCUyjt0nqDA3b8BhUcJgObWERDO
	 Sa0zqEYWG+Oeg==
Date: Sat, 7 Dec 2024 18:41:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <andrew+netdev@lunn.ch>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v5 2/6] octeontx2-af: CN20k basic mbox
 operations and structures
Message-ID: <20241207184117.4ec188c7@kernel.org>
In-Reply-To: <20241204140821.1858263-3-saikrishnag@marvell.com>
References: <20241204140821.1858263-1-saikrishnag@marvell.com>
	<20241204140821.1858263-3-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 19:38:17 +0530 Sai Krishna wrote:
> -	ret = request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX),
> -			  rvu_mbox_pf_intr_handler, 0,
> -			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
> +	ret = request_irq(pci_irq_vector
> +			  (rvu->pdev, RVU_AF_INT_VEC_MBOX),
> +			  rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
> +			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX *
> +			  NAME_SIZE], rvu);

You're breaking these lines in very strange way. AFAICT they fit in 
80 chars.

