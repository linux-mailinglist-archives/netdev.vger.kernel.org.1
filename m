Return-Path: <netdev+bounces-71909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7208558C3
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13E4B2614A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C15A1361;
	Thu, 15 Feb 2024 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuYdJrIC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859710F4
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960452; cv=none; b=GnlLWqXxQXSTx4IS1PbD1DbE9GZGXhKykepWHhStFU7RzQgOLP9rXQTz6V8YmwNv8cMku52CkzFXVWdaeBONaHKBgujACWLRp8VAUGmrHL9ydhr3pReeusXuPfNV0UxPPJTkJn5Wtapn3R61yg7pXqtKRp7zGgXVemz89LQ74Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960452; c=relaxed/simple;
	bh=Eph46rx8GGX94bSeDzp609vgyTDfyo3Cd+XiUtfWsp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPht9q2xO4bX9wbaDD7q1JpVVMalJqB4LUwkxtiduKEaIC/iAjjLW0a5zP8oKdqBonZooTvautxo8mBcfecTbJxX5pe19+z6KSTy35ResdbeMfQSWH/fM3tWl2682gYvM5NWH8Y6XRDJs+GjrmifgrBxmgp5PqWGlsKYkA6MClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuYdJrIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BFAC433C7;
	Thu, 15 Feb 2024 01:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707960451;
	bh=Eph46rx8GGX94bSeDzp609vgyTDfyo3Cd+XiUtfWsp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BuYdJrIC5B8Nwvn5TgVSCR0pq/1tMr1kNRZ631QdKtO8ZCF8d2NjzalhjXfI8Phvm
	 /IwCpwGnARKFOWLywIwpFtjQlkhUtByoj/okzdUs4kWWM4+3mI2lwiS+N7V+bD78X4
	 1NWv8ZW9RFN0BSiUecaSi+cU/c5fyziqP8rhxqQwWFyF7KHrFpaG2FU2L5soA59ef5
	 0LWUQvbtXNnqEDHdEEAbZjZMWlqsCjAGQ+ToMxHHVxHvmJOTm0Hx70FGr8Yc4+nWQ9
	 0EIVP8MGkQErcpgujorRPMsD4firyAJD0BKZXjZIMVsYO9HcpD2WTQQjL8ZFxf0lhz
	 Tu05ogbYmPAWw==
Date: Wed, 14 Feb 2024 17:27:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <Shyam-sundar.S-k@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH v5 net-next 3/5] amd-xgbe: add support for new XPCS
 routines
Message-ID: <20240214172730.379344e5@kernel.org>
In-Reply-To: <20240214154842.3577628-4-Raju.Rangoju@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
	<20240214154842.3577628-4-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Greg!

Would you be able to give us your "no" vs "whatever" on the license
shenanigans below? First time I'm spotting this sort of a thing,
although it looks like we already have copies of this exact text
in the tree :(

On Wed, 14 Feb 2024 21:18:40 +0530 Raju Rangoju wrote:
> + * AMD 10Gb Ethernet driver
> + *
> + * This file is available to you under your choice of the following two
> + * licenses:
> + *
> + * License 1: GPLv2
> + *
> + * Copyright (c) 2024 Advanced Micro Devices, Inc.
> + *
> + * This file is free software; you may copy, redistribute and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or (at
> + * your option) any later version.
> + *
> + * This file is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * This file incorporates work covered by the following copyright and
> + * permission notice:
> + *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
> + *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
> + *     Inc. unless otherwise expressly agreed to in writing between Synopsys
> + *     and you.
> + *
> + *     The Software IS NOT an item of Licensed Software or Licensed Product
> + *     under any End User Software License Agreement or Agreement for Licensed
> + *     Product with Synopsys or any supplement thereto.  Permission is hereby
> + *     granted, free of charge, to any person obtaining a copy of this software
> + *     annotated with this license and the Software, to deal in the Software
> + *     without restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
> + *     of the Software, and to permit persons to whom the Software is furnished
> + *     to do so, subject to the following conditions:
> + *
> + *     The above copyright notice and this permission notice shall be included
> + *     in all copies or substantial portions of the Software.
> + *
> + *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
> + *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
> + *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> + *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
> + *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
> + *     THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *
> + * License 2: Modified BSD
> + *
> + * Copyright (c) 2024 Advanced Micro Devices, Inc.
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Advanced Micro Devices, Inc. nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * This file incorporates work covered by the following copyright and
> + * permission notice:
> + *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
> + *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
> + *     Inc. unless otherwise expressly agreed to in writing between Synopsys
> + *     and you.
> + *
> + *     The Software IS NOT an item of Licensed Software or Licensed Product
> + *     under any End User Software License Agreement or Agreement for Licensed
> + *     Product with Synopsys or any supplement thereto.  Permission is hereby
> + *     granted, free of charge, to any person obtaining a copy of this software
> + *     annotated with this license and the Software, to deal in the Software
> + *     without restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
> + *     of the Software, and to permit persons to whom the Software is furnished
> + *     to do so, subject to the following conditions:
> + *
> + *     The above copyright notice and this permission notice shall be included
> + *     in all copies or substantial portions of the Software.
> + *
> + *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
> + *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
> + *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> + *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
> + *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
> + *     THE POSSIBILITY OF SUCH DAMAGE.


