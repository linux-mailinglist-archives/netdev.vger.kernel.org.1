Return-Path: <netdev+bounces-49733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB967F348B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF7BB20E47
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AED56759;
	Tue, 21 Nov 2023 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faUS3nAW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2211101
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBE8C433C8;
	Tue, 21 Nov 2023 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700586667;
	bh=9xZlubgenr0D3688h0WjNELIDULkrdT4NJPGpjip9jA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=faUS3nAWpDx45dmgIqzVpr4rU8XUuY+swiTtGdM3UwxDy7qwzoooehmjKvtg4r8zG
	 9bcswCAPWDUFSxpLDn/dHjOdZPdGCxJsvL7ghL7XA4i8ilRxlsyhhraBf2IW30sGA1
	 LTu4ouWjpwDK/uB3xAh2um33y5mK5ItqFGuvLFO2Lq3XszU7nLsmxXggF0MToZZ2Xb
	 Xohd2IFfR8rqO41A9NjfLp614JWxUuTuxSWK7JiV+xtOAsG5KQ2hmHryaPwXK0ygmG
	 D5HREhXfCZVYE1Cqy0fd6J3hnz18HSbecrvW7q2nHc6pUBw+DEfpI37AgmIg4PX7Pw
	 +lK2FfyuMiq3A==
Date: Tue, 21 Nov 2023 09:11:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Nov 21st
Message-ID: <20231121091106.02e51d0f@kernel.org>
In-Reply-To: <20231121160542.GA1136838@kernel.org>
References: <20231120082805.35527339@kernel.org>
	<20231121160542.GA1136838@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks to everyone who attended!

Notes:
https://docs.google.com/document/d/12BUCwVjMY_wlj6truzL4U0c54db6Neft6qirfZc=
ynbE/

I forgot to mention one thing:

The "cc_maintainers" check in patchwork has been improved, it will
now ignore emails which we haven=E2=80=99t heard from in 3 years (1 year if=
=20
the author and missing CC emails share the domain).

