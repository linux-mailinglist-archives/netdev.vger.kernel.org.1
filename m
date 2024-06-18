Return-Path: <netdev+bounces-104282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 156EC90C042
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 02:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBBF1F22219
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 00:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D117F8;
	Tue, 18 Jun 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqZCyrVZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116917F3;
	Tue, 18 Jun 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669672; cv=none; b=r6U1xq05EmwOS/U9y4OSKJKdHtWf+B2NsAc0yPsyui2vnwm8UD2ZGP7X5Df+CAdAYlR5m1ZTaOjvR5/Hj+18cbspZ/NJc99tUAOlJZhGDCREY9DeIUkzfZiQJZG2zPBYbcFV2aVnIixLy80CVBuTGboYO7eu89p9XTJ3ngBo/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669672; c=relaxed/simple;
	bh=AqCOcEd4ls31i1LUK6L8hUCY0cozFi8uvOkLyRI3fsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcvtZC3AGatWLbACBWjYUpq2UAKTpCa8sKQGYMY/1BzZ/u2vqvzSGBt0pfyDq+fQ8RqJk/iQnw6u+/QeCZ53dyYAoLZAo1XyXRoORWmppoQ2p41j/PWJvs1K28RPq/yg5HMjcUjI/YO4ooC9r87JGnQus5sghAzACXHfJYbAYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqZCyrVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD73C4AF48;
	Tue, 18 Jun 2024 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718669672;
	bh=AqCOcEd4ls31i1LUK6L8hUCY0cozFi8uvOkLyRI3fsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqZCyrVZgYgqsUMwSSwtx7EqDU5vMEaRhInCp1Q0EFOD8csIBHGM9Zr8QvVL4YXWU
	 7LICNb9CLVcQrH3Gly2FM45p6R9OErQZZRqklvA0/iEa81kgyG5AIbMg1FdumPsalj
	 NyHVeKMw7xqIaTjnZM9EySLHGN1MczKhrzXUCoxxQHGEtt+lflkcgA7D0/c53KHrPn
	 hCfI8Wz5fKgQC33/5Oy+6DD7KrG873bJwoytwSX20cdWj1sOdnHD8VjvKccZbVst65
	 nN/ims8YxA/+5LWQNK/sViGuuUZ4j9YxFq1x5O+LII5qr+DIlPFdkwVvEhrvC1x1Oo
	 Bp7SRacjfw4iw==
Date: Mon, 17 Jun 2024 17:14:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: dwc-xlgmac: fix missing MODULE_DESCRIPTION()
 warning
Message-ID: <20240617171430.5db6dcd0@kernel.org>
In-Reply-To: <ZnAYVU5AKG_tHjip@nanopsycho.orion>
References: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>
	<ZnAYVU5AKG_tHjip@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 13:04:53 +0200 Jiri Pirko wrote:
> Looks okay. Missing "Fixes" tag though. Please add it and send v2.
> Also, please make obvious what tree you target using "[PATCH net]"
> prefix.

I've been applying these to net-next lately, TBH.
Judging by the number of these warnings still left in the tree we are
the only ones who care.

