Return-Path: <netdev+bounces-12865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD373933F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 01:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E2A1C20CBF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF51DCC6;
	Wed, 21 Jun 2023 23:54:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3871C769
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF0DC433C8;
	Wed, 21 Jun 2023 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687391691;
	bh=lBPO3ZhFAmH7VQLHkIL4XIsw15NEty+QUAYnGoFZeMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QozBL7Q+Lg3KDS5qP1Ehx0M4CIsfzqgkJsgaM+01CbzH5lnfRLb14u0vJOeyRjNmt
	 1VDxXCVg0ANvjSB88HrSbUZKT313WkkhONXJPmUzqgdDy2w3KrSaf3C7D+SnjYB5+K
	 wTFeAclrfiD+AuLd8ggg5Q3U8Ns3rVS3aiwk1O4//agNBzPLxGLauWsCVqMeikwSj/
	 qyIKCyvFQnJdfByxGKtV26YTuToXntuqfCz0oZn5gw3wUtFIaq6VqHBqcslV+/wQto
	 xSjiMVeNMg9LmjPxSwBV0h4YLyyybUXhIIzxhHfc82k4egclFtg9MryG3sFWPeiHdN
	 lLAVbkkuPvRwg==
Date: Wed, 21 Jun 2023 16:54:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <bgodavar@codeaurora.org>, Rocky Liao
 <rjliao@codeaurora.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm:
 document VDD_CH1
Message-ID: <20230621165449.2f2436a4@kernel.org>
In-Reply-To: <74788626-231c-ccfb-ecc8-87dbc6a4ecea@linaro.org>
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
	<20230620111456.48aae53c@kernel.org>
	<74788626-231c-ccfb-ecc8-87dbc6a4ecea@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 08:05:50 +0200 Krzysztof Kozlowski wrote:
> On 20/06/2023 20:14, Jakub Kicinski wrote:
> > Hi Luiz, I don't see you CCed here, should we take it directly 
> > to net-next?  

Lemme take it, it's trivial enough.

> Bluetooth bindings are not part of BLUETOOTH entry, so obviously no Cc
> for bluetooth maintainers. I'll send a patch to update maintainers.

Thanks!!

