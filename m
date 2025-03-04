Return-Path: <netdev+bounces-171651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1788AA4E07D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36BE3B95DA
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8BF204C1D;
	Tue,  4 Mar 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y2bhocnC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0686202F90;
	Tue,  4 Mar 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097505; cv=none; b=pVgu4NZ58JaPPsj7ONS4Oylrp1SSi2N6ChILH+d9GVdJGcXVWXm1l+JnSnxawZ+QynAu+z5r9dTBm8e44hITm9+t5EkCmraZoDrEhRPhkAl7OIIUdvMfcKeXuthdjmY6msSM/K2e92g2uXtwhJ/paKI51TW0Nge6AEAP+asmfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097505; c=relaxed/simple;
	bh=SqVSO0zZhtSIAZubXOzoTuy9PzOq5wHwfBsiiZZKMQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzgv7AX5GX58HKMO5SCqFrhuw593A7QdiSurevcc5CgEHmNGWOHB/B983faW3ON+3jc2aVdNV95Tj3dGqJsyM3YPOdfFvFKqYDiWnbDVTUz/kliEHWKVjh4Z3yxYh18YICzhlo48HubSksuP7BKeNuvU+kYuhkayro6QEQPMBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y2bhocnC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+xWBTJhN0XYH43psf/8dEkzJCCMPK7fvqc3iPcn+1ek=; b=y2bhocnCO79LqjeoT7udogNEeI
	JBArkzcradPOBewej2dEF8GnWGXY3RSY2Wk8R2gmHmqQ7B9tiYK/NGzcWvU9g9Q3rJDv6qCcfZYN2
	0pZY38gr6o5D1BHSdvye8S3YEN1ONom5SkBtPY8Is782RmUcNYQWcLLQ2yHAmpveh2Jg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpSzc-0029lG-3z; Tue, 04 Mar 2025 15:11:32 +0100
Date: Tue, 4 Mar 2025 15:11:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: H ZY <hzyitc@outlook.com>
Cc: "olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"john@phrozen.org" <john@phrozen.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: net: dsa: qca8k: add
 internal-PHY-to-PHY CPU link example
Message-ID: <f7ac97f4-7677-402d-99f1-ae82709a3549@lunn.ch>
References: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556D90A3778BDF7AB9A7030C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <ae329902-c940-4fd3-a857-c6689fa35680@lunn.ch>
 <TYZPR01MB5556C13F2BE2042DDE466C95C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <55a2e7d3-f201-48d7-be4e-5d1307e52f56@lunn.ch>
 <dbd0e376-d7c3-4ba9-886b-ba9529a2ec4e@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd0e376-d7c3-4ba9-886b-ba9529a2ec4e@outlook.com>

> (Port0 and Port6). Could I just keep this or should I need to add a new
> case ?

The existing examples are probably sufficient. Just check the text to
make sure it does not limit it to ports 0 and 6.

> > So is this actually internally? Or do you have a IPQ50xx SoC connected
> > to a qca8337 switch, with copper traces on a PCB? If so, it is not
> > internal.
> 
> The "internal" is used to describe the localcation of PHY not the link.
> In current code, qca8k has supported to use a external PHY to do a
> PHY-to-PHY link (Port0 and Port6). This patch make the internal PHYs
> support it too (Port1-5).
> 
> The followiing topology is existed in most IPQ50xx-based router:
>     _______________________         _______________________
>    |        IPQ5018        |       |        QCA8337        |
>    | +------+   +--------+ |       | +--------+   +------+ |
>    | | MAC0 |---| GE Phy |-+--MDI--+-|  Phy4  |---| MAC5 | |
>    | +------+   +--------+ |       | +--------+   +------+ |
>    | +------+   +--------+ |       | +--------+   +------+ |
>    | | MAC1 |---| Uniphy |-+-SGMII-+-| SerDes |---| MAC0 | |
>    | +------+   +--------+ |       | +--------+   +------+ |
>    |_______________________|       |_______________________|

So logically, it does not matter if the PHY is internal or
external. The patch would be the same. I've even see setups where the
SGMII link would have a PHY, then a connection to a daughter board,
and then a PHY back to SGMII before connecting to the switch. Running
Ethernet over the connector is easier than SERDES lines.

So i would probably drop the word internal from this discussion,
unless it is really relevant.

	Andrew

