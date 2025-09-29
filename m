Return-Path: <netdev+bounces-227199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF6FBA9F7F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FE53BB62B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E911E30C63A;
	Mon, 29 Sep 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDx+zozR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1930C34D;
	Mon, 29 Sep 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162265; cv=none; b=Mr0GkmAthEB0KOvS6188WjWaKVX671vypQ598WE1haD3Vs0c5mSWXDVGMMRsPZl+T6oublGzQc+hXTPv0jeJ0iJo5MKjGZA7vBtD784zKy47i/mYubQt+LDhxex9u3FdYxoLm3s+qGVHSo4dVMn67Sa9UC0zKpysp88aZ6dqtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162265; c=relaxed/simple;
	bh=YeRAgj+cW5Z8TMZu2gFKs86qDtVneW7lvxDiBS33YbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcEbNevwFGIWrP0kuOJL1EjVdC34zy64xf6o5sdCZ0Hag7ntpbKb5SL9F+P9yn6G1l+xO9RGZasl0h44TZueDC5fvkspwbXEpl1CFaGF9csI4MuWDs/QYXqN4i1DfOHiHd1cIyFjNcIVMBBt2el3tbHksP+QbjMGSkfEP0CgBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDx+zozR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2811C4CEF4;
	Mon, 29 Sep 2025 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759162265;
	bh=YeRAgj+cW5Z8TMZu2gFKs86qDtVneW7lvxDiBS33YbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fDx+zozRaPOSgskQbwK9oYhfcLVqEpwZT1cXNOtf86OTxCNMkMq3VK4KJbOl7j0/t
	 ribX7k94vpEYDArQ1taOrPJ9OK4l4mVz89Sz9U5FuyxGKiWIX6N8pwLVV50itdc1mm
	 o5Gqg0rBoX/5CSswmrZRs0LZnoUthhNrwho6dhJGio4f473Zb2/o6cda6b9JpG0mzE
	 zIOoUt/6NOuBXz2Tz68bxAjz0utcbGaLKR9MQfuB6nPDYxU2tQxBz92w7tkFWj/8zB
	 e8Rno9LmRK1zylb5Qu7chKTJ9gKP9PzhqESLcwqLrrSL86XqvcOR8D8ShigdiM1u7K
	 z41seOaq42dkQ==
Date: Mon, 29 Sep 2025 09:11:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: yicongsrfy@163.com
Cc: michal.pecio@gmail.com, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, marcan@marcan.st,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 yicong@kylinos.cn
Subject: Re: [PATCH v3 3/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <20250929091104.51574946@kernel.org>
In-Reply-To: <20250929075401.3143438-3-yicongsrfy@163.com>
References: <20250929054246.3118527-1-yicongsrfy@163.com>
	<20250929075401.3143438-1-yicongsrfy@163.com>
	<20250929075401.3143438-3-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 15:54:01 +0800 yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>

Please slow down. Per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
you need to wait 24 between postings.

