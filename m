Return-Path: <netdev+bounces-53501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAD803625
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9032F28103D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0E286B3;
	Mon,  4 Dec 2023 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e+X/EkRx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD135FE
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+wJpETgGcKbutG1ffO0VnoD+7J7Fap7n0Qtx/h2mSI4=; b=e+X/EkRxXr0esqk8qg6j2iTY1g
	LqTu+YSlnHJCudoObiSbdevQAvAtMAYaSVXsHdo3wedkDaSvoHL/FKBBtxvCnUZzZjTbFDTlyoLcL
	T2Hsm6yPZyzg+Eqe23rwLSS2WmzfZwsCAmSGqmnoDRtC+nqrcd5tn21GEvQHY3QUUt7s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rA9hS-001yqO-7n; Mon, 04 Dec 2023 15:13:30 +0100
Date: Mon, 4 Dec 2023 15:13:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: mvmdio: Avoid excessive sleeps in
 polled mode
Message-ID: <1105b591-567f-4fcc-8cf0-5e83f11d89ae@lunn.ch>
References: <20231201173545.1215940-1-tobias@waldekranz.com>
 <20231201173545.1215940-3-tobias@waldekranz.com>
 <20231202124508.3ac34fcf@kernel.org>
 <87a5qq9wow.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5qq9wow.fsf@waldekranz.com>

> Looking at it again, I think I was too scared of touching the original
> interrupt path, as I have no means of testing it (no hardware). I will
> try to simplify this in v2, and hope that someone else can test it.

I have a couple of kirkwood machines which have the interrupt. So i
can test this.

    Andrew

