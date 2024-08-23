Return-Path: <netdev+bounces-121434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3695D204
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E871C20E71
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A74184550;
	Fri, 23 Aug 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJwENFa/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73D14AD30;
	Fri, 23 Aug 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428182; cv=none; b=kD66BdaDviLZpQWA1tqG1j7oiedZq8q78iu9efazIcU7f9gq9Oa67QfCPdaE8qYCPSbV4sNGQEKlMw/aEXDZHanQydv6K6wXxtd9gLJoHYaYyLyna0zdp7f2fNFe/2aX8gF1LkDaqyQqhZRgB8qeY4R2VNMTawAa3tATa8V6Lkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428182; c=relaxed/simple;
	bh=I9gc2djIDzPGy0ixSrbc+n8oHPkFzl7mDiSiq44+R/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fybm/ueAJmqdGqca/aNLnL6Rd9/yr/gMoPY3NxanGwgY/pthZ1jiJFPVmQ7S68vW1jkd7NNMut20zG0UYYfpO95q2h40QAieNl6DGQ+TQr9R1RqmCOH1dasa7seZYHgYYUU0bSAIchlqaqNSniqa3XTSxuHu3f4Kwrpz9qjVZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJwENFa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B60CC32786;
	Fri, 23 Aug 2024 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724428182;
	bh=I9gc2djIDzPGy0ixSrbc+n8oHPkFzl7mDiSiq44+R/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aJwENFa/u8ls8c2y1XXiDsilkGYNAeK+s7/WMmfnudXCyvu895QJUOGNcowJj4Bv6
	 4L9/Srr4zOQ/ydhJ0dTAVg8a3nPGBAXTkWh1XIHzgmHK4FZp1EKyf8pkZflIRH9CHk
	 BvorQuIkQZXSdWQDvziuDlWRHzElzCZSw4NmKMXMQuaCC67+CVwyBlNEnD8207DjpD
	 Rfo5DD19UJKWvRJnhBEfQPRktXwsXd++EVgwYPFZrzyWrgRmmgtVLKb70nsGKPSCTI
	 qXUe1TEe/fL0r22F+xrLc97LdIUSOmvtGfX0zSN2nY0Zse3dj8uPpzV++h293tjNIt
	 A71QXt6DOLhCA==
Message-ID: <fa0a7bb3-4030-42cc-a437-716d645e30b9@kernel.org>
Date: Fri, 23 Aug 2024 18:49:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix 10M Link issue on AM64x
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Dan Carpenter <dan.carpenter@linaro.org>, Diogo Ivo <diogo.ivo@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240823120412.1262536-1-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240823120412.1262536-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/08/2024 15:04, MD Danish Anwar wrote:
> Crash is seen on AM64x 10M link when connecting / disconnecting multiple
> times.
> 
> The fix for this is to enable quirk_10m_link_issue for AM64x.
> 
> Fixes: b256e13378a9 ("net: ti: icssg-prueth: Add AM64x icssg support")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

