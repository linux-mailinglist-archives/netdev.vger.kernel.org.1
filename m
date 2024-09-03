Return-Path: <netdev+bounces-124620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070DB96A39B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6821C21348
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB51189536;
	Tue,  3 Sep 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Q4ecfTA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2937462;
	Tue,  3 Sep 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379630; cv=none; b=GF9tPPqzoObvUaMfek/bdUDZubzJw/mUzC/ThDPtWo8OikXiVAoAMI9L1fs5tW0F8cFTWHTaUnfyEqUNFEzUHTSopPgiwBljF/xizIrqPrJ5Pefl5z2kxOBLb5NQhWCiTHXSJflWqAIom4a+DYYfWTuMMAJzQMT6zkYaVwXIZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379630; c=relaxed/simple;
	bh=ZK/1w6Ap/OIkmGOTQs+JfOp4gTkKRiP9LPHx30+PPyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFE3BRmLcEq+P3hHgigEVT0W9Rr+85HXKVIsE4j8VpwPAa0BxAB1ytvCJ2uWmZZV/bBMmNYA6gObJ+EjJ556ac3YV2WH/DQFLiYj+EKV9wOK0FUgDri033Y+ol5qSF0BU6JHqmdJYE0Yz/VtP7mDJAJ5qBLGqQSGpE+7pDjdXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Q4ecfTA2; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 0E3BC1F92C;
	Tue,  3 Sep 2024 18:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725379623;
	bh=ZK/1w6Ap/OIkmGOTQs+JfOp4gTkKRiP9LPHx30+PPyE=; h=From:To:Subject;
	b=Q4ecfTA2JU91IHhHBvgMxs6J0idLbj/P8pl/0ig/63RIjK4KRcOcoWCI/HQopswfh
	 TQL8S5r5wJvo/eR4Rq7he2kHt4qmizNEhWwjF9EFD+/r8egSTfTXCRGx2g25rrJXhF
	 zTcTexme7k5u/UyOZriYfHfg7389XliTLMONjUc5AipczA6kYqO12/s7qKvxmkrF4H
	 NI368XqJTQ9x7zncW4JJ4p/VsYfYWk9jOlWofTMLHVdPe1dkQYGGazVjT0sv0tWD0t
	 uAStGIMNqv02noxLa3A46gp8IlKxjlJxOL1JKWpQLZED8qdQnXjY0XXisUpeSFs/mO
	 W/LUGOqWw23mA==
Date: Tue, 3 Sep 2024 18:07:00 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Francesco Dolcini <francesco@dolcini.it>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Linux Team <linux-imx@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 0/3] net: fec: add PPS channel configuration
Message-ID: <20240903160700.GB20205@francesco-nb>
References: <20240809094804.391441-1-francesco@dolcini.it>
 <311a8d91-8fa8-4f46-8950-74d5fcfa7d15@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <311a8d91-8fa8-4f46-8950-74d5fcfa7d15@prolan.hu>

Hello,

On Tue, Sep 03, 2024 at 04:10:28PM +0200, Csókás Bence wrote:
> What's the status of this? Also, please Cc: me in further
> conversations/revisions as well.

I am going to send a v4 in the next few days to address the comments
on the dt-bindings change and apart of that I hope is good to go.

Francesco




