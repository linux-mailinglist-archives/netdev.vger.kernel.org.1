Return-Path: <netdev+bounces-27753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1577D194
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051DD1C209B3
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29D17AB4;
	Tue, 15 Aug 2023 18:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7F13AFD
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF98DC433C8;
	Tue, 15 Aug 2023 18:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692123355;
	bh=ue+DHnTWogh9x4/wbN+kqQCpSLUJL/OugkBmklSdLho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nH0Unv+LEriZvrApV2k/WkeQSi3bdh8FvNrUBkAwrVYzmXAG6nMMx6I+sBg6DaruF
	 dJhrtFR9bIcmhusp0/k5LrKqNVAfihx+y3HWpBOWAz/9Q0g0aLifNhV5taCTQvvJbh
	 J2X7SX18elPdH2/Iw6tLBoqegtwITQTVZANi7aPrBGMWZHLZ31ut16E2/m3oHocX7j
	 81+a2dz71Fs9727zz5LhTmifzRC5qfxAoxC2eD5NbqIelpxJQlkEmrXrQ4SCuerCz6
	 VViGN4ojbdzT8PwSfJqOChi9JI8dNqr9vLWUCMNYQWnAnXfawO8vrgwtWkfrE7mss4
	 1SzYNaZ+0rygQ==
Date: Tue, 15 Aug 2023 11:15:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-08-11
Message-ID: <20230815111554.7ff6205e@kernel.org>
In-Reply-To: <CABBYNZJmkOpPgF6oox-JAyGAZRxzX7Kn9JQpLPXi_FR=Cf-FOA@mail.gmail.com>
References: <20230811192256.1988031-1-luiz.dentz@gmail.com>
	<20230814164546.71dbc695@kernel.org>
	<CABBYNZJmkOpPgF6oox-JAyGAZRxzX7Kn9JQpLPXi_FR=Cf-FOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 10:59:35 -0700 Luiz Augusto von Dentz wrote:
> > As indicated by Stephen's complaint about lack of an SoB tag,
> > it appears that DaveM merged this PR over the weekend :)  
> 
> Ok, since it has been applied what shall we do?

Not much we can do now. Make sure you run:

https://github.com/kuba-moo/nipa/blob/master/tests/patch/verify_signedoff/verify_signedoff.sh

on the next PR.

