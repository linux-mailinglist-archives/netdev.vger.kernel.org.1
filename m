Return-Path: <netdev+bounces-249360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40459D1737F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9D88300B9E5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8123793AD;
	Tue, 13 Jan 2026 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZjanKlM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A1378D98;
	Tue, 13 Jan 2026 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291922; cv=none; b=aAO36d2IwZm8X+C0q/2GBf3ajYrVhJftCCy+TWmrHS+FcPUPPCJ9E5bRwCdBDiz/IoFFmtAlJstXHtlOg/NNw5/NVUuQPTEC8ZMm/uUxDsFYv2uObpo3kmb3G0zJtj+RLQKNaL8NLszpRLZ7oS2cw08R0ug0vJmtqLLi+kqxg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291922; c=relaxed/simple;
	bh=qm+rItbWD7M6gskD+2ZgtO4El9J3UiCyaHNXI3efs/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL0faCbqEf0/ssoybCPI47tse3XT5rxfbYVNbW9J13DkpH9R7v1aX3/U/usoWFCP9zJ27qborkEFB4M3I58CGk4sxixlRODDTXwN8oudwxVBA9+xohj7UJnA5/WAzcVYpHASQq8cZpey62fhd1VpZyk6eBkL15+cIVezq1PWG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZjanKlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22BAC19422;
	Tue, 13 Jan 2026 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768291922;
	bh=qm+rItbWD7M6gskD+2ZgtO4El9J3UiCyaHNXI3efs/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZjanKlMYS8SKbsSbk7gld33H5Rjqz+qoh2LhRDxxzvc308SPu/wGjII103/86xT+
	 2yk8pa1RkbwxrnktMYHCYIt6MMJsArZzBqpO479BeZ8T8OmhOxA6HWs2/DXKLl0xUc
	 AVznyIw+aG269hooPrcqDeqnVmD4jT8Iw4yWDcB04RRimNFBNOrZjGUJd6zFDJPxAu
	 CAoPLkMHx5c/2KsCSEJ4sjqePC4SG0a4P+EswmMNWxrDxERViZvAqk6rXEma0335SZ
	 aoTQu8cWdN89DZliKEpEstXNewtCsPyFVNnd184yF5msyk8m99NDgWymms5qNSfJBt
	 YS2o/R3qBsCjQ==
Date: Tue, 13 Jan 2026 09:11:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Message-ID: <20260113-beige-guillemot-of-painting-575bda@quoll>
References: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
 <20260112-airoha-npu-firmware-name-v1-2-d0b148b6710f@kernel.org>
 <f57867a0-a57d-4572-b0ed-b2adb41d9689@lunn.ch>
 <aWT4vcBzG6UnaqOF@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWT4vcBzG6UnaqOF@lore-desk>

On Mon, Jan 12, 2026 at 02:35:57PM +0100, Lorenzo Bianconi wrote:
> > static const struct of_device_id of_airoha_npu_match[] = {
> >         { .compatible = "airoha,en7581-npu", .data = &en7581_npu_soc_data },
> >         { .compatible = "airoha,an7583-npu", .data = &an7583_npu_soc_data },
> >         { /* sentinel */ }
> > };
> > 
> > Why cannot this scheme be extended with another compatible?
> 
> yes, that is another possibility I was thinking of but then I found
> "firwmare-name" property was quite a common approach.

"firmware-name" is for cases when the firmware is per board, not per
SoC.

Best regards,
Krzysztof


