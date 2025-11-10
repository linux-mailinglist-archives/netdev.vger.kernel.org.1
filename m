Return-Path: <netdev+bounces-237224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21295C478A0
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C64B14EE425
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB72236E5;
	Mon, 10 Nov 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ztiH7bgv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453318A956;
	Mon, 10 Nov 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788136; cv=none; b=L059sldZ6RVdpX6lsWoVPX+sthblU+e3Gd5PsoQDLcw7x6q6+fYYjIYH5u0a/Vu5TrWxTjfO7CqNbX7HsHWWoe1h6g94l8Ig0Fk8l9wug+3QKAnkr01Ns4cQ4XfpOHVTANYl6ut+joYaHGED7jMpf9T1+pck8OP0J3CeqSgTMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788136; c=relaxed/simple;
	bh=TsRwq4alRiMLTUSP+TQrXROO+fIY++fmtBgUt7JZMfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MM+cBIaHGzuuo06IQ7H/IPh7Sgm+DzXSxNOuQO1kj69pa/8UefGX9P9VTQWlJ5/TKLGNb/TbmP0Ah4SjbYnpD+dXqF7PBIlh2AsT5lSo5Ppn2bHe7vQPVjfo6Nwe+MNKvv8sLmnHe3OWZNoKRulL2Guljt5fZuAwWfE1017Xoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ztiH7bgv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Awr+81kQsRnEBxn06SpEGdo1D44sv/W67zP5wVfdji8=; b=ztiH7bgviNzNanjroR1I3K9ala
	g4VP79+oXXvnv4jp8O3mC+I7CpuE7e3ZyKbul3ax9mvMQ6uF7ZgjsEZNlsmW9dsatq3/x3Y8DcaYg
	mJNFvp8XO6OaYEG83DMlc/K8uhCnXFrzIYQ4gaGxb/KYyaWvHCnkNFd/0FERfx4c+qj4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vITi7-00DX2g-4E; Mon, 10 Nov 2025 16:21:39 +0100
Date: Mon, 10 Nov 2025 16:21:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v4 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <aeb5d294-d8c7-4dbb-a159-863963d38059@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-rgmii_delay_2600-v4-1-5cad32c766f7@aspeedtech.com>

> Add the new property, "aspeed,rgmii-delay-ps", to specify per step of
> RGMII delay in different MACs. And for Aspeed platform, the total steps
> of RGMII delay configuraion is 32 steps, so the total delay is
> "apseed,rgmii-delay-ps' * 32.

You already have hard coded base addresses to identify the MAC
instances. So i don't see the need for this in DT. Just extend the
switch statement with the delay step.

    Andrew

---
pw-bot: cr

