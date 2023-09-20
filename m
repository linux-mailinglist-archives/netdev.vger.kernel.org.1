Return-Path: <netdev+bounces-35110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940217A721A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFAE1C2092B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 05:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329E33C21;
	Wed, 20 Sep 2023 05:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140B28F1
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:32:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69AA3;
	Tue, 19 Sep 2023 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/CINST4ityXNhoVAarY5lh3k37tzzTDhSRd3Om7kDGY=; b=pay/pzmq20ZtMt6njYaMbIU+55
	tdQx+nb+/IK8wkalRicItEgCWtP5FEE+vv2Hi3aLZf9aGKU44QdPNPH+37XR6OW9uY1tflHh/TGts
	jwSWRPs3pB5e3TM0aYrFd0qqRQnwPq4DGdvY1nYmX5qsfHxcW9sVmiTEhUiOe71Z9dJhbvHQc/zgN
	9dKuXA2h04iFod3bpENWTDQOdegWco+8lkpX2aMLfAkBXz3Il7SKRoXwJ5Sc791XvISHxj/i1QVeD
	aTTny4QAYio0jJPogihDBSIsdpDYRCkvucO5ofMhyrHIeHOc8ncsEN79MDeJCd4/sNr0YzgFHis8H
	3hbeFYoA==;
Received: from [2601:1c2:980:9ec0::9fed]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qippX-001vFZ-2f;
	Wed, 20 Sep 2023 05:32:55 +0000
Message-ID: <4c84eb7b-3dec-467b-934b-8a0240f7fb12@infradead.org>
Date: Tue, 19 Sep 2023 22:32:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 20
 (drivers/net/ethernet/intel/idpf/idpf_txrx.o)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Alan Brady <alan.brady@intel.com>
References: <20230920133714.351f83f9@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230920133714.351f83f9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/19/23 20:37, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230919:
> 
> The mm tree lost its boot warning.
> 
> The drm-misc tree gained a conflict against Linus' tree.
> 
> Non-merge commits (relative to Linus' tree): 6006
>  3996 files changed, 459968 insertions(+), 111742 deletions(-)
> 
> ----------------------------------------------------------------------------

on arm64:

when CONFIG_NET is not set:

aarch64-linux-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o: in function `idpf_rx_rsc.isra.0':
drivers/net/ethernet/intel/idpf/idpf_txrx.c:2909:(.text+0x40cc): undefined reference to `tcp_gro_complete'


-- 
~Randy

