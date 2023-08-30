Return-Path: <netdev+bounces-31426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0C78D6E7
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873B42810AA
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967AC6FDB;
	Wed, 30 Aug 2023 15:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40E23DF
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 15:18:12 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF831A3;
	Wed, 30 Aug 2023 08:18:11 -0700 (PDT)
Received: from [78.30.34.192] (port=40966 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qbMxK-002KUx-7F; Wed, 30 Aug 2023 17:18:09 +0200
Date: Wed, 30 Aug 2023 17:18:05 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Patrick McHardy <kaber@trash.net>, Jan Engelhardt <jengelh@gmx.de>,
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH nf] netfilter/xt_u32: validate user space input
Message-ID: <ZO9dreEK8SCsgQz4@calendula>
References: <20230828132107.18376-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828132107.18376-1-wander@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 10:21:07AM -0300, Wander Lairson Costa wrote:
> The xt_u32 module doesn't validate the fields in the xt_u32 structure.
> An attacker may take advantage of this to trigger an OOB read by setting
> the size fields with a value beyond the arrays boundaries.
> 
> Add a checkentry function to validate the structure.
> 
> This was originally reported by the ZDI project (ZDI-CAN-18408).

Applied to nf, thanks

