Return-Path: <netdev+bounces-15403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889B7475AD
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29251C20976
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99C66AB9;
	Tue,  4 Jul 2023 15:54:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7E6AB0
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:54:01 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73C8E76;
	Tue,  4 Jul 2023 08:54:00 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3094910b150so6553988f8f.0;
        Tue, 04 Jul 2023 08:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688486039; x=1691078039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU5Ch7ZyFPAWmV2R4i+//IDVV+8rAbsYSxN4PN94SKo=;
        b=KGVkCWZEIfkiANksVsSTWgoF+RjRl1BInStoOm76wz4Tyvgwo1jQ6rYMhZVofTpwyt
         k72Fd+GVx3POSvxhDyqTr048lZywYJ3rrAGxinYeqngYZDDc/lUjNRoboZl4s5GqpBk/
         MGabKjulr9mz3b503FHf4lrwFcnIAzZ7Clm2GQ+PbBbc9bDTGC7z9TpkqgV4ld3qX94S
         zjYp+Zh+JA5sDIL7vxxOjBcdb9wAI48oFPu72jDbS4I7IpnoOOxDbMzAcQ5k+ipvEdvj
         S0bMW1+wIzXjqPUe0SYJPi3BKT0/ockcSNIRULCaim5V7BKCDS/02hWA7HZ5ejgglHQu
         aJJg==
X-Gm-Message-State: ABy/qLbBM/R56adU2D7XBDX9eBCb5Pdf6puv5IrluZxhYVBUFVIowkxy
	XF0sWBdFQKIm5CuLuJHJiMk=
X-Google-Smtp-Source: APBJJlHzl4vBL3Mzs/GqCSL4TXjsKgUc3WR8xPFH6e+bK9+ldHDZQ/QxFVje1zjYxjFoQ7rPAkB94g==
X-Received: by 2002:adf:e806:0:b0:314:1e99:32fd with SMTP id o6-20020adfe806000000b003141e9932fdmr10582861wrm.58.1688486038924;
        Tue, 04 Jul 2023 08:53:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id c8-20020a056000104800b003143ba62cf4sm3738843wrx.86.2023.07.04.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:53:58 -0700 (PDT)
Date: Tue, 4 Jul 2023 08:53:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	sergey.senozhatsky@gmail.com, pmladek@suse.com,
	Dave Jones <davej@codemonkey.org.uk>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <ZKRAlJMi3tjOSrXD@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
 <4b2746ad-1835-43e6-a2fc-7063735daa46@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2746ad-1835-43e6-a2fc-7063735daa46@lunn.ch>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 06:46:25PM +0200, Andrew Lunn wrote:
> Hi Breno

Hello,

> Why not just send the message without uname appended. You probably
> want to see the OOM messages...
> 
> Also, what context are we in here? Should that be GFP_ATOMIC, which
> net/core/netpoll.c is using to allocate the skbs?

Maybe this is not necessary anymore, since I might be using the buffer
already allocated.

> > +static inline void send_msg_udp(struct netconsole_target *nt,
> > +				const char *msg, unsigned int len)
> > +{
> > +#ifdef CONFIG_NETCONSOLE_UNAME
> > +	send_ext_msg_udp_uname(nt, msg, len);
> > +#else
> > +	send_ext_msg_udp(nt, msg, len);
> > +#endif
> 
> Please use
> 
> if (IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {} else {}
> 
> so the code is compiled and then thrown away. That nakes build testing
> more efficient.

Makes total sense, I am incorporating it into v2 now.

Thanks!

