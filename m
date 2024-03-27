Return-Path: <netdev+bounces-82333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A988D510
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 04:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B7E2C75F6
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA71CF92;
	Wed, 27 Mar 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0A+cGpY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4E380
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711510467; cv=none; b=dSFj7OYWJ1B8xXStv9wwkXHa6R8I9GPDt5fs1TSF6FUXP9/Ea8IduDYHLDi55+grf2faEgmZMsUYcmuEujrQOdVw6b5gAw0IzcxkRNxLe7Q6UBOkfy69m2yke2EM81wVsZcMYmNcVdvagaP1WSUrggxqfAhsWw5TG2KTzWDg6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711510467; c=relaxed/simple;
	bh=C2eSKKoUQ8peaNhNZv243+bDGsWLreYGK1B+6YZDQb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1htQ/tkKyl3/Fg9Yu00rinA1QxnsHwZOmwdfB0XZfLrV0JdkkKTdcP1U7mH/WuOmWDoPs9L/C9A0oKtSo3yf7x/zS5K5gVUB+ZJD+dPsFHrqaSluLaIifX5wJeBaywIGlqBfmCZWxMfBQkkBgnKYU+dfDT6wZ8q8ijy4apEiLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0A+cGpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E499C433F1;
	Wed, 27 Mar 2024 03:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711510466;
	bh=C2eSKKoUQ8peaNhNZv243+bDGsWLreYGK1B+6YZDQb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C0A+cGpYep+JPFc9y/E4IP7W80VyjDiO+EX6gyMC6+PVJbAZwAqiNAxOf0hGahlo5
	 ooldoLIu4MJFpQjKaxPEkSjw68dEAMwO2GneAA887hhi7D80IODrMc1boMnk1KWB3l
	 FXsBhI/AtL8Oq3ejekQDZdWjIm4cFu7hkUo+bO25E2J8tQzfBIzRVdi6Rw2WDG6YYx
	 6tEPPRqKPbL5xFXD7BBDtyvL4WP5VVSz6egp1jKFUj/nutCynCyv6Nm4aXx0EMUkzz
	 MPhRJjIIODzsiFbNrSz/0vSyuYmZ2JjzerqnbFyfwtWKGcdhYd8KfAdF/S6QcBA4Ze
	 YOyXSHsgnzBwA==
Date: Tue, 26 Mar 2024 20:34:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv2 net-next 2/2] doc/netlink/specs: Add vlan attr in
 rt_link spec
Message-ID: <20240326203425.1c5bbe5a@kernel.org>
In-Reply-To: <20240326024325.2008639-3-liuhangbin@gmail.com>
References: <20240326024325.2008639-1-liuhangbin@gmail.com>
	<20240326024325.2008639-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 10:43:25 +0800 Hangbin Liu wrote:
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 

nit: please add a "---" line here so that the changelog is not part 
of the commit after we apply it with git am.

> v2:
>  - Add eth-protocols definitions, but only include vlan protocols (Donald Hunter)
>  - Set protocol to big-endian (Donald Hunter)
>  - Add display-hint for vlan flag mask (Donald Hunter)
> ---

