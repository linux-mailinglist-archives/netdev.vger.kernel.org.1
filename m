Return-Path: <netdev+bounces-37663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6771D7B6832
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 920E51C20823
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194D208DD;
	Tue,  3 Oct 2023 11:44:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC427DF62
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B88C433C8;
	Tue,  3 Oct 2023 11:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696333469;
	bh=yaYF8nb6MGq8t2g+aVZfQLDiwQe8acgckiqnV2dLxv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1L016eKkQnPRYFTSWXF1ICWSxYD9w/kulER6Q0Vn4uQ54bsfWsMXdtAgc/Uo6LAy
	 KKua71HQnxSZjZeS2NejRYQ4/35slOsJ8wakBSFgTixqx5lY+J+tCI1bT13O1KbaJz
	 YFPI5eJgWlRzM7y2LwWXuxARgq9FY/MsPQwidvhth2Af0cEt+CyW3vx/rc2KfvLkWH
	 e8UfwKONycNVRdszAUNRYe937PQwLjlXCpv+vA+fzF8hgALt7/l0OEekuaeJfJomEc
	 RqvSafdTDpgAL6xcyfnGUJcPYhrFCrTgkCcLi1BRLyco/43YW8YBAyvFbXL06rdR8e
	 z53YvalJqqOog==
Date: Tue, 3 Oct 2023 13:44:24 +0200
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: cfg80211: fix header kernel-doc typos
Message-ID: <ZRv+mApb7siTqWg7@kernel.org>
References: <20231001191633.19090-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001191633.19090-1-rdunlap@infradead.org>

On Sun, Oct 01, 2023 at 12:16:31PM -0700, Randy Dunlap wrote:
> Correct spelling of several words.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>


