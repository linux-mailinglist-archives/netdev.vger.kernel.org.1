Return-Path: <netdev+bounces-48971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB87F03B9
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 01:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6DA1C20878
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 00:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965261848;
	Sun, 19 Nov 2023 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4Yar2rv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849017E8;
	Sun, 19 Nov 2023 00:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D6AC433C8;
	Sun, 19 Nov 2023 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700352093;
	bh=UswlqZPwAXhTVxY1YgDFPc5Vs0O4sCxJ8Ap4WTkwVQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S4Yar2rvVJuDvkoohWoSJKHh/LK0FgcdewDPwXy0WE4R9Q6vN4qfhvuiPPNQIDpGo
	 B23Kimu4pjHY3pADAmNV9MWxa3blPGP4XbdsU+tVfrdx+LfvA97GsCVN4uOZ/sDaFo
	 waSxbqenZaRyqQPibezzgg957pTDQHSYn89yfhbJ7u2DjYASsPjttl/wG14oBWpq9R
	 Jvo1LnlPt0mONssTAOfZT4HrL0XSZ7b4SmbEc4tXtQCImrsvADfQ+w9EqKqxgYl/Z2
	 e+nEnwM8hpQR74QvBjOqMOhsOmjzhj+RLR0yN9IXW5V++4CpiZkGDf+i5Xht1ODn3e
	 Gdilz/nSnwOQQ==
Date: Sat, 18 Nov 2023 16:01:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] netlink: specs: Expand the pse netlink
 command with PoE interface
Message-ID: <20231118160131.207b7e57@kernel.org>
In-Reply-To: <20231116-feature_poe-v1-6-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-6-be48044bf249@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 15:01:38 +0100 Kory Maincent wrote:
> +        name: pse-admin-state
> +        type: u32
> +        name-prefix: ethtool-a-
> +      -
> +        name: pse-admin-control
> +        type: u32
> +        name-prefix: ethtool-a-
> +      -
> +        name: pse-pw-d-status
> +        type: u32
> +        name-prefix: ethtool-a-

The default prefix is ethtool-a-pse-
Why don't you leave that be and drop the pse- from the names?

