Return-Path: <netdev+bounces-57505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDC1813383
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAD5282FF3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626355B1EB;
	Thu, 14 Dec 2023 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="WpdW/17k"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E0212D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JOrkzxGekcw7VHo53kYxfb41EEzQLNXXXNM04Cve1jE=; b=WpdW/17kBvvf0FVKA68/EvHW+p
	XDWIEfP9wcJ6Ypj1NIZF/4VKl7k4aQeeubhKcuYGmVU5Ws6QDsQILesh3NWKwN/oLO6VezzDqDZv3
	ztYn7KvZMdvW8SMC4dw09Xbx0DXV5XxnNLiizFmaaQQrRuU/PmW9QFTBX7av75rO1Oe5kKOXtiXbH
	Lp1RdJR1k2VZoc4TVL5ltIdI3zb1BHuIbTYet0CcFqZQ4LlFUfuWlTsMt5rqI4Zb1NOzskSgoMTE5
	262hTKAmaNye0nw+5TvZUi25cqx39ercWw1gq2UsevixFXaZWsma5zGy3FzrzMKc0fXPIF9WCUjDG
	Z/HoSvKQ==;
Received: from [192.168.1.4] (port=36326 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rDn0E-0000XH-2U;
	Thu, 14 Dec 2023 15:47:54 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 14 Dec 2023 15:47:54 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <olteanv@gmail.com>
CC: <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: dsa: dont use generic selftest strings for custom selftests
Date: Thu, 14 Dec 2023 15:47:51 +0100
Message-ID: <20231214144751.1507-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231214142511.rjbr2a726vlr57v4@skbuf>
References: <20231214142511.rjbr2a726vlr57v4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

Indeed I do have a custom implementation for the mv88e6xxx chip, but its not
come to state to be posted because of test/chip specifics.

> I didn't notice when the selftest support was added that there is no
> implementation in DSA drivers of custom ds->ops->self_test(). Adding
> interfaces with no users is frowned upon, precisely because it doesn't
> show the big picture.

I was not aware of this, I apologize. If this is the case, perhaps this patch
should wait for the first custom self test implementation and be reposted as
a part of bigger series.

Thanks,
Ante


