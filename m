Return-Path: <netdev+bounces-47900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D287EBC9E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EF21C20ACE
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F557E;
	Wed, 15 Nov 2023 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMSxlRo3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254379461
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45381C433C8;
	Wed, 15 Nov 2023 04:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700022740;
	bh=DcJpZza30H4zfnwfFjo1F5dIGsEQgJRcTEb1Fu4/AK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sMSxlRo3WjV0AAFn0miy28kV0y4JWuk+HkQfoSjzTS3V3GCyjj4r0Q3FAO5XNX3BN
	 4soGEUeu4Vw8/hqF1cQ7pyNRKefmzqslHcjyDymUXQNGNJvQxKDWYnjv22cMKL9kmw
	 jWFCUEu9HdZWs4q31mXj2hJZVZi3/e7oT/E5Xlfq1JUlTCQopewpAGABGLySxp5/bW
	 Y3S6NXaYrKKiT2pRapK77KWheO1Q6byaTgKSHvUVTZVnoPUoQTpH+l6UKikFZKiyXl
	 Qzh9IZeZdV6slOA0wZoZHH/DeRnosEoOEJBvJGjatKZWsM6DHnyJEweSdzCFt/Z9ym
	 Ym15AOFGO0P0w==
Date: Tue, 14 Nov 2023 23:32:17 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>, Pradeep Nemavat
 <pnemavat@google.com>
Subject: Re: [PATCH v7 net-next 2/5] cache: enforce cache groups
Message-ID: <20231114233217.03e03fd2@kernel.org>
In-Reply-To: <20231113233301.1020992-3-lixiaoyan@google.com>
References: <20231113233301.1020992-1-lixiaoyan@google.com>
	<20231113233301.1020992-3-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 23:32:58 +0000 Coco Li wrote:
> Set up build time warnings to safeguard against future header changes of
> organized structs.
> 
> Warning includes:
> 
> 1) whether all variables are still in the same cache group
> 2) whether all the cache groups have the sum of the members size (in the
>    maximum condition, including all members defined in configs)

Could you extend scripts/kernel-doc to ignore the new macros?
It's fairly simple script, should hopefully be very easy.
Otherwise using the macros will cause warning spew with W=1.

