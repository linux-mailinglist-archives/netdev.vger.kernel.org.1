Return-Path: <netdev+bounces-140380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C30E9B643A
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAC71C21524
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BAA1E7C0B;
	Wed, 30 Oct 2024 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ooR9oXz4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A3185B62;
	Wed, 30 Oct 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295337; cv=none; b=ZdGC9hVIS80E0vNiKstt9yBKihxq14mJM61VtKPlj9+FQxxUniAiTqfsPskZAvVDt+Sc8gJjlwZuQXcR9kVvwjiOmuKPaWF9qXgmkXp/uCdfGWcPvCJfe9Nu1s3T6AOL4L7zz1BFLCueD1cJGzJexiT1moVgIwSzkF+F6ueSHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295337; c=relaxed/simple;
	bh=q0+2bsG1gRSPhvpYprB+IAG8xeuM/DVRZ6H3+S4xmGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXxdp05g+xhPRyvYfESpFvf0Xo0hOK34e+3Alt+IbGMxnoz+8OddeHFKj/oYZ1xziJJ8j8pM3s9V7BcLFX8LX8P/OTWMaubAwW63slWbD5syySpYhhJ7otio9nlukiWFKM9A/ZeyJ6EL8Tznd3K0Q7+eSpp4exKqETektIgNel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ooR9oXz4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q/3yOnbAAYgurf+C+eCBdRRuc1aeP4zqVtwXMl6zbys=; b=ooR9oXz4Ia58Wc5ZleJG1mkXW8
	hSOeOcdYurwLwLvenD/zFFbS3NugdL74o7f1gWJL73KUdkbvj3/otUa4u+onWqOlaIXM3u6EzhGQ2
	LcMJWbdzUetNevvOLuRujQKCRwmCPDOR9xhU5wcYXWBg4/4QftMbpuelJsa1Pfmww7es=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t68r7-00BgzV-E7; Wed, 30 Oct 2024 14:35:25 +0100
Date: Wed, 30 Oct 2024 14:35:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct
 phy-mode property value
Message-ID: <b078780a-4afd-43af-afcf-309707614b0a@lunn.ch>
References: <20241028091214.2078726-1-suraj.gupta2@amd.com>
 <MN0PR12MB59539234124DEF1B37FAB220B7542@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB59539234124DEF1B37FAB220B7542@MN0PR12MB5953.namprd12.prod.outlook.com>

On Wed, Oct 30, 2024 at 06:12:37AM +0000, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: Suraj Gupta <suraj.gupta2@amd.com>
> > Sent: Monday, October 28, 2024 2:42 PM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: git (AMD-Xilinx) <git@amd.com>; Katakam, Harini <harini.katakam@amd.com>
> > Subject: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode property
> > value
> > 
> > Correct phy-mode property value to 1000base-x.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

