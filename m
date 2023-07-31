Return-Path: <netdev+bounces-22787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516B76942F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A728158C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD91F17FEB;
	Mon, 31 Jul 2023 11:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985C17FE9
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F73C433C7;
	Mon, 31 Jul 2023 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690801562;
	bh=ptlIcexTGVAfKLriVP8hRGXIwt03DC6igntTMUD3iYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QY+fzNiknKbMqKurxTra3/t1BBIpTMsFgsHUgrlM4OQrBmY5OD1APtsgiMf0c8HuJ
	 KK85gG0C3fzBIKl78RxTmKPpSfWFd26/IGaQwD6Z9OrcIw5DDoKnVZgUsu+rPhMqY1
	 CLh0SCAgaNKv/Jqr8j8Hd+Tod4yraqBROspUraO8=
Date: Mon, 31 Jul 2023 13:05:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: require EXPORT_SYMBOL_GPL symbols for symbol_get
Message-ID: <2023073139-sleet-implosion-a1c5@gregkh>
References: <20230731083806.453036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731083806.453036-1-hch@lst.de>

On Mon, Jul 31, 2023 at 10:38:01AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series changes symbol_get to only work on EXPORT_SYMBOL_GPL
> as nvidia is abusing the lack of this check to bypass restrictions
> on importing symbols from proprietary modules.

For the whole series:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

