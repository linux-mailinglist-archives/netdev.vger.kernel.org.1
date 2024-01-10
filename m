Return-Path: <netdev+bounces-62775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0A982923F
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 02:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A71BBB25D0E
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 01:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D51373;
	Wed, 10 Jan 2024 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS8IERtg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A515C0
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 01:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ADAC433C7;
	Wed, 10 Jan 2024 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704851629;
	bh=qlUIwbbtpo45n1KMhaofjPduz19QrD1vi2ZUEgS+Z6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XS8IERtgg2gnH09tLqasG6VOJpk2jRhkdg1ERVxxKwzMGXZLmD2Ce223Ai+JFFhOm
	 EJh43+GSPPzZusj9A8xa8Lf2yzw3vssECrgj68G5Inxh0kUOl1d5hxJtFqJsJaHvr+
	 pi2zr/iz3koQfcRlkD3wBU99y6TdMPKVGOsn3iKKpdBnIVVvkie+jD6dISzzonUVSW
	 ZmzjdwF5GBQPp6jGwauwXuBqAT/6Lxtm04jIhBfz88v1zfQEfDlHZ36wCFo/ff25Zf
	 m82rmx3o+yepLG+EIJZYR2CDS6WvMczoNmOttfsSBpoFft8DXYs8+Duj6p39zyJUvA
	 ZCCqTXFrFFbPA==
Date: Tue, 9 Jan 2024 17:53:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/5] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <20240109175348.34208e1e@kernel.org>
In-Reply-To: <725ad89a-038a-45bb-b710-24c2798f0dba@davidwei.uk>
References: <20231228014633.3256862-1-dw@davidwei.uk>
	<20231228014633.3256862-3-dw@davidwei.uk>
	<20240103173928.76264ebe@kernel.org>
	<725ad89a-038a-45bb-b710-24c2798f0dba@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jan 2024 08:57:59 -0800 David Wei wrote:
> >> +	ret = sscanf(buf, "%u %u", &id, &port);
> >> +	if (ret != 2) {
> >> +		pr_err("Format is peer netdevsim \"id port\" (uint uint)\n");  
> > 
> > netif_err() or dev_err() ? Granted the rest of the file seems to use
> > pr_err(), but I'm not sure why...  
> 
> I can change it to use one of these two in this patchset, then I can
> chnage the others separately in another patch. How does that sound?

Separate patch and separate series. Let's not load more unrelated
patches into this series :)

