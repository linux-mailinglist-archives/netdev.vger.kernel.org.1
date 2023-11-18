Return-Path: <netdev+bounces-48867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FDE7EFCAB
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 01:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B17C1F277C4
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CFA3C;
	Sat, 18 Nov 2023 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qctXKSTq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1EA38
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 00:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FFAC433C7;
	Sat, 18 Nov 2023 00:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700268242;
	bh=7dRtlgTO7MbUOGP0ASKinRXRX8cN0mULAPOvJmEpL98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qctXKSTqT5w+qoUyy6KSTRkVk/xI93J2RwYpaKD6jl8nAznruBU3qKThU9rT1CzAh
	 QK5yY0hyI1Ei41P4GTPwthfPWx7JsJX7F8xSCOX8k2wo2FQo3IP7lsYPw74aNefv3u
	 vyMhRM6LCEG5M649qDIJTQK8FzwEZHXGRp7LCCis0PEQit+OvKggdDirFpcWz6jd7g
	 SesHfY5i69vq68qPpuud6TrmDQ6KJAiKntHHBJZ4FW7kXwdVlFrdgmA+f89/AXGyw5
	 +KZxximYd3Uizfg390kzJ1Y1mCoQRyb7Mr3IRWTouD8s31oAg5LM7xejCCUtCOv4uh
	 f3NSKwiBEZc+Q==
Date: Fri, 17 Nov 2023 16:44:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 arinc.unal@arinc9.com
Subject: Re: [net-next 0/2] net: dsa: realtek: Introduce realtek_common,
 load variants on demand
Message-ID: <20231117164400.18b5a928@kernel.org>
In-Reply-To: <CAJq09z6_4H6ZZJrjXZALuL9aHPy20FzvUivWfvSZRU1AXUX-Rw@mail.gmail.com>
References: <20231117235140.1178-1-luizluca@gmail.com>
	<CAJq09z6_4H6ZZJrjXZALuL9aHPy20FzvUivWfvSZRU1AXUX-Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 20:57:34 -0300 Luiz Angelo Daros de Luca wrote:
> Sorry, I used the wrong prefix. It is missing PATCH.

That's fine, patchwork gobbled it up as is, no need to repost.

