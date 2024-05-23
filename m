Return-Path: <netdev+bounces-97801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB08CD504
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F002282928
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73813C3D3;
	Thu, 23 May 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nVQHAj90"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F571E520
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472044; cv=none; b=FOXeNOVvMFzPKtaWBGj9Jo3XUP2Vhl87NdG+KMG8e7Tmjsy221EoypwHcHGjKAzOcBipqVUChjB4zYbRLWMlkAHjMozgDYaJPHBp/24VqcUjUZIJxP2r9qd2QoeQsAXq9V4wGNfxbE/tDwd1FmtNgQwKYvrREXMFSNs5+PC0CDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472044; c=relaxed/simple;
	bh=O632SEV4c8g7DSyVyh4VKG9Pke7ibrTI2shAckEXxH0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=n8PN4Hg2IltR8jz8CSKn6ioWj+0fqmt4/2Vic2TRKY7rL0HhYEc4TH2/BEUwfF5hNM8/LMj6aKr6kHFSoOdf9E17gMh4Ps8uWCti0gKMQZ8P8AI7k00fj/ZguQNGdqNLKkhC/Zj4RMV/ZggT4Y6NY8MQN1eT6QH/8cheSZlHs/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nVQHAj90; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716472038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9jJndIApYA5vF1kJYhYBR4cPc85HX3Ck4s+MnMctEc=;
	b=nVQHAj90/xRKg+f/aCGNkmwjHTrHA710pK51BwJfTgNaqDYxR9ESE08W9TVhoWiFS/ZE0G
	hry/+i2IL9DvQUVDlKb45E/tj2yiLlBWs81C691Fhgr+ODFGR3lDlad6WA90vFdVgRkojA
	rXyG267xyMERxsWTZBTLhObl+qlhPpUZcFqCtEwVAwJaGGPXZoOyowIRk5AQbRlGBa2QKl
	El7FPf1QXEP4omM8TmAybGHxwp2O3CHrQ/odxrMAmmMfHd4GBdhhYpg2k3z/znLc9aA36t
	2lunZq1IC12/pTJHmtR7E5Pjayo7NUoVmJfzhcrfcU/edsUzK8bBRFgFtHE4cw==
Date: Thu, 23 May 2024 15:47:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sirius <sirius@trudheim.com>
Cc: Gedalya <gedalya@gedalya.net>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <Zk9CehhJvVINJmAz@photonic.trudheim.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <Zk9CehhJvVINJmAz@photonic.trudheim.com>
Message-ID: <3435957a9fd5645c2e12c471247cd98c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 15:19, Sirius wrote:
> In days of yore (Thu, 23 May 2024), Gedalya thus quoth:
>> Yes, echo -ne '\e]11;?\a' works on _some_ (libvte-based) terminals but 
>> not
>> all. And a core networking utility should be allowed to focus on, 
>> ehhm,
>> networking rather than oddities of a myriad terminals.
> 
> Then it perhaps should not add colour to the output in the first place 
> and
> focus solely on the networking.
> 
> A suggestion would be the iproute2 package revert the option to compile
> colourised output as default, sticking to plain text output as that
> require zero assumptions about the user terminal. Carry on offering the
> '-c' switch to enable it at runtime.

Frankly, a better suggestion would be to leave that compile-time option
supported, but to suggest that it isn't used until the current issues 
are
resolved, or until some stopgap measures are in place.

