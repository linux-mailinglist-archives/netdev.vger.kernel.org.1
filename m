Return-Path: <netdev+bounces-122426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E296142F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85EC1C23692
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F151CDFB9;
	Tue, 27 Aug 2024 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUzYw/Z+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028271CC150
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776659; cv=none; b=YLYxhHN/FVDM9SIdzgdn3+0JaTy47AwfMXm/mX3OIOvnFKoqimLPiPP19azfKqJmN6XFNyR5Oy7Q35QeeUNsA+aDlcj+sWoax1urp9bQ3QxiWGZSQMi1OHa9tTzXfFChEm3d7Tx+qOVmIf5iJ4HHSDYF1wgYhl+L8DxUf9RfEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776659; c=relaxed/simple;
	bh=2rivhHg50zV4SOFBLNRvWKMhV08KWycGH2f9b49b6Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clQHNeg5HSHSapjWk20A8VGlAE8uhNwG1gMkKG/TvdL5pz13PW5pEwIU8soX28F/qrm1TfSwp78PtxbIuMG0LfDwOSkHhIahLdBpdYE9oMWnmoMo8I0r6OfeiBKxfpaxOU+sYuF4RVB8AjUY5+MBOOojOoxAWRv2vuxHcEwWi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUzYw/Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1954C4AF0C;
	Tue, 27 Aug 2024 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776658;
	bh=2rivhHg50zV4SOFBLNRvWKMhV08KWycGH2f9b49b6Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUzYw/Z+GrsYvZC8ImJRJCl6mDF5oHo+aXGldie2QKR9WSH4364IRjxg27TRJ5KiN
	 cw07IxjvByMttPWmlZKjVR3YVKoGnjBRGEXOCaO2LsbWJ8YQv9wRfnsnvMnFxyxd5H
	 fJ/ovqI9CBZJyHTynV4YsRxufJ9yc3cAX9Lnfz/Hob2+X8CmDPCpGkAJ8w5xqYNCLP
	 gNGRHN3S5F6tvVFff1028lW8B8AjZRwjvCCN0A6BS56kdF1eeE3Ty0N0/dur5f0Jwr
	 EfiGsaf647DDJSFwTfAiVfoF0bX9bp6slGbKEMHYUxr0AQYRmUoZuR2XxnjM8UWeoI
	 0aFNo3HHXhybw==
Date: Tue, 27 Aug 2024 17:37:33 +0100
From: Simon Horman <horms@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	ndabilpuram@marvell.com
Subject: Re: [PATCH net-next,2/2] octeontx2-af: configure default CPT credits
Message-ID: <20240827163733.GP1368797@kernel.org>
References: <20240827042512.216634-1-schalla@marvell.com>
 <20240827042512.216634-3-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827042512.216634-3-schalla@marvell.com>

On Tue, Aug 27, 2024 at 09:55:12AM +0530, Srujana Challa wrote:
> The maximum CPT credits that RX can use are now configurable through
> a hardware CSR. This patch sets the default value to optimize peak
> performance, aligning it with other chip versions.
> This patch also adds changes to avoid RXC HW registers access on
> CN10KB as RXC is not available on CN10KB.

This sounds like it should be split into two patches.

> Signed-off-by: Srujana Challa <schalla@marvell.com>
> Signed-off-by: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>

...

