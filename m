Return-Path: <netdev+bounces-21491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F23763B4A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B00281CE7
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324F253D9;
	Wed, 26 Jul 2023 15:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF551DA5F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5C6C433C7;
	Wed, 26 Jul 2023 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690386003;
	bh=wpAk9eVRkO3m5yXAXAX/GMvTJFrvAOQChp70gooG/Ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CGiz0wSdqSzSeULBwoxHkD2IpHoH2HI4Kc9jKrtFIShwBmu/gus7rZf6vjVQqVUEf
	 7+EUM2FVhKtVDvqnz2463f1vK3YXASSyg4JM5v2vFbg2+da6jVP+koG6KWkl/Z7BQ3
	 bWKd9sJNSvSPANGWWkxEprhl+N1RX59dFgQ10IkLgPx3Jhwn2Cd6CtQWbZ5e8ScbFo
	 PiTOeaZOZqf1CQXeAE4otjL0E5CqkOKvbCW4yrmiq4UJDr3rFzdmhKoV7vp2sKra3M
	 DuXJhGdwv4p9uJMtpxDBrZHe1TunDFbdc0SeLZlRfVToM9NHl+MVtObv5JMJ/im5o/
	 bBnOAclht3iZQ==
Date: Wed, 26 Jul 2023 08:40:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Md Danish Anwar <a0501179@ti.com>
Cc: Simon Horman <simon.horman@corigine.com>, MD Danish Anwar
 <danishanwar@ti.com>, Randy Dunlap <rdunlap@infradead.org>, Roger Quadros
 <rogerq@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn
 <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v11 03/10] net: ti:
 icssg-prueth: Add Firmware config and classification APIs.
Message-ID: <20230726084001.0758feaf@kernel.org>
In-Reply-To: <ZMDOWecss/9F+0nb@corigine.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
	<20230724112934.2637802-4-danishanwar@ti.com>
	<ZL94/L1RMlU5TiAb@corigine.com>
	<b2016718-b8e4-a1f8-92ed-f0d9e3cb9c17@ti.com>
	<ZL99WfF7iuzeMP78@corigine.com>
	<5a4b293f-7729-ee03-2432-cd49ff92d809@ti.com>
	<ZMDOWecss/9F+0nb@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 09:42:17 +0200 Simon Horman wrote:
> Thanks for splitting things up into multiple patches.
> I know that is a lot of work. But it is very helpful.

+1, definitely much easier to review now!

