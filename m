Return-Path: <netdev+bounces-18054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0E754694
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 05:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A69E1C21679
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 03:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18F2EA9;
	Sat, 15 Jul 2023 03:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B157EA6
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F285C433C8;
	Sat, 15 Jul 2023 03:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689392179;
	bh=c3tslDX7l0mK6db/sbQQSGrMSv0gZmxNU8aa2qw8Exw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lH8cEjJgrHWp90asOlEIXOLgBx+AxBeW+J0hbuFVxUmlG78xQor+z1BUWToZ1CA7r
	 cn1o8Jc7NKEbU1HT7ArlrBCCfJYvwNQupFLPc4kgws4ypai1Ypr4XzLhaJ2bZLeOdH
	 Gg7AeK3fBXDF8T9k+rOop6SM+4keVwFP0w24t2f3IwyYkzMr/kjo9HOKUrA/LSO7i9
	 m6OLEWszrWqQXhVnZ0UlXEG00ej1IXteKgMST95UOGVjtD5EJavIfZWvnAinP7GaeA
	 KEdJvTMUTYbsXFgo6nGgGYmBp7W+4pCLtJPLWUTtAU3ZIv/sNyQ0AVTwpH2CWVbVOr
	 VoE1+eFU5IyIA==
Date: Fri, 14 Jul 2023 20:36:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: hanyu001@208suo.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/slip: Add space after that ','
Message-ID: <20230714203618.2e19e8ed@kernel.org>
In-Reply-To: <4b922e9203381b3411696feae9ee02da@208suo.com>
References: <tencent_C824D439C8CE96AD83779E068967114FF105@qq.com>
	<4b922e9203381b3411696feae9ee02da@208suo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 16:02:13 +0800 hanyu001@208suo.com wrote:
> Fix Error reported by checkpatch.pl
> 
> ./drivers/net/slip/slhc.c:381: ERROR: space required after that ',' 
> (ctx:VxV)

Don't send checkpatch fixes to networking, thanks.

