Return-Path: <netdev+bounces-39673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DFA7C04A8
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5B4281EB9
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7E32195;
	Tue, 10 Oct 2023 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgQRxMcv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645F32191
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 19:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962F4C433C7;
	Tue, 10 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696966356;
	bh=GPjua0IjCuMmByKlFL6lkNxV/332at3VwhBzisfdC1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bgQRxMcvNVVtr9a++yWmtIV8aRE4qIlhES2ie00klEHXAI4mm1LXGCzByBIEv3th6
	 DbBMK1z1cDlS5GonXRB1Zevzm3uChV8KKdPxdjM2oDpYCILXlIMKy31hatUQWL8R57
	 RyzhYyLY54XXXY+dYJOW907p91R/NA0H82XkaZm6Wf92w+B9y9BjsL4P9tjK5CkGUO
	 Mn9EPEgFt0v75/3f6OW2bSN3kus9cLE50edhw8BcDkJO+ALPTGxrxPd15djB7ViAS7
	 SplqRtSI3pCgyJvf26XuBMHyR6sW+lFwmX6C1P5YzGz/smaclVJKUtvQ9lFiZRL1Mr
	 q86GKoXJPXBfw==
Date: Tue, 10 Oct 2023 12:32:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
Message-ID: <20231010123235.4a6498da@kernel.org>
In-Reply-To: <20231008075221.61863-1-hayatake396@gmail.com>
References: <20231008075221.61863-1-hayatake396@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Oct 2023 07:52:22 +0000 Takeru Hayasaka wrote:
> This is a patch that enables RSS functionality for GTP packets using
> ethtool.
> A user can include her TEID and make RSS work for GTP-U over IPv4 by
> doing the following:
> `ethtool -N ens3 rx-flow-hash gtpu4 sd`
> In addition to gtpu(4|6), we now support gtpc(4|6), gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.

This is for tunneling, right? IDK much about GTP but we don't have flow
types for other tunneling protos. What makes this one special?

