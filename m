Return-Path: <netdev+bounces-29491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A818A7837BD
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 04:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080E2280F66
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE091108;
	Tue, 22 Aug 2023 02:07:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2410E9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B89C433C8;
	Tue, 22 Aug 2023 02:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692670054;
	bh=BXif2ZDawun47IOKfLhj4S7BpMJpIaoTJhgi8oGmLek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jV6fqwsp148gdiGN8tYn7z8S9oY70wEjuHPgKS2Cw5CBCy1doN13UZBv9hPBJKLBH
	 3cIq3CO3772DJZp766/VTIoKwvFjFWlGntWjVNyItRGgfdWrWAf3yVZXHKnmeDMuFz
	 bl0FMla3d6UCxJLCPu1JpYEHdwRUMkcpwFCUf5Oj5xvabz2NYP6cypU4w8P5/C+sNK
	 Eviz8uU3d3zfqGsAjDYV6dMCm3O4mM6izFfSswPj8S5+9F30v+WfclK5rUPtCi0hKf
	 ETDN1BmgYW7hLflr7ZTR8D0A4j3Hgp6KjeMHT4ggfmAQjXJkCmXJZ3YQSWS/FBnOwN
	 LgycsJPgIwxxQ==
Date: Mon, 21 Aug 2023 19:07:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>, Simon Horman
 <simon.horman@corigine.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <20230821190732.62710f21@kernel.org>
In-Reply-To: <20230817114527.1585631-1-danishanwar@ti.com>
References: <20230817114527.1585631-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 17:15:22 +0530 MD Danish Anwar wrote:
> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ICSSG ethernet ports.

Richard, let us know if you'd like to TAL or we're good to apply.

