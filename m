Return-Path: <netdev+bounces-22917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3F276A03A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F21C20C8E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED51DDC7;
	Mon, 31 Jul 2023 18:20:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755731D2F8
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD9BC433B9;
	Mon, 31 Jul 2023 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690827601;
	bh=AL8IQvRuROckVk8brJfkavPt8PtZd1aJDIS2DkRo6uA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oxEq1KPXwyVC1XodEZWtEzrbM+XLI07D7cJOSKzt1Oscom6oVTU1lwGFJPA5F6uBJ
	 6qL57Cigp7iSIR5GUFKTHhgLDYNw3s54jdNApWbMEkaJC1YsJcasDjaQaL1O05SJLG
	 Ic7ZS7rI9/EYJGe/xRS02qJvdI7YVFP9rsSQPB3ATnZHbcgg4UREZfWCOip439fA4E
	 LsoQccIbooMH6I3oBljrgyoic0cSzMrliwPNcPedoz8+sg+mqGYXJLTuIN5Bcm0RX9
	 QVLPR5U1qki9AeiFZHYj3Cx1t+mlEniOJJbXyxG6y60zJggaAbh70ayc3X/OvNqKg2
	 QSiXoG2n1eSnw==
Date: Mon, 31 Jul 2023 11:19:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Mack <daniel@zonque.org>, Haojian
 Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>, Joshua
 Kinard <kumba@gentoo.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org (open
 list), linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/5] net: enetc: use EXPORT_SYMBOL_GPL for
 enetc_phc_index
Message-ID: <20230731111959.7403238c@kernel.org>
In-Reply-To: <20230731083806.453036-3-hch@lst.de>
References: <20230731083806.453036-1-hch@lst.de>
	<20230731083806.453036-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 10:38:03 +0200 Christoph Hellwig wrote:
> enetc_phc_index is only used via symbol_get, which was only ever
> intended for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
> for it so that symbol_get can enforce only being used on
> EXPORT_SYMBOL_GPL symbols.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

