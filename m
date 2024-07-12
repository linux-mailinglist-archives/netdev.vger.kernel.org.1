Return-Path: <netdev+bounces-111002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466D092F3CF
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87FDB2113E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9A21FAA;
	Fri, 12 Jul 2024 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ5gnElF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E952F44;
	Fri, 12 Jul 2024 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720749247; cv=none; b=WKjGnDG+rfAPJf4agK70OP843t5GCprwzOSRqfO7oiixZS+ywST6v09ZAzk47tPln5Jro+iYhl/cU2t4YaRyelsYjJGnbQOH+SQPRi5XwhUNUcGuF8GwVd4Uq59fhUCtlH2oVDd7Gz8YHgwQQzpnRlCGHACTFhbIuEpKDApnsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720749247; c=relaxed/simple;
	bh=5CTx6bCR6Kt8rrszmp+0ZDJmXxuBWBJA+2RDRefnq5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8UqaQpjKyEGGTWQfWbYmG9JCLA8xM4fOINKBZoSHqxc7OcUNateQT5PW5L9hzrRKKIZ1cPoRtK5YzK3Ndvb4ySCXej1SCSzhiu9qu1Eq+D4nRkQ2N0XxQ85d1KoDNle9WAOQ152IY3DSIHzrNTzYllU9qOm/ZO1MAnJuTFwHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ5gnElF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C400DC116B1;
	Fri, 12 Jul 2024 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720749246;
	bh=5CTx6bCR6Kt8rrszmp+0ZDJmXxuBWBJA+2RDRefnq5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZ5gnElFiAPAk6+eo0g8Aw30BuglRBTb0e2dVnr4KxDzd4VCxKS5ggkznBOKbA3wa
	 NIEFVo8TxWmNla6HfRR9AVqVVIehy8mKL5nM7ZAxXJ9NLj+6wdJKcqNyGrPPNuaype
	 6IFjlqMABZBKGG4h0eLloCGTTBE+Cq/mHqfGf1cYzxvx2c0GKY6zfvfB8ieHcAcN9d
	 Ny0AP9854CpJA56D90pQqEpBw5z36yAopKpiTnSS2/gG+JAKrj0tTm1fc+V2TJalEc
	 O4GDYFsv0WkhH/rX2vOdTymsyfbTi2sQsGswACupOfv+UR/wq77BROScYVmDvTxzMM
	 xnJ0bapNOnKyw==
Date: Thu, 11 Jul 2024 18:54:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, Ilya
 Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman
 <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, Florian
 Westphal <fw@strlen.de>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/10] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
Message-ID: <20240711185404.2b1c4c00@kernel.org>
In-Reply-To: <20240709163825.1210046-4-ast@fiberby.net>
References: <20240709163825.1210046-1-ast@fiberby.net>
	<20240709163825.1210046-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  9 Jul 2024 16:38:17 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> +	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, fl_mask)) {

Does this work with nest as NULL?=20

tb here is corresponding to attrs from tca[TCA_OPTIONS], so IIRC we need
to pass tca[TCA_OPTIONS] as nest here. Otherwise the decoder will look
for attribute with ID fl_mask at the root level, and the root attrs are
from the TCA_ enum.

Looks like Donald covered flower in Documentation/netlink/specs/tc.yaml
so you should be able to try to hit this using the Python ynl CLI:
https://docs.kernel.org/next/userspace-api/netlink/intro-specs.html#simple-=
cli
But to be honest I'm not 100% sure if the YNL reverse parser works with
TC and its "sub-message" polymorphism ;)
--=20
pw-bot: cr

