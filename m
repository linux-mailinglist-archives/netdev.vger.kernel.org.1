Return-Path: <netdev+bounces-100342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B8E8D8A68
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376331C21DFD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A733E49E;
	Mon,  3 Jun 2024 19:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CB2746B
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443723; cv=none; b=iCPmTIFFDMPisv1stOfRRz4y0zh/04yXMCUVHiu46Js0Oye1nT2GJ0TwOEkIjLhyZ6Z9lBpXs2vl5UpWSlQkoeFkYMQorRkbJc4tFAcgmFHAmsWP+MroolHFyCRyQOB4liVyQqs4yRngkvdQNmsn/kfEL2a5qp0cm2zX7WePIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443723; c=relaxed/simple;
	bh=2bhRw3rs19BcI8K57jd8P5eppbEvatXtIOY+vC0d0f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsXucaG8Vj2NsPEV42D+Kz4sPHwlx6lpOcd+c6QC39W9JWUqZPkOccYCed45wrLFyMu/qp5dfIEa+mooKNzcvt3MjgTL21zBBrw09hBP75rGgIbT74vJNPPlRmNUl/6H/zxDVKXl86zjiCe2dTd6lSjNCqVGfker+AceWDr7Vpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [46.222.218.95] (port=2768 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sEDGs-007oRH-9y; Mon, 03 Jun 2024 21:23:08 +0200
Date: Mon, 3 Jun 2024 21:23:05 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jianguo Wu <wujianguo106@163.com>
Cc: netdev <netdev@vger.kernel.org>, contact@proelbtn.com,
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] seg6: fix parameter passing when calling
 NF_HOOK() in End.DX4 and End.DX6 behaviors
Message-ID: <Zl4YGQ3pqEobNTAl@calendula>
References: <2a78f16a-0ff5-46bf-983b-9ab038f5a5cd@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a78f16a-0ff5-46bf-983b-9ab038f5a5cd@163.com>
X-Spam-Score: -1.9 (-)

Hi,

On Thu, May 30, 2024 at 03:43:38PM +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> input_action_end_dx4() and input_action_end_dx6() call NF_HOOK() for PREROUTING hook,
> for PREROUTING hook, we should passing a valid indev, and a NULL outdev to NF_HOOK(),
> otherwise may trigger a NULL pointer dereference, as below:

Could you also add a selftest to improve coverage of this infrastructure?

Thanks.

