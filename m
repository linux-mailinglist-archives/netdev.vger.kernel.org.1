Return-Path: <netdev+bounces-223761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D442B7EC84
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67CE7A43D3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3988429C327;
	Tue, 16 Sep 2025 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+cOa2Lr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F07292B2E;
	Tue, 16 Sep 2025 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062374; cv=none; b=Xpq6N+mSTkFkuwWYL0RwGrpc14fP32KST5eOGzci0/yleiKGBkVc0zkQM+gavExJbPZF9xzTWj3am6gBFzmNMnznyT45ZyMe9i2ubx5jG+2cIBPg47iOjGW9ggUGQc8xs9g0C51CltjG3xGI9s/SPeTSQJxsaNb3Du3V8ju9TQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062374; c=relaxed/simple;
	bh=Ort8kF21YmqS/VszU+RQlm6xUoyQ77hb3hySCxPgjDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPxFDjRNb8WeKa1BJu+OXMLYQIrln0a8UCoDZ39D1KgG2NglCCPbPBPm5NumIIskmhHqtc1SKEdM75i1XXtVT+fXZJjJ64/Iri5Hnv8I+nzkbDFSdcRUAq5EEbNGxujF3E3qQH08rdagMAgls2Qec1T9mIRTplbyJFgJWiDB6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+cOa2Lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163A6C4CEEB;
	Tue, 16 Sep 2025 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758062373;
	bh=Ort8kF21YmqS/VszU+RQlm6xUoyQ77hb3hySCxPgjDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+cOa2LrKFip85zl7kxfCjTEXmwSTQ87NTyhrwlFjZ1FGAr6a48/UdWwirn3ixWo+
	 QD4g5Vb6nkKT2n6zllDTiSUUb9zIDkUVND5IMyNREKoohCP8J6LFSG2QVMTv3l2kf1
	 uOEpqH80l4uIcUk3y94BVc0b09Awuk9H2a1dpdY/oCqUJ4TOB0wxi9QFeXk7NouzaC
	 gzPfjevTfZzqnNp+6/9VWfssfLYTxHoeJjaitIhn57y5PW7aiMVoSL+qJChB3VYnJY
	 xvzdxHu/G/UnRzIGt52uKd8wvfRkO6dQ1pG8ds56koRuAjapL7TTJLF/YtWH6TcQip
	 6VPbZ7JY8gnjA==
Date: Tue, 16 Sep 2025 15:39:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Sabrina Dubroca <sd@queasysnail.net>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/11] tools: ynl: prepare for wireguard
Message-ID: <20250916153932.200647ad@kernel.org>
In-Reply-To: <CAHmME9rf9NGRVtJBnjUJVPraGKL6dk0nRxzXmSi-7X6Y1zjmsA@mail.gmail.com>
References: <20250915144301.725949-1-ast@fiberby.net>
	<CAHmME9rf9NGRVtJBnjUJVPraGKL6dk0nRxzXmSi-7X6Y1zjmsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Sep 2025 17:53:00 +0200 Jason A. Donenfeld wrote:
> On Mon, Sep 15, 2025 at 4:47=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen =
<ast@fiberby.net> wrote:
> >
> > This series contains the last batch of YNL changes to support
> > the wireguard YNL conversion. =20
>=20
> "the wireguard YNL conversion"

FWIW these patches stand on their own whether we accept the wireguard
patches or not. Put more plainly - please do not read me applying this
set as an endorsement of the larger plan..

> Did I miss some conversation about this? I figure I must have. I must
> say I'm not too keen on wireguard (and apparently only wireguard?)
> being a guinea pig for this.

The specs themselves are gaining maturity. I think adding a YNL spec
for wireguard would be quite nice. Whether we should be converting
the kernel code and uAPI to take advantage of the auto-generation is
a completely separate conversation. If you're not anticipating many
new additions in the uAPI there's little to be gained.

Intro:
https://docs.kernel.org/next/userspace-api/netlink/specs.html
Existing specs:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/Do=
cumentation/netlink/specs/
Libs:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/to=
ols/net/ynl/pyynl/lib/ynl.py
https://github.com/linux-netdev/ynl-c (this one is also in tree)
https://github.com/linux-netdev/ynl-cpp

