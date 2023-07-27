Return-Path: <netdev+bounces-22016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E8765B52
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAE5282283
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C7117AC4;
	Thu, 27 Jul 2023 18:26:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3A27127
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD5DC433C7;
	Thu, 27 Jul 2023 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690482389;
	bh=38m+H+J5PB3iY8TDOflMJlMPB9/6szSQVwMEdIoXuf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmNlmgbgzKpqIL+xP4oLth6sWF8wCNmzETkxjJ4lZsdhcs0HbT8QCXDkbHtvPByjK
	 XJe3L7yGdQbbvSEz8b7NirWfiEeCBZserbRr/TTL08T4El9I8hUSwZOiqJ7Yex06lD
	 agsxASV1/C6FdQYWQC06ItHPTdhEoIxwNx++yegcLMFmtLEmziluFPOewhCxRKQ0o1
	 Cdu21Q30uYXTvq0mcXRfRTSwJ1m43w9eukzbLGg8RNwHBBTANAW/522Bxc6aXhXlAm
	 jJkuIdwzMf84/g1/4EPZnRC8Gl/2fHZDHcB0YkrTLjL2+N8U1jlj3SxutxRxtcZ4FT
	 vBmKEVO8J5tKA==
Date: Thu, 27 Jul 2023 11:26:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com, gospo@broadcom.com
Subject: Re: [PATCH net] bnxt: don't handle XDP in netpoll
Message-ID: <20230727112628.69884e5d@kernel.org>
In-Reply-To: <20230727170505.1298325-1-kuba@kernel.org>
References: <20230727170505.1298325-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 10:05:05 -0700 Jakub Kicinski wrote:
>  	if (bnapi->tx_pkts && !bnapi->tx_fault) {
> -		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
> +		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts, budget);

I forgot the tx_fault detection went into net-next and not net :(
I'll have to rebase and deal with the conflict.
-- 
pw-bot: cr

