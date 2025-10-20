Return-Path: <netdev+bounces-230954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE03BF25F9
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAAC3A2315
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02249277C9A;
	Mon, 20 Oct 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r1s/IDur"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD31A00CE
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977211; cv=none; b=d9lE6tjoeTPfpuvWX+jt62/qDfmlPXoKo+fEN3+oumxYHh+xYZNp/tcsaeOW0zx1ZG1hzpdyiBc1sFr5H51LtidovXeGzv7B5k5VN4ykthEz6rilwRAWEifpdrugxQj9IPC1Ij1nTABeBahnV6gBRz3q1NNzgNruh7WPiH/JjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977211; c=relaxed/simple;
	bh=pdNdX8v1MDSFRZMV5MT0COvMukViATiBkBIZqPzZEFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ubszx14Xi8M2qC/ZllW9Nzvc0sHb87dXxBSqnqCiv5Ja347jljogfnJUqxpyas8GGW/WblhdPH9/ICcmdiMIcFHkW3GOf/TT2rd7EysTbp0J2ZJk6GjQlXYap+QBvMQHOB9jwfZBY7FhNss7pN6yvhtryt5Ee3NaoPuNaec8OJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r1s/IDur; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 07D551A1554;
	Mon, 20 Oct 2025 16:20:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD913606D5;
	Mon, 20 Oct 2025 16:20:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22272102F23D4;
	Mon, 20 Oct 2025 18:19:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760977205; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fOomjV5+2NrTeZzvTi7Ejxa4gGP3QvNxT8vT02HLQ4w=;
	b=r1s/IDurZZo0wyVbxIZ8mPpkdWocznK/4SdGv78TMT3f09s2mlZxT8QR8A17H/I1xUuB/7
	n3j89KOCvUseDx+LOf2U+bPosjA3NTu+QJBkSX8QACfRZ2IusBQhb6zVKOihi/vECBqfWY
	LUBRIgN79+u/OUFZcEpus1MVcAnf9CVu31/CrAmEWBVLiEE6kIyyftyIJ9FDElipImd4rb
	4EcnKdmknuN5a+TM3XAAL9ZeWdDZVdkfPHH1829FvPSPeC7xGf5ayKDICCSRS7hhIbpMxK
	zybYnqs2lNOsJagmLYout9BRKjhMxYJVfFXibD0KzdwMhE8WjnjI/GAGrNmuuQ==
Message-ID: <ba2c0a35-eaad-4ae7-a337-b32cdf6323c6@bootlin.com>
Date: Mon, 20 Oct 2025 18:19:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/4] amd-xgbe: add ethtool phy selftest
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
 <20251020152228.1670070-3-Raju.Rangoju@amd.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251020152228.1670070-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Raju,

On 20/10/2025 17:22, Raju Rangoju wrote:
> Adds support for ethtool PHY loopback selftest. It uses
> genphy_loopback function, which use BMCR loopback bit to
> enable or disable loopback.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

This all looks a lot like the stmmac selftests, hopefully one day
we can extract that logic into a more generic selftest framework
for all drivers to use.

But in any case, this looks good to me  :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


