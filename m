Return-Path: <netdev+bounces-243304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BAFC9CBAB
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 20:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB99D3A8772
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3D2D322F;
	Tue,  2 Dec 2025 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5mRWO6f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C962C21E7
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702638; cv=none; b=I+iI2zCGtp2Lg46xRkrFmfzBR/YVTrtqLfkAC+q7H1uMLm+K/UWFSx1vzI6jq4X6VIO/vizV7zWDta+0U3V8WTuqLrkKaRMY82P/954qTk52YLlVTc3inNxCqe9pztCQtt6yzQvFV1f+Xh+gYmW+YEdR/lCGT/gawTA4O1uowR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702638; c=relaxed/simple;
	bh=rsSmygFIAY4vcsAN+Ighfqm8RnZc6tR4kLbyvhedq/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qz96euygG8qOuDV9at1MgfGyBtAqocfk6VLfmoEwOz8fdsoY0XwHg9Bps3Nwp2cjgeghx+NTLBE4n7d6KTZ6Tf1HroUdvikFUINuilA/LB/LVGam2kTO5KtlkAbXy7lGXxr8ppPl5YmAwtoz/LdeMrM8Bbx5+QO3tmO/rG9tSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5mRWO6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0083BC4CEF1;
	Tue,  2 Dec 2025 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764702637;
	bh=rsSmygFIAY4vcsAN+Ighfqm8RnZc6tR4kLbyvhedq/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s5mRWO6fc8qP65IKNSltvE3lIlBCybMoyAF3pHpQ9KCqRktrkW5kly26zhDCsot7K
	 PtAPi5fa+Tmx2zw/4Xz8O4hvF6TS5wWPaIFVylY/5Nj1+zLCb3J2rMjFBqtO9Nd/n+
	 256U7WSX/V8JSAlavp42jYjFz9iCU1NjIgH6+DPauCnoxIpqzw01Ejfwf+WhgkEmtB
	 C35oc1k2ZcKLNow/vl7pAF5x4CcitD+gXzqnqA3kk2OfPTtr9z28lfF5lKAdcOyBLy
	 2A355eB7RTbcpWIBJF+24jqr/SSVQdBoDFiD4438mPFaUEghp8Cgk5/ABCpRXga/pU
	 sz5gyVnvL09rQ==
Date: Tue, 2 Dec 2025 11:10:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonas =?UTF-8?B?S8O2cHBlbGVy?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/5] Multi-queue aware sch_cake
Message-ID: <20251202111036.07964fdd@kernel.org>
In-Reply-To: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
References: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 01 Dec 2025 11:00:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> This series adds a multi-queue aware variant of the sch_cake scheduler,
> called 'cake_mq'. Using this makes it possible to scale the rate shaper
> of sch_cake across multiple CPUs, while still enforcing a single global
> rate on the interface.

Let's push this out to v6.20 (or lucky v7.1).

