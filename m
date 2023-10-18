Return-Path: <netdev+bounces-42204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8297CDA7D
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B609E1C20C5E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D63A20338;
	Wed, 18 Oct 2023 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb/LQIlF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71F19440
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7D3C433C8;
	Wed, 18 Oct 2023 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697628801;
	bh=00Aj5x/xbamSn834Rz9OMwu8KJzHOhtrQtScQJyQgzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rb/LQIlFJYbMvP3gx8utHIrKdbnUzKw+fch/2u7ZoO5ge2cYHamEeQTlA3VTsn5yN
	 bEpFY4dy+9dKCEewncjheoVVW4VOA4mTyr87L3x1XHjhWDRbVhlAAdSoSrcczFQAMc
	 dNHcj36/r4DywmeIFsbL/xc2kwKXOXpLL1dB/qkBPIDS4bkgEXrSxO+znD4eVnhyq0
	 HBTTQXc34xbILc6awJ8D8KVo1KKo8xQYQSdC/r/jTGIFG1VuriozmhvK+jyk5ifx0v
	 lGJY/lYjlMsVOrji7bqTpNEoNTfnvcVc3BgTzZnkTMfHEMXhorrREI9xmJcpHmUECp
	 KfA54Ccd4zSiw==
Date: Wed, 18 Oct 2023 13:33:17 +0200
From: Simon Horman <horms@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: fec: Remove non-Coldfire platform IDs
Message-ID: <20231018113317.GM1940501@kernel.org>
References: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
 <20231017063419.925266-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017063419.925266-3-alexander.stein@ew.tq-group.com>

On Tue, Oct 17, 2023 at 08:34:19AM +0200, Alexander Stein wrote:
> All i.MX platforms (non-Coldfire) use DT nowadays, so their platform ID
> entries can be removed.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Simon Horman <horms@kernel.org>


