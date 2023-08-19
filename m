Return-Path: <netdev+bounces-29037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A57816F3
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F5F1C20E73
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B81ED8;
	Sat, 19 Aug 2023 03:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59447809
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 03:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D00C433C7;
	Sat, 19 Aug 2023 03:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692414277;
	bh=dtcSBqES1UkgU5PoDaxyBlcDC3X9l+cuo4Sw6D6v6nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SKnpmp0yLplFyU3x2+hX/36Mm9NYcONHjrrzWcHZLfKdDRRV/+2Ny9j3KEET3eJuC
	 M29jaWONetMZ6KabOOvmCGspIzVG4Y9tyXBIIjbJ5fjXsJpZzRRasOyO9npDMvK2vP
	 8fIf8Qh9xXQwiIvFV23Gp0QjC/cYQKlasasRHOacZ8Bveiyz18M3Up35/AIBPXIxDC
	 3j9tMziOWYmsR/vsMynylYUg6gfFjJ1vSI3lxGuP+MtSpu2lLrgEbysQrDixD0coxu
	 /349Q+sKCt+3yyrG8H3z4R0Mct4xrUWKbUl7AMPbxOsgphoCRS+7utzKpdC/bAamhF
	 nUJOAEiIsO+KQ==
Date: Fri, 18 Aug 2023 20:04:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: annotate data-races around
 sk->sk_lingertime
Message-ID: <20230818200436.7625c590@kernel.org>
In-Reply-To: <CANn89i+2_exCdN=qMGJ=cYmpx9P58am98nW5x4fju1PpsMFW_Q@mail.gmail.com>
References: <20230818021132.2796092-1-edumazet@google.com>
	<20230818192850.123e8331@kernel.org>
	<CANn89i+2_exCdN=qMGJ=cYmpx9P58am98nW5x4fju1PpsMFW_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Aug 2023 05:03:47 +0200 Eric Dumazet wrote:
> > net/core/sock.c:1238:14: warning: result of comparison of constant 36893488147419103 with expression of type 'unsigned int' is always false [-Wtautological-constant-out-of-range-compare]
> >                         if (t_sec >= MAX_SCHEDULE_TIMEOUT / HZ)
> >                             ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
> >  
> 
> Ah... I thought I was using clang.... Let me check again.

Could be a W=1 warning.

