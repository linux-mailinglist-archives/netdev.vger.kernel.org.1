Return-Path: <netdev+bounces-96376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F388C5809
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73D2B22AE5
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3317EBA6;
	Tue, 14 May 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM/yPOKu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95F17EBA5;
	Tue, 14 May 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697244; cv=none; b=hrppoj6nU6Wy1Q/TXlaGquspiEVO3dbFIx2lO/d/uHuO9pIEaVTDXbK8pGVqCNnkOX35Od3RfSbwCdrD173LxKUBsjpkwyzcMVfjCfZbSwZCDVZbqjuoyJfKPSh81+p2IGkgrITiZd2ZHDO0SGw1FNi4LNQfUEei8YfnYRZphI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697244; c=relaxed/simple;
	bh=vp+pb1AL5SqjxH5Mubn4EN8sHuiOw80ODPCTptQGbQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+2TFujbnBXsn0uaJZNs56fOXHJEG7ZIgZLl1uoio760qdGcCLNx0kqW7UMyKzoQ5g8VRw2jPalAuphaZwkJOK1C4hWpbFckW2jqFaPTJZZiGiia/kqrADZpEKhHD7YABCin9cDAR+8ZoA5kPBvmiiONJxOdEe+8qYWbCEY67pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM/yPOKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7639C2BD10;
	Tue, 14 May 2024 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715697244;
	bh=vp+pb1AL5SqjxH5Mubn4EN8sHuiOw80ODPCTptQGbQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PM/yPOKuKbblOVKppmWZiL6Nv4WlTZ4f1hjserq8Aqm8XnshnwVxGgFA1KGwgfbUa
	 t7H2XgKXrHoTC1Y3r2Brh5Pu2PwFfffbxP8IWhcPmvLKRuny/0HNCt4H7A5tDZ26KX
	 X3vBTupYqubWvMvRG/YoioX1qBcokOF3jRiPo7IAlH4UBJN/u6yQTRhNvYNySPcVMW
	 Rfpo7N+ruQWwmTZFQG3PXnAa2yxgaZ5hjo9hCcNy31Rq1uAV058BcxGFeH7Sp6UbiQ
	 HoJNKE2ebd6sECIzoFwyaaDPFD8U1TSlHOtGxSb9m1eD1BT2Hq3awQgmugGdpUtPsa
	 u+g/5pbWf8XVw==
Date: Tue, 14 May 2024 07:34:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, Pauli Virtanen
 <pav@iki.fi>
Subject: Re: pull request: bluetooth-next 2024-05-10
Message-ID: <20240514073402.72d2887c@kernel.org>
In-Reply-To: <CABBYNZ+f8L946_=6RyGvsN3bmu4EwJ2tTgxPg9YmNxckJTc_iw@mail.gmail.com>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
	<20240513142641.0d721b18@kernel.org>
	<CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
	<20240513154332.16e4e259@kernel.org>
	<6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
	<CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
	<CABBYNZ+f8L946_=6RyGvsN3bmu4EwJ2tTgxPg9YmNxckJTc_iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 22:12:04 -0400 Luiz Augusto von Dentz wrote:
> > > It might be safer to only suppress the sk_error_report in
> > > sock_queue_err_skb. Or at least in bt_sock_poll to check the type of
> > > all outstanding errors and only suppress if all are timestamps.  
> >
> > Or perhaps we could actually do that via poll/epoll directly? Not that
> > it would make it much simpler since the library tends to wrap the
> > usage of poll/epoll but POLLERR meaning both errors or errqueue events
> > is sort of the problem we are trying to figure out how to process them
> > separately.  
> 
> @Jakub Kicinski I'm fine removing these from the pull request, or if
> you want to do it yourself, in order not to miss the merge window,
> then we can discuss it better and even put you and Willem on CC to
> review the upcoming changes.

Sounds like the best way forward, thanks!
Could you drop them and resend the PR?

It's going to take me until noon pacific to write up the PR text
for all of net-next, to give you a sense of when our PR will come
out.

