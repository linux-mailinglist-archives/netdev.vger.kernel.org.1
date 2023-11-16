Return-Path: <netdev+bounces-48432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208EC7EE531
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB6D2810F9
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937D2CCBC;
	Thu, 16 Nov 2023 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zUupdeqo"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6CFAD;
	Thu, 16 Nov 2023 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RQpjx3xss5JoP0672H6uZ18yK44pM/h/GVN/t8dBRd0=; b=zUupdeqoR0t918i860g0uC1DqU
	xxvNzeUzj9F5kUBxyeZT/Ji6cezvSWagc5KeDDX+LUJxjLdII+LM5Z4OjR1e7ZeDKO0B57LgkrP4U
	84tuXL/t99DwiMwWpOqQFz2GVc2r3uQCHgomervUIlfFvbj5Vc3WG/pzoA8R0IDBEA0PGPiOxk1kE
	uAKDACBWI6VqlOIpxcjfC7+pLmEPzHhgn2X0ROtVkzjTxdS1fkOp4jKwg3TNBomRhTcof1rZm4Tdf
	qJh0F/sd9bKPW+3YXrZ4Epw8wjCYqxE0OSyLSrTZRjkyltKOic7hmuIOEVZW9BEKCiUnPjiXkgER7
	a2U6Cgdg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r3fGP-003yFA-3A;
	Thu, 16 Nov 2023 16:30:45 +0000
Date: Thu, 16 Nov 2023 08:30:45 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 7/9] firmware_loader: Expand Firmware upload
 error codes
Message-ID: <ZVZDtfSM35gSjdQo@bombadil.infradead.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-7-be48044bf249@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-7-be48044bf249@bootlin.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Nov 16, 2023 at 03:01:39PM +0100, Kory Maincent wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

