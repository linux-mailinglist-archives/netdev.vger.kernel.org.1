Return-Path: <netdev+bounces-143173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71229C155E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC620282EA6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AD52EAE6;
	Fri,  8 Nov 2024 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9Scpycd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00624168B1;
	Fri,  8 Nov 2024 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039682; cv=none; b=IzPBf7NW8VXxOCDpjAgzphdTujCcAafT55xTu5ohLTCjDqpQueNhncyoorb6bO5Bfrkf7odf9Bj2dkA+KobXamgPB7dnUUIn6ZNboMY92inVlqk6861kuEtrBECnA7fkAIYv4Qw4BMhx3Y2GoQjiEdiqbfbkbgdQtzWoVZ/KRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039682; c=relaxed/simple;
	bh=sCS9gX/KjFPuMs5Efb706fmR3wTzIiiVF0VBT6y+TPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Goyu2shUz3JT48WLvbOB2MyQAkgJMu/ShPCrFu4cGJ0x+t2/boXtAbdNgBVaiOtXsXbQ/m/illpF8Vtab4Dxet1UbWi/VgtPv1MxP8OCGOYlSrhERdbbvfAn9NtjMpjpOYjvz3NtlQL8oP7mo9OElkcDqYpdlVsb98F2XyBH/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9Scpycd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653AFC4CECE;
	Fri,  8 Nov 2024 04:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731039681;
	bh=sCS9gX/KjFPuMs5Efb706fmR3wTzIiiVF0VBT6y+TPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g9ScpycdzeWWTMu79U45MK8VDgo0uHilpSKdrI9z7TlXFWRPlpZg64z+rDJ/0b30l
	 F7/YPR4N5q3plZHiFvYfjXA6JbmzbWHAkpQ03qiBfhxHiWOWvOX5QPW9C8EDPC4DBj
	 6igEdbz8cNJSCVt8SKTokQsrt8gDgs+GOntbpKZ56b4A2FyvGIe5PQAYk0Dr4dGKug
	 umA8k/UbG+J6CEMxk//guWJ9WAYmCVuaEk3ObEL7o0nfi69Qk8qj+Z9o+tMXodcIPg
	 ZBiWVdI5cqrUkPqN7atW/7qbEJbs8/uu6+jC0+PpwARtvJc888l8u3pjoJe/Ig6rQG
	 KVSsGJLP8Xt5Q==
Date: Thu, 7 Nov 2024 20:21:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
 bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
 m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v7 2/6] net: Add control functions for irq
 suspension
Message-ID: <20241107202119.525a3b76@kernel.org>
In-Reply-To: <20241108023912.98416-3-jdamato@fastly.com>
References: <20241108023912.98416-1-jdamato@fastly.com>
	<20241108023912.98416-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 02:38:58 +0000 Joe Damato wrote:
> +EXPORT_SYMBOL(napi_suspend_irqs);

One more nit after all.. please drop the exports, epoll code can't
be a module. Feel free to repost without the 24h wait.

