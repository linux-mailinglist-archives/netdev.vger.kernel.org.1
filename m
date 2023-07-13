Return-Path: <netdev+bounces-17339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553875150C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB67C281AD4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDAE181;
	Thu, 13 Jul 2023 00:16:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24417C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D781C433C9;
	Thu, 13 Jul 2023 00:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689207398;
	bh=2D+KsRaEraMulQIp1Am2Sd9wHz5kZh2S1J4BW5UWa0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WLBHtcNBLf+4DPNHoEfgOFmvnGRaPkR0Qb6OaAM0mf0W7DE3Muhnno/L1bHQT27wN
	 l/MzXIyQO8ZDTZT6VjwM1Ye+N04Y8aGfLDecfDZ9OWL4FejBteo2WpYuCdfD5e51zN
	 +DTY4WNSZCZcDjn+eIFHof79s4cbaMClTQ8hmYnEWRDhnFswlApEXaAGoYoQtLCoEt
	 WxPStCTAQUAE3QeZvRE64jlqxd85bD+kSogg8qNi0Gjlz67QInXmrDsMkGpnhXf1b0
	 xJXJjLo3i0+w1m/tgZ/1JYaHhuqo8rQuUBHUvlmNjBqU/WTNm2tDXAO3ODNVtNH3W8
	 q8WY9u2ClqNkA==
Date: Wed, 12 Jul 2023 17:16:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH v2 net 07/12] inet: frags: eliminate kernel-doc warning
Message-ID: <20230712171637.5c9630b9@kernel.org>
In-Reply-To: <20230712044040.10723-1-rdunlap@infradead.org>
References: <20230712044040.10723-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 21:40:40 -0700 Randy Dunlap wrote:
> Change the anonymous enum kernel-doc content so that it doesn't cause
> a kernel-doc warning.
> 
> inet_frag.h:33: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Could you resend the entire series with the more complex WiFi patches
taken out as well?

