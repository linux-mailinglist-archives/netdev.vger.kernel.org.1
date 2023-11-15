Return-Path: <netdev+bounces-47950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B27EC12A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36271C2074A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B2E156DE;
	Wed, 15 Nov 2023 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIDlGeKt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E814F8B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D52FC433C8;
	Wed, 15 Nov 2023 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700047118;
	bh=adpWzHaP7Je7KyP6sEwKyhUso8uKwhw/i89rIOpi9f0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UIDlGeKt7KzPNrV/vXmhP4BC/5bibGM6S61HotM5q0DKZW2lENcVH1ybP1yfHh5kx
	 3nT0mYSPFvgl4YSZ8tB504dqvp+DEvYI1fzRSkFkpO+NUIE/6ex6StXAeeCOPk2eha
	 po6p4kXeSIkggwkZr+AqErf45Bdyh5n5GB3rXgBMyHfr+bfJdD9g+n22/Rw09S9Ijg
	 Y0VzjsHCqR0uIAONUZjgiiGLyWBM1Z5YEGT6pfW4NlmI8WLi89dLZpq7CQXtesqmEn
	 eBn2jg6inCxclDzo6FUEQdzkSdo2fZSZ4ao5KSdQAx3o1fupT5/IfxFQ0CzwbbnhtZ
	 i5cyQsh/OnxvA==
Message-ID: <495a61b9-7208-472b-aec4-411a034ea34a@kernel.org>
Date: Wed, 15 Nov 2023 13:18:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add entry for TI ICSSG Ethernet driver
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com
References: <20231113094656.3939317-1-danishanwar@ti.com>
 <20231114175013.3ab9b056@kernel.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231114175013.3ab9b056@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/11/2023 00:50, Jakub Kicinski wrote:
> On Mon, 13 Nov 2023 15:16:56 +0530 MD Danish Anwar wrote:
>> Also add Roger and myself as maintainer.
> 
>> +TI ICSSG ETHERNET DRIVER (ICSSG)
>> +R:	MD Danish Anwar <danishanwar@ti.com>
>> +R:	Roger Quadros <rogerq@kernel.org>
> 
> Looks like this got (silently?) merged already, but you added
> yourselves as R:eviewers not M:aintainers..

Reviewer is correct for me.

-- 
cheers,
-roger

