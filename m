Return-Path: <netdev+bounces-160670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA7A1AC86
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A098E162109
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 22:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FD1CF7A1;
	Thu, 23 Jan 2025 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS0PydAP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0381CEE8C;
	Thu, 23 Jan 2025 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670331; cv=none; b=T+esq8UTYEYAwioFPR8nqeOIK0h+Qj/uD85gKCME53OkjoSbhOa8GP5sSYoEgGu1xtCjX4hljFxkjtnBHy5zquQXTD8u/2KagQUnKEDY7r5vG+0zWrw8YMVW8KMVNd9fNxh31lrQ215e7ZGigzK6pB47qeQyxeoKlrbaQDd+/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670331; c=relaxed/simple;
	bh=h5zYZEeh2fayA+qgYt1ROno/TFyCfT21k9zimU507Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2nn39r9oMPdlpNaOmpPpl88BqjXaWw9hk358K4oBqv9BG9LkLqmdaSuUoHkhAPkchQrjY4hAxVDVgm4xI0EUoffU+7rUOKflTaXBlH+c/VDQlpx2fymPZ/uFAaEtlYhm/OyQR4Ev4LCfn/+Afo6FU5xd/8l7fFFv+DRYqmyQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS0PydAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D677C4CED3;
	Thu, 23 Jan 2025 22:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737670330;
	bh=h5zYZEeh2fayA+qgYt1ROno/TFyCfT21k9zimU507Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pS0PydAP+A2YJMSiI8R5iPpvEnHyM7oUr40s3uHQxbFxq6iXZ498P+qYTBYL5FiG9
	 98ffwKSrAFQvn9NDtjAD0K87PpxCpCsK6QXof+baFrDGreCApwkNQ2vmEuqNXQu+Kv
	 t6pyoV7HiNuLnpxeSUQPHwzR9n4Af9dU6mCCXwY7HXLAbXf+0xDZZfq8IFEW797fuL
	 Wvc5n0H8yOZaKN4VElcrUqH4XdlT2AfYnkHZYFINZC+3L3iS8PP6SfaN/r5TJWuik1
	 wjpwY2Kn/I7M3bLekd2YYYhV8/+KYrxRXUJXBzyBldxEU0xqvYvokHfM/QoJLFgqRS
	 VUARXO7KPHoWA==
Date: Thu, 23 Jan 2025 16:12:09 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	conor+dt@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
	joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, eajames@linux.ibm.com,
	andrew@codeconstruct.com.au, minyard@acm.org,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 02/10] bindings: ipmi: Add binding for IPMB device intf
Message-ID: <173767032899.448455.5833909744401276024.robh@kernel.org>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-3-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116203527.2102742-3-ninad@linux.ibm.com>


On Thu, 16 Jan 2025 14:35:17 -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


