Return-Path: <netdev+bounces-201896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D39AEB607
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2481C21FF2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960529ACF7;
	Fri, 27 Jun 2025 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIMwd5af"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB72980B4;
	Fri, 27 Jun 2025 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022625; cv=none; b=WG44ngWxuphQw/YXn+4l+ECt0Qjs/gnLIJMmAecq/URuVgMonvx9txQnuxiUTFX6ih6F8GY6dlLtprMozAYPwAF13lz6hHvKGnHh/BNHCaTlmTvued7lRBJbqMT/Bc+iiCcM3Sb3Rf7qyKMhCnQEdoJ5Zk9dqEnIBBH0iXIAYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022625; c=relaxed/simple;
	bh=mGMGfBohkZ1WPzOd7l0m/Nelbywkij2anI7hHz+8Wtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuynsI9VW7I+lq3bqjYmaLKGDORejbwrn7Q9CwQoAc3ZJvfcB1EmQhbyMuwyidf+B+Vi0/rfM58HGiOUfZY5smMw3ZEo02YjTjU5QZ/n1pTWu+2y5jIlOXhkt2pMk9qcCilfoy1EU462r0T8d2KGibVfXrw8GQNbqVoiVzp8BdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIMwd5af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02D5C4CEE3;
	Fri, 27 Jun 2025 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751022625;
	bh=mGMGfBohkZ1WPzOd7l0m/Nelbywkij2anI7hHz+8Wtg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IIMwd5afvL0J/BPxLK6qEbVvjUxRT5d3rknTaZM9WrdHd8lyYqOmr4faeVqoQbv9A
	 zFLWXY6pifR+dc3jVcynzhPcSoqUw/bjuLO16NQMRL3IbMXoeQFD3wAc1unC/B2xRo
	 fXZN/irWwTW4V69YlaOZCyDJrw75cGKi3a1hUee3+MvzPxU4BbBK8iN0F5j/6AW8QM
	 Lzbli/VLSYDfFxzNXv0wsScHhUGDO7ytjshn+VJc+8XTqxPbf8rwhoyhBfSu2jT6qg
	 Xaba5+y0sfXJINzM+ZuwAghARcnWnqWFCpAsRNf2aNw0spdKADrCkN4NJ+TcUlwM+X
	 DHxNNlgHHTpHw==
Message-ID: <7dd6cb50-78bc-4d44-afc1-9e0fb99a5e49@kernel.org>
Date: Fri, 27 Jun 2025 06:10:22 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
To: Matthew Gerlach <matthew.gerlach@altera.com>,
 Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250613225844.43148-1-matthew.gerlach@altera.com>
 <20250626234816.GB1398428-robh@kernel.org>
 <fe705ffc-9a4c-462c-a1bf-e14c55cdb2cd@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <fe705ffc-9a4c-462c-a1bf-e14c55cdb2cd@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 20:40, Matthew Gerlach wrote:
> 
> 
> On 6/26/25 4:48 PM, Rob Herring wrote:
>> On Fri, Jun 13, 2025 at 03:58:44PM -0700, Matthew Gerlach wrote:
>> > Convert the bindings for socfpga-dwmac to yaml. Since the original
>> > text contained descriptions for two separate nodes, two separate
>> > yaml files were created.
>>
>> Sigh I just reviewed a conversion from Dinh:
>>
>> https://lore.kernel.org/all/20250624191549.474686-1-dinguyen@kernel.org/
>>
>> I prefer this one as it has altr,gmii-to-sgmii-2.0.yaml, but I see some
>> issues compared to Dinh's.

Apologies for the duplicate review. I was planning to convert the dwmac 
first then add on to the gmii. We should continue with Matthew's version.

> I am sorry for my part in the duplicate review. I just rechecked the 
> output of get_maintainers.pl, and Dinh was not listed, and I should have 
> known better.
> 
> I am happy to do the work to resolve the differences and resubmit with 
> Dinh as the maintainer.
> 

I'm not the maintainer of this. Maxime Chevalier is. Please don't add me.

Dinh

