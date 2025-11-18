Return-Path: <netdev+bounces-239732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BEC6BCD6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2ECF13672F0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631BA2DE717;
	Tue, 18 Nov 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="mgnpm9kS"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870537031D
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763503394; cv=none; b=fQvXOrBm9Xaxsm8WbSTr/wZ8r/NJO9e1t9kQ+F+C0HNMk/FTzIgE48yvoMCba21aIrwd0NotHW3CAanuuStv/JYLTCfxBQBQe2GygfzEblmBjECEBKk/9vZDDMZjvGl5XmyJ+D6IsdfqHbCqWAetVCzrWh32TYeNKnwgRcrNxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763503394; c=relaxed/simple;
	bh=0OikAlS2d6QjRAxLsBMq0lSLVdK+gqqz7zRQNdQhN7w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=URMgIs5kZSN8cRDDd1Y9+u9gPxISf6SkiORHI+8bo22/VNH1dUAQqd/ZxlJUFWsSFikf5fLWx+UNNm8MdGFGJTVrKPLoe0zTgg8FMqlzBB4NwXMyFgtW5pqcmTN1BR3YCqIr3D933ibVELZxCRa2ljX+I7PQHX15dVadTEsCb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=mgnpm9kS; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vLTmu-003b7s-92; Tue, 18 Nov 2025 23:03:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=0OikAlS2d6QjRAxLsBMq0lSLVdK+gqqz7zRQNdQhN7w=; b=mgnpm9kSw7UAEXKOPfbmaYeeLe
	BiKaU3Kk5rDK8oWIdiUmG5RQIYuTzmyayPYSrLo/YnPqe3+tfaC8YDUyNeEKy46ZMR+Ehdo3uEf3M
	ehsw7xY5Ekj6fbRX8qQv8iu2vnlgd5M7Zo+CwRS4UD5S7KLMBvYDe0MlHlpWAB+/2CChHAnqpj6Lv
	vC5o50H2wyJJjAnVyxQHeeiRFfBphJTWVJ9Ngdm7wDxqIcuepXM9ivlxQhKI+R0jqdA2Idl6wSX6E
	HFtI8fbr1rbYHgpAKOhA9dYb+tGAfIEj3/zgHW3fx2jkGiI+4Htj07LpynwLTKEAcq/6P4UBMegYP
	Zq7BqfLQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vLTmt-00074q-UH; Tue, 18 Nov 2025 23:03:00 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLTmb-00DGFx-Hz; Tue, 18 Nov 2025 23:02:41 +0100
Message-ID: <916d79b2-1b21-4791-9b23-a018a8c4b530@rbox.co>
Date: Tue, 18 Nov 2025 23:02:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: vsock broken after connect() returns EINTR (was Re: [PATCH net
 2/2] vsock/test: Add test for SO_LINGER null ptr deref)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
 <d3a0a4e3-57bd-43f2-8907-af60c18d53ec@rbox.co>
 <js3gdbpaupbglmtowcycniidowz46fp23camtvsohac44eybzd@w5w5mfpyjawd>
 <70371863-fa71-48e0-a1e5-fee83e7ca37c@rbox.co>
 <cosqkkilcmorj5kmivfn3qhd2ixmjnrx7b2gv6ueadvh344yrh@ppqrpwfaql7d>
Content-Language: pl-PL, en-GB
In-Reply-To: <cosqkkilcmorj5kmivfn3qhd2ixmjnrx7b2gv6ueadvh344yrh@ppqrpwfaql7d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 11:14, Stefano Garzarella wrote:
> ...
> If you agree, I'd say let's leave things as they are for now.

Yup, I wholeheartedly agree :)


