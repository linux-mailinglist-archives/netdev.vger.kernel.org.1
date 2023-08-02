Return-Path: <netdev+bounces-23767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76F176D76E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79391C21312
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC5101EC;
	Wed,  2 Aug 2023 19:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAA10782
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB702C433C8;
	Wed,  2 Aug 2023 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691003277;
	bh=AtabSoCTmU8/gWEDdjyX6211qOFN6BSOTGhR7bMY0ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uG60NkW2sVNNoCgmVljzbKIqaaCndo0+LoUA9LyH+ahPeBLd6j0WsjnQvHZt64tq9
	 nl6/tnKgCaV7u1OP+OfMFyR0P+eJybajhDshnI6pqBQg0+Ua20xmg1lGfg4rftWU82
	 Ux2ClcMrTJcfraExKcTtAwQg1iW29Yp/GbLfLq04UVuInIdEQ55jHpjDhTtdw96cjB
	 cJ8DztYRdOLkd9lk9z348dgmFKdyhJKQFEyxsvPyJ7+ey0UC/5NcAq0SxI+9W6ei08
	 xvdB/irCh2tXltdZkqzGwUDDM2/xNwVA60ynt4k1nUAyF7D+05nC2mIoiRYr4HNMUQ
	 fP1YDJOYEEHyQ==
Date: Wed, 2 Aug 2023 12:07:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>, Wolfgang
 Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Message-ID: <20230802120755.10849c9a@kernel.org>
In-Reply-To: <20230801062237.2687-3-jirislaby@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
	<20230801062237.2687-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Aug 2023 08:22:37 +0200 Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.

Which tree are these expected to flow thru?

