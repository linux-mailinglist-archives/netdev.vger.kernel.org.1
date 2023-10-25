Return-Path: <netdev+bounces-44212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0627D71A7
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74417281A7B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4A62E657;
	Wed, 25 Oct 2023 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="teTI4x/R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D526E3C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:23:40 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD1E92;
	Wed, 25 Oct 2023 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KSvipvPwB0LwmbdUXHWvqGMVCXXCLb37wMlJPclW53k=;
	t=1698251019; x=1699460619; b=teTI4x/RdRNj1XiUEd25aW1RIcUoHx418GuysskiItD3RZ5
	TsRVIjgYFv3WYomVJegyhPHhRVtPrBYLTr8kgl8jQIgDgJr9bbvYsKyb8q5ZYeEHdigM7FTpXarRY
	QIZDp4GdJ4giL1tLll+tgQgXN01f7huDPekf626E+d1/J6xiS5uS18Ty/t7L5n9UGkPQse0LikIsZ
	C9Sms5kWzaPlxD53da6RArx0+A62BtSjQidIjPafeH2suL99j7t84qtHGFIIkECScBbLDTDUK876i
	5UsUi9p0uWl4QJX/ZqQoB7h1Yxj3i1tLA6p59515gxOx5h8szSoHreVN3tXVleQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvgfL-00000002ccP-3vTk;
	Wed, 25 Oct 2023 18:23:32 +0200
Message-ID: <b96201ae56ab165701fd5057bb9c52bb84369d91.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
 j.vosburgh@gmail.com, andy@greyhouse.net, dsahern@kernel.org,
 jhs@mojatatu.com,  xiyou.wangcong@gmail.com, jiri@resnulli.us,
 vinicius.gomes@intel.com,  razor@blackwall.org, idosch@nvidia.com,
 linux-wireless@vger.kernel.org
Date: Wed, 25 Oct 2023 18:23:30 +0200
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>
References: <20231025162204.132528-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2023-10-25 at 09:22 -0700, Jakub Kicinski wrote:
> struct nla_policy is usually constant itself, but unless
> we make the ranges inside constant we won't be able to
> make range structs const. The ranges are not modified
> by the core.

Makes sense, wonder why I didn't do that from the beginning ...

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

