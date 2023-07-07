Return-Path: <netdev+bounces-16163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63FD74BA0C
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F39328198E
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299117FF0;
	Fri,  7 Jul 2023 23:27:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AF2F28
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 23:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCE2C433C7;
	Fri,  7 Jul 2023 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688772458;
	bh=P+uTzSoEqJJWCevlsdh+M1GqE95HMg/uVvhx5B1sX1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g7qA+fyPMtwHwYkAqhITQUei9SCkfMhs7WRXaXAJGM1VslLzlR+unsnZj0WbYsPXb
	 6xAE4bLv9l2Lq/hVKRRUwpN2bU9q7TtlmjiPfkTi3upYlPY5VQ3x1g8m3TrUgdcnT9
	 sUdPou1NXL1PYYNLgF0XbVxv8YYcSis/9GkDPcoIjU93vlM++GwTOzszv9KyUTsSTu
	 mAXHxOaP5JLj9Ku0t+qiW55ca/WhLsQLlMJq2K2AjTF0O2Bt+MTZPYD15YEGDfh71y
	 10qneoudIs8cClwUT79qcLm70hH4hC+lXLxMEemyXADmZ6Rhwy0yDqq+07u1lEGqPL
	 XDwKFAgsHtsJg==
Date: Fri, 7 Jul 2023 16:27:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Forbes <jforbes@fedoraproject.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
Message-ID: <20230707162737.0a411b18@kernel.org>
In-Reply-To: <CAFxkdApnEo8RPOQ3zVjAZBeTtH2UbaT2798gQ5w0SA5e-dtZng@mail.gmail.com>
References: <20230706145154.2517870-1-jforbes@fedoraproject.org>
	<20230706084433.5fa44d4c@kernel.org>
	<CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
	<20230707151206.137d3a94@kernel.org>
	<CAFxkdApnEo8RPOQ3zVjAZBeTtH2UbaT2798gQ5w0SA5e-dtZng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jul 2023 17:19:12 -0600 Justin Forbes wrote:
> they add an entry for it, and don't realize that the entry is ignored

Maybe that someone should not be "adding an entry" to a file which 
has this at the top:

#
# Automatically generated file; DO NOT EDIT.

?

> VENDOR_QUALCOMM is not enabled.  Either all devices capable of using
> rmnet should be hidden behind VENDOR_QUALCOMM or rmnet should not be.

I agree that Qualcomm drivers are an atrocious mess.
They should live neatly in the wwan section. But it's Qualcomm,
they don't care. Let's not have it sprawl even more.

