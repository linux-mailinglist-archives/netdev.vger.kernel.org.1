Return-Path: <netdev+bounces-31751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C765578FEDA
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D3C1C20A5B
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921AFC122;
	Fri,  1 Sep 2023 14:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259BAD41
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 14:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E5DC433CA;
	Fri,  1 Sep 2023 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693577973;
	bh=JAauFWIxKYvceN+T1u/1aK8XkdIL/hConDHTAsdEqd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSa7PA16/mnS00v9z+cjDXi2IRRhf2kc6p7h43OvPbwarST4BivFQHwtJYING4//Q
	 odSlT6rbcM4dt0SDTSvPrK9MMx5tdtM2v9hC/VJQfJbHXldq9GrVcoCInq1u6Oau7q
	 cudZhpsQ8c2RVp0m2DTAo3CeeKDXgLPZPF2Uf+G2+5s83vOTMt+bO7Zr6wJ9HBiAQS
	 iouyY2qxi04OJ3guY6MGO0FpJy9g4I+PjLJXNVkG66pf5bYfEfyxbEMxonfQWMHoIh
	 X8htAA+OzSpRbV8fOCC6g4m4hBylwtRL34SMycZG1j61QgTkleWBYNkErlcXR6gG7p
	 oZnusXnemJpSQ==
Date: Fri, 1 Sep 2023 16:19:05 +0200
From: Simon Horman <horms@kernel.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	quic_viswanat@quicinc.com
Subject: Re: [PATCH net-next 0/2] net: qrtr: Few qrtr fixes
Message-ID: <20230901141905.GJ140739@kernel.org>
References: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>

On Fri, Sep 01, 2023 at 03:50:19PM +0530, Sricharan Ramabadhran wrote:
> Patch #1 fixes a race condition between qrtr driver and ns opening and
> sending data to a control port.
> 
> Patch #2 address the issue with legacy targets sending the SSR
> notifications using DEL_PROC control message.

Hi Sricharan,

if these are fixes then they should be targeted at 'net' rather than
'net-next', and consideration should be given to supplying Fixes tags.

If these are not fixes, then please don't describe them as such.
In this case targeting net-next is correct, but it is currently closed,
as per the form letter below.

In either case please consider:

* Arranging local variables for new Networking code in
  reverse xmas tree order - longest line to shortest

* Avoiding introducing new Sparse warnings


## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

