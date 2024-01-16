Return-Path: <netdev+bounces-63748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ED382F25C
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 17:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423961F244F9
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4481C6A4;
	Tue, 16 Jan 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4r8Zb36"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D281C290
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 16:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEF6C433F1;
	Tue, 16 Jan 2024 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705422506;
	bh=K6klib63U7gA1DdMkelWhSv2PbXAwyhfb9Y+JGeCAho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k4r8Zb36HPRbOh4kcm5IUB4VzwieSe0TLHUSjar2xzoY0561hav3h+px/sA3ajcKq
	 3FormZBKZtwlJfyHpRJZeVGHvE63LO1ramB7UbQjmgRjjQhLIQpynMwEUipjD1frhF
	 atWYy+3OGij5mKeFhAy499IivcJOX9mkvg/bhFbIBPaKw0vyZDqjG3Ahn9mE9NJepg
	 4Y2QWjd0cMbtvLohWobNuf+8oITkMwxpz+qgM+TP4cbM5bv01jT+MHfHwRV8wnG36z
	 9OKkuARwGNHhqyda92sfd5/QOU3QIetPbhsGYSDc1oa95Vgkdq38zzXz9NhthM59wk
	 oyTUge1D9EZmg==
Date: Tue, 16 Jan 2024 08:28:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kasper Dupont <kasperd@sgcrd.13.jan.2024.kasperd.net>
Cc: netdev@vger.kernel.org
Subject: Re: Receiving GENEVE packets for one VNI in user mode
Message-ID: <20240116082824.4deaa25e@kernel.org>
In-Reply-To: <20240113223533.GA3929032@sniper.kasperd.net>
References: <20240113223533.GA3929032@sniper.kasperd.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jan 2024 23:35:33 +0100 Kasper Dupont wrote:
> Is there a way to make one of these approaches work or some other way
> to achieve it?
> 
> If it is impossible to do in user mode do you think a kernel module to
> add the functionality would be possible with the current kernel code?

Perhaps open a tap interface and redirect to it with bpf/tc/whatnot?

