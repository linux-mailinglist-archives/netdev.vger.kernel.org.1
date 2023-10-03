Return-Path: <netdev+bounces-37664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142187B6838
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 974862815DC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6E4219F4;
	Tue,  3 Oct 2023 11:44:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1E219F0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C06C433C8;
	Tue,  3 Oct 2023 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696333483;
	bh=g1cMEDzygz3CrEdKHgqMPmc+fXebxasdJMmGyr9hBA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHZcb7O7dtzjquNOOAfo1HhpwBZUCFsnU22i2w8X92NaY0avXhwKyoxciiPBcSMAX
	 pg69zpA4q+WuxkzKnnfsbTKntYPBIg3hZAom8vrszHxaOQC+RvPc9VRPKo/LohDX1C
	 XIQeCP+EaY4Z93qYiwPtDNpKEhj7g9S4YC7TFhoosAj6ir9dOTWU7IrZvLp5GgLKSb
	 hpDNaN8pbqs8BJAB+5JI3AWD/TmO7d5LAODEfxWYyzkhS1khJ/+yx2zQ0hoTDAiD10
	 bbgZNFuHMrBtmght3WRfjRYmY/5FHskKFN7sVfTXdpxGSOEgdBncjX3AqCNUFc0yCy
	 vmBZS60oBlHhA==
Date: Tue, 3 Oct 2023 13:44:39 +0200
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] wifi: mac80211: fix header kernel-doc typos
Message-ID: <ZRv+p69B4JbSETgJ@kernel.org>
References: <20231001191633.19090-1-rdunlap@infradead.org>
 <20231001191633.19090-2-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001191633.19090-2-rdunlap@infradead.org>

On Sun, Oct 01, 2023 at 12:16:32PM -0700, Randy Dunlap wrote:
> Correct typos and fix run-on sentences.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>


