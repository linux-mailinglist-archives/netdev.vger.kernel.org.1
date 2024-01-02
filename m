Return-Path: <netdev+bounces-61044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1648224B8
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3AE282FFC
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6C171C3;
	Tue,  2 Jan 2024 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smip+GtN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA72182A3
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB89C433C7;
	Tue,  2 Jan 2024 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704234474;
	bh=Z8fRPXBkc5qJUDZsSc7F1Ef46IXvp86ABvHErRoAVg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=smip+GtNVtyWEzYBPyH01qhiLCHHbwkiWKYxvuvP44ShEckCSnN94jC785l8LLOnN
	 YNOkP0W2N93Six+LCzdusBdXBVlpPja/EUyVDBh9aWiBgxOrvvhxw+cVGkPirDNpNK
	 iHP3tPKYsNW6chzoyZos+kh5LqR5DrcPu1i/TO/0AX24MCnyLWjlWeumZ21FOlbE5p
	 1LkrAz98QcwgRK8H3JBL7x9u9PfvRKejhLFLD6Tc83buYPZb+dphIrhf7O5LVx84iD
	 IraNDvuEYssuG97OEdxPMgITZP5HolGk6AK561UNnlzgkGajoRDf/8q3Zd4FSWx66h
	 s2QoYxSHRtNdg==
Date: Tue, 2 Jan 2024 14:27:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v6 0/8] Implement more ethtool_ops for Wangxun
Message-ID: <20240102142752.670cc412@kernel.org>
In-Reply-To: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
References: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 18:16:31 +0800 Jiawen Wu wrote:
> Provide ethtool functions to operate pause param, ring param, coalesce
> channel number and msglevel, for driver txgbe/ngbe.

This was posted before shutdown:

https://lore.kernel.org/all/20231205101002.1c09e027@kernel.org/

and got marked as Deferred. Please rebase & repost.

