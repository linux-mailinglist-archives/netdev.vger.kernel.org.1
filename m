Return-Path: <netdev+bounces-127996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C74977732
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6411C242DF
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9DD1B12CC;
	Fri, 13 Sep 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM7BNGin"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960833F7;
	Fri, 13 Sep 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197036; cv=none; b=n01TdLUuQtr2zy2+bH/H0iaF/LxxPahOGVzLohLV9usvlU2zz54lifzuNJn8m1Iam54LnbqfCHOadglSAp4L3XadhLvPvspzcY7yYg/kEOQkxcdRxEzZ12MFKv/QP6w7qdO/abkhXBSfJUK2dVu0SFfFatjLULOyhahqmVz5eR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197036; c=relaxed/simple;
	bh=R8Pv2u3DHGtu8tYmDlWrlFob5oeeSwmyFbr03cJrckI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAcwrbS/yTffbS2CM8+kWc3Ee0n10IHj+Uur7x31Swo5IQIp6E/PAEs1kf8gGFUri+/xtfRW6JC9dl6lO/QDoeYdZqpwdK5LXT6G08spxx1ZeHhM1KgppaY0NNxb4wOTm8fA86xQY1SuSgFl4d9qDkxfQ1eTmQmuJfEBt/EorIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM7BNGin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411D8C4CEC3;
	Fri, 13 Sep 2024 03:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726197035;
	bh=R8Pv2u3DHGtu8tYmDlWrlFob5oeeSwmyFbr03cJrckI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MM7BNGint6truNOTeN5E4xEgXK4rsWAuZEZ24crQn+J9nFLgAdkDfnfLSxZPX9r3e
	 sHvpr069oBj3oskC2k+1X+RNH39ygsgw8qZ+jla7AOAgIfdc3d7PMIhmV/unhaH1D0
	 pfMhSIELYcnSp3YMQwMZA6O7UyyV5z+/NiidZm0YCpApHkSF0YEJ9MPzZ80BMGYuly
	 nirO3PTLUZQdw/hZ9qJUrF5LNyPczoeCcrAb06gEx0fy/Ue6aH1xDNIfaG47CE5n4X
	 6tpJckXfS0TQuynczy20hbXozVU7sNDFn13zV7AYW0ZeSKAMZMwc5Xls80Ig2AWil1
	 z7qbvFIDm3+vg==
Date: Thu, 12 Sep 2024 20:10:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>, Willem de
 Bruijn <willemb@google.com>, Pavel Begunkov <asml.silence@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] memory-provider: fix compilation issue without
 SYSFS
Message-ID: <20240912201034.6ced56f5@kernel.org>
In-Reply-To: <CAHS8izMEzug_c+LYG3=tPq6ARQjsXQqCwkO+t0hPpWiivxTB1A@mail.gmail.com>
References: <20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org>
	<CAHS8izOkpnLM_Uev79skrmdQjdOGwy_oYWV7xb3hNpSb=yYZ6g@mail.gmail.com>
	<73a104e0-d73f-4836-92fd-4bef415900d4@kernel.org>
	<CAHS8izMEzug_c+LYG3=tPq6ARQjsXQqCwkO+t0hPpWiivxTB1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 11:21:23 -0700 Mina Almasry wrote:
> > I briefly looked at taking this path when I saw what this helper was
> > doing, but then I saw all operations related to the received queues were
> > enabled only when CONFIG_SYSFS is set, see commit a953be53ce40
> > ("net-sysfs: add support for device-specific rx queue sysfs
> > attributes"). I understood from that it is better not to look at
> > dev->_rx or dev->num_rx_queues when CONFIG_SYSFS is not set. I'm not
> > very familiar to that part of the code, but it feels like removing this
> > #ifdef might be similar to the "return 0" I suggested: silently
> > disabling the check, no?
> >
> > I *think* it might be clearer to return an error when SYSFS is not set.
> >  
> 
> FWIW it looks like commit e817f85652c1 ("xdp: generic XDP handling of
> xdp_rxq_info") reverted almost all the CONFIG_SYSFS checks set by
> commit a953be53ce40 ("net-sysfs: add support for device-specific rx
> queue sysfs attributes"), at least from a quick look.

That's right, just delete the ifdef. I should have done that when
I moved the helper. Please send the fix ASAP.

