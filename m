Return-Path: <netdev+bounces-42926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD47B7D0ABD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221BD1C20918
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8D847D;
	Fri, 20 Oct 2023 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="qAOpso6d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FB211A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 08:46:36 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE7D46
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XRg9DsEl/nt3hnyWShdIe+EcbDJwslBOsvtJkyHufJc=; b=qAOpso6duiZS4eu3AJOQdn0bvQ
	eR7ySX2GH559HKGh/wqcf0D09sr5Cvj6GwxiwVEMic9bsfPR+p4ALp5326ZDAgoe18M3SRrxGQXiI
	lt/N7SxguJyflcefIeWLzmII2185n4EA+qQkrR9n7RgcQq+ojGK9O39o5fnKndGBlYEnWFvNPlyqO
	Squ5Qhb+Dp4EZBWPTRV3ye2tST0cX6lWYnrjL2wNZftR91sqzHY3uK2pTGFrcITkZ6AWNTGzqfTpt
	Yg1OHFLdcFZXpwP9bcSx7Y2nzledvgVBnZv/dXLMlfyA20kTGVkS7TI6qA9iBObjm8xHeV4fYGitr
	sHCF6p6A==;
Received: from [192.168.1.4] (port=21399 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qtl9F-0000z6-2F;
	Fri, 20 Oct 2023 10:46:25 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 20 Oct 2023 10:46:25 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
	<ante.knezic@helmholz.de>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<devicetree@vger.kernel.org>, <edumazet@google.com>, <f.fainelli@gmail.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>, <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to select
Date: Fri, 20 Oct 2023 10:46:20 +0200
Message-ID: <20231020084620.4603-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231019165409.5sgkyvxsidrrptgh@skbuf>
References: <20231019165409.5sgkyvxsidrrptgh@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

On Thu, 19 Oct 2023 19:54:09 +0300, Vladimir Oltean wrote:

> So user ports and CPU ports meet at ksz8_port_setup() from different
> call paths, but I think it's strange to continue this coding pattern for
> port stuff that's not common between user ports and CPU ports. For that
> reason, the placement of the existing ksz8795_cpu_interface_select() is
> also weird, when it could have been directly placed under
> ksz8_config_cpu_port(), and it would have not confusingly shared a code
> path with user ports.
> 
> Could you please add a dedicated ksz88x3_config_rmii_clk(), called
> directly from ksz8_config_cpu_port()? It can have this as first step:
> 
> 	if (!ksz_is_ksz88x3(dev))
> 		return 0;
> 
> and then the rest of the code can have a single level of indentation,
> which would look much more natural.

Ok, will do. I am guessing I should leave the existing 
ksz8795_cpu_interface_select() as it is?

