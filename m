Return-Path: <netdev+bounces-52604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 703527FF673
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0103CB20E79
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70255100A;
	Thu, 30 Nov 2023 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWcwnlM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1254F82;
	Thu, 30 Nov 2023 16:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2197C433C8;
	Thu, 30 Nov 2023 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701362582;
	bh=8wyputpFdm2cBZ54ZzkL6T98tTMSJWpqPV+JdrSK/7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWcwnlM+w1ltPx8nM+/an5hvPw8v4UIBR91eaUZCa48me5GW+dK0OUU4H6vjMxoY0
	 dLcpZabGxfPi7yIXpBsxCTkiU3k9yfTuf/zXhnVvbHtcGoyx1N4Yau+sTo/wLEGInY
	 zzu7XT4Q0QOnMsNCE1G7ll+jex3eXlvBTgSxpLbB/UXsdvujHgiI4KGCH++ggxro5t
	 XAnNAzLt71G0QVl7cCJoaum3SUMvgI7HGvBOEfYljNP0rXMaP7dL35ZPI0zb1ENe9q
	 y1vpuO5kAuFomMY2V1vPYm7Aj0TvaSPzhGaAwB9AaZOH7BtrJk5KRzN+Vz/ltIPRs9
	 Ahhj8BkvDe3AQ==
Date: Thu, 30 Nov 2023 16:42:57 +0000
From: Simon Horman <horms@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>, dmitry.bezrukov@aquantia.com,
	marcinguy@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCHv2] USB: gl620a: check for rx buffer overflow
Message-ID: <20231130164257.GD32077@kernel.org>
References: <20231122095306.15175-1-oneukum@suse.com>
 <2c1a8d3e-fac1-d728-1c8d-509cd21f7b4d@omp.ru>
 <367cedf8-881b-4b88-8da0-a46a556effda@suse.com>
 <5a04ff8e-7044-2d46-ab12-f18f7833b7f5@gmail.com>
 <2338f70a-1823-47ad-8302-7fb62481f736@suse.com>
 <20231124115307.GP50352@kernel.org>
 <794803a2-3084-4591-b91f-6c7cc7a3dbe9@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794803a2-3084-4591-b91f-6c7cc7a3dbe9@suse.com>

On Thu, Nov 30, 2023 at 10:38:09AM +0100, Oliver Neukum wrote:
> On 24.11.23 12:53, Simon Horman wrote:
> > 
> > 
> > I think it would be useful to include information along the lines
> > of the above in the patch description.
> 
> Hi,
> 
> I see why you want this information to be available.
> So I thought about it and I think this should be
> either in Documentation or in a comment in usbnet,
> so that new drivers include the necessary checks
> from the start. What do you think?

Hi Oliver,

yes, now you mention it that does seem appropriate.
And I don't think that doing so gates this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: under-review

