Return-Path: <netdev+bounces-140907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C79B8955
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E981F22A76
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44735280;
	Fri,  1 Nov 2024 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sePsJvnJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B427482;
	Fri,  1 Nov 2024 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428526; cv=none; b=VexbQl+IuzZqx2WeDjDUoFnK1q+6osBHmhf5ocGwh74j8MabF0TshdQa98vAR/jkXLr4VOFNe8jW5cpv2Pi1VPJ/b3rMx6IXY4PVZzlF3B/sg4AmrcBj1YI7L1OG8xLh9/8z4jz5QZJsz14HmFL3uXqujZX2/A2OD52GxQTfvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428526; c=relaxed/simple;
	bh=JrrcGy3WNSLTN19FZmr/1xEe+Vp+HHilQggRG+C2jss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBOOHNfw0dML2nmOMCQ9MqnpvRr3S0gCXcsoceRMw4jGvSdPg89x2gn12jgwfJjdhtZZSyF51mvMxOMdtFKp+V7KHFYB70DR78Gwg6oEgSEFAq0zEcOqQqLCvCTvQQ4Et/g/M/oclgRsbweLmtJVCFC+KuKf8Z+voxz4JxuWVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sePsJvnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F22C4CEC3;
	Fri,  1 Nov 2024 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428525;
	bh=JrrcGy3WNSLTN19FZmr/1xEe+Vp+HHilQggRG+C2jss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sePsJvnJnFWmiteSyCg4yIUBWt+sU2Ldqxxi+YDpQs57ZRvXh7paWKjgARxQrKzft
	 c7DMRq00K9/d1nR4FZGCxvVV3085J/yRG0nItgol+HyWlXuDj6tacUObqlF4QkhIZU
	 xAWDD5AASa8zONmTOcBkBZ0bvPIadLb99W6eRUciPV+3G80+HvZW0nhkKnzsvwkcz3
	 C9zlLwb/7vdAy6j5k3R3pzTeCOdzbK4lC8J5mYZ6RZ26XtweR6o0bVdZ+WOleHqcjQ
	 JwuvGBQLiv2P8n+2Gfvjcyc0ezob1SsIQD93QiQmom4WG4xsDHTk3RcT1XgTO1J7wq
	 OIZN1xRV16hlw==
Date: Thu, 31 Oct 2024 19:35:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: gongfan <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Cai
 Huoqing <cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>, Shen
 Chenyang <shenchenyang1@hisilicon.com>, Zhou Shuai
 <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [RFC net-next v01 1/1] net: hinic3: Add a driver for Huawei 3rd
 gen NIC
Message-ID: <20241031193523.09f63a7e@kernel.org>
In-Reply-To: <ebb0fefe47c29ffed5af21d6bd39d19c2bcddd9c.1730290527.git.gur.stavi@huawei.com>
References: <cover.1730290527.git.gur.stavi@huawei.com>
	<ebb0fefe47c29ffed5af21d6bd39d19c2bcddd9c.1730290527.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 14:25:47 +0200 Gur Stavi wrote:
>  50 files changed, 18058 insertions(+)

4kLoC is the right ballpark to target for the initial submission.
Please cut this down and submit a minimal driver, then add the
features.

