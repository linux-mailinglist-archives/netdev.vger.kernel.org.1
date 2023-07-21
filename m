Return-Path: <netdev+bounces-19877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0C75CA2D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A2F1C21724
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA827F05;
	Fri, 21 Jul 2023 14:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892231ED25
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7671FC433C7;
	Fri, 21 Jul 2023 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689950223;
	bh=TAtVRatQJl7dp+O8SxA2iZNWmvzPDyQDzJ+19l+YMPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jr1bpJYXgtl6kH7UuJx2WoWg4zRlM14AAfNfU40kal/bQWfMfCoNDOwcS8vuCiNb4
	 wLu8gn+dumG1/je/9W115PNjpPz/I3SzSOYR6kS/hRv7m/LU2a4ALWVB4EYu8GUiXq
	 sRgBPMfHvuavOl3TzThwDlwMjR3RpfGF7Pvl+8hj5k9yxDwD7m8B1nESPns4rQ2E3q
	 qiZg/TJo/YYQL+hf+3r2OecLWy2DkX0ad/o/IOIbKnbWNIxGUbSDtJ/IESBENNO1oj
	 pRuPeiqEV4TAie6sd8rSCDLMIgi5y5L0fVoXmVVlFiUGcaGfyq5ISw1jbPbcfRpsX1
	 3zY0iA6uS851w==
Date: Fri, 21 Jul 2023 07:37:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: Paul Fertser <fercerpav@gmail.com>, linux-wireless@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Rani Hod <rani.hod@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7615: do not advertise 5 GHz on first phy of
 MT7615D (DBDC)
Message-ID: <20230721073701.38f8479c@kernel.org>
In-Reply-To: <00a2f5ba-7f46-641c-2c0e-e8ecb1356df8@nbd.name>
References: <20230605073408.8699-1-fercerpav@gmail.com>
	<00a2f5ba-7f46-641c-2c0e-e8ecb1356df8@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 10:03:49 +0200 Felix Fietkau wrote:
> On 05.06.23 09:34, Paul Fertser wrote:
> > On DBDC devices the first (internal) phy is only capable of using
> > 2.4 GHz band, and the 5 GHz band is exposed via a separate phy object,
> > so avoid the false advertising.
> > 
> > Reported-by: Rani Hod <rani.hod@gmail.com>
> > Closes: https://github.com/openwrt/openwrt/pull/12361
> > Fixes: 7660a1bd0c22 ("mt76: mt7615: register ext_phy if DBDC is detected")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Fertser <fercerpav@gmail.com>  
> Acked-by: Felix Fietkau <nbd@nbd.name>
> 
> Jakub, could you please pick this one up for 6.5?

Kalle reported that he's back to wireless duties a few hours after you
posted so just to avoid any confusion - I'll leave this one to Kalle
unless told otherwise.

