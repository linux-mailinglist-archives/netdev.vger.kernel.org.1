Return-Path: <netdev+bounces-226573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4582BA233B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF27188A884
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30F8258CD7;
	Fri, 26 Sep 2025 02:22:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200E38DE1
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853365; cv=none; b=JBz+UY/YySF1cpylcbhlGvWLOYrldozXAUceeg+6br2FlAp2rlJ0IA+SH8nN5ojkGTodyzMN9qv2bCm/lkB5VHYr/SiRWxgNo23dfzEyms8aYSbJDyvrFIl10PX6CJa6pEIHA9q5w/Nuy+iLbFO38SanAObBZNRK6+Aq9p93Ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853365; c=relaxed/simple;
	bh=WtHkABSSrZk+o/73OI9gMwGu43QupOuqdBHmE+sA3hM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QlUnKEAbPkpZPU3Ip/pwvgFK4LVFfYveNziDOjUiQXLGKKsf8z3R3kxAWKrt0QCBkMvruPzwGQCcwPHAeMxWIGuXP1qc7KrnIvsP8KbiNeGNX+3VHoGNqCkGvoFX6MKhtIivNxNU2gAp67sx0kvco/Kz7657Wci5Hhiij0J+Owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1758853267t685t03608
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.220.236.115])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4022943953029472022
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Alexander Lobakin'" <aleksander.lobakin@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250922094327.26092-1-jiawenwu@trustnetic.com>	<20250924183640.62a1293e@kernel.org>	<05ab01dc2ded$f2e9a610$d8bcf230$@trustnetic.com> <20250925190401.70c85ada@kernel.org>
In-Reply-To: <20250925190401.70c85ada@kernel.org>
Subject: RE: [PATCH net-next v5 0/4] net: wangxun: support to configure RSS
Date: Fri, 26 Sep 2025 10:21:06 +0800
Message-ID: <061e01dc2e8c$371340a0$a539c1e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTHj73TMmcD+HtktVQlPcEqyyH7gJ+IGKqAlqN6RwCLk/5A7R+oyTQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M182XWJxg1fqe8GrRT/8TQ8HPdaBO8rz1UF9LFxNNPtVgm1og3RyJHVo
	Oi3RssyqjdS1IxUUSMwNhVApUjjfM0DbzTNpLczc4vVwG4xgWMHpKch1W7M1km2PHdh6XO3
	1MyJRjhjhio8dvmn1aBk73gbfm23i+tvpyHaOuGkIY3u10p6OL8+VbyHIL0brTRmpxtBtCV
	uCs3cqbX9eadUt/IowflZ4hDwi3Mwp8A9fL4tnkOILW/U1/zcCFseQ+xHNMP3m77O41Rr+6
	trY4eYk6HV2Slglszc1Li/RUDxeI7UbdJpTO5Nbq0kpVvbeWiW0lj08yP36/brecUFcSTQ3
	cmjr66cdPGd+JkIbT8gGKDACvcSTVASzix8eBSnezPP1b1Yu18Bf7FleRzepYLXxA3gcx+C
	2PZTypwJed3LZxElezwL5og18oLjK7e25ZU/L59TUSwtkX3uDk23UXYcT/awyRYWebBVkd2
	PGWkBJnAmnvZiadohH0cnbz+bDkF+qIKN94zP9Fuh0THXuENc2nRQLzWarjCKZiy8JVfkPX
	Rszy+xfQlcuBlLblc4nVGPtMkoISn7FOHc9DqhBiGJNZHpF2jPiWTbeXRYTDwPkbQD/Eudv
	DVy4EHLf6QqePJMLx/KK8ZATdt8gdTShRHsHN5VETUTsfrmktfWUZScY6f5aw6Tbg5w62ur
	n58IWniccETaQDfaGul55TuOFMJDARBcFZp7g+C7PZvu2bZfkxg+W9TnJvpa7JfEiUeLI5a
	wFZ9cLAf/jI7py9XVUuQMlRV8wFwUn7+umvjKpXUaEWEGcpZ5G1P2xNPlyZA7yGQzPCly67
	bIZRrmJ6uKBBJkiINXq6prxxvKxm5SBAvK7vTOZ3nMzxtMAJ8j+BlJaIPVXh7FKBDNlD7Zr
	168EJcvgYKEVFUecODZxQnm1jwAD3bab5UKhIcGkjcrSz8XwgBozVAXqIak99mXKU8ZSzlx
	yntq5WpVVZpv35GxDHb4lICQexMjTbCSBbMI+7OJuqvaNWmbG0WJ5FyLs/3MGoTaBbJIsyc
	qAO/HFX377OvDn5unuZ3IGI1+Kl9g=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

> > root@w-MS-7E16:~/net-next# NETIF=enp17s0f0 LOCAL_V4="10.10.10.1" REMOTE_V4="10.10.10.2" REMOTE_TYPE=ssh
> > REMOTE_ARGS="root@192.168.14.104" tools/testing/selftests/drivers/net/hw/rss_ctx.py
> > root@192.168.14.104's password:
> > TAP version 13
> > 1..17
> > not ok 1 rss_ctx.test_rss_key_indir
> > ok 2 rss_ctx.test_rss_queue_reconfigure # SKIP Not enough queues for the test or qstat not supported
> > ok 3 rss_ctx.test_rss_resize
> > ok 4 rss_ctx.test_hitless_key_update # SKIP Test requires command: iperf3
> 
> Please install iperf3 and retry just this one?

Thanks, this iperf3 test is passed.
I'll paste the output in the v6 cover-letter.


