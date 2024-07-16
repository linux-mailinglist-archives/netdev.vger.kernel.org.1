Return-Path: <netdev+bounces-111813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC49331C3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 21:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA681C22F87
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7F1A08C3;
	Tue, 16 Jul 2024 19:23:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB41A08BC;
	Tue, 16 Jul 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157833; cv=none; b=fE2Uww8O1f5zrwNEu8MZy5LSBykHgd2nC4kxZb6MhPTTZ5PBDU3WXMuheMpTjskhA/9cIXxITdTonSM4ZP9+2gtoUZ1dyrv9isz/8sw4+vZHBJkn8jUfM/BZcA/DAI3F50md0G79gS/ZNeAeTbrh9A3b8WnUNj/5sPpxL0Y8Eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157833; c=relaxed/simple;
	bh=MZvtKV7MyIYgeewUbYxyMqnRijB/ZV6O78sV1Lbrlpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ct8tbfiF9ypN6KT5OAbTLW2cu/Ckp5OhB3wCIcRKSOoOwQFEo+fFq849PlNQFWz1J1sfzGyAF46Qqg6ueUE/GxENWD8qrIjda3jFQ12OWn3Y0zna8sFwOgeEyWZhbsiOEBmdSLTMSbI5UCA9nEydw40wHfLcNpiiXS5C90rtG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.151] (port=17264 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sTnly-0001jF-9S;
	Tue, 16 Jul 2024 22:23:39 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1103.mail.hosting.nic.ru (Exim 5.55)
	with id 1sTnly-00EFHO-2l;
	Tue, 16 Jul 2024 22:23:38 +0300
Message-ID: <6aee5b9f-ddce-4c95-8f59-712e687b264f@ancud.ru>
Date: Tue, 16 Jul 2024 22:23:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnx2x: remove redundant NULL-pointer check
To: Simon Horman <horms@kernel.org>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240712185431.81805-1-kiryushin@ancud.ru>
 <20240713182928.GA8432@kernel.org>
 <11e7b443-c84d-48ff-b7d7-12b4381585df@ancud.ru>
 <20240715181029.GD249423@kernel.org>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <20240715181029.GD249423@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


On 7/15/24 21:10, Simon Horman wrote:
> Though if it would me I'd just drop the reference
> to bnx2x_vf_op_prep entirely.
>
Thank you for the feedback! I guess I will do so in second version
when net-next open next time

