Return-Path: <netdev+bounces-50933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4EF7F792F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 17:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B84B21235
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5D2E83D;
	Fri, 24 Nov 2023 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVPeKQw/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AD381D2;
	Fri, 24 Nov 2023 16:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DE4C433C8;
	Fri, 24 Nov 2023 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700843758;
	bh=81UaCbvzEewXtgJlUNfRbHsaHofBH6A66ylN8DLvIiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVPeKQw/bPu6BhhgtDIyqtRg38BzBzz66/kYT2nDsJWD0DaHJ28JcTCzNMNxQt5hC
	 CJWNgL2YhgfjqPQ3Fv/dNQAXJmvLOIF8AXu1B6JncBeynr7B6w2VVtuqNqSIuA41OL
	 UmLuK1+40trdrn5BXlSW7tQuzNEHlwS5zQ38Li4X7+6k5iPTd16tYx2xEmWPiUIAGP
	 TjcO3Mfabu9ac5j7sTudN4i3cnrKgSmCMpkDdyAc6WvPJCzcxosWGnHL+Z6/mK2ny6
	 H3MN0imC3UZl30O57BsYjh1OTDOvUKEU/o7o2V4qz2Y2On2Z2EPone7/jOZfj2Frh7
	 d5mzQxnikU1Fw==
Date: Fri, 24 Nov 2023 16:35:52 +0000
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/9] net: pse-pd: Introduce PSE types enumeration
Message-ID: <20231124163552.GR50352@kernel.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-3-be48044bf249@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-3-be48044bf249@bootlin.com>

On Thu, Nov 16, 2023 at 03:01:35PM +0100, Kory Maincent wrote:
> Introduce an enumeration to define PSE types (PoE or PoDL),
> utilizing a bitfield for potential future support of both types.
> Include 'pse_get_types' helper for external access to PSE type info
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

...

> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h

...

> @@ -133,6 +150,11 @@ static inline int pse_ethtool_set_config(struct pse_control *psec,
>  	return -ENOTSUPP;
>  }
>  
> +static u32 pse_get_types(struct pse_control *psec)

Hi Kory,

a minor nit from my side: as this is a function in a header file,
it should be static inline

> +{
> +	return PSE_UNKNOWN;
> +}

...

