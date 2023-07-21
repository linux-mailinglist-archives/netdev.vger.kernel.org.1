Return-Path: <netdev+bounces-19791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE4075C588
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAA42821D2
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007191D2E4;
	Fri, 21 Jul 2023 11:10:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79093D78;
	Fri, 21 Jul 2023 11:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F86C433CA;
	Fri, 21 Jul 2023 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689937805;
	bh=doH7QBRGiTSMgWAl8lnHKFFkVmk48+gAH6oH3iUKSSk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=TeAAwkPYEkdHeLK0jHxq6rhHVazN/1TU7+62HrOkZfmqnl2lsKp3jBdYSSSx3x6Uh
	 m15wh0fBK+D8y/YNmxsYmZbhKqahbucNApMvstvBdluZ1jjMWp3xqUeOWKIgMVPmHn
	 /VuGq9YznORGspLjh+kXxyfS4zeYzoKVtb1T9v+EMRd8I2SJaIjLsOOItDHDp9Cyov
	 wYV0qE0CJlIdZ8XcBcTBG8nm4qUcKUew8YQR8u4OhZVhYtwIvL0eJ9oMTZrVXaEyEP
	 IgzxkYYIZv+2ogIMyEQdmY0HIQJr2qb68R+SiKTahVIeZdt05ZiiBl8mp33tp2Ti/M
	 bLI+aH7ty9Iag==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  regressions@lists.linux.dev,  Johannes Berg <johannes@sipsolutions.net>,
  Jakub Kicinski <kuba@kernel.org>
Subject: Re: Closing down the wireless trees for a summer break?
References: <87y1kncuh4.fsf@kernel.org>
Date: Fri, 21 Jul 2023 14:10:02 +0300
In-Reply-To: <87y1kncuh4.fsf@kernel.org> (Kalle Valo's message of "Tue, 13 Jun
	2023 17:22:47 +0300")
Message-ID: <87sf9h1px1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Me and Johannes are planning to take a longer break from upstream this
> summer. To keep things simple my suggestion is that we would official
> close wireless and wireless-next trees from June 23rd to August 14th
> (approximately).
>
> During that time urgent fixes would need go directly to the net tree.
> Patches can keep flowing to the wireless list but the the net
> maintainers will follow the list and they'll just apply them to the
> net tree directly.

A change of plans, I'm actually back already now and have opened both
wireless and wireless-next trees. I will go back offline at some point
but hopefully Johannes will be back by then.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

