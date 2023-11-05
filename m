Return-Path: <netdev+bounces-46085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA47D7E126C
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 08:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524A8B20C9C
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 07:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E6E53B7;
	Sun,  5 Nov 2023 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968E2CA7
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 07:09:00 +0000 (UTC)
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC40FF;
	Sun,  5 Nov 2023 00:08:57 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
	id BBC2C587232C6; Sun,  5 Nov 2023 08:08:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id B951760C1EA73;
	Sun,  5 Nov 2023 08:08:53 +0100 (CET)
Date: Sun, 5 Nov 2023 08:08:53 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
    "David S . Miller" <davem@davemloft.net>, 
    Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
    Linux Network Development Mailing List <netdev@vger.kernel.org>, 
    Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>, 
    Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH net] net: xt_recent: fix (increase) ipv6 literal buffer
 length
In-Reply-To: <20231104210053.343149-1-maze@google.com>
Message-ID: <1654342n-nn1q-959p-s6r0-3846psss5on6@vanv.qr>
References: <20231104210053.343149-1-maze@google.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Saturday 2023-11-04 22:00, Maciej Żenczykowski wrote:
>
>IPv4 in IPv6 is supported by in6_pton [...]
>but the provided buffer is too short:

If in6_pton were to support tunnel traffic.. wait that sounds
unusual, and would require dst to be at least 20 bytes, which the 
function documentation contradicts.

As the RFCs make no precise name proposition

	(IPv6 Text Representation, third alternative,
	IPv4 "decimal value" of the "four low-order 8-bit pieces")

so let's just call it

	"low-32-bit dot-decimal representation"

which should avoid the tunnel term.

