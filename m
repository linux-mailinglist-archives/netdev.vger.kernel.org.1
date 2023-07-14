Return-Path: <netdev+bounces-17755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD041752FA4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BDB281FAA
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DACDED0;
	Fri, 14 Jul 2023 02:57:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F010F4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C2C433C8;
	Fri, 14 Jul 2023 02:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689303451;
	bh=ZYU7x/FrF5TDpwKIcUsr0Y69lsE9wJCU2EzIi69goQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzz2epqhOTKY5s8SDnbOLRmKPC5PvZqwbKiwOAJ9lETB+Ja6Irw384SYOtjhjNJk9
	 1XNlVjqb48xer8vxPTkSKlM/Frhzq8mA4Hn61HhAOr3IgdyCc9DQjvXsYuZcXrcNES
	 uRuuUCxm90+mksD1YWSjvaqcR6g8wPdtvtHyoXGNVfd5g5G/Zsnl/3rBBTbps9nRm0
	 wYV7PceNLBYnU/IBsv16BgVz5M5+CAhTFjPLGcJ15C5RbMP45VYD6l4VGoaB68dQvR
	 M65e0BHzdyMeeu5KWE03C3oLqd2NySNYCICRN9zu4hgRqbFMVtCEIMdInCupgYGBZE
	 k0itB1fwjS4xg==
Date: Thu, 13 Jul 2023 19:57:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <idosch@idosch.org>,
 <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH v2 net-next 1/5] ionic: remove dead device fail path
Message-ID: <20230713195730.24afb3ee@kernel.org>
In-Reply-To: <20230713192936.45152-2-shannon.nelson@amd.com>
References: <20230713192936.45152-1-shannon.nelson@amd.com>
	<20230713192936.45152-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 12:29:32 -0700 Shannon Nelson wrote:
> Note: This patch is cherry-picked from commit 3a7af34fb6e
>       because the following patchset is dependent on this
>       change.  This patch can be dropped from this series
>       once net-next is updated

Doesn't work, I tested applying the series after merging the trees -
git am doesn't skip this cleanly so our scripts get confused and 
end up making a real mess of the branches. Let's stick to the
documented process. You'll have to repost without this patch.
-- 
pw-bot: cr

