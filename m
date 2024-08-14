Return-Path: <netdev+bounces-118391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA8951751
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5C61F22354
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397314389F;
	Wed, 14 Aug 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIzinRqT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11914387B;
	Wed, 14 Aug 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626411; cv=none; b=o+AJwE/Bl/6v4m3hkexSnrtgSrk3nRdrWNLlbG0pbW0/fZ+7+/2ZLV6JT7sf1ImFUl414xIhOX3220qZFtEbasUD797ZE7avCjg9ez1ddrEKulmtOmfEJBE7D+S6ZEDqM230K2g7exsP/LVcDfdbblJ7Gip+cRiO9+fPbDnnpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626411; c=relaxed/simple;
	bh=aWmH3sWtQ+FGj5on2nAJT14mAoJFktWZxP7WslPeMW0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=EQ4WhdhDfxnFfm3RG3frKinLQW9NbWWPm7FE6mWuPmmI2qi+rDoV9tA9C/W379Gc82sk+tbDRw3WPkQnCjaYEWVs/wHyTarbf89Ii0dmU8KQaQkep8a0HfKoUsdOcVGeYJu12kNMwdI1L2aRHGHKyzaCbJUNBPVoW6RcyUV6KtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIzinRqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABDFC4AF13;
	Wed, 14 Aug 2024 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723626411;
	bh=aWmH3sWtQ+FGj5on2nAJT14mAoJFktWZxP7WslPeMW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YIzinRqTgZLiUEVZ0ipr2k/xKvy+TKwiETqWc3B0FTT6GAr3GhNNVX1+Eev+jbNmP
	 LsruYt1YTxCyEMwZJqzva57v2Lmu6NrTsN2HHnpNFAqNwBvVytGOctxgtBY9dgkTaC
	 Uq/4hcTwXhssYNlQqy6OqdEQeZ4+C6h6SVaBw/aH7Rvqck00Y+h8QD2YRrydto78xi
	 SopYwhUmrvaYu2RfHHo9YHpLCrw007ukuIU10sE+KjkJWAJjTcxZpwqypHAh8TqlN7
	 3+Bp9Mu+iWBhXSbXB+EC+QHy1snq0O1o3YixjNQL/s9SmyaOy/w7hPa8w9gHFLVg65
	 4XQBZY7deaKoQ==
Content-Type: multipart/mixed; boundary="------------7JMRSDFsHcdDrMqFd7RB8dW5"
Message-ID: <6b5897e7-1bed-4eb3-8574-093db5dea159@kernel.org>
Date: Wed, 14 Aug 2024 11:06:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using
 unevaluatedProperties: manual merge
Content-Language: en-GB
To: Frank Li <Frank.Li@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: imx@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240811184049.3759195-1-Frank.Li@nxp.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240811184049.3759195-1-Frank.Li@nxp.com>

This is a multi-part message in MIME format.
--------------7JMRSDFsHcdDrMqFd7RB8dW5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Frank,

On 11/08/2024 20:40, Frank Li wrote:
> Replace additionalProperties with unevaluatedProperties because it have
> allOf: $ref: ethernet-controller.yaml#.
> 
> Remove all properties, which already defined in ethernet-controller.yaml.
> 
> Fixed below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
>    fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  c25504a0ba36 ("dt-bindings: net: fsl,qoriq-mc-dpmac: add missed
property phys")

and this one from 'net-next':

  be034ee6c33d ("dt-bindings: net: fsl,qoriq-mc-dpmac: using
unevaluatedProperties")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side[1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, a merge of the two modifications has been
taken: adding 'phys', and removing 'managed'

Rerere cache is available in [2].

Cheers,
Matt

1: https://github.com/multipath-tcp/mptcp_net-next/commit/691930dfa066
2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/d15f8

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------7JMRSDFsHcdDrMqFd7RB8dW5
Content-Type: text/x-patch; charset=UTF-8;
 name="691930dfa066cc019020ee32efc7a795736dc1e6.patch"
Content-Disposition: attachment;
 filename="691930dfa066cc019020ee32efc7a795736dc1e6.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZnNsLHFv
cmlxLW1jLWRwbWFjLnlhbWwKaW5kZXggNDJmOTg0M2QxODY4LGYxOWM0ZmE2NmYxOC4uYmU4
YTIxNjNiNzNlCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
ZnNsLHFvcmlxLW1jLWRwbWFjLnlhbWwKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9mc2wscW9yaXEtbWMtZHBtYWMueWFtbApAQEAgLTM2LDEyIC0zMCw2
ICszMCwxMCBAQEAgcHJvcGVydGllcwogICAgICAgIEEgcmVmZXJlbmNlIHRvIGEgbm9kZSBy
ZXByZXNlbnRpbmcgYSBQQ1MgUEhZIGRldmljZSBmb3VuZCBvbgogICAgICAgIHRoZSBpbnRl
cm5hbCBNRElPIGJ1cy4KICAKLSAgIG1hbmFnZWQ6IHRydWUKLSAKICsgIHBoeXM6CiArICAg
IGRlc2NyaXB0aW9uOiBBIHJlZmVyZW5jZSB0byB0aGUgU2VyRGVzIGxhbmUocykKICsgICAg
bWF4SXRlbXM6IDEKICsKICByZXF1aXJlZDoKICAgIC0gcmVnCiAgCg==

--------------7JMRSDFsHcdDrMqFd7RB8dW5--

