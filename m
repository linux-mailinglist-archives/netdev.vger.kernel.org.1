Return-Path: <netdev+bounces-20432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C8275F87C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5645A281485
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CEB8C12;
	Mon, 24 Jul 2023 13:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAE568C
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 13:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D375C433C9;
	Mon, 24 Jul 2023 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690205867;
	bh=XPnxWK5iXuMFmrHKJKeJo0Yq9Glo/4xviAz4D9r3qYg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=AQrFT9qK5bvxE2SdPkvTqntbfl+zjptc4bWvBPnEiJ3KaahyBRVbd41316B9r//dq
	 nCM04qi0ERmUmkw/YFiIStxapFGdGZPXLQCXtgl0X87rKs/3mcLNzTQThj3UWivHKK
	 EH/SgWV3nuqSqhJotS3jyfTAYXm4Am7y/XufRsUhV6OagLOoKpg3tWzXpgrw5jpc2U
	 mp2tNryq2n5j4wf38MHg17i5d4vbbmIwQ6SMkhDMlh0fpLIrckG91ODSzXxjPlEaOy
	 MLsBr1Pa1my88iz+3/Q3CXT6oKq6auRsgjLGrLSsUB0U61bmIk9ablLW9Rdx697Zqk
	 7sUO80MkTLE8w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: mt76: mt7615: do not advertise 5 GHz on first phy of
 MT7615D (DBDC)
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230605073408.8699-1-fercerpav@gmail.com>
References: <20230605073408.8699-1-fercerpav@gmail.com>
To: Paul Fertser <fercerpav@gmail.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
        <angelogioacchino.delregno@collabora.com>,
 Paul Fertser <fercerpav@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Rani Hod <rani.hod@gmail.com>,
 stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169020586134.3064516.1730669435879829563.kvalo@kernel.org>
Date: Mon, 24 Jul 2023 13:37:43 +0000 (UTC)

Paul Fertser <fercerpav@gmail.com> wrote:

> On DBDC devices the first (internal) phy is only capable of using
> 2.4 GHz band, and the 5 GHz band is exposed via a separate phy object,
> so avoid the false advertising.
> 
> Reported-by: Rani Hod <rani.hod@gmail.com>
> Closes: https://github.com/openwrt/openwrt/pull/12361
> Fixes: 7660a1bd0c22 ("mt76: mt7615: register ext_phy if DBDC is detected")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

421033deb915 wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230605073408.8699-1-fercerpav@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


