Return-Path: <netdev+bounces-30194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A22786512
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A941C20DA1
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D317D2;
	Thu, 24 Aug 2023 02:09:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F57F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561FEC433C8;
	Thu, 24 Aug 2023 02:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692842980;
	bh=LsDjzS0ubVyeAmBjbKI0WhfpBLrPEuVSFOUd2yRKu28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m+TRjClYoACdmk49Rx8lVsD7iUq/rjTavF0qeRxxa7Icd4UW6tlYhCkd3I+RL1Ulc
	 vRjU2GTjppe27GJHcM5YnP456dDJjBvthexQOJP3tJ+dNiaqMCA2uUR/MUGPLvppb6
	 dYlxocB8XoKxip9YPIeEQrlzqzeFZywXXG8upiRUJhcOWVPXGZJnE51KjAor6U56de
	 Q+pv1WXYji9sJdmh0FgG3PLfFYtwJj20sw6qDgm3pZgXUd+gP2JOmTll45WiQch2OP
	 a++oNgAVFdBbVqJfla5UkQT4SHmxy+/AXVtBULvtiIYw6BZyJwJjUhGTMwPap6ZEUX
	 zlg+Hxs/ZrBYw==
Date: Wed, 23 Aug 2023 19:09:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net-next 00/15] mlx5 updates 2023-08-22
Message-ID: <20230823190939.37f94708@kernel.org>
In-Reply-To: <20230823051012.162483-1-saeed@kernel.org>
References: <20230823051012.162483-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 22:09:57 -0700 Saeed Mahameed wrote:
> 1) Patches #1..#13 From Jiri:
> 
> The goal of this patchset is to make the SF code cleaner.
> 
> Benefit from previously introduced devlink_port struct containerization
> to avoid unnecessary lookups in devlink port ops.
> 
> Also, benefit from the devlink locking changes and avoid unnecessary
> reference counting.
> 
> 2) Patches #14,#15:
> 
> Add ability to configure proto both UDP and TCP selectors in RX and TX
> directions.

Acked-by: Jakub Kicinski <kuba@kernel.org>

