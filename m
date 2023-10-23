Return-Path: <netdev+bounces-43443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9157D3275
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 13:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE10B20BEB
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A114AA8;
	Mon, 23 Oct 2023 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5215484
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:20:16 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37069DB
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 04:20:15 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qusye-00086W-UO; Mon, 23 Oct 2023 13:20:08 +0200
Date: Mon, 23 Oct 2023 13:20:08 +0200
From: Florian Westphal <fw@strlen.de>
To: Kaustubh Pandey <quic_kapandey@quicinc.com>
Cc: mark.tomlinson@alliedtelesis.co.nz, pablo@netfilter.org,
	netdev@vger.kernel.org, quic_sharathv@quicinc.com,
	quic_subashab@quicinc.com
Subject: Re: KASAN: vmalloc-out-of-bounds in ipt_do_table
Message-ID: <20231023112008.GB31012@breakpoint.cc>
References: <7ce196a5-9477-41df-b0fa-c208021a35ba@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce196a5-9477-41df-b0fa-c208021a35ba@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kaustubh Pandey <quic_kapandey@quicinc.com> wrote:
> Hi Everyone,
> 
> We have observed below issue on v5.15 kernel
> 
> [83180.055298]
> ==================================================================
> [83180.055376] BUG: KASAN: vmalloc-out-of-bounds in ipt_do_table+0x43c/0xaf4

Whats this?  See scripts/faddr2line

