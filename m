Return-Path: <netdev+bounces-32738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE43799F35
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE91C1C2084B
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D208482;
	Sun, 10 Sep 2023 17:58:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E1257E
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 17:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65527C433C7;
	Sun, 10 Sep 2023 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694368710;
	bh=NH8cClsBXDOEH39n3025iXsEaUUDx0eXXxKoTLrsTfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nw1169OdRDD27uQy6uZv9dnITBYxHgo+JW2YfIRjTb+SrKxvk96R7dhKWXFTuUuOd
	 QzvFa0FU0aXP0Dn5dSxdHGMRSqn9HXJo9qq6E6sLqHeUdwaCN4m/Fc18dsV9+nx8aF
	 vrvYUky2hIb0H7BnGLutaJUrtREANLGqLLlZm+lcpX/tGrEZsPgPOAK74+cqia7KZI
	 jNYY2BtRk7UZ47V3lMrsFaJVUdB+430XAv23IDypced/r1ARFcP7I07J0hn+Lb4uq/
	 TvJQLpjtvL6cbxp1jIrqFm3GDqlbrN637P51Q88Kj0oJ/p6x3FZ2/Pr/B27wN43zMB
	 si7gR6HPyzOqg==
Date: Sun, 10 Sep 2023 19:58:24 +0200
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, steen.hegelund@microchip.com, rdunlap@infradead.org,
	casper.casan@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 4/6] net: ethernet: implement data
 transaction interface
Message-ID: <20230910175824.GL775887@kernel.org>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>

On Fri, Sep 08, 2023 at 07:59:17PM +0530, Parthiban Veerasooran wrote:
> The ethernet frame to be sent to MAC-PHY is converted into multiple
> transmit data chunks. A transmit data chunk consists of a 4-byte data
> header followed by the transmit data chunk payload.
> 
> The received ethernet frame from the network is converted into multiple
> receive data chunks by the MAC-PHY and a receive data chunk consists of
> the receive data chunk payload followed by a 4-byte data footer at the
> end.
> 
> The MAC-PHY shall support a default data chunk payload size of 64 bytes.
> Data chunk payload sizes of 32, 16, or 8 bytes may also be supported. The
> data chunk payload is always a multiple of 4 bytes.
> 
> The 4-byte data header occurs at the beginning of each transmit data
> chunk on MOSI and the 4-byte data footer occurs at the end of each
> receive data chunk on MISO. The data header and footer contain the
> information needed to determine the validity and location of the transmit
> and receive frame data within the data chunk payload. Ethernet frames
> shall be aligned to a 32-bit boundary within the data chunk payload.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Hi Parthiban,

this patch seems to introduce new Sparse warnings.
Please consider addressing those, and ideally the warnings
flagged in the existing oa_tc6.c code.

Thanks in advance!

