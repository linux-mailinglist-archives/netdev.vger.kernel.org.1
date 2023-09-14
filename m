Return-Path: <netdev+bounces-33779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441187A01A9
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 12:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC41FB20BD7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396D20B35;
	Thu, 14 Sep 2023 10:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD501D524;
	Thu, 14 Sep 2023 10:27:50 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0AC1BEC;
	Thu, 14 Sep 2023 03:27:49 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: festevam@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2F7CB86907;
	Thu, 14 Sep 2023 12:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694687267;
	bh=1Q/AFQfaU7MJvgFWoBA1WBlnBomqrlH9jRBRjIyqRmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LVRabDJIiCY/07ZH01gIHAncOW7pVO8svUbHwGUy+KfMOtOrt1GDGiqpBou4Hq1R0
	 Du2A9oJcE0nE8N8H30ZQ91oxOl1GsFHWDEq/4+IGP+SFmyd4CnJoejry8Nz5ABwDk6
	 Hw6A3CW2t0ir3VMJu3u33a6UeynBBRjCkn4vdbVjbEChg3QXodEnwJ9QgwUBsq9F19
	 uHfMG+Qhqv3fEaD3OnVApredAwmKscQsygLkLvfFEwiu7ync1zoGewDwaywI8XsflF
	 mMkAtQYio+nq/z50ArvLX5vGB2O1k4a9TOOU00BnU5p3sTSbE+fT7a/4wgdIGwsXm0
	 kt5xF8dmqASjw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Sep 2023 07:27:47 -0300
From: Fabio Estevam <festevam@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Fabio Estevam <festevam@gmail.com>, shawnguo@kernel.org,
 wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 kuba@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8dxl-ss-conn: Complete the FEC
 compatibles
In-Reply-To: <eba4483dd75a1c18bdb24f7c41e701f96f1e2d0a.camel@redhat.com>
References: <20230909123107.1048998-1-festevam@gmail.com>
 <20230909123107.1048998-2-festevam@gmail.com>
 <9dd78edb2476cc5b57ce7f6b5c6bb338ebef43fd.camel@redhat.com>
 <eba4483dd75a1c18bdb24f7c41e701f96f1e2d0a.camel@redhat.com>
Message-ID: <5927d40861ccd43b6d362a68718e7eba@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Paolo,

On 14/09/2023 03:16, Paolo Abeni wrote:

> Thinking again about it, I assume this should go via the devicetree git
> tree, so I'm dropping it from the netdev pw.

You're right. This one should go via Shawn's tree.

Thanks

