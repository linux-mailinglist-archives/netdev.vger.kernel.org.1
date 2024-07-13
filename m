Return-Path: <netdev+bounces-111202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C159303B9
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2571C2146B
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576617C98;
	Sat, 13 Jul 2024 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK977/56"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C586125D6;
	Sat, 13 Jul 2024 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720847212; cv=none; b=FR8vME9DoS8eQbyv2BjZB6quMY+dnG8z3jndZ84yqFvMddOfUbwN6lZZlR4hwlHhlSe9a+OmZqGWiNWmFvKfhILjEJp8j6yxwdZop10rq+0hbBbZ3PwRtWSgdKildJrmXArLbiL5UCgukf96LDJK7EuBhiMbCEDX4b1AvMA6NTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720847212; c=relaxed/simple;
	bh=Ks5ksCtyolGtmIEmXXl6ruVlbedszpfa2kkBgbZxmrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2/IQYA5gEtW3dhtqX7BUtDZKFip5X+1kjc83riM05gqG2kRKtzQbWG/0iwiEWMn/OwaR3bGdXmB66y8uGwWADkU6fjG/P4Do2D+Tw/L4ekHC+7IoHziQImCFq0/XbBqp89S95C5JY1Ean/HnwBDXy3tPEVWbG6Ffc+JyaJvb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK977/56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F86C32781;
	Sat, 13 Jul 2024 05:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720847211;
	bh=Ks5ksCtyolGtmIEmXXl6ruVlbedszpfa2kkBgbZxmrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EK977/56S9gn2GdRktY/KbFPCOybFuan57hjlIhOpMrw+BY2v3brizD6IM6gnXXDp
	 1+ffZTH/sjO+DpkaRGOv28tylfyhAHf03YJ8fPu/+xkc4NNS9K4ftsYCl2Ww9LGNXR
	 TfFOYANISMv/4XY/qU77hTTJiwyYFKM+Z6XgzQjszsCTj3ErCQ423dIG79laQe3tdH
	 1ubWdTlOLfp038C5iNL5+sUC3o3ImAwIwOwWtbUEW9n0B22K2aJI2PKHiKBze8Q8oD
	 21YzE3R1rrJab5mjqvs40h3agNhNEK7DL7xtfao0iGBbiSus5br8iSPTOWSLctoPLA
	 soqo3nmbbs0Fw==
Date: Fri, 12 Jul 2024 22:06:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v9 00/11] Introduce RVU representors
Message-ID: <20240712220650.3c2c2abd@kernel.org>
In-Reply-To: <20240712175520.7013-1-gakula@marvell.com>
References: <20240712175520.7013-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 23:25:09 +0530 Geetha sowjanya wrote:
> This series adds representor support for each rvu devices.
> When switchdev mode is enabled, representor netdev is registered
> for each rvu device. In implementation of representor model, 
> one NIX HW LF with multiple SQ and RQ is reserved, where each
> RQ and SQ of the LF are mapped to a representor. A loopback channel
> is reserved to support packet path between representors and VFs.
> CN10K silicon supports 2 types of MACs, RPM and SDP. This
> patch set adds representor support for both RPM and SDP MAC

Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst:420: WARNING: Literal block expected; none found.

