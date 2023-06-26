Return-Path: <netdev+bounces-14075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5073ECC1
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB008280DFF
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A714A9E;
	Mon, 26 Jun 2023 21:17:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588FB14A99
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F3BC433C8;
	Mon, 26 Jun 2023 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687814260;
	bh=m6R5W5JzOK/r+RLvw57H/MMvrBNhhMZoPSKNc3Df3/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6D1cYIyWB5XbF9nsE2IfThXTl5d0iZhyhOEVouOJf6EAxbTDVAIkOL+O6IgkT0OZ
	 vm++4eyFCz4ikuC5oFDpeufd1sR0kqH/ljrqXC8G/eeRVdukrx0HLQZxX+3vOtN1ud
	 m7sdUIk1WxqEBHPO2R5c7RCuTpLNcyiRegOooc4wicdZ2C4BJ55Eo6QA+R+Yt6pC2h
	 OH2uycRH1GhElxOAFUHp62JLU+oVWRSrG59KmI6fkXYg/XlTHbug+XZXPZxwm5/6qA
	 tG9EdMqDT21byZIMrH8fXe4mRkFjLtkZGhWD4qCz7DsOIxMSpkyRS0ELDuYFpITNTl
	 FHQYXP2yIjopQ==
Date: Mon, 26 Jun 2023 14:17:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tariq
 Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH] net: Fix special case of empty range in
 find_next_netdev_feature()
Message-ID: <20230626141739.54d78c7e@kernel.org>
In-Reply-To: <20230623142616.144923-1-joachim.foerster@missinglinkelectronics.com>
References: <20230623142616.144923-1-joachim.foerster@missinglinkelectronics.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 16:26:16 +0200 Joachim Foerster wrote:
> Fixes: 85db6352fc8a ("net: Fix features skip in for_each_netdev_feature()")
> Cc: stable@vger.kernel.org

Nothing passes @feature with bit 0 set upstream, tho, right?
Fix looks fine, but it doesn't need the fixes tag and CC stable,
since its theoretical/forward looking.

Please repost explaining how we can hit this problem upstream
or with the Fixes/CC stable replaced by a sentence stating that
the problem can't currently be triggered.
-- 
pw-bot: cr

