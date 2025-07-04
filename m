Return-Path: <netdev+bounces-204175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDB5AF95ED
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C83B887B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1422877D5;
	Fri,  4 Jul 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0O6zElY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F2277C87
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640466; cv=none; b=V12+/OK+o+eIbz9Tim+l89EwYiVnGrMdE83lM6TQwUPpBb+xqk42uY4i3r9t9qY5h/uyH3tr5qHpqJJXOvspT3jEMgGROKiJpr0vUsDv3Hp3q+i7l+yuiYRO0za/h88Xac6HLGFynpVC9xPD4tX0r49U5y96dn08AGzQQh9v+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640466; c=relaxed/simple;
	bh=jwcVzcOp2LjEkMGfNXiETyByGfXvf0/LAVTF7MdWfQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEVC2ju63wItRbOViNyNrKt8XnKgoDj+ftf0mCs+PvwDGjid/T/RsKTkZX8fu86yp85xXwHzpz9VkWBLQceevOVVyD7oVvXM2OVzjWJMP99TA77G47eaXCb85fctBPLY7PLJt+IicxXbwzqLJnG+RcS/bQoP8TAt8rsfSyYgXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0O6zElY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B40C4CEE3;
	Fri,  4 Jul 2025 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751640463;
	bh=jwcVzcOp2LjEkMGfNXiETyByGfXvf0/LAVTF7MdWfQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0O6zElYoWbmZPP62cHIicYkg9GvCc4BngwLsq0dhP3JHuG6080LbkeE9dT2X44J0
	 8cjfLBtQm1+kC3BeST7xFCi/y7AauHxUuUyBf/7c9mdavwY8hMspOAlUIasbuY4dz+
	 F/aa4+Ewkzotdx/iAEQHPXUNII2iIV9Y7S/QH8NNKNi4vI+7D3BjY+1DxcwIo6oquh
	 WUcqs7dUk4rn8dUlPEYnuF5/GAwtkp1Rt+NtIxmpmZXs4ZbnvZcZQUtXOfcHYENiGc
	 ZWLr6ohYJYngdlFj0PbJDTVCYTizi79LQO7hKCWPvJH7sTRLpthtuwe9a1x5GO4uzr
	 9OGtnxU4LljJg==
Date: Fri, 4 Jul 2025 15:47:39 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: airoha: npu: Add NPU wlan memory
 initialization commands
Message-ID: <20250704144739.GZ41770@horms.kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
 <20250702-airoha-en7581-wlan-offlaod-v1-1-803009700b38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-1-803009700b38@kernel.org>

On Wed, Jul 02, 2025 at 12:23:30AM +0200, Lorenzo Bianconi wrote:
> Introduce wlan_init_reserved_memory callback used by MT76 driver during
> NPU wlan offloading setup.
> This is a preliminary patch to enable wlan flowtable offload for EN7581
> SoC with MT76 driver.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


