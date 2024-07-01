Return-Path: <netdev+bounces-108213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E291E62B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B5628319D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15CB16D31E;
	Mon,  1 Jul 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qej7VKzH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7571616DEA2;
	Mon,  1 Jul 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853542; cv=none; b=bDXTl3iF9VrogZ5q9h3+XEW143mInKNEi2XsSyr/wt6yQk0d39H0lANZ1u1pzx2qhg9PpRiB8q0dzwMSVayXgd6BRNTdQfOneew7Xc+Idc89/J1XK9nwtAfhfGICFBGjDeDH1YVYGeK3SloXtxhtw1akQYmkfHVvnrhT/aIjlhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853542; c=relaxed/simple;
	bh=q4OyPjfv5gZUEE9LaQIDRfn9M+XRJa3CUQSw/90n/wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APqnb7nth4FT5Q1rjxRcbnCzjRICNs+sHHOUuVF3ktKC1/ujqvEtgYD6UCfplSl8oSk5aDdTgWGx8/na+3QSkpC80VCBKijc5OU/fS+Rlm0WjQemabmSB1M+ncEXgpS9jXg9y2qfq/VeM1ypNdLQH0FTEH8r7rd7VHW7AHeNe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qej7VKzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCEBC116B1;
	Mon,  1 Jul 2024 17:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719853542;
	bh=q4OyPjfv5gZUEE9LaQIDRfn9M+XRJa3CUQSw/90n/wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qej7VKzHzPUOq4ckzBYcfg9rVISB9gVbTxOWwvMtchH96xvQiv3nl3G4oUUGMtB72
	 8lbcSRW0T1OGFcMXTjV623y81/vvrPS4GYlTD16W5X2j4zvZXiXjh9QByihra6SRmA
	 Gs9rXcAOiqfXqpgkCpHnHDWCESU7s1a3p+xaPRNeF0lA57e8BcPmNfoLwXndobXW40
	 Ro77pzygJ6uaS9vIfnoYwAVDUWwJJTK9sm2dv2tSuy7fSt2rKOYVE63kEuftQ4hKNN
	 5IIPp8mHcIgtHju4tIaxWfm6X3jrH09KKdYMSAdYZsc/gMfR1bslaZIxo8hhAIpUHL
	 WgPoqm0mGnfkA==
Date: Mon, 1 Jul 2024 11:05:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH V2] dt-bindings: net: bluetooth: convert MT7622 Bluetooth
 to the json-schema
Message-ID: <171985353997.121079.12971350950183482042.robh@kernel.org>
References: <20240628054635.3154-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628054635.3154-1-zajec5@gmail.com>


On Fri, 28 Jun 2024 07:46:35 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Dropped serial details from example
> 2. Added required example include
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Simplify example
> 
>  .../bluetooth/mediatek,mt7622-bluetooth.yaml  | 51 +++++++++++++++++++
>  .../bindings/net/mediatek-bluetooth.txt       | 36 -------------
>  2 files changed, 51 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


