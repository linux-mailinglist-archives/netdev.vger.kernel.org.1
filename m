Return-Path: <netdev+bounces-151676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1937D9F0873
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA764280C88
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F071B3956;
	Fri, 13 Dec 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkAziuNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65311AE005;
	Fri, 13 Dec 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083450; cv=none; b=JA2jRwmRov/G7NJKhvS+WQR2GJo4BJTxTOphiatuKdk4oycq2wFEaeFx5+ebzgVfw8ibQk4YNmCiH23+6YS8Wo/zwhIcliy+r/2DhlGpLQoOPYKGWux+LVH19qFACvXLCnDWXHmz0ufc4kZxatVmpIJgTwISw/OEd0yfyAA87Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083450; c=relaxed/simple;
	bh=p7yFAHkgmh+RMBW/XoJtPR0CR3rmJqWOYiYB3WSkPxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXcvn2C7SNo0TaX/i4061BzhvVJbNBizLq2uhAWgxiIUqOdBgqqMocW/hskkLdWxGJGEjUoZgBi4RwVrP7vGoJ1QSoAVExlVR8bF0hVuUe/jTcaGpjpCIO7Q3s4o6P2So5wRiLQW9t6PHd3MlZzVr0xkTmcI64K4JcnentmGIu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkAziuNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F16C4CED0;
	Fri, 13 Dec 2024 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734083450;
	bh=p7yFAHkgmh+RMBW/XoJtPR0CR3rmJqWOYiYB3WSkPxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkAziuNNMieRwtIfLOYKgOSMJmiWX815WSEIfjcXuuE1um/TBa5qC+tfJZ+QKvm3H
	 hPjWLHjJ8RT3t7iLozfgmU8YOSkl7iv6E8UnmI9iAFvCskHHRncK+G1ugdp5rfZfBT
	 j5eCPiDX/69WTRWYRpvoUVxu9rL+hIwc+osHR8VNaaCZWGgq1hhSNGDxAV9PtF9TEy
	 SeNGhsJ1EMOSROd7Iio0pW8eLL6tmGeFzLMGa29RoaX7vSxGFjP4LxelWn1a84jjam
	 6acNWQGXxceMLRjxFTfH2d9L/EsHUGxTluck42inAvgdziIZ4wcuJ03boWtxarD/1/
	 rp82tJn1SMvUQ==
Date: Fri, 13 Dec 2024 10:50:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, Marek Vasut <marex@denx.de>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Vladimir Oltean <olteanv@gmail.com>, 
	UNGLinuxDriver@microchip.com, Woojung Huh <woojung.huh@microchip.com>, 
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Improve
 example to a working one
Message-ID: <sugh74o4cevws4lkrsweqzejaciu2dcjt4rlzuncp4ceddwgra@lhgbx3lmkqyk>
References: <20241210120443.1813-1-jesse.vangavere@scioteq.com>
 <dfb09395-78ce-477f-bbbc-747b0a234d4f@lunn.ch>
 <CAMdwsN_Kgb23Rw0q041fFr9T70twx2vAX2J+MvJz+585ZyyanQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMdwsN_Kgb23Rw0q041fFr9T70twx2vAX2J+MvJz+585ZyyanQ@mail.gmail.com>

On Tue, Dec 10, 2024 at 11:01:02PM +0100, Jesse Van Gavere wrote:
> Hi Andrew
> 
> Op di 10 dec 2024 om 17:18 schreef Andrew Lunn <andrew@lunn.ch>:
> >
> > To some extent, the example is for the properties defined in the
> > binding. For properties defined in other bindings, you should look at
> > the examples in other bindings, and then glue it all together in a
> > real .dts file.
> >
> > I don't know if Rob will accept this patch.
> >
> >         Andrew
> 
> To some extent I understand that perspective, but in this case for
> example dsa-port itself has no example, I also struggled quite a bit
> getting the example going (admittedly a bit due to my lack of

The point of the example is to show this device, not everything, so
adding there nodes which are not covered by the binding is usually not
what we expect.

For example what ethernet ports are might be pretty obvious, considering
they are already defined by child schema which is supposed to bring you
full example and full description, thus parent schema does not have to
be detailed.

Best regards,
Krzysztof


