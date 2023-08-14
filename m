Return-Path: <netdev+bounces-27393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F8777BCD0
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A9D1C209BC
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638CAC2C8;
	Mon, 14 Aug 2023 15:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2ABC2C6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380F8C433C7;
	Mon, 14 Aug 2023 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692026264;
	bh=/kLW9eHG591ZtySPNe1sbJrUxMdJO9Fh5+ev7C13oEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j6P0OGUDl9njr2QCQq4tgpMQ0vy9ywHev64HxATbVEmS5WJww+ZFyivIx90fmQjqw
	 XuhZ6JoTZC8NhjFOv3+BFMg+YY84GwIMydYvYEpmWK7D+uvBWzlpcNyHvb4ORiHErh
	 e00m1vNZRdUNtKiA0ze0wtwNL63TsJfUt++a/pMypiPurAUDgZcirvYv4YPKWAtXdH
	 bEmUEk6ZjIA2RKfdvirUwmKF9uET8KlxVDRLfYBmKPXDLHlUonllyLmKNfiBTF5UMD
	 No1tdCGd39cj5JBDL8G78K64Oe3FLLivm0FToHIz7jQVsO5vHR8/WOv54gz9BjlSRg
	 ron2WxZiWbydQ==
Date: Mon, 14 Aug 2023 08:17:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Manish Chopra <manishc@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ariel Elior
 <aelior@marvell.com>, Alok Prasad <palok@marvell.com>, Nilesh Javali
 <njavali@marvell.com>, Saurav Kashyap <skashyap@marvell.com>,
 "jmeneghi@redhat.com" <jmeneghi@redhat.com>, "yuval.mintz@qlogic.com"
 <yuval.mintz@qlogic.com>, Sudarsana Reddy Kalluru <skalluru@marvell.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>, David Miller
 <davem@davemloft.net>
Subject: Re: [EXT] Re: [PATCH v2 net] qede: fix firmware halt over suspend
 and resume
Message-ID: <20230814081743.3a7a7030@kernel.org>
In-Reply-To: <BY3PR18MB46128F47E175B8CFDECE3077AB17A@BY3PR18MB4612.namprd18.prod.outlook.com>
References: <20230809134339.698074-1-manishc@marvell.com>
	<20230810174718.38190258@kernel.org>
	<BY3PR18MB4612F2621E50B2F12F2BC342AB10A@BY3PR18MB4612.namprd18.prod.outlook.com>
	<20230811144507.5ab3fdae@kernel.org>
	<BY3PR18MB46128F47E175B8CFDECE3077AB17A@BY3PR18MB4612.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Aug 2023 10:24:52 +0000 Manish Chopra wrote:
> > I'm asking about recovery without this patch, not with it.
> > That should be evident from the text I'm replying under.  
> 
> Nope, It does not recover. We have to power cycle the system to recover.

Alright, please state that in the commit message and drop the
unnecessary NULL check for v2.

