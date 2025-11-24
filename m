Return-Path: <netdev+bounces-241298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FADC827D5
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA3734E2A0F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28287318136;
	Mon, 24 Nov 2025 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g03KG4ze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034532566D3
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018750; cv=none; b=pQ/6w4E+37ES4eBZhl3wFBom0xJx71c3ev1W1HOwHkAbdUZs7w7Bs4hfOILjVn+rIgXYHpSPM0sTOGsz3jQM+DclyWpyt6vLLZQ0+w7IXyuuN5gndCt5ts80Wvo9k93NSlVZWrkjU147lx74+AneaAFFZspb9CHGqfSQJRPNcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018750; c=relaxed/simple;
	bh=RuTdAgSnYYlzR/XIr74+3G+Z4HUyVT5eevPzNOmaFxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBvqGSz6fwpBsj3hK7LybaAGeOaXbYhzy/7rQRXPlKNDpb4OHbZ0oxvI4bKOUx/ktZ59eQGQFeu42qd6Zz0ijuiB/tPVXrHFXvkRfDZumjad/vHCCyEuVdQLhkOvKwamH5kLn1Yy5WP5Epym0iCde0Ks1GWdjRzJr5I/bwp2Ibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g03KG4ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A37C4CEF1;
	Mon, 24 Nov 2025 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764018749;
	bh=RuTdAgSnYYlzR/XIr74+3G+Z4HUyVT5eevPzNOmaFxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g03KG4zeou7QHhn52MGKHDk0L3ntd7Xm0+UQA1aE3GTIwrx/kKkE900kAhnTa1mh5
	 g5KOUSxQPIelHF/ln0Pt8sQ+ZVyFe6CWaUt6y0N5N3X/5NmwIBW8DmUOuRKeBMm5EN
	 k4cp60gdHx4BTcaGCzje5wtcnfLlHYOIVQW7Q6AUcWua4I/Apx6rHbzL0hOTrwLcDP
	 VgUAVlPyEFm+AVVEi1t2ZHztVSSsmun0XRDCo36DLWmdmpOeXf1ZI7K+1GvDB6dVgN
	 WMmYSrqryY2iX6cT52JxE3+RJSNHXueFqW7WNncll9KmAfCPA6OctH8o/kpjgPmDbo
	 sZIvNYMYJU74g==
Date: Mon, 24 Nov 2025 13:12:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 1/2] selftest: af_unix: Create its own
 .gitignore.
Message-ID: <20251124131228.1b26bb57@kernel.org>
In-Reply-To: <CAAVpQUATnxEVBE8uNt01eih=CnonmnLwYSrEZEhDk_EEk7Pemg@mail.gmail.com>
References: <20251124194424.86160-1-kuniyu@google.com>
	<20251124194424.86160-2-kuniyu@google.com>
	<20251124115145.0e6bb004@kernel.org>
	<CAAVpQUATnxEVBE8uNt01eih=CnonmnLwYSrEZEhDk_EEk7Pemg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 12:07:28 -0800 Kuniyuki Iwashima wrote:
> > nit: missing new line  
> 
> Will add in v2.

Feel free to skip the 24h wait. I'd like to get the netdev foundation CI
to a clean state so I can shut off the AWS one completely.

