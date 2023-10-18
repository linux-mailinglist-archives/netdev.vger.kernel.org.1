Return-Path: <netdev+bounces-42205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204F7CDA81
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF5F1C20A68
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2BA22F00;
	Wed, 18 Oct 2023 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbKF3B97"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243320338
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992D7C433C8;
	Wed, 18 Oct 2023 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697628814;
	bh=vSmucRbdmxNfM/ypGsamkt/MH6nNlrA+0et1C5k6Y5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbKF3B97Er06Q3ZA6squSNECuJA5M+SrDufUjwhv+U1wp1cyIhnLfDaeU6LGlusgW
	 ld6/i0qc4bW6oOQ5pZtLK2cjpz8YLXOgVwghwdMi4ojM9/bKfF6vDtBv3I+lZsTnDX
	 bPZ40ewMR6BvHz0jyPbgGUy5qYxHqWoBzuzDKcnpM1ukHJtr9YT3Jy0NwECEBCa4Ip
	 6yWFdoUYk97MpZ9ZAH9Z7TPQh5DVZX0NPrKG+64hOHXYjI3kYJTaQapIkKTIA63nE9
	 l5Sxhv0VOJRjZcYARSk8X7vqRiWqp/P7Kh+zmASHOE8qia8yfb7FGdcyRw/WIsRcbn
	 4fPCL0SWoTvRQ==
Date: Wed, 18 Oct 2023 13:33:30 +0200
From: Simon Horman <horms@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: fec: Fix device_get_match_data usage
Message-ID: <20231018113330.GN1940501@kernel.org>
References: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
 <20231017063419.925266-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017063419.925266-2-alexander.stein@ew.tq-group.com>

On Tue, Oct 17, 2023 at 08:34:18AM +0200, Alexander Stein wrote:
> device_get_match_data() expects that of_device_id->data points to actual
> fec_devinfo data, not a platform_device_id entry.
> Fix this by adjusting OF device data pointers to their corresponding
> structs.
> enum imx_fec_type is now unused and can be removed.
> 
> Fixes: b0377116decd ("net: ethernet: Use device_get_match_data()")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Simon Horman <horms@kernel.org>


