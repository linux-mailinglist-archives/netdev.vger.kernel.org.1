Return-Path: <netdev+bounces-32775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1034979A6A8
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3689D1C20927
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C3BBE68;
	Mon, 11 Sep 2023 09:20:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EBEBE5D
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:20:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C32CD3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694424012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS9lli0wQxzaeTtYduf+SRNAVGdyjoOnuF5+YHmnsp0=;
	b=T+rpU0jcNcksImrtWJKpXZ5zCTvZEYOMvYCFlmaVwDbOy04okIzRCMM5CpeSuug2pDLXTl
	jLA8Df6rB6wP+5muVD1ba4QXulpKQnwe/+U2/yFu6LK5y881QmoE9L0b5TEhzVB7ugGQgb
	1CHTPnFtaXvfe5BGcOlGFFx4WSKnFck=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Z-I_ltENMOmtDMC7cHwVYw-1; Mon, 11 Sep 2023 05:20:10 -0400
X-MC-Unique: Z-I_ltENMOmtDMC7cHwVYw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-997c891a88dso287589866b.3
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424009; x=1695028809;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GS9lli0wQxzaeTtYduf+SRNAVGdyjoOnuF5+YHmnsp0=;
        b=qs/6SZciWLAZ8Tv995tIfiwqPvW64hkA4R2qSRZCZfNB4WAf8TTfnLkux0neTaxOl7
         MiJKNU9FNtkz8sDYcWtky7rwrfoop+l+TiEGm5XEWc1jTR0WmpSxkbMxSDKbhi4d5NCo
         xqpsWo6exF8GeVM96hP51ntXSNfEFZg1oHemTW+LAgHqLDZzmFOUc6e3M7BGNa8M9Ort
         M2TES49Mn+zL7JVNqK2paxcC9ZM1AgnxqL/cIicPSr4jEjFUmt0lRxSQ1LKj2rC+2fyK
         J3wc9dltjrQQlxCWADdZ+TC1eflw0/bIVVJ1neSyuUe0v5iQbmUJUBBrYrO3GumZ7NUS
         9TjQ==
X-Gm-Message-State: AOJu0Yywm+eVSIazwOdQgwHaDjrWhQ77PR1t7hmLeIQqGQrMV5AfOUqc
	mcOC21JEPd4gxEAgPNSO97kqnReDTaR5R0uDjhIJOy2ZFppEKzGE+CPS5PUFkTLQhRmM0+0VGKK
	zFJGpoW4/WWflN52WkXHi89XA
X-Received: by 2002:a17:906:768f:b0:9a0:9558:82a3 with SMTP id o15-20020a170906768f00b009a0955882a3mr6795804ejm.58.1694424009394;
        Mon, 11 Sep 2023 02:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkBc0rdiHwYVxnqaCimatHdHg4I0Z4S/Rok+rT3zSfqZu/ml0H/GPLrSjgEsNYr1vPJUl/Ug==
X-Received: by 2002:a17:906:768f:b0:9a0:9558:82a3 with SMTP id o15-20020a170906768f00b009a0955882a3mr6795791ejm.58.1694424009051;
        Mon, 11 Sep 2023 02:20:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906360700b0098ce63e36e9sm5135636ejb.16.2023.09.11.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:20:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1D72EDC709D; Mon, 11 Sep 2023 11:20:08 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: Tree wide: Replace xdp_do_flush_map()
 with xdp_do_flush().
In-Reply-To: <20230908143215.869913-2-bigeasy@linutronix.de>
References: <20230908143215.869913-1-bigeasy@linutronix.de>
 <20230908143215.869913-2-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Sep 2023 11:20:08 +0200
Message-ID: <87pm2pkqwn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> xdp_do_flush_map() is deprecated and new code should use xdp_do_flush()
> instead.
>
> Replace xdp_do_flush_map() with xdp_do_flush().
>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arthur Kiyanovski <akiyano@amazon.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: David Arinzon <darinzon@amazon.com>
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Cc: Felix Fietkau <nbd@nbd.name>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Louis Peens <louis.peens@corigine.com>
> Cc: Marcin Wojtas <mw@semihalf.com>
> Cc: Mark Lee <Mark-MC.Lee@mediatek.com>
> Cc: Martin Habets <habetsm.xilinx@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Noam Dagan <ndagan@amazon.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Saeed Bishara <saeedb@amazon.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Shay Agroskin <shayagr@amazon.com>
> Cc: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you for doing this cleanup!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


