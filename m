Return-Path: <netdev+bounces-220723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5DB485D0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA373AED57
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3152EE29F;
	Mon,  8 Sep 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="Ko96LrMR"
X-Original-To: netdev@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439582EBBAD
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317148; cv=none; b=JbEXRK5ZOx4D7IrwusF382dq1cqBvoa4aBLgDN47Spt4oBENJSXFA+KVtQo9MjLqxqq6ZIDXUtkNEScA2qIsoKfbXANUqU+C55O161lJqdb7g6AcM/kILJCJWjENGCjLz+TqSy9hem5qG99lwN7U80W+Ed4odOCHtFS9QTw2uOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317148; c=relaxed/simple;
	bh=d+1NzY41ieqsgQaA2F9pO4XUTWm0C2biPQvwyg8eQ6I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UtQ9OhA0vOfaLyVmg/qV2nHxJOdQqVG6qd3OWB5SmMYNhZIGPaqC55uu+upIDfBIoZJB6O9Bb+PdvMpTpEEk1hDzkszUOdHFPLZJwI2NAcT+37goHdMxI3G8mKFAzG+hI5C/Pd5LAGtXK7fNxJ9N91EcuJCHLSSTlPT36HU2wN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=Ko96LrMR; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3928:0:640:8b00:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id B4E7AC0EBF;
	Mon, 08 Sep 2025 10:39:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xcfArBfM8iE0-K2ZAI4bS;
	Mon, 08 Sep 2025 10:39:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1757317142; bh=d+1NzY41ieqsgQaA2F9pO4XUTWm0C2biPQvwyg8eQ6I=;
	h=From:Subject:In-Reply-To:Cc:Date:References:To:Message-ID;
	b=Ko96LrMRgDOGJIKaMHdagjqliyEy1pBEQHF8OFb4a87WaR3iFiIeOJtn63WMDnyN6
	 OWbXQsPmfcBZHCAip7YgCuF6tZkVH3WGrzFIlcl71hHdO5aJmalTT/KlpfQo0kHNJa
	 1c1d9cYIefCdjiOxCS8Y1VcTnO0QdAiEA0Op0st4=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <7e463b05-ae28-4a98-b8fa-bdff266aa62f@0upti.me>
Date: Mon, 8 Sep 2025 10:38:59 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rmk+kernel@armlinux.org.uk
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, kuba@kernel.org, matt@traverse.com.au,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>
Subject: Re: [PATCH net 3/3] net: phylink: disable autoneg for interfaces that
 have no inband
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey folks, this seems to have regressed a different setup: I have a Banana Pi BPi-R4 connected to a dumb unmanaged switch with a 10GbaseCR cable, and it fails to negotiate a link with a21202743f9c applied. Reverting it makes things work again. It seems like phylink_get_inband_type doesn't handle base-R modes at all? I'll maybe have some more time to poke this myself later this week, but throwing it out there in case anyone more experienced has ideas.

