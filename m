Return-Path: <netdev+bounces-22097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444B17660CC
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03563282568
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D527EA;
	Fri, 28 Jul 2023 00:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DD7C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED62C433C7;
	Fri, 28 Jul 2023 00:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690504762;
	bh=wtmpg7W3mlGtjhQLE/xGTKmf0V5t8PqiXxR8B4eX5EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uLMNDTeq/3O/KOUgjIWrI7oCdup8xIRgRCDTn6MaGBu3OcIijpZp0dBktTsEDSowq
	 8wSNwhK4SF+Fx3Lga+iNclEQ41xZff72DsQ/yCOvAUIeDme+AD1NpPRSejCKEZmT9c
	 lfpAeyes3FiGZfeWT+C+wvumVPThZz1mqRKfn0OOTMnaKeM1xc0dW6TihxmPkrPTF2
	 l+nDRyfpxqW7l7wlhpise/nPyyRcjDxUjxZa6q/x0dqpkLmAlSWSmAJtCBEgmKJkWj
	 45MD7XmjSc0W6cEYNlImvi+4GvnYsippkG4AiU6e4ANDKpC/j8WEnLNEC162IjbEqm
	 PikXkWf8V+IzA==
Date: Thu, 27 Jul 2023 17:39:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/2] tools/net/ynl: configuration through
 json
Message-ID: <20230727173921.311f8e1d@kernel.org>
In-Reply-To: <20230727120353.3020678-2-mtahhan@redhat.com>
References: <20230727120353.3020678-1-mtahhan@redhat.com>
	<20230727120353.3020678-2-mtahhan@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 08:03:30 -0400 Maryam Tahhan wrote:
>  tools/net/ynl/cli.py | 108 ++++++++++++++++++++++++++++++++++---------

I think we should keep cli.py nice and simple, it'd be better to
create a separate script which suits you use case.
-- 
pw-bot: cr

