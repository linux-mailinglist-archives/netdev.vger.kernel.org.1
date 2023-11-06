Return-Path: <netdev+bounces-46280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C072F7E3039
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D3F280D56
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347A2D7B1;
	Mon,  6 Nov 2023 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3YfLs/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185C2FE03;
	Mon,  6 Nov 2023 22:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D48C433C8;
	Mon,  6 Nov 2023 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699311488;
	bh=H4Iv+P8YcX9rpNXz0/hou29NDLB8x17itHwPVgURl84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o3YfLs/FFCiDmnxlSt62WZUBU7k8dKh09DuUoSLUbbuS6E8Z3ow0CQCg4BC1Uo3Bw
	 iyB82LSNEezfoCzBFhlJRZw/GPKO9FQWhn7e66Fk1BfajOx8bbgjlHNSDtFdwgYP86
	 zOAbt9sDeUDtKyPNasHarCKON2Qmo+x9yLaaLdM3sD1EqZlU7A+3xm4ugeaF2NdkVn
	 o+Iq1BPCjY3C6x1uakcGt4QX1WSqxAwycxnIHVBbpXl+7xb6Zxz9W83QeVgDa3V6pJ
	 z2qm2diAZix3G2K/7oVJ9GcUov95FqXrLraEZt7Fo3mISMhxqw8ydckhqyClKREnAL
	 34O8WAJS8Kp0g==
Date: Mon, 6 Nov 2023 14:58:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Justin Chen <justin.chen@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Message-ID: <20231106145806.669875f4@kernel.org>
In-Reply-To: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Nov 2023 17:33:46 +0100 Markus Elfring wrote:
> Add a jump target so that a bit of exception handling can be better
> reused at the end of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

The diffstat proves otherwise. 
Please don't send such patches to networking.

