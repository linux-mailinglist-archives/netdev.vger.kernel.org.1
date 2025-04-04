Return-Path: <netdev+bounces-179380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E97A7C349
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 20:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF5189656F
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B12208978;
	Fri,  4 Apr 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqVofHKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86500BE4A
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743792085; cv=none; b=nKn1KGCAQ5dsJLit8ZzfLw7L16yTHDs1/rwSjlVBb0X0UBQUIgd/7VMiHAK4ZXyDwzmnyNSmzjnCKv5NixvenL4MEeHsXQg7dFXE5ABJKqNEljeZcLkFFqKrRKowrq4xKiKV8broVaUmAhDyhiSBjQDajzAovrKpyjyRdsilUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743792085; c=relaxed/simple;
	bh=gBEOgWeKM/0hCXmGF208DkDsYqOpuh1zhf9k5TG/Bss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CreV7/Lt65GPYicGluTLZ5uW3xKVrMfVdIBnhy6mxZ33nilPdzbyfO4D9YUT/Qmv8aqf8aFZwSDpKpnP/ekgTgxtV3H+Mt3W2gw2cPcjmQ+E+huRyyjUwdirG4LWz0ExQ9C/xV2ehJAz+0fpyAQo899iL7Hjiwkw/ogwZxFDN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqVofHKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2812C4CEDD;
	Fri,  4 Apr 2025 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743792085;
	bh=gBEOgWeKM/0hCXmGF208DkDsYqOpuh1zhf9k5TG/Bss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eqVofHKhxXWExLNJwzaIo6YTo/c/C3AR9QM5hD9/6CLh2d7i5BzqDarGrHGqFKExv
	 HzeuRgJ1TxlTb21h235o3nNxw0UVijsjWUdNHYyG8h3p0er+VmnOSGhjffTyWi6iDz
	 mbvwPg2bJEgslsAaw1FjLgnJ5L3Yz7Sf3rU33kPbis7ufSSprvQNUqdecU66vCTr+q
	 ToWhcJYh7LnwVp2IqWHdPuNmzY8LEG4R819O5gmBvFFkPoNHErXFXnl06DdTH/DDn+
	 GUI4/x3GBSQJ/QXcrpoSeyrTbI6/vo/fMzr/3xTPSdy5e9WGoS8Rl1wbCo+IZurLcm
	 KUEzcAoMaEbzg==
Date: Fri, 4 Apr 2025 11:41:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [Patch net v2 11/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with ETS parent
Message-ID: <20250404114123.727bc324@kernel.org>
In-Reply-To: <8bd1d8be-b7ee-4c32-83a9-9560f8985628@mojatatu.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
	<20250403211636.166257-1-xiyou.wangcong@gmail.com>
	<20250403211636.166257-6-xiyou.wangcong@gmail.com>
	<8bd1d8be-b7ee-4c32-83a9-9560f8985628@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Apr 2025 13:59:39 -0300 Victor Nogueira wrote:
> On 03/04/2025 18:16, Cong Wang wrote:
> > Add a test case for FQ_CODEL with ETS parent to verify packet drop
> > behavior when the queue becomes empty. This helps ensure proper
> > notification mechanisms between qdiscs.
> > 
> > Note this is best-effort, it is hard to play with those parameters
> > perfectly to always trigger ->qlen_notify().
> > 
> > Cc: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>

Hi!

Any ideas what is causing the IFE failure? Looks like it started
happening when this series landed in the testing tree but I don't
see how it could be related ?

