Return-Path: <netdev+bounces-96968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC498C879C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608101F2341C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3448455769;
	Fri, 17 May 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AZE/axk+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511254FAF;
	Fri, 17 May 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954170; cv=none; b=IGUaqRL6rtIg2v00WLe/b+M42Tm7b1KkqCIGOhucN/ZgOhZkkMJVq3W01AwkyZaB+TL9jphqpIMEssbW5aYHElCNm5p4QBuQWorcpFICVw0SXBbC6mfplhn37uswtl0gnkkLtK/G6Zw7I6xxoQZAFuMggvaA65KhY+LXPFvKMp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954170; c=relaxed/simple;
	bh=LEFMBsPh4x85fiALpW4Jhs0qhfd/PS/cLG9AMrTavD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP219Y0Cj9KJ6hwShGLkcww8RWccQA2X6t+KxQp1QyGfbxkUaclvMmigjeHv2v5SKRPGkdSq0hGbGEvCUL3ryD+acNn1xqO3qVa0kRma/rVUGFfIhUAQ76zjk4p/TAPPNLJCjqaHKMM9eVQLRYEQ+UYzL6xRLFN9hBpxRF3GOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AZE/axk+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pk/W9e89sqlkjRFyy/G4QXKaCAzosUOTniNUWw5lh80=; b=AZE/axk+2en4FQ+tO3zZeqtkGS
	OCjIoIK3wrU6ktnmLymgHJHYSsQZ3CZiNqSx+WUFhYqGrBhbYYcjFYJ6z9r1V6rxJLPjk+QE/6rds
	1DMW9XzEa8prH6ICGlwaWBdW/J92MHP+mjwZQ9MwU2ocqwYBW7TgZRvgAAPB1TZRK26I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7y43-00FZvK-3j; Fri, 17 May 2024 15:56:03 +0200
Date: Fri, 17 May 2024 15:56:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kip Broadhurst <kbroadhurst@ti.com>
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <41e30085-937a-410a-ac6a-189307a59319@lunn.ch>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517104226.3395480-1-u-kumar1@ti.com>

On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for TI specific phy header files. This allows for Linux
> kernel files to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
> 
> While at this, update the TI copyright year to sync with current year
> to indicate license change.
> 
> Cc: Kip Broadhurst <kbroadhurst@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  include/dt-bindings/net/ti-dp83867.h | 4 ++--
>  include/dt-bindings/net/ti-dp83869.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/dt-bindings/net/ti-dp83867.h b/include/dt-bindings/net/ti-dp83867.h
> index 6fc4b445d3a1..2b7bc9c692f2 100644
> --- a/include/dt-bindings/net/ti-dp83867.h
> +++ b/include/dt-bindings/net/ti-dp83867.h
> @@ -1,10 +1,10 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
>  /*
>   * Device Tree constants for the Texas Instruments DP83867 PHY
>   *
>   * Author: Dan Murphy <dmurphy@ti.com>
>   *
> - * Copyright:   (C) 2015 Texas Instruments, Inc.
> + * Copyright:   (C) 2015-2024 Texas Instruments, Inc.
>   */

IANAL

but about 1/4 of this file was written by Wadim Egorov
<w.egorov@phytec.de>. It would be good to Cc: him and make sure he
does not object.

The other file is fine, it was all Dan Murphy's work.

     Andrew

