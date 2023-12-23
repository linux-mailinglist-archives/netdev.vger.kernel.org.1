Return-Path: <netdev+bounces-60068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98981D403
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 13:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10DF1C2165B
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400779C5;
	Sat, 23 Dec 2023 12:31:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F03D2E9
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rH19j-0003sA-7r; Sat, 23 Dec 2023 13:31:03 +0100
Date: Sat, 23 Dec 2023 13:31:03 +0100
From: Florian Westphal <fw@strlen.de>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC iproute2-next] remove support for iptables action
Message-ID: <20231223123103.GA14803@breakpoint.cc>
References: <20231222173758.13097-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222173758.13097-1-stephen@networkplumber.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Stephen Hemminger <stephen@networkplumber.org> wrote:
>  tc/em_ipset.c                        | 260 --------------

Not sure if this is unused, also not related to the iptables/xt action.

