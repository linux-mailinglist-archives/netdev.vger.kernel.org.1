Return-Path: <netdev+bounces-205094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20481AFD4D7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084CD3AA061
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAFC2E540C;
	Tue,  8 Jul 2025 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPhSriLj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B42DCF7B;
	Tue,  8 Jul 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994475; cv=none; b=S13N5tndYMUo7ZLF5zIw9FCCO03Jz8KM49j0ixg00bz7Qw96KE8HObKedmiZzWAve1qrcrrmkN8QYPJ1CFJRB7TSHvnuBF/0YqskGJ64cxcxy+nNsaUw5MvbXPuwtmwAyXc+uL3q9u3gqtkErZo4JZ5t5w34yFl0nJq0gSaoNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994475; c=relaxed/simple;
	bh=QnEG1HbwwQTlmOz8mRAiiw1tW05XGruA++x9Dw3+Hpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsXhtKr0CxmEdZHZZOYdq5xvIwdzuHac4SA0pn4iuk+bWHxuIHguK/S7auLcdQhfT+E2AXFDoOv7yIGUaps66QAfNix+HJ59xEo9gCuTWkXqNydF3aALFovDmt4yIJf7aoJ5h55rxjd7vmPAHYoNTy1I9m8dbC2y2PF4lGybJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPhSriLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FB0C4CEED;
	Tue,  8 Jul 2025 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751994474;
	bh=QnEG1HbwwQTlmOz8mRAiiw1tW05XGruA++x9Dw3+Hpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPhSriLjSCaZJ5j5pN2+2Tw6FL33qnAYlhzIYsD9lpBGyLtbSKwN0D0/BYR/vgLF9
	 liDev3asiYZ6hQDEqfpGH2EHQ13OGIso0RAfErP0SJctBYuoI3cZjuibEY5oraCrUJ
	 oA6NWDEtf2Y3esNZeTnAvzwuoQZXHuLIAhcDDyxBGrud0qJpp7f6XCDyls4vwiYxml
	 M7wwx2j301mGUqrKUnkCPiKdk2mQgQibdVYDXKEDVZn3TU6zO6XMDk0q4CuUebeoY3
	 yi865ib3LzKyTwAT8DKYp8Wai24s0C+Av80CFcibSPVGAA5p4Jebf0zbbxDIsMLVZL
	 3U7hJXoNgZ8YQ==
Date: Tue, 8 Jul 2025 12:07:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	kernel test robot <lkp@intel.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] net: dt-bindings: ixp4xx-ethernet: Support
 fixed links
Message-ID: <175199447269.638971.14707251724633971542.robh@kernel.org>
References: <20250704-ixp4xx-ethernet-binding-fix-v1-1-8ac360d5bc9b@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-ixp4xx-ethernet-binding-fix-v1-1-8ac360d5bc9b@linaro.org>


On Fri, 04 Jul 2025 14:54:26 +0200, Linus Walleij wrote:
> This ethernet controller is using fixed links for DSA switches
> in two already existing device trees, so make sure the checker
> does not complain like this:
> 
> intel-ixp42x-linksys-wrv54g.dtb: ethernet@c8009000 (intel,ixp4xx-ethernet):
> 'fixed-link' does not match any of the regexes: '^pinctrl-[0-9]+$'
> from schema $id: http://devicetree.org/schemas/net/intel,ixp4xx-ethernet.yaml#
> 
> intel-ixp42x-usrobotics-usr8200.dtb: ethernet@c800a000 (intel,ixp4xx-ethernet):
> 'fixed-link' does not match any of the regexes: '^pinctrl-[0-9]+$'
> from schema $id: http://devicetree.org/schemas/net/intel,ixp4xx-ethernet.yaml#
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507040609.K9KytWBA-lkp@intel.com/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/intel,ixp4xx-ethernet.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


