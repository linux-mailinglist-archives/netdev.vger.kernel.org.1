Return-Path: <netdev+bounces-18709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D664B758564
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132161C20B1C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B0D168CC;
	Tue, 18 Jul 2023 19:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F158168BC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A735C433C7;
	Tue, 18 Jul 2023 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689707477;
	bh=+HkpbelCVxn3hOwtOAxEdmpD4XslKX+FgXDJ+ENvVgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KCMkYmrQJpNZM04XeQ6zBXZEf2AK/rMj/xkiSERCQyaEgIElHFzB07LxBiVPm1tzc
	 3kc103duv7hL8yjHjr4grD7j15LznrGfsNl0gcw+6mWpQpISYnTiUgRAnLg7XGFNWX
	 Kp8aI2EHhnYlGJT+G3skxQ/YfSwVM3soBuMzXx1XzKBtWKFwvwF/0/q5Nm5Tzwth0g
	 cQvUwunVeBs1zDKSPnSLGns27WtjxXhx4BlenPBoJaUQl78mJScCN0ENPfL4oz5D1+
	 o8za7tOeubfIJm+eiVhzFUSliDpJ+N3lfG/WoF9PqKDH20DcTpjMfi9T54yur4I5x7
	 ojCK/S1bdMwUA==
Date: Tue, 18 Jul 2023 12:11:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: justinstitt@google.com, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Nick
 Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] net: dsa: remove deprecated strncpy
Message-ID: <20230718121116.72267fff@kernel.org>
In-Reply-To: <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
	<316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 11:05:23 -0700 Kees Cook wrote:
> Honestly I find the entire get_strings API to be very fragile given
> the lack of passing the length of the buffer, instead depending on
> the string set length lookups in each callback, but refactoring that
> looks like a ton of work for an uncertain benefit.

We have been adding better APIs for long term, and a print helper short
term - ethtool_sprintf(). Should we use ethtool_sprintf() here?

