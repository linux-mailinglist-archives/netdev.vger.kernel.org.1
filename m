Return-Path: <netdev+bounces-34565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4747A4B0A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AD91C20AAE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD61D55D;
	Mon, 18 Sep 2023 14:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D66FB8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18049C32783;
	Mon, 18 Sep 2023 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695047303;
	bh=cVt3BSeAbCgVpGd6WsEDtgkVPihUYdejvLe8R1O+i1g=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=oujQRKR3JJRDQPQnBYyL9Mg1kpOvs+cB33amTS3eFRjjqd1ZG90xTJeuoCIljLWSh
	 77WZKkUjudUGRZIgu3zj8S3mVt8EOKLZYDjtT05yhKmY7IfiIxZLbLhCC8AruV3ojg
	 UMhQ8RsJVZBstLuk0jUp5BH0orKiLeSIezkoh/b26DFLv6yZlsFbPy+66G54AQ3sO5
	 6wfuro4Idxl2oYwUqrRAifR5IZOQdnnjV/JhDh9fm1EKl4Ox8JjFOAuH26AFjEs5pY
	 zOds9b6vC4jPfASTBfTap1B9zqOOL9Fn2sbFEgLN7ARf0r6uZ12mYb7JLJwRvgSpyT
	 dZudbPpR/4joA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] wifi: cw1200: Avoid processing an invalid TIM IE
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230831-ieee80211_tim_ie-v3-1-e10ff584ab5d@quicinc.com>
References: <20230831-ieee80211_tim_ie-v3-1-e10ff584ab5d@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <kernel@quicinc.com>, =?utf-8?q?Toke_H?=
	=?utf-8?q?=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 "Christian Lamparter" <chunkeey@googlemail.com>,
 Stanislaw Gruszka <stf_xl@wp.pl>,
 "Helmut Schaa" <helmut.schaa@googlemail.com>,
 Ping-Ke Shih <pkshih@realtek.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169504729816.740666.17271538419199878496.kvalo@kernel.org>
Date: Mon, 18 Sep 2023 14:28:19 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> While converting struct ieee80211_tim_ie::virtual_map to be a flexible
> array it was observed that the TIM IE processing in cw1200_rx_cb()
> could potentially process a malformed IE in a manner that could result
> in a buffer over-read. Add logic to verify that the TIM IE length is
> large enough to hold a valid TIM payload before processing it.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless-next.git, thanks.

b7bcea9c27b3 wifi: cw1200: Avoid processing an invalid TIM IE

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230831-ieee80211_tim_ie-v3-1-e10ff584ab5d@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


