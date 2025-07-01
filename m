Return-Path: <netdev+bounces-202936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDFCAEFC1D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFEA3A5143
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1677278143;
	Tue,  1 Jul 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxONX8z2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63411A0B0E;
	Tue,  1 Jul 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379404; cv=none; b=iytFHAikwpGw/gMZCfkRFW6sROuPKu60h/RX2GivyOgFFK8IHJRoD5Och1PTON7V+ZUAFKGiss1YXlv8OrwcjVZd0IJKpqvtuHKmEUwC+wjPGOuhkd5r8XzDbkve1dNuihu6kdd6WcLAJymgGeTdn9LRbJ7D4vQo1yGDSncSBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379404; c=relaxed/simple;
	bh=pyB93qMyYeN/PYe4l5xRCsxTGA33dPeVkZtZBh5MsYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SApnGS7eiJF1ddUYbPYhYHAVk/ZzvcZ3KOvtL/Bln/5kdC53r5sIT+vXfLa1YmqVE71F8Crs2Ck7AHYly6c58fZnUv/79Rxwgcu17Bgda3i9Y9tJOdX98BNb/IhaujJlSbReyFNwaw3dnUkviMHN7SLtVSTFpnMH1e+ZLuA+SqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxONX8z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF32C4CEEB;
	Tue,  1 Jul 2025 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751379404;
	bh=pyB93qMyYeN/PYe4l5xRCsxTGA33dPeVkZtZBh5MsYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxONX8z2ZAC9sHGJsgcJ8C1glGVYRd69JfPaK6w6q8zusI3AHtZsCSQnxwH6xNwfz
	 3dCs92217WqB4UzOD5TCRtPjcSQ7uufb8rHfk9VgOa/nKtfxkm1FL6xRvtho3QPscp
	 OBsPZZNB2QCf6CI1564wNMMYQf0l44X1gFsgzABJ6htf2ugbe/t05kvhPvEh531gAQ
	 abSCRYBVRl8H+P8d7gzqWqz8IaFAnbyeSzF89LTuQWhnSXMwN8eqs2wsAuCRvjfMjt
	 MU+dfSRT2ipfQ62BWY//P4kcZ5Q+7C4h6R523NT11hKvBaA8bY23YXb3L418fx8XP7
	 MjmdNArWbTcmw==
Date: Tue, 1 Jul 2025 15:16:40 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: Re: [PATCH net-next 2/5] net: ip-sysctl: Format possible value range
 of ioam6_id{,_wide} as bullet list
Message-ID: <20250701141640.GU41770@horms.kernel.org>
References: <20250701031300.19088-1-bagasdotme@gmail.com>
 <20250701031300.19088-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701031300.19088-3-bagasdotme@gmail.com>

On Tue, Jul 01, 2025 at 10:12:57AM +0700, Bagas Sanjaya wrote:
> Format possible value range bounds of ioam6_id and ioam6_id_wide as
> bullet list instead of running paragraph.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


