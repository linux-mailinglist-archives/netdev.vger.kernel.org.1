Return-Path: <netdev+bounces-51530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C637FB02E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BC7281BD6
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CF4C95;
	Tue, 28 Nov 2023 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyhYjOKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD28EC5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7B8C433C7;
	Tue, 28 Nov 2023 02:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701139388;
	bh=FP5iJJdaRp/C3nYdpRdsVX299+R2BDsbJDi1D7WwSW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qyhYjOKf9DXu8bH+bDiJXmJUfqSLmCdUcv9xz5080dk3JfRoUfnMtEgHfAhNWe+Ru
	 6ENqX9mYL7GV88wm+J6VPnNLsZ1hAejksTrttO6WeLCjpR8hL96nBJOPz9KalEjXbu
	 MOfVYudEUkpaFVVEwB6B+gw3dG5Yxz9T4ZmepFNcC/r8e0J7/Kpte39LrQj/7CLc/v
	 5svFCaCQPbKI3auHVmmySgb3dm25Ul+qWPfN8ypOB2O+8FSIC9Ilc6yHXYfn9094Xf
	 3rAgCaEnPVZFlwRpzVpnQqC5wOnSpvBfPCIqLKkXrb5SizJuLDRM36sLxTHbN5mEuJ
	 GPt1vUCUBqi6Q==
Date: Mon, 27 Nov 2023 18:43:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
 <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>,
 "Veerasenareddy Burru" <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v1 1/2] octeon_ep: implement device unload
 control net API
Message-ID: <20231127184306.68c2d517@kernel.org>
In-Reply-To: <20231127162135.2529363-2-srasheed@marvell.com>
References: <20231127162135.2529363-1-srasheed@marvell.com>
	<20231127162135.2529363-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 08:21:34 -0800 Shinas Rasheed wrote:
> Device unload control net function should inform firmware

What is "control net" again?

