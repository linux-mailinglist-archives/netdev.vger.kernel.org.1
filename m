Return-Path: <netdev+bounces-147395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642859D960A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281972870F8
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991A1CDFD5;
	Tue, 26 Nov 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="sm1Eselv"
X-Original-To: netdev@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660407DA68
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619634; cv=none; b=n2cLUs+fkEDFmVQbuw5EE5DENePmxoVSrKRqa52fYDH0+hS3yLrLS106u4sJGXOrXMBCWQNEfMU2hhCjNu/0r/aMNI9l3hCUfh6Q1sqySSaBL6SEMMa6pNdLssAXdfVkKziD2gp1J4GeaWQhtf0rNQd3qx8xHBKHSqPNtGErC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619634; c=relaxed/simple;
	bh=yU6qBgdihvrhSYweQuYV9vc8GNthC8DHVUQ8KNp0IkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEE+aO5XGLbjFPialIzB8MT1HDTB/Jwske16LwGM5dEQF7zsATdERIofnNlaRgpjUJYIPUcr4gOqrsBJmITfEGm9ZYYzdrFDHMbXM1u0lSYtBqwz+JDhi/GJFT2L2nLEpFP8YrxpYcJXHNORwk76Yzvyot8H6ehCLzURt4Zqq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=sm1Eselv; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4XyKhF0zglzPjkv;
	Tue, 26 Nov 2024 12:13:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1732619629; bh=j6Y9+6uUJ2Pa3GHmjyF8UDGNT1ROWiLZ/MbAIp1zEgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From:To:CC:
	 Subject;
	b=sm1Eselva6Txl3Whpf4JP3L2p5FMYCoQIqqhH8xI3S4B1kxFEX2a2HyYQjAgHi6hl
	 elTbKNop4ZNfCZ5KwW3PmV5p8o+ygaPpRrUwM74+4N3ZHGX9fD4r+JHmxAa9l5SL0k
	 6/2G2/skoQN+2EmDwRZFqkoUaA7C54d9XISLKWCV2MyXI20iVo14ZMMLflCIby4c6U
	 hoVHPBryizhM6MHm3z4kd2pt0pt70muDyzLJqT5aZ88mR8XGwuBdElvCxIRa5LPSo4
	 lNUjFadwiA6e+N74J/m33UDuPW8wn+/s9BgURBkWaIzeJrXmPsn3ASyE1ofN7CXB6F
	 YG+JEeoYjBTrA==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.37.42
Received: from [131.188.37.42] (faui7y.informatik.uni-erlangen.de [131.188.37.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/T7Jnm08JeNSfSsX2RBua6GarexAPDcPs=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4XyKhB2yHMzPkYx;
	Tue, 26 Nov 2024 12:13:46 +0100 (CET)
Message-ID: <8e01759d-02cb-4601-9d92-7b6526225915@fau.de>
Date: Tue, 26 Nov 2024 12:13:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/sched: netem: account for backlog updates from child
 qdisc
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20241125231825.2586179-1-martin.ottens@fau.de>
 <20241125161222.40448603@hermes.local>
Content-Language: en-US, de-DE
From: Martin Ottens <martin.ottens@fau.de>
In-Reply-To: <20241125161222.40448603@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.11.24 01:12, Stephen Hemminger wrote:

> Does this also address this issue with running non-work conserving
> inner qdisc?
> 
> See: https://marc.info/?l=linux-netdev&m=172779429511319&w=2

The bug that my patch fixes only occurs when netem interacts with 
an inner qdisc like tbf, the behavior when netem interacts with its 
parent qdiscs is not changed by the patch. 
Therefore the patch does not address the UaF bug.

