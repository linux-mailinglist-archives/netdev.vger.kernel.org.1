Return-Path: <netdev+bounces-47601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A087EA9D7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD51C209BD
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 04:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A0BA45;
	Tue, 14 Nov 2023 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCw6aaw/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0EBA40
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B290C433C7;
	Tue, 14 Nov 2023 04:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699937571;
	bh=Fehotwj7vqVEsM2u92+0dm7EmsnchcQiOoVbXbBJyEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WCw6aaw/kOJLJbOHYNiZel363/Cfj5DafhBw1EdrFZcImbTebz2eLblEz0sbE3JFD
	 y6Er5x+3WfUyrSEo8me56gE1AexVfftWTyIokizqDCR7MsLGAiEb+x8l/4FPF3UGs0
	 kWHh6rE2p1ftougyW9tWMwoQsq7eOpj9c+OfS44A64q/50iNMIwbY1H9wsYhDKVlbr
	 X33vQxgEO/PNerodmk51NPeHg+68CYJky/k3Q6wDo1Wpgb0ybvuefeirSiptKKf+ne
	 QOvRGObKCLfZ+V8adJyQkGOK7Qux8KAR798aZvF4a9xZynCRL8CiS2QkBe1NjI9YXG
	 Plgk01oDioJLQ==
Date: Mon, 13 Nov 2023 23:52:48 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ptp: annotate data-race around q->head and q->tail
Message-ID: <20231113235248.48542922@kernel.org>
In-Reply-To: <ZVAf_qdRfDAQYUt-@hoboy.vegasvil.org>
References: <20231109174859.3995880-1-edumazet@google.com>
	<ZU2wRnF_w-cEIUK2@hoboy.vegasvil.org>
	<CANn89iL5NC4-auwBRAitOiGMEk1Ewo9LOu2TitYHnU3ekzAaeA@mail.gmail.com>
	<ZU5j2V9aUae0FE1o@hoboy.vegasvil.org>
	<20231110115224.3d2f180c@kernel.org>
	<ZVAf_qdRfDAQYUt-@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Nov 2023 16:44:46 -0800 Richard Cochran wrote:
> > Meaning we should revert 8a4f030dbced ("ptp: Fixes a null pointer
> > dereference in ptp_ioctl") ?  
> 
> Yes, I think that would be ideal.

Done!

BTW Eric patch is series id 800000 in patchwork.
Nice and round number :)

