Return-Path: <netdev+bounces-130915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9AD98C086
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727941F24C3F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9D1C8FCD;
	Tue,  1 Oct 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XN6BPNkF"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E791C8FD3;
	Tue,  1 Oct 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793772; cv=none; b=N4pr8d5FkRc5MwJZJ6+X2oF18dNLQr36/lKgAHtivcU/qVvuVsAqfoUALalXGVz1j/9JEUT8aTrRVZNQz6Omula88bLSEfpM1FQS66PzLAHsd1LjodgivhKAwrLwlMLNEk75cjJgQL2eUBqSJVtLs5JAliCEN9VxA9WrbSLyB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793772; c=relaxed/simple;
	bh=U4GrEghVoP1WN9uwqwp45RxPINrOjl761dTu1qHdNCc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7YKMcUILuTSCt4Ds8Jjt3haUErycXZKqhkQJ42ndXPPU2H0YNg4doYyoTSx83bcyUkuSYJX00dfmX08c6fjNbYAb56qrGy+oT6olFymk/YqTlznrboeC60CN/dzANBmsdSynFKTWqvnCdjGxUbEVfgR4uX09j1t6Igy9nSWuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XN6BPNkF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9C76142BFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1727793764; bh=U4GrEghVoP1WN9uwqwp45RxPINrOjl761dTu1qHdNCc=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=XN6BPNkFADZoRUYhm3gYb9nE4a6jOibDgCxDUgz/w+4Ko/Kxrx9CRPS6gVMzvwAB/
	 OUlMpj+shX3IyESDPQvmaZCWXD08ZLq0liw4ChG9PxrvHWe8Iq5zPJZ/pn46GgW7IS
	 bhgiF9bKRgu+OLrmpaNW3byySrFGhGJJUHI6yzt32CkcF58d7ASmLD31LsRcZOOpEl
	 LohVhStmBOgLN96gs5QbuEpgmghley9GUOJOq6jbDDbKVSfkeBhVQzUN7HeMiLJxfQ
	 2WNr7DSIfUcfSJ7lvrcq9Xg1K1Q96B3JE4owKtkBPjPGEStg/QIEQ0eEJ6RzW6W0p2
	 Agzfm1v+op0Jw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9C76142BFD;
	Tue,  1 Oct 2024 14:42:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: nicolas.dichtel@6wind.com, linux-doc <linux-doc@vger.kernel.org>, netdev
 <netdev@vger.kernel.org>
Subject: Re: Doc on kernel.org
In-Reply-To: <4d6edf70-57fb-43a1-bf15-330bd5f6405b@6wind.com>
References: <4d6edf70-57fb-43a1-bf15-330bd5f6405b@6wind.com>
Date: Tue, 01 Oct 2024 08:42:35 -0600
Message-ID: <877car7ulg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:

> Hello,
>
> I'm not sure to address the right people. I wonder if it's possible to remove
> some obsolete docs from kernel.org.
> For example, the ip-sysctl page exists in two versions: txt and rst, but the txt
> version is obsolete (removed from the kernel tree 4 years ago, in v5.8):
>
> https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> https://www.kernel.org/doc/Documentation/networking/ip-sysctl.rst

Everything under that URL is somewhat suspect, actually; the best thing
to do is to look at https://docs.kernel.org/ instead.

I agree that it would be good to clean up that stuff, I can't do that
directly, but I know who to talk to about it.

Thanks,

jon

