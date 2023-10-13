Return-Path: <netdev+bounces-40825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D50317C8BE7
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75527B209FD
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C61F19A;
	Fri, 13 Oct 2023 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkwVYiSn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3321BDE8
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C0DC433C8;
	Fri, 13 Oct 2023 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697216485;
	bh=YnT14MMXq7XR87hug77tKqCOaJhEfMS0UHv6aBrTz3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BkwVYiSni4VQS3Du7z91bcC9loh529708IRUmOAgmr+Zo33tSBMw2uayaWdj5oNT7
	 5sovp/Vvmm0e6tATGqaoSFnSlb67IIvi8yPXCtnDVDoo3Ke2iuYcfQg+j8qhdlWnS3
	 E/VoZBG6oiu2Sb8Gri2BoU6KEuhJq6Qiw2TmoHIG4Xz0xhrY0Lh6ZNEOLxfNn1Cod8
	 WV+9DLGv+ysS1LOAjliGV+HSQwWO/xC6+DoAEsdVfMzroVFb32aZhGuC1Dfni94+Y0
	 gaoD91ECBtZw/E5GvHlKq1sj65XEmefWoMQZvtKqr8+KYMHCZ/15l9Eubo/xlV80bV
	 v8A1gskewF4xw==
Date: Fri, 13 Oct 2023 10:01:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Guo <heng.guo@windriver.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <filip.pudak@windriver.com>
Subject: Re: [PATCH] net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment
 after fragment check
Message-ID: <20231013100124.47148d24@kernel.org>
In-Reply-To: <20231011015137.27262-1-heng.guo@windriver.com>
References: <20231008005922.24777-2-heng.guo@windriver.com>
	<20231011015137.27262-1-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 09:51:37 +0800 Heng Guo wrote:
> Subject: [PATCH] net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment check

Applied, thank you!

For future reference - the net-next goes into the prefix (git
format-patch --subject-prefix="PATCH net-next") and does not 
replace the commit prefix. So:

[PATCH net-next] net: fix
       ^            \
   net-next here     this stays as net

