Return-Path: <netdev+bounces-141079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A99B9699
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9148CB20C5A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CF31CC179;
	Fri,  1 Nov 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWdTRB8N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC684E1C;
	Fri,  1 Nov 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482443; cv=none; b=gtZV02iYi0nKahOb4wz/1OeYESFXO3tDUpHWxPDShQ+sNw8t36ogaM8MJb+jCJKoDW/fPBAo0hnEhw+AtwuDY0uY797JzCBc1WIxMPDwktYSu0i56tFeS5Lb8Bg5IfxOSz0pN7Wk/GEcZc9K4b5fRcDNseJRNtFbKE1wr1Uz3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482443; c=relaxed/simple;
	bh=13D5qO+iCCU4BtPeL0cBtUnyyfuAgxln/g3XVg4bLfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNSPGw0qc119GtVTtRTBe0tqfMk35B5YHbR5d5MDoIcthGAZG1JpXdlrbFthmV4qspxalFCjUkfrOeGOHqTzaz+DC7+2w5lSBoeQMlZ7zMF5rTU3ORWGOXJ/58FbwRMPeXV/MqhyJGTrgnoqDQFccg10FeBwrX0ZmKCOtSaBTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWdTRB8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B6CC4CECD;
	Fri,  1 Nov 2024 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730482443;
	bh=13D5qO+iCCU4BtPeL0cBtUnyyfuAgxln/g3XVg4bLfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWdTRB8Nhtivx/MimJEqGEAxXtuEYXsLxs8ZHgNq65+Eg6+P4PS9rjSKApLSazoWI
	 u039m64m6Kp2DYoOSE6KFajfgXamleIoBicYcJekyKDbSYhdYcP7pxsKKbjocPo/ZJ
	 AmnFRmmLLWYguOcN+ZYYA1ghGbdtlecFnPqugPkKbEAglQhv0LI7kkSemQgqu0A1V/
	 L9Tg2ZvchTtfSpkpu0Ti1gLYB6/DbDoRQImeccyacz+feSa2K30DQ+diiZsiFUtZ+0
	 Qu+6s8367BaNZdCYq8Ah8PnRovg0/UtaOOwUjYZo2tTZyzvxKqI/2Z3Y5sfceU77Yx
	 0WGEd1hpmIq9Q==
Date: Fri, 1 Nov 2024 12:34:01 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Suraj Gupta <suraj.gupta2@amd.com>,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct
 phy-mode property value
Message-ID: <20241101173401.GA3780112-robh@kernel.org>
References: <20241028091214.2078726-1-suraj.gupta2@amd.com>
 <20241031185312.65bc62dc@kernel.org>
 <20241101-left-handshake-7efc5a202311@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101-left-handshake-7efc5a202311@spud>

On Fri, Nov 01, 2024 at 05:14:50PM +0000, Conor Dooley wrote:
> On Thu, Oct 31, 2024 at 06:53:12PM -0700, Jakub Kicinski wrote:
> > On Mon, 28 Oct 2024 14:42:14 +0530 Suraj Gupta wrote:
> > > Correct phy-mode property value to 1000base-x.
> > > 
> > > Fixes: cbb1ca6d5f9a ("dt-bindings: net: xlnx,axi-ethernet: convert bindings document to yaml")
> > > Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> > > index e95c21628281..fb02e579463c 100644
> > > --- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> > > +++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> > > @@ -61,7 +61,7 @@ properties:
> > >        - gmii
> > >        - rgmii
> > >        - sgmii
> > > -      - 1000BaseX
> > > +      - 1000base-x
> > >  
> > >    xlnx,phy-type:
> > >      description:
> > 
> > Can we get an ack from DT folks?
> 
> I dunno, the commit message gives no detail at all about the impact of
> changing this, so I don't want to ack it. I *assume* that this is parsed
> by common code and 1000BaseX is not understood by that common code,
> but...

We're the ones defining the names in ethernet-controller.yaml. It should 
also have failed validation if used because the list here must be a 
subset of that list. So nothing to do with whatever the kernel does.

Acked-by: Rob Herring (Arm) <robh@kernel.org>

