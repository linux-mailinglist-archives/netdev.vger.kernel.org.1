Return-Path: <netdev+bounces-207891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5584B08E7D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A584A69E0
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C9F2E542D;
	Thu, 17 Jul 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnSEsC1v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF31291C1A
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760137; cv=none; b=EXarmKtrcLnHoG6H+7DyIEAT/wiSJ7KGrUhCwWqyoBEoh31ZI+wT77CxM0h9l+ssYU1lI6jMoXeXGeiBhPOVsICS8HIw3BX+4Qcw+NAiVSMoQ/AHv9EI09FDJO/J+XSPpiNusxYa84lwD1g7bSTLBUTcF9NwtiTJUfjnqcyxZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760137; c=relaxed/simple;
	bh=QNLDHEkTtJmWG5sdS7uffX7epbi/RQaKZJYa2PsawY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qkd3EIXqzlq3Ad1/M9iWF38ijqzGWwyJQ0xmqW+9vTxdlmluO+Ew+K3Nqge+AsLULtw7B3JUwlMUE088pn1isiKn/y3x5QiOZJOXWHa5xC6z3RQ8631PZ+fBouhuYgFODJr9QkSOX3QHmIGDPTBJONEI0WlTCl8ATFoWGWKX4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnSEsC1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF0EC4CEE3;
	Thu, 17 Jul 2025 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752760135;
	bh=QNLDHEkTtJmWG5sdS7uffX7epbi/RQaKZJYa2PsawY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnSEsC1vGHbjwRqj+yvowm6s5WCG7aIfzqxHs9xbLHGPDM/asL6W/gERS5fgpSu1V
	 y952j9kpsO/cm9O1zq6aNlgGggXfXToNzzbXYNkH11UVoyXQThZTB6pUWMofppTUzw
	 ECY3winfAGbi1g/S0VmjyEXuTM61fBor1ZDWmVZa99BvdVUpG4EMbLiBc8K5ASisF4
	 Tr8T9uTiv+jbJZpw5+9WUCFkhCCuniYSDHK/GApPuokPlHKEwWnsuCX1F2JII0Dfn1
	 gvWSAhGGuWFXq+67lgpmhfh1yntg8UHBnnTHBI6G12e0E1vG3wTBThe+exfKvAyeij
	 W2gWUIDOis12A==
Date: Thu, 17 Jul 2025 06:48:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?57uD5Lqu5paM?= <jjm2473@gmail.com>
Cc: netdev@vger.kernel.org, Frank.Sae@motor-comm.com
Subject: Re: net: phy: Motorcomm YT85xx reset issue
Message-ID: <20250717064854.14ecf4cc@kernel.org>
In-Reply-To: <CAP_9mL46Z3kwaSdyCAaEd0iugDEyva6FMBXTPjDhyuWfKZc+7g@mail.gmail.com>
References: <CAP_9mL46Z3kwaSdyCAaEd0iugDEyva6FMBXTPjDhyuWfKZc+7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2025 10:30:36 +0800 =E7=BB=83=E4=BA=AE=E6=96=8C wrote:
> nanopi-r2c has a stmmac, which uses clock from yt8521s,
> `ip link set dev eth0 down; sleep 1; ip link set dev eth0 up` will
> trigger a hard reset on yt8521s (`reset-gpios`), but
> `motorcomm,clk-out-frequency-hz` is not applied after reset, then
> stmmac die:

Is this a regression or you're trying to figure out how to make it work?

