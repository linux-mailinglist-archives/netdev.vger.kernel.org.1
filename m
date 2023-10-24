Return-Path: <netdev+bounces-44047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9E7D5ED1
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D5E281C72
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C49CA5A;
	Tue, 24 Oct 2023 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYJzOD3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369A749D;
	Tue, 24 Oct 2023 23:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05FCC433C7;
	Tue, 24 Oct 2023 23:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191429;
	bh=tz0Z0tRADQZzKoq1quWYDKlJzlX0XjC1ypy2jzzmxHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYJzOD3DRjuILWDBtVfqhysL8NOHgbMQ60DZIc3muG2JY9yZuqh3nVmRsWzc0y64x
	 CwhGw3b7p5+f6yYtiRIJwZ2oH++koYVwhRDhZovOgLNmSANl3y+A+6/Oc1CV9IlptV
	 GtAi5A9WG68ZXAbyY0uH09qcFR1FnUH6ZES12Fmw71wIJ2WdTAjD87kXau42OOyJDz
	 Q83soTWwX4skKvJqthKKeZhoMYPF4GwNcqotHF1UphldE4NfHeRba7ryZs52bORrAl
	 X72jwzGkx/xHsycSbxyOtLMqnvmPC0jS0RbcIZoJLAnDZ74EbzuY35If87tqnyGI8s
	 s54NtSYRj3Sew==
Date: Tue, 24 Oct 2023 16:50:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Davide Caratti <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Matthieu Baerts <matttbe@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] uapi: mptcp: use header file generated
 from YAML spec
Message-ID: <20231024165027.6eddc03b@kernel.org>
In-Reply-To: <20231024164936.41ae6f3c@kernel.org>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
	<20231023-send-net-next-20231023-1-v2-5-16b1f701f900@kernel.org>
	<20231024125956.341ef4ef@kernel.org>
	<a29b6917-d578-35c4-978d-d57a3bccd63f@kernel.org>
	<20231024164936.41ae6f3c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 16:49:36 -0700 Jakub Kicinski wrote:
> On Tue, 24 Oct 2023 16:30:27 -0700 (PDT) Mat Martineau wrote:
> > I'm not sure if you're offering to add the feature or are asking us (well, 
> > Davide) to implement it :)  
> 
> Either way is fine, Davide seems to have tackled the extensions in patches 
> 1 and 2, so he may want to do it himself. Otherwise I'm more than happy
> to type and send the patch :)

To be clear - assuming you do actually want to keep using the old names.

